local mod	= DBM:NewMod(2330, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144747, 144767, 144963, 144941)
mod:SetEncounterID(2268)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(18358)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282098 282107 285889 282155 282411",
	"SPELL_CAST_SUCCESS 282444 285878 282636",
	"SPELL_AURA_APPLIED 282079 285945 282135 286007 282209 282444 282834 286811 284663 285879 290573",
	"SPELL_AURA_APPLIED_DOSE 285945 282444",
	"SPELL_AURA_REMOVED 282079 282135 286007 282834 286811 290573",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, fine tune Lacerating Claws swap stacks
--TODO, fine tune attack speed swaps?
--TODO, verify what causes pakus timer to be 65 or 70 pretty consistently, but not always.
--Below are two pulls, same guild, same strat, everything. timers are 70, 60, 65 in one and 70, 70, 60 in other
--https://www.warcraftlogs.com/reports/tvFNR43pf6TcGjYL#fight=7&type=summary&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20282098%20or%20ability.id%20%3D%20282107%20or%20ability.id%20%3D%20285889%20or%20ability.id%20%3D%20282155%20or%20ability.id%20%3D%20282411)%20and%20type%20%3D%20%22begincast%22%0A%20or%20(ability.id%20%3D%20282444%20or%20ability.id%20%3D%20285878%20or%20ability.id%20%3D%20282636%20or%20ability.id%20%3D%20282736)%20and%20type%20%3D%20%22cast%22%0A%20or%20(ability.id%20%3D%20282209%20or%20ability.id%20%3D%20282834%20or%20ability.id%20%3D%20286811)%20and%20type%20%3D%20%22applydebuff%22%0A%20or%20ability.id%20%3D%20282109%20and%20target.name%20%3D%20%22Roirrawami%22&view=events
--https://www.warcraftlogs.com/reports/tvFNR43pf6TcGjYL#fight=8&type=summary&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20282098%20or%20ability.id%20%3D%20282107%20or%20ability.id%20%3D%20285889%20or%20ability.id%20%3D%20282155%20or%20ability.id%20%3D%20282411)%20and%20type%20%3D%20%22begincast%22%0A%20or%20(ability.id%20%3D%20282444%20or%20ability.id%20%3D%20285878%20or%20ability.id%20%3D%20282636%20or%20ability.id%20%3D%20282736)%20and%20type%20%3D%20%22cast%22%0A%20or%20(ability.id%20%3D%20282209%20or%20ability.id%20%3D%20282834%20or%20ability.id%20%3D%20286811)%20and%20type%20%3D%20%22applydebuff%22%0A%20or%20ability.id%20%3D%20282109%20and%20target.name%20%3D%20%22Roirrawami%22&view=events
--Line 2 of expression is wraths (that's right blizz put 0 of them in combat log)
--Line 3 of expression is hex, separated in case want to filter it out since it is a log spammer
--[[
(ability.id = 282098 or ability.id = 282107 or ability.id = 285889 or ability.id = 282155 or ability.id = 282411) and type = "begincast"
 or (ability.id = 282444 or ability.id = 285878 or ability.id = 282636 or ability.id = 282736) and type = "cast"
 or (ability.id = 282209 or ability.id = 282834 or ability.id = 286811) and type = "applydebuff"
 or ability.id = 282109 and target.name = "Omegall"
 or (ability.id = 282135 or ability.id = 290573 or ability.id = 284663) and type = "applydebuff"
--]]
--General
local warnActivated						= mod:NewTargetAnnounce(118212, 3, 78740, nil, nil, nil, nil, nil, true)
--Paku's Aspect
local warnGiftofWind					= mod:NewSpellAnnounce(282098, 3)
local warnPakuWrath						= mod:NewSoonAnnounce(282107, 4)
--Gonk's Aspect
local warnCrawlingHex					= mod:NewTargetAnnounce(282135, 2)
--Kimbul's Aspect
local warnLaceratingClaws				= mod:NewStackAnnounce(282444, 2, nil, "Tank")
--Akunda's Aspect
local warnMindWipe						= mod:NewTargetNoFilterAnnounce(285878, 4)
local warnAkundasWrath					= mod:NewTargetAnnounce(286811, 2)
--Bwonsamdi
local warnBwonsamdisWrath				= mod:NewTargetNoFilterAnnounce(284663, 4, nil, false, 2)--Spammy latter fight, opt in, not opt out

--General
local specWarnActivated					= mod:NewSpecialWarningSwitchCount(118212, "Tank", DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(118212), nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--Pa'ku's Aspect
local specWarnHasteningWinds			= mod:NewSpecialWarningCount(285945, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(12, 270447), nil, 1, 2)
local specWarnHasteningWindsOther		= mod:NewSpecialWarningTaunt(285945, nil, nil, nil, 1, 2)--Should be dispelled vs tank swapped, but in super low case a 10 man group has no dispeller, we need tank warning
local specWarnPakusWrath				= mod:NewSpecialWarningMoveTo(282107, nil, nil, nil, 3, 2)
--Gonk's Aspect
local specWarnCrawlingHex				= mod:NewSpecialWarningYou(282135, nil, nil, nil, 1, 2)
local yellCrawlingHex					= mod:NewPosYell(282135)
local yellCrawlingHexFades				= mod:NewIconFadesYell(282135)
local yellCrawlingHexAlt				= mod:NewYell(282135)
local yellCrawlingHexFadesAlt			= mod:NewShortYell(282135)
local specWarnCrawlingHexNear			= mod:NewSpecialWarningClose(282135, nil, nil, nil, 1, 2)
local specWarnRaptorForm				= mod:NewSpecialWarningDefensive(285889, nil, nil, nil, 3, 2)
local specWarnGonksWrath				= mod:NewSpecialWarningSwitch(282155, "Dps", nil, nil, 1, 2)
local specWarnMarkofPrey				= mod:NewSpecialWarningRun(282209, nil, nil, nil, 4, 2)
local yellMarkofPrey					= mod:NewYell(282209)
--Kimbul's Aspect
local specWarnLaceratingClaws			= mod:NewSpecialWarningStack(282444, nil, 8, nil, nil, 1, 6)
local specWarnLaceratingClawsTaunt		= mod:NewSpecialWarningTaunt(282444, nil, nil, nil, 1, 2)
local specWarnKimbulsWrath				= mod:NewSpecialWarningYou(282834, nil, nil, nil, 1, 2)
local yellKimbulsWrath					= mod:NewYell(282834)
local yellKimbulsWrathFades				= mod:NewFadesYell(282834)
local specWarnKimbulsWrathNear			= mod:NewSpecialWarningClose(282834, nil, nil, nil, 1, 2)
--Akunda's Aspect
local specWarnThunderingStorm			= mod:NewSpecialWarningRun(282411, "Melee", nil, nil, 4, 2)
local specWarnMindWipe					= mod:NewSpecialWarningYou(285878, nil, nil, nil, 1, 2)
local specWarnAkundasWrath				= mod:NewSpecialWarningYou(286811, nil, nil, nil, 1, 2)
local yellAkundasWrath					= mod:NewYell(286811)
local yellAkundasWrathFades				= mod:NewFadesYell(286811)
--Krag'wa

--Bwonsamdi
local specWarnBwonsamdisWrath			= mod:NewSpecialWarningYou(284663, nil, nil, nil, 3, 2)
local specWarnBwonsamdisWrathDispel		= mod:NewSpecialWarningDispel(284663, "RemoveCurse", nil, nil, 1, 2)

--Pa'ku's Aspect
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19013))
local timerGiftofWindCD					= mod:NewCDTimer(31.6, 282098, nil, nil, nil, 2)
local timerPakusWrathCD					= mod:NewCDCountTimer(60, 282107, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Gonk's Aspect
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19016))
local timerCrawlingHexCD				= mod:NewCDTimer(25.4, 282135, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
local timerRaptorFormCD					= mod:NewCDTimer(15.8, 285889, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--15.8-17
local timerGonksWrathCD					= mod:NewCDTimer(60, 282155, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Kimbul's Aspect
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19021))
local timerLaceratingClawsCD			= mod:NewCDTimer(26.8, 282444, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--26.8-31.6
local timerKinbulsWrathCD				= mod:NewCDTimer(60, 282834, nil, nil, nil, 3)
--Akunda's Aspect
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19024))
local timerThunderingStormCD			= mod:NewCDTimer(19.5, 282411, nil, "Melee", nil, 3, nil, DBM_CORE_TANK_ICON)
local timerMindWipeCD					= mod:NewCDTimer(33.7, 285878, nil, nil, nil, 3)
local timerAkundasWrathCD				= mod:NewCDTimer(60, 283685, nil, nil, nil, 3)
--Krag'wa
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19193))
local timerKragwasWrathCD				= mod:NewCDTimer(49.8, 282636, nil, nil, nil, 3)
--Bwonsamdi
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19195))
local timerBwonsamdisWrathCD			= mod:NewCDCountTimer(50, 284666, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON..DBM_CORE_HEALER_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPakusWrath				= mod:NewCountdown(70, 282107, true, nil, 5)
--local countdownLaceratingClaws		= mod:NewCountdown("Alt12", 244016, false, 2, 3)
local countdownKragwasWrath				= mod:NewCountdown("AltTwo32", 282636, "Ranged", nil, 3)

mod:AddNamePlateOption("NPAuraOnPact", 282079)
mod:AddNamePlateOption("NPAuraOnPackHunter", 286007)
mod:AddNamePlateOption("NPAuraOnFixate", 282209)
mod:AddSetIconOption("SetIconHex", 282135, false, false, {1, 2, 3, 4})
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(282079, true)--Not real spellID, just filler for now

--mod.vb.phase = 1
mod.vb.hexIcon = 1
mod.vb.ignoredActivate = true
mod.vb.pakuWrathCount = 0
mod.vb.wrathCount = 0
mod.vb.kragwaCast = 0
local raptorsSeen = {}

local function clearActivateIgnore(self)
	self.vb.ignoredActivate = false
end

function mod:OnCombatStart(delay)
	table.wipe(raptorsSeen)
	self.vb.hexIcon = 1
	self.vb.ignoredActivate = true
	self.vb.pakuWrathCount = 0
	self.vb.wrathCount = 0
	self.vb.kragwaCast = 0
	self:Schedule(3, clearActivateIgnore, self)
	if self.Options.NPAuraOnPact or self.Options.NPAuraOnPackHunter or self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(4, "enemypower", 2)
	end
	if self:IsHard() then
		timerKragwasWrathCD:Start(29.3-delay)
		countdownKragwasWrath:Start(29.3-delay)
		if self:IsMythic() then
			timerBwonsamdisWrathCD:Start(51-delay, 1)
		end
	end
end

function mod:OnCombatEnd()
	table.wipe(raptorsSeen)
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPact or self.Options.NPAuraOnPackHunter or self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282098 then
		warnGiftofWind:Show()
		timerGiftofWindCD:Start()
	elseif spellId == 282107 then
		DBM:AddMsg("blizz added Paku's Wrath to CLEU, tell DBM author!")
		--specWarnPakusWrath:Show(args.sourceName)
		--specWarnPakusWrath:Play("gathershare")
		--timerPakusWrathCD:Start()
		--countdownPakusWrath:Start()
	elseif spellId == 285889 then
		timerRaptorFormCD:Start()
		for i = 1, 4 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnRaptorForm:Show()
				specWarnRaptorForm:Play("defensive")
				break
			end
		end
	elseif spellId == 282155 then
		DBM:AddMsg("blizz added Gonk's Wrath to CLEU, tell DBM author!")
		--specWarnGonksWrath:Show()
		--specWarnGonksWrath:Play("killmob")
		--timerGonksWrathCD:Start()
	elseif spellId == 282411 then
		timerThunderingStormCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, true, false) then--Only show warning if target/focus on caster
			specWarnThunderingStorm:Show()
			specWarnThunderingStorm:Play("justrun")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282444 then
		timerLaceratingClawsCD:Start()
	elseif spellId == 285878 then
		timerMindWipeCD:Start()
	--elseif spellId == 284666 then
		--timerBwonsamdisWrathCD:Start()
	elseif spellId == 282636 then
		self.vb.kragwaCast = self.vb.kragwaCast + 1
		if self.vb.kragwaCast % 4 == 0 then
			timerKragwasWrathCD:Start(40)
			countdownKragwasWrath:Start(40)
		else
			timerKragwasWrathCD:Start(3)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282444 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 8 then
				if args:IsPlayer() then
					specWarnLaceratingClaws:Show(amount)
					specWarnLaceratingClaws:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnLaceratingClawsTaunt:Show(args.destName)
						specWarnLaceratingClawsTaunt:Play("tauntboss")
					else
						warnLaceratingClaws:Show(args.destName, amount)
					end
				end
			else
				warnLaceratingClaws:Show(args.destName, amount)
			end
		end
	elseif spellId == 285945 then
		local amount = args.amount or 1
		if (amount >= 12) and self:AntiSpam(5, 1) then--Fine Tune
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnHasteningWinds:Show(amount)
				specWarnHasteningWinds:Play("changemt")
			else
				specWarnHasteningWindsOther:Show(args.destName)
				specWarnHasteningWindsOther:Play("changemt")
			end
		end
	elseif spellId == 282079 then
		if self.Options.NPAuraOnPact then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 286007 then
		if self.Options.NPAuraOnPackHunter then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 282135 or spellId == 290573 then
		local icon = self.vb.hexIcon
		if args:IsPlayer() then
			specWarnCrawlingHex:Show()
			specWarnCrawlingHex:Play("targetyou")
			if icon > 8 then
				yellCrawlingHexAlt:Yell()
				yellCrawlingHexFadesAlt:Countdown(5)
			else
				yellCrawlingHex:Yell(icon, icon, icon)
				yellCrawlingHexFades:Countdown(5, nil, icon)
			end
		elseif self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnCrawlingHexNear:CombinedShow(0.3, args.destName)
			specWarnCrawlingHexNear:CancelVoice()--Avoid spam
			specWarnCrawlingHexNear:ScheduleVoice(0.3, "runaway")
		else
			warnCrawlingHex:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconHex and icon < 9 then
			self:SetIcon(args.destName, icon)
		end
		self.vb.hexIcon = self.vb.hexIcon + 1
	elseif spellId == 282209 then
		if args:IsPlayer() then
			if self:AntiSpam(3, 5) then
				specWarnMarkofPrey:Show()
				specWarnMarkofPrey:Play("justrun")
				yellMarkofPrey:Yell()
			end
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, nil, nil, true, {0.75, 0, 0, 0.75})
			end
		end
		if not raptorsSeen[args.sourceGUID] then
			raptorsSeen[args.sourceGUID] = true
			if self:AntiSpam(10, 2) then
				specWarnGonksWrath:Show()
				specWarnGonksWrath:Play("killmob")
				timerGonksWrathCD:Start()
			end
		end
	elseif spellId == 282834 then
		if args:IsPlayer() then
			specWarnKimbulsWrath:Show()
			specWarnKimbulsWrath:Play("targetyou")
			yellKimbulsWrath:Yell()
			yellKimbulsWrathFades:Countdown(12)
		elseif self:CheckNearby(5, args.destName) then
			specWarnKimbulsWrathNear:CombinedShow(1, args.destName)
			specWarnKimbulsWrathNear:ScheduleVoice(1, "runaway")
		end
		if self:AntiSpam(10, 3) then
			timerKinbulsWrathCD:Start()
		end
	elseif spellId == 285879 then
		if args:IsPlayer() then
			specWarnMindWipe:Show()
			specWarnMindWipe:Play("targetyou")
		else
			warnMindWipe:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 286811 then
		if args:IsPlayer() then
			specWarnAkundasWrath:Show()
			specWarnAkundasWrath:Play("runout")
			yellAkundasWrath:Yell()
			yellAkundasWrathFades:Countdown(6)
		else
			warnAkundasWrath:CombinedShow(0.3, args.destName)
		end
		if self:AntiSpam(10, 4) then
			timerAkundasWrathCD:Start()
		end
	elseif spellId == 284663 then
		if args:IsPlayer() then
			specWarnBwonsamdisWrath:Show()
			specWarnBwonsamdisWrath:Play("targetyou")
		else
			warnBwonsamdisWrath:Show(args.destName)
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and self:CheckDispelFilter() then
			specWarnBwonsamdisWrathDispel:Show(args.destName)
			specWarnBwonsamdisWrathDispel:Play("helpdispel")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282079 then
		if self.Options.NPAuraOnPact then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 282135 or spellId == 290573 then
		if args:IsPlayer() then
			yellCrawlingHexFades:Cancel()
		end
		if self.Options.SetIconHex then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 286007 then
		if self.Options.NPAuraOnPackHunter then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 282209 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 282834 then
		if args:IsPlayer() then
			yellKimbulsWrathFades:Cancel()
		end
	elseif spellId == 286811 then
		if args:IsPlayer() then
			yellAkundasWrathFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:282107") then
		self.vb.pakuWrathCount = self.vb.pakuWrathCount + 1
		specWarnPakusWrath:Show(L.Bird)
		specWarnPakusWrath:Play("gathershare")
		warnPakuWrath:Schedule(50)
		timerPakusWrathCD:Start(60, self.vb.pakuWrathCount+1)
		countdownPakusWrath:Start(60)
	end
end

do
	local Bwonsamdi = DBM:EJ_GetSectionInfo(19195)
	function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
		--IF Bwonsamdi is yeller, and target is nil, it's always a wrath. If there is a target, it's someone dying and Bwonsamdi taunting them.
		--The actual string matches for text shouldn't be needed any longer but being kept around in event Bwonsamdi's non english name in joural doesn't match non english name in yell sender
		if (not target and npc == Bwonsamdi) or msg:find(L.BwonsamdiWrath) or msg == L.BwonsamdiWrath or msg:find(L.BwonsamdiWrath2) or msg == L.BwonsamdiWrath2 then
			self:SendSync("BwonsamdiWrath")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 130966 then--Permanent Feign Death (dying/leaving) (slightly faster than UNIT_DIED)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 144747 then--Pa'ku's Aspect
			timerGiftofWindCD:Stop()
		elseif cid == 144767 then--Gonk's Aspect
			timerCrawlingHexCD:Stop()
			timerRaptorFormCD:Stop()
		elseif cid == 144963 then--Kimbul's Aspect
			timerLaceratingClawsCD:Stop()
		elseif cid == 144941 then--Akunda's Aspect
			timerThunderingStormCD:Stop()
			timerMindWipeCD:Stop()
		end
		if timerPakusWrathCD:GetRemaining(self.vb.pakuWrathCount+1) > 40 then
			local elapsed, total = timerPakusWrathCD:GetTime(self.vb.pakuWrathCount+1)
			local remaining = total - elapsed
			DBM:Debug("timerPakusWrathCD extended by: 10 seconds do to boss death with > 40 remaining", 2)
			timerPakusWrathCD:AddTime(10, self.vb.pakuWrathCount+1)
			countdownPakusWrath:Cancel()
			countdownPakusWrath:Start(remaining+10)
		end
	elseif spellId == 282080 then--Loa's Pact (entering)
		if not self.vb.ignoredActivate then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
		end
		--Start Timers
		local cid = self:GetUnitCreatureId(uId)
		if cid == 144747 then--Pa'ku's Aspect
			timerGiftofWindCD:Start(4.8)--Assuming he always starts at 90 energy even when he isn't spawned on pull
			timerPakusWrathCD:Start(73.5, self.vb.pakuWrathCount+1)--When actual emote fires, first event we can detect
			countdownPakusWrath:Start(73.5)
		elseif cid == 144767 then--Gonk's Aspect
			timerCrawlingHexCD:Start(13.4)--Assuming starting at 70 energy is always true
			timerRaptorFormCD:Start(15.7)
			timerGonksWrathCD:Start(31)
		elseif cid == 144963 then--Kimbul's Aspect
			timerLaceratingClawsCD:Start(10.3)
			timerKinbulsWrathCD:Start(42.2)
		elseif cid == 144941 then--Akunda's Aspect
			timerMindWipeCD:Start(5.6)
			timerAkundasWrathCD:Start(13)
			timerThunderingStormCD:Start(15.4)
		end
	elseif spellId == 283193 then--Since blizzard hates combat log so much (clawing hex)
		self.vb.hexIcon = 1
		timerCrawlingHexCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "BwonsamdiWrath" and self:IsInCombat() then
		self.vb.wrathCount = self.vb.wrathCount + 1
		timerBwonsamdisWrathCD:Start(50, self.vb.wrathCount+1)
	end
end
