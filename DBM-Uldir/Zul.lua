local mod	= DBM:NewMod(2195, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(138967)
mod:SetEncounterID(2145)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 273361 273889 273316 273451 273350",
	"SPELL_CAST_SUCCESS 274358",
	"SPELL_AURA_APPLIED 273365 271640 273434 276093 273288 274358 274271",
	"SPELL_AURA_APPLIED_DOSE 274358",
	"SPELL_AURA_REMOVED 273365 271640 276093 273288 274358 274271",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out correct CAST event/ID for Dark Revelations
--TODO, shadow barrage need actual warnings? seems like basic crap boss spams so omitting for now
--TODO, see if congeal is cast often, and if it is, reduce emphesis on warning.
--TODO, move RegisterOnUpdateHandler to only be used when one of those adds is actually up (if we can detect their spawns and deaths cleanly)
--TODO, check Locus of Corruption trigger
--TODO, stack count assumed for tank swaps
--TODO, minion of zul fixate detection?
--TODO, deathwish CAST event.
--TODO, maybe switch warning for minions of zul, or detectable spawns, show on a custom infoframe number of adds up (each type)
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Stage One: The Forces of Blood
local warnPoolofDarkness				= mod:NewCountAnnounce(273361, 4)--Generic warning since you want to be aware of it but not emphesized unless you're an assigned soaker
--Stage Two: Zul, Awakened
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnRupturingBlood				= mod:NewStackAnnounce(273365, 2, nil, "Tank")

--Stage One: The Forces of Blood
local specWarnDarkRevolation			= mod:NewSpecialWarningMoveAway(273365, nil, nil, nil, 1, 2)
local yellDarkRevolation				= mod:NewYell(273365)
local yellDarkRevolationFades			= mod:NewShortFadesYell(273365)
local specWarnPitofDespair				= mod:NewSpecialWarningDispel(273434, "RemoveCurse", nil, nil, 1, 2)
local specWarnPoolofDarkness			= mod:NewSpecialWarningCount(273361, false, nil, nil, 1, 2)--Special warning for assigned soakers to optionally enable
local specWarnCallofBlood				= mod:NewSpecialWarningSwitch(273889, "-Healer", nil, nil, 1, 2)
----Forces of Blood
local specWarnCongealBlood				= mod:NewSpecialWarningSwitch(273451, "Dps", nil, nil, 3, 2)
local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: Zul, Awakened
local specWarnRupturingBlood			= mod:NewSpecialWarningStack(274358, nil, 2, nil, nil, 1, 6)
local specWarnRupturingBloodTaunt		= mod:NewSpecialWarningTaunt(274358, nil, nil, nil, 1, 2)
local specWarnRupturingBloodEdge		= mod:NewSpecialWarningMoveTo(274358, nil, nil, nil, 1, 7)
local yellRupturingBloodFades			= mod:NewShortFadesYell(274358)
local specWarnDeathwish					= mod:NewSpecialWarningYou(274271, nil, nil, nil, 1, 2)
local yellDeathwish						= mod:NewYell(274271)
local specWarnDeathwishNear				= mod:NewSpecialWarningClose(274271, nil, nil, nil, 1, 2)

mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerDarkRevolationCD				= mod:NewAITimer(12.1, 273365, nil, nil, nil, 3)
local timerPoolofDarknessCD				= mod:NewAITimer(12.1, 273361, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerCallofBloodCD				= mod:NewAITimer(12.1, 273889, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18538))
local timerBloodyCleaveCD				= mod:NewAITimer(12.1, 273316, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCongealBloodCD				= mod:NewAITimer(12.1, 273451, nil, "Dps", nil, 5, nil, DBM_CORE_DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18550))
local timerRupturingBloodCD				= mod:NewAITimer(12.1, 274358, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDeathwishCD					= mod:NewAITimer(12.1, 274271, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MAGIC_ICON)


--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(258040, true)
mod:AddNamePlateOption("NPAuraOnPresence", 276093)
mod:AddNamePlateOption("NPAuraOnThrumming", 273288)
mod:AddNamePlateOption("NPAuraOnEngorgedBurst", 276299)

mod.vb.poolCount = 0
local unitTracked = {}

function mod:OnCombatStart(delay)
	self.vb.poolCount = 0
	timerDarkRevolationCD:Start(1-delay)
	timerPoolofDarknessCD:Start(1-delay)
	timerCallofBloodCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(4, "enemypower", 1)
	end
	table.wipe(unitTracked)
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
		if self.Options.NPAuraOnEngorgedBurst then
			self:RegisterOnUpdateHandler(function(self)
				for i = 1, 40 do
					local UnitID = "nameplate"..i
					local GUID = UnitGUID(UnitID)
					local cid = self:GetCIDFromGUID(GUID)
					if cid == 139059 then
						local unitPower = UnitPower(UnitID)
						if not unitTracked[GUID] then unitTracked[GUID] = "None" end
						if (unitPower < 30) then
							if unitTracked[GUID] ~= "Green" then
								unitTracked[GUID] = "Green"
								DBM.Nameplate:Show(true, GUID, 276299, 463281)
							end
						elseif (unitPower < 60) then
							if unitTracked[GUID] ~= "Yellow" then
								unitTracked[GUID] = "Yellow"
								DBM.Nameplate:Hide(true, GUID, 276299, 463281)
								DBM.Nameplate:Show(true, GUID, 276299, 460954)
							end
						elseif (unitPower < 90) then
							if unitTracked[GUID] ~= "Red" then
								unitTracked[GUID] = "Red"
								DBM.Nameplate:Hide(true, GUID, 276299, 460954)
								DBM.Nameplate:Show(true, GUID, 276299, 463282)
							end
						elseif (unitPower < 100) then
							if unitTracked[GUID] ~= "Critical" then
								unitTracked[GUID] = "Critical"
								DBM.Nameplate:Hide(true, GUID, 276299, 463282)
								DBM.Nameplate:Show(true, GUID, 276299, 237521)
							end
						end
					end
				end
			end, 1)
		end
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming or self.Options.NPAuraOnEngorgedBurst then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273361 then
		self.vb.poolCount = self.vb.poolCount + 1
		if self.Options.SpecWarn273361count then
			specWarnPoolofDarkness:Show(self.vb.poolCount)
			specWarnPoolofDarkness:Play("helpsoak")
		else
			warnPoolofDarkness:Show(self.vb.poolCount)
		end
		timerPoolofDarknessCD:Start()
	elseif spellId == 273889 then
		specWarnCallofBlood:Show()
		specWarnCallofBlood:Play("killmob")
		timerCallofBloodCD:Start()
	elseif spellId == 273316 then--Tank Cleave
		timerBloodyCleaveCD:Start(nil, args.sourceGUID)
	elseif spellId == 273451 and self:AntiSpam(8, 1) then
		specWarnCongealBlood:Show()
		specWarnCongealBlood:Play("targetchange")
		timerCongealBloodCD:Start(nil, args.sourceGUID)
	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBloodshard:Show(args.sourceName)
		specWarnBloodshard:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274358 then
		timerRupturingBloodCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274358 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnRupturingBlood:Show(amount)
					specWarnRupturingBlood:Play("stackhigh")
					yellRupturingBloodFades:Cancel()
					yellRupturingBloodFades:Countdown(20)
					specWarnRupturingBloodEdge:Cancel()
					specWarnRupturingBloodEdge:Schedule(15, DBM_CORE_ROOM_EDGE)
					specWarnRupturingBloodEdge:CancelVoice()
					specWarnRupturingBloodEdge:ScheduleVoice(15, "runtoedge")
				else
					--local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
					--local remaining
					--if expireTime then
					--	remaining = expireTime-GetTime()
					--end
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
						specWarnRupturingBloodTaunt:Show(args.destName)
						specWarnRupturingBloodTaunt:Play("tauntboss")
					else
						warnRupturingBlood:Show(args.destName, amount)
					end
				end
			else
				warnRupturingBlood:Show(args.destName, amount)
			end
		end
	elseif spellId == 273365 or spellId == 271640 then--Two versions of debuff, one that spawns an add and one that does not (so probably LFR/normal version vs heroic/mythic version)
		if self:AntiSpam(5, 2) then
			timerDarkRevolationCD:Start()
		end
		if args:IsPlayer() then
			specWarnDarkRevolation:Show()
			specWarnDarkRevolation:Play("targetyou")
			yellDarkRevolation:Yell()
			yellDarkRevolationFades:Countdown(10)
		end
	elseif spellId == 273434 then
		specWarnPitofDespair:CombinedShow(0.3, args.destName)
		specWarnPitofDespair:CancelVoice()--Avoid spam
		specWarnPitofDespair:ScheduleVoice(0.3, "helpdispel")
	elseif spellId == 276093 then--Sanguine Presence
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 273288 then--Thrumming Pulse
		if self.Options.NPAuraOnThrumming then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 274271 then
		if self:AntiSpam(5, 4) then
			timerDeathwishCD:Start()
		end
		if args:IsPlayer() then
			specWarnDeathwish:Show()
			specWarnDeathwish:Play("targetyou")
			yellDeathwish:Yell()
		elseif self:CheckNearby(15, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnDeathwishNear:CombinedShow(0.3, args.destName)
			specWarnDeathwishNear:CancelVoice()--Avoid spam
			specWarnDeathwishNear:ScheduleVoice(0.3, "runaway")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 273365 or spellId == 271640 then
		if args:IsPlayer() then
			yellDarkRevolationFades:Cancel()
		end
	elseif spellId == 276093 then--Sanguine Presence
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 273288 then--Thrumming Pulse
		if self.Options.NPAuraOnThrumming then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 274358 then
		if args:IsPlayer() then
			yellRupturingBloodFades:Cancel()
			specWarnRupturingBloodEdge:Cancel()
			specWarnRupturingBloodEdge:CancelVoice()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 139185 then--minion-of-zul
	
	elseif cid == 139051 then--nazmani-crusher
		timerBloodyCleaveCD:Stop(args.destGUID)
	elseif cid == 139057 then--nazmani-bloodhexer
		timerCongealBloodCD:Stop(args.destGUID)
	elseif cid == 139059 then--Bloodthirsty Crawg
		DBM.Nameplate:Hide(true, args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274168 then--Locus of Corruption
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerDarkRevolationCD:Stop()
		timerPoolofDarknessCD:Stop()
		timerCallofBloodCD:Stop()
		timerRupturingBloodCD:Start(2)
		timerDeathwishCD:Start(2)
	end
end
