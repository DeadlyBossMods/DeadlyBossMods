local mod	= DBM:NewMod(2195, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(138967)
mod:SetEncounterID(2145)
mod:DisableESCombatDetection()--ES fires moment you throw out CC, so it can't be trusted for combatstart
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 273889 274098 274119 273316 273451 273350",
	"SPELL_CAST_SUCCESS 273360 273365 271640 274358 274168",
	"SPELL_AURA_APPLIED 273365 271640 273434 276093 273288 274358 274271 273432 276434",
	"SPELL_AURA_APPLIED_DOSE 274358",
	"SPELL_AURA_REMOVED 273365 271640 276093 273288 274358 274271 273432 276434",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_TARGET_UNFILTERED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, move RegisterOnUpdateHandler to only be used when one of those adds is actually up (if we can detect their spawns and deaths cleanly)
--TODO, check Locus of Corruption trigger for bugs after adding unneeded antispam to fix an impossible bug
--TODO, stack count assumed for tank swaps?
--TODO, check if all blood triggers associated with correct mobs, it was hard to see from video
--TODO, minion of zul fixate detection?
--TODO, maybe switch warning for minions of zul, or detectable spawns, show on a custom infoframe number of adds up (each type)
--[[
(ability.id = 273889 or ability.id = 274098 or ability.id = 274119) and type = "begincast"
 or (ability.id = 274358 or ability.id = 274168 or ability.id = 273365 or ability.id = 271640 or ability.id = 273360) and type = "cast"
 or (ability.id = 273889 or ability.id = 274098 or ability.id = 274119) and type = "cast"
 or (ability.id = 273316 or ability.id = 273451) and type = "begincast"
--]]
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Stage One: The Forces of Blood
local warnPoolofDarkness				= mod:NewCountAnnounce(273361, 4)--Generic warning since you want to be aware of it but not emphesized unless you're an assigned soaker
local warnActiveDecay					= mod:NewTargetNoFilterAnnounce(276434, 1)
--Stage Two: Zul, Awakened
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnRupturingBlood				= mod:NewStackAnnounce(273365, 2, nil, "Tank")

--Stage One: The Forces of Blood
local specWarnDarkRevolation			= mod:NewSpecialWarningMoveAway(273365, nil, nil, nil, 1, 2)
local yellDarkRevolation				= mod:NewYell(273365)
local yellDarkRevolationFades			= mod:NewShortFadesYell(273365)
local specWarnPitofDespair				= mod:NewSpecialWarningDispel(273434, "RemoveCurse", nil, nil, 1, 2)
local specWarnPoolofDarkness			= mod:NewSpecialWarningCount(273361, false, nil, nil, 1, 2)--Special warning for assigned soakers to optionally enable
local specWarnCallofCrawg				= mod:NewSpecialWarningSwitchCount("ej18541", "-Healer", nil, nil, 1, 2)
local specWarnCallofHexer				= mod:NewSpecialWarningSwitchCount("ej18540", "-Healer", nil, nil, 1, 2)
local specWarnCallofCrusher				= mod:NewSpecialWarningSwitchCount("ej18539", "-Healer", nil, nil, 1, 2)
local specWarnMinionofZul				= mod:NewSpecialWarningSwitch("ej18530", "MagicDispeller", nil, nil, 1, 2)
----Forces of Blood
local specWarnCongealBlood				= mod:NewSpecialWarningSwitch(273451, "Dps", nil, nil, 3, 2)
local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, false, nil, 2, 1, 2)--Spam cast, so opt in, not opt out
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: Zul, Awakened
local specWarnRupturingBlood			= mod:NewSpecialWarningStack(274358, nil, 3, nil, nil, 1, 6)
local specWarnRupturingBloodTaunt		= mod:NewSpecialWarningTaunt(274358, nil, nil, nil, 1, 2)
local specWarnRupturingBloodEdge		= mod:NewSpecialWarningMoveTo(274358, nil, nil, nil, 1, 7)
local yellRupturingBloodFades			= mod:NewShortFadesYell(274358)
local specWarnDeathwish					= mod:NewSpecialWarningYou(274271, nil, nil, nil, 1, 2)
local yellDeathwish						= mod:NewYell(274271)
local specWarnDeathwishNear				= mod:NewSpecialWarningClose(274271, nil, nil, nil, 1, 2)

mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerDarkRevolationCD				= mod:NewCDTimer(45, 273365, nil, nil, nil, 3)
local timerPoolofDarknessCD				= mod:NewCDCountTimer(30.6, 273361, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerCallofCrawgCD				= mod:NewNextCountTimer(14, "ej18541", nil, nil, nil, 1, 273889, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerCallofHexerCD				= mod:NewNextCountTimer(14, "ej18540", nil, nil, nil, 1, 273889, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerCallofCrusherCD				= mod:NewNextCountTimer(14, "ej18539", nil, nil, nil, 1, 273889, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerAddIncoming					= mod:NewTimer(12, "timerAddIncoming", 273889, nil, nil, 1, DBM_CORE_DAMAGE_ICON)--Even if you push the boss before add appears, if this timer has started, add IS coming
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18538))
local timerBloodyCleaveCD				= mod:NewCDTimer(13.4, 273316, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCongealBloodCD				= mod:NewCDTimer(23, 273451, nil, "Dps", nil, 5, nil, DBM_CORE_DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18550))
local timerRupturingBloodCD				= mod:NewCDTimer(6.1, 274358, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDeathwishCD					= mod:NewNextTimer(25.6, 274271, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MAGIC_ICON)


--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(258040, true)
mod:AddNamePlateOption("NPAuraOnPresence", 276093)
mod:AddNamePlateOption("NPAuraOnThrumming", 273288)
mod:AddNamePlateOption("NPAuraOnBoundbyShadow", 273432)
mod:AddNamePlateOption("NPAuraOnEngorgedBurst", 276299)
mod:AddNamePlateOption("NPAuraOnDecayingFlesh", 276434)
mod:AddSetIconOption("SetIconOnDecay", 276434, true, true)

mod.vb.phase = 1
mod.vb.poolCount = 0
mod.vb.CrawgSpawnCount = 0
mod.vb.HexerSpawnCount = 0
mod.vb.CrusherSpawnCount = 0
mod.vb.activeDecay = nil
local unitTracked = {}
--P1 Add Timers (heroic)
local CrawgTimers = {35, 42, 46.6, 47.2}
local HexerTimers = {51, 62.4, 62.9}
local CrusherTimers = {70, 63.6}
local CrawgName, HexerName, CrusherName = DBM:EJ_GetSectionInfo(18541), DBM:EJ_GetSectionInfo(18540), DBM:EJ_GetSectionInfo(18539)

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				if currentPower / maxPower * 100 >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		--Player personal checks
		local spellName3, _, _, _, _, expireTime = DBM:UnitDebuff("player", 276672)
		if spellName3 and expireTime then--Personal Unleashed Shadow
			local remaining = expireTime-GetTime()
			addLine(spellName3, remaining)
		end
		local spellName4, _, currentStack = DBM:UnitDebuff("player", 274195)
		if spellName4 and currentStack then--Personal Corrupted Blood
			addLine(spellName4, currentStack)
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	DBM:AddMsg("There is no Dana, only Zul")
	self.vb.phase = 1
	self.vb.poolCount = 0
	self.vb.CrawgSpawnCount = 0
	self.vb.HexerSpawnCount = 0
	self.vb.CrusherSpawnCount = 0
	self.vb.activeDecay = nil
	timerPoolofDarknessCD:Start(20.5-delay, 1)
	timerDarkRevolationCD:Start(30-delay)
	timerCallofCrawgCD:Start(35, 1)--35-38
	timerCallofHexerCD:Start(51.3, 1)--51-54
	timerCallofCrusherCD:Start(70, 1)--70-73
	if self.Options.InfoFrame then
		--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	table.wipe(unitTracked)
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming or self.Options.NPAuraOnBoundbyShadow or self.Options.NPAuraOnEngorgedBurst or self.Options.NPAuraOnDecayingFlesh then
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
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming or self.Options.NPAuraOnBoundbyShadow or self.Options.NPAuraOnEngorgedBurst or self.Options.NPAuraOnDecayingFlesh then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273889 then--Bloodthirsty Crawg
		self.vb.CrawgSpawnCount = self.vb.CrawgSpawnCount + 1
		specWarnCallofCrawg:Show(self.vb.CrawgSpawnCount)
		specWarnCallofCrawg:Play("killmob")
		--local timer = self.vb.phase == 2 and P2CrawgTimers[self.vb.CrawgSpawnCount+1] or CrawgTimers[self.vb.CrawgSpawnCount+1]
		local timer = CrawgTimers[self.vb.CrawgSpawnCount+1]
		if timer then
			timerCallofCrawgCD:Start(timer, self.vb.CrawgSpawnCount+1)
		end
	elseif spellId == 274098 then--nazmani-bloodhexer
		self.vb.HexerSpawnCount = self.vb.HexerSpawnCount + 1
		specWarnCallofHexer:Show(self.vb.HexerSpawnCount)
		specWarnCallofHexer:Play("killmob")
		--local timer = self.vb.phase == 2 and P2HexerTimers[self.vb.HexerSpawnCount+1] or HexerTimers[self.vb.HexerSpawnCount+1]
		local timer = HexerTimers[self.vb.HexerSpawnCount+1]
		if timer then
			timerCallofHexerCD:Start(timer, self.vb.HexerSpawnCount+1)
		end
	elseif spellId == 274119 then--nazmani-crusher
		self.vb.CrusherSpawnCount = self.vb.CrusherSpawnCount + 1
		specWarnCallofCrusher:Show(self.vb.CrusherSpawnCount)
		specWarnCallofCrusher:Play("killmob")
		--local timer = self.vb.phase == 2 and P2CrusherTimers[self.vb.CrusherSpawnCount+1] or CrusherTimers[self.vb.CrusherSpawnCount+1]
		local timer = CrusherTimers[self.vb.CrusherSpawnCount+1]
		if timer then
			timerCallofCrusherCD:Start(timer, self.vb.CrusherSpawnCount+1)
		end
	elseif spellId == 273316 then--Tank Cleave
		timerBloodyCleaveCD:Start(13.4, args.sourceGUID)
	elseif spellId == 273451 and self:AntiSpam(8, 1) then
		specWarnCongealBlood:Show()
		specWarnCongealBlood:Play("targetchange")
		timerCongealBloodCD:Start(23, args.sourceGUID)
	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBloodshard:Show(args.sourceName)
		specWarnBloodshard:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274358 then
		timerRupturingBloodCD:Start()
	elseif spellId == 274168 and self:AntiSpam(5, 2) then--Apparently requires antispam for something that fire ONCE in combat log, no idea why.
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerDarkRevolationCD:Stop()
		timerPoolofDarknessCD:Stop()
		timerCallofCrawgCD:Stop()
		timerCallofHexerCD:Stop()
		timerCallofCrusherCD:Stop()
		timerRupturingBloodCD:Start(3.7)
		timerPoolofDarknessCD:Start(15, self.vb.poolCount+1)--Still used in P2
		timerDeathwishCD:Start(20)
	elseif spellId == 273365 or spellId == 271640 then--Two versions of debuff, one that spawns an add and one that does not (so probably LFR/normal version vs heroic/mythic version)
		timerDarkRevolationCD:Start()
	elseif spellId == 273360 and self:AntiSpam(5, 5) then
		self.vb.poolCount = self.vb.poolCount + 1
		if self.Options.SpecWarn273361count then
			specWarnPoolofDarkness:Show(self.vb.poolCount)
			specWarnPoolofDarkness:Play("helpsoak")
		else
			warnPoolofDarkness:Show(self.vb.poolCount)
		end
		timerPoolofDarknessCD:Start(nil, self.vb.poolCount+1)
	elseif spellId == 273889 then--Bloodthirsty Crawg
		timerAddIncoming:Start(12, CrawgName)
	elseif spellId == 274098 then--nazmani-bloodhexer
		timerAddIncoming:Start(12, HexerName)
	elseif spellId == 274119 then--nazmani-crusher
		timerAddIncoming:Start(12, CrusherName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274358 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
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
		else--Not a tank
			--Make sure someone who's not a tank still gets a warning and told to go to edge of room
			--Non tanks won't wait til 3 stacks to tell tank to run out
			if args:IsPlayer() then
				specWarnRupturingBlood:Show(1)
				specWarnRupturingBlood:Play("stackhigh")
				yellRupturingBloodFades:Cancel()
				yellRupturingBloodFades:Countdown(20)
				specWarnRupturingBloodEdge:Cancel()
				specWarnRupturingBloodEdge:Schedule(15, DBM_CORE_ROOM_EDGE)
				specWarnRupturingBloodEdge:CancelVoice()
				specWarnRupturingBloodEdge:ScheduleVoice(15, "runtoedge")
			end
		end
	elseif spellId == 273365 or spellId == 271640 then--Two versions of debuff, one that spawns an add and one that does not (so probably LFR/normal version vs heroic/mythic version)
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
	elseif spellId == 273432 then--Bound by Shadow
		if self.Options.NPAuraOnBoundbyShadow then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 276434 then--Decaying Flesh
		self.vb.activeDecay = args.destGUID
		warnActiveDecay:Show(args.destName)
		if self.Options.NPAuraOnDecayingFlesh then
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
		if spellId == 273365 and self:AntiSpam(5, 3) then
			specWarnMinionofZul:Show()
			specWarnMinionofZul:Play("helpdispel")
		end
	elseif spellId == 276093 then--Sanguine Presence
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 273288 then--Thrumming Pulse
		if self.Options.NPAuraOnThrumming then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 273432 then--Bound by Shadow
		if self.Options.NPAuraOnBoundbyShadow then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 276434 then--Decaying Flesh
		if self.Options.NPAuraOnDecayingFlesh then
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

do
	local function TrySetTarget(self)
		if DBM:GetRaidRank() >= 1 then
			for uId in DBM:GetGroupMembers() do
				if UnitGUID(uId.."target") == self.vb.activeDecay then
					self.vb.activeDecay = nil
					SetRaidTarget(uId.."target", 8)
				end
				if not (self.vb.activeDecay) then
					break
				end
			end
		end
	end

	function mod:UNIT_TARGET_UNFILTERED()
		if self.Options.SetIconOnDecay and self.vb.activeDecay then
			TrySetTarget(self)
		end
	end
end

--At some point during testing, blizzard hotfixed out the CLEU event for pool of darkness, this is the backup (1 second slower than old CLEU event)
--CLEU event is still coded into mod for good measure in case it returns but not holding breath
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:273361") and self:AntiSpam(5, 5) then
		self.vb.poolCount = self.vb.poolCount + 1
		if self.Options.SpecWarn273361count then
			specWarnPoolofDarkness:Show(self.vb.poolCount)
			specWarnPoolofDarkness:Play("helpsoak")
		else
			warnPoolofDarkness:Show(self.vb.poolCount)
		end
		timerPoolofDarknessCD:Start(nil, self.vb.poolCount+1)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then--Deathwish
		timerDeathwishCD:Start()
	end
end
