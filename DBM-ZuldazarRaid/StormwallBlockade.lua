local mod	= DBM:NewMod(2337, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(146251, 146253, 146256)--Sister Katherine 146251, Brother Joseph 146253, Laminaria 146256
mod:SetEncounterID(2280)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(18367)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284262 284393 284383 285017 284362 288696 288941",
	"SPELL_CAST_SUCCESS 285350 285426 285118 290694 289795 287169 284106",
	"SPELL_AURA_APPLIED 286558 284405 285000 285382 285350 285426 287995 288205 284361",
	"SPELL_AURA_REFRESH 285000 285382",
	"SPELL_AURA_APPLIED_DOSE 285000 285382",
	"SPELL_AURA_REMOVED 286558 285000 285382 285350 285426 287995 288205 284361",
	"SPELL_INTERRUPT",
--	"SPELL_PERIODIC_DAMAGE 285075",
--	"SPELL_PERIODIC_MISSED 285075",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, switch to custom hybrid frame to show both shields and boss energy and storm's Wail
--TODO, icons and stuff for storm's wail
--TODO, add "watch wave" warning for Energized wake on mythic
--[[
(ability.id = 284262 or ability.id = 284393 or ability.id = 284383 or ability.id = 285017 or ability.id = 284362 or ability.id = 288696 or ability.id = 288941) and type = "begincast"
 or (ability.id = 285350 or ability.id = 285426 or ability.id = 285118 or ability.id = 290694 or ability.id = 289795 or ability.id = 287169 or ability.id = 284106) and type = "cast"
 or type = "interrupt"
 or ability.id = 284405 and type = "applydebuff"
--]]
--Stage One: Storm the Ships
----General
local warnTranslocate					= mod:NewTargetNoFilterAnnounce(284393, 2)
----Sister Katherine
local warnCracklingLightning			= mod:NewTargetAnnounce(288205, 4)
local warnElecShroud					= mod:NewTargetAnnounce(287995, 4)
local warnJoltingVolley					= mod:NewCountAnnounce(287169, 3)
----Brother Joseph
local warnSeaStorm						= mod:NewTargetAnnounce(284361, 2)
local warnTemptingSong					= mod:NewTargetAnnounce(284405, 2)
local warnTidalShroud					= mod:NewTargetAnnounce(286558, 4)
--Stage Two: Laminaria
local warnCataTides						= mod:NewCastAnnounce(288696, 3)
local warnKelpWrapped					= mod:NewStackAnnounce(285000, 2, nil, "Tank")
local warnStormsWail					= mod:NewTargetNoFilterAnnounce(285350, 3)

--Stage One: Storm the Ships
----General
local specWarnTidalEmpowerment			= mod:NewSpecialWarningInterrupt(284765, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(285075, false, nil, 2, 1, 8)
----Sister Katherine
local specWarnVoltaicFlash				= mod:NewSpecialWarningDodge(284262, nil, nil, nil, 2, 2)
local specWarnCracklingLightning		= mod:NewSpecialWarningMoveAway(288205, nil, nil, nil, 1, 2)
local yellCracklingLightning			= mod:NewYell(288205)
local yellCracklingLightningFades		= mod:NewShortFadesYell(288205)
----Brother Joseph
local specWarnSeaStorm					= mod:NewSpecialWarningMoveAway(284361, nil, nil, nil, 1, 2)
local yellSeaStorm						= mod:NewYell(284361)
local yellSeaStormFades					= mod:NewShortFadesYell(284361)
local specWarnSeasTemptation			= mod:NewSpecialWarningSwitch(284383, "RangedDps", nil, nil, 1, 2)--Ranged assumed for now, melee stay out until temping song goes out
local specWarnTemptingSong				= mod:NewSpecialWarningRun(284405, nil, nil, nil, 4, 2)
local yellTemptingSong					= mod:NewYell(284405)
--Stage Two: Laminaria
local specWarnEnergizedStorm			= mod:NewSpecialWarningSwitch("ej19312", "RangedDps", nil, nil, 1, 2)
--local yellKepWrapped					= mod:NewFadesYell(285000)
local specWarnSeaSwell					= mod:NewSpecialWarningDodge(285118, nil, nil, 2, 3, 2)
local specWarnIreoftheDeep				= mod:NewSpecialWarningSoak(285017, "-Tank", nil, nil, 1, 2)
local specWarnStormsWail				= mod:NewSpecialWarningMoveTo(285350, nil, nil, 2, 3, 2)
local yellStormsWail					= mod:NewYell(285350)
local yellStormsWailFades				= mod:NewShortFadesYell(285350)

--Stage One: Storm the Ships
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19257))
----Sister Katherine
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19261))
local timerVoltaicFlashCD				= mod:NewCDTimer(17, 284262, nil, nil, nil, 3)--17-35 wtf?
local timerCracklingLightningCD			= mod:NewCDTimer(12.1, 284106, nil, nil, nil, 3)--12.1 and 22 alternating
--local timerThunderousBoomCD			= mod:NewCastTimer(55, 284120, nil, nil, nil, 2)--After timing is figured out after crackling
local timerElecShroudCD					= mod:NewCDTimer(34, 287995, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)--34-41, maybe health based?
----Brother Joseph
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19262))
local timerSeaStormCD					= mod:NewCDTimer(10.9, 284360, nil, nil, nil, 3)
local timerSeasTemptationCD				= mod:NewCDCountTimer(34, 284383, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Might be health based
local timerTidalShroudCD				= mod:NewCDTimer(36.5, 286558, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)--Probalby health based
--Stage Two: Laminaria
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19258))
local timerCataTides					= mod:NewCastTimer(15, 288696, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSeaSwellCD					= mod:NewCDTimer(20.6, 285118, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerIreoftheDeepCD				= mod:NewCDTimer(32.8, 285017, nil, nil, nil, 5)
local timerStormsWailCD					= mod:NewCDTimer(120.2, 285350, nil, nil, nil, 3)
local timerStormsWail					= mod:NewTargetTimer(12, 285350, nil, nil, nil, 5)
local timerJoltingVolleyCD				= mod:NewCDCountTimer(43.6, 287169, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownSeaSwell					= mod:NewCountdown(20.6, 285118, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnKepWrapping", 285382)
mod:AddSetIconOption("SetIconWail", 285350, true)
mod:AddRangeFrameOption(5, 285118)
mod:AddInfoFrameOption(284760, true)

mod.vb.phase = 1
mod.vb.bossesDied = 0
mod.vb.cracklingCast = 0
mod.vb.sirenCount = 0
mod.vb.joltingCast = 0
mod.vb.stormsActive = 0
mod.vb.stormsWailIcon = 1
local freezingTidePod = DBM:GetSpellInfo(285075)
local stormTargets = {}

local updateInfoFrame
do
	local stormsWail = DBM:GetSpellInfo(285350)
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
		--Big Guys Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		if #stormTargets > 0 then
			--addLine("", "")
			for i=1, #stormTargets do
				local name = stormTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				local spellName, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 285350, 285426)
				if spellName and expireTime then
					local remaining = expireTime-GetTime()
					addLine(name, math.floor(remaining))
				end
			end
		end
		return lines, sortedLines
	end
end

--Needs to be run on pull and teleports (either player changing sides or boss)
local function delayedSisterUpdate(self, reschedule)
	self:Unschedule(delayedSisterUpdate)
	if self:CheckBossDistance(146251, true) then--Sister Katherine
		timerCracklingLightningCD:SetFade(false)
		timerVoltaicFlashCD:SetFade(false)
		timerElecShroudCD:SetFade(false)
	else
		timerCracklingLightningCD:SetFade(true)
		timerVoltaicFlashCD:SetFade(true)
		timerElecShroudCD:SetFade(true)
	end
	--Secondary scan (only runs on translocate)
	if reschedule and reschedule < 4 then
		self:Schedule(2, delayedSisterUpdate, self, reschedule+1)
	end
end

local function delayedBrotherUpdate(self, reschedule)
	self:Unschedule(delayedBrotherUpdate)
	if self:CheckBossDistance(146253, true) then--Brother Joseph
		timerSeaStormCD:SetFade(false)
		timerSeasTemptationCD:SetFade(false, self.vb.sirenCount+1)
		timerTidalShroudCD:SetFade(false)
	else
		timerSeaStormCD:SetFade(true)
		timerSeasTemptationCD:SetFade(true, self.vb.sirenCount+1)
		timerTidalShroudCD:SetFade(true)
	end
	--Secondary scan (only runs on translocate)
	if reschedule and reschedule < 4 then
		self:Schedule(2, delayedBrotherUpdate, self, reschedule+1)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(stormTargets)
	self.vb.phase = 1
	self.vb.bossesDied = 0
	self.vb.cracklingCast = 0
	self.vb.sirenCount = 0
	self.vb.joltingCast = 0
	self.vb.stormsActive = 0
	self.vb.stormsWailIcon = 1
	if not self:IsLFR() then
		--Sister
		timerCracklingLightningCD:Start(5.9-delay)--5.9-10.8
		timerVoltaicFlashCD:Start(8.8-delay)
		timerElecShroudCD:Start(30-delay)
		--Brother
		timerSeaStormCD:Start(6-delay)--0.3-8
		timerSeasTemptationCD:Start(15.5-delay, 1)--Might be health based
		timerTidalShroudCD:Start(30.1-delay)--30-32
	else
		--Sister
		timerCracklingLightningCD:Start(13.7-delay)--3.9-8.8?
		timerVoltaicFlashCD:Start(20-delay)
		--Brother
		timerSeaStormCD:Start(6-delay)--0.3-8
		timerSeasTemptationCD:Start(12.1-delay, 1)--Might be health based
	end
	if self:IsMythic() then
		timerSeaSwellCD:Start(19.8-delay)
		countdownSeaSwell:Start(19.8-delay)
	end
	if self.Options.NPAuraOnKepWrapping then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	self:Schedule(0.5, delayedSisterUpdate, self, true)--Update timers couple seconds into pull
	self:Schedule(0.5, delayedBrotherUpdate, self, true)--Update timers couple seconds into pull
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnKepWrapping then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	--Reset fades on wipes
	timerCracklingLightningCD:SetFade(false)
	timerVoltaicFlashCD:SetFade(false)
	timerElecShroudCD:SetFade(false)
	timerSeaStormCD:SetFade(false)
	timerSeasTemptationCD:SetFade(false)
	timerTidalShroudCD:SetFade(false)
end

function mod:OnTimerRecovery()
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284262 then
		if self:CheckBossDistance(args.sourceGUID, true) then
			specWarnVoltaicFlash:Show()
			specWarnVoltaicFlash:Play("watchorb")
			timerVoltaicFlashCD:SetFade(false)
		else
			timerVoltaicFlashCD:SetFade(true)
		end
		if self:IsLFR() then
			timerVoltaicFlashCD:Start(29)
		else
			timerVoltaicFlashCD:Start()--12
		end
	elseif spellId == 288941 and self:AntiSpam(20, 2) then--AntiSpam must be at least 15 here, 20 for good measure
		specWarnVoltaicFlash:Show()
		specWarnVoltaicFlash:Play("watchorb")
		timerVoltaicFlashCD:Start(42.5)
	elseif spellId == 284393 then
		warnTranslocate:Show(args.sourceName)
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 146251 then--Sister
			self.vb.cracklingCast = 0
			timerVoltaicFlashCD:Stop()
			timerCracklingLightningCD:Stop()
			timerElecShroudCD:Stop()
			--This may be more complicated than this, like maybe a pause/resume more so than this
			timerCracklingLightningCD:Start(14)
			timerVoltaicFlashCD:Start(17)
			timerElecShroudCD:Start(36.4)
			self:Schedule(3, delayedSisterUpdate, self, 1)
		else--Brother
			timerSeaStormCD:Stop()
			timerSeasTemptationCD:Stop()
			timerTidalShroudCD:Stop()

			--This may be more complicated than this, like maybe a pause/resume more so than this
			timerSeaStormCD:Start(12.1)
			timerSeasTemptationCD:Start(26.7, self.vb.sirenCount+1)--Even less sure about this one
			timerTidalShroudCD:Start(37.7)
			self:Schedule(3, delayedBrotherUpdate, self, 1)
		end
	elseif spellId == 284383 then
		self.vb.sirenCount = self.vb.sirenCount + 1
		if self:CheckBossDistance(args.sourceGUID, true) then
			specWarnSeasTemptation:Show()
			specWarnSeasTemptation:Play("killmob")
			timerSeasTemptationCD:SetFade(false)
		else
			timerSeasTemptationCD:SetFade(true)
		end
		timerSeasTemptationCD:Start(34, self.vb.sirenCount+1)
	elseif spellId == 285017 then
		specWarnIreoftheDeep:Show()
		specWarnIreoftheDeep:Play("helpsoak")
		timerIreoftheDeepCD:Start()
	elseif spellId == 284362 then
		if self:CheckBossDistance(args.sourceGUID, true) then
			timerSeaStormCD:SetFade(false)
		else
			timerSeaStormCD:SetFade(true)
		end
		if self:IsMythic() then
			timerSeaStormCD:Start(9.7)
		elseif self:IsLFR() then
			timerSeaStormCD:Start(17)
		else
			timerSeaStormCD:Start()--10.9
		end
	elseif spellId == 288696 then
		warnCataTides:Show()
		timerCataTides:Start()
		timerSeaSwellCD:Stop()
		countdownSeaSwell:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 285350 or spellId == 285426) and args:GetSrcCreatureID() == 146256 then
		self.vb.stormsActive = self.vb.stormsActive + 1
		timerStormsWailCD:Start()
	elseif spellId == 285118 then--All P2 Sea Swell
		specWarnSeaSwell:Show()
		specWarnSeaSwell:Play("watchstep")
		if self:IsMythic() then
			timerSeaSwellCD:Start(17)
			countdownSeaSwell:Start(17)
		elseif self:IsLFR() then
			timerSeaSwellCD:Start(24.3)
			countdownSeaSwell:Start(24.3)
		else
			timerSeaSwellCD:Start()
			countdownSeaSwell:Start(20.6)
		end
	elseif spellId == 290694 and self:AntiSpam(5, 3) then--Mythic P1 Sea Swell
		specWarnSeaSwell:Show()
		specWarnSeaSwell:Play("watchstep")
		timerSeaSwellCD:Start(20)
		countdownSeaSwell:Start(20)
	elseif spellId == 289795 and self.vb.phase == 2 then--Zuldazar Reuse Spell 06 (P2 sirens spawning)
		self.vb.sirenCount = self.vb.sirenCount + 1
		if self:AntiSpam(8, 5) then
			specWarnSeasTemptation:Show()
			specWarnSeasTemptation:Play("killmob")
		end
		if self.vb.sirenCount % 2 == 0 then
			timerSeasTemptationCD:Start(36.3, self.vb.sirenCount+1)
		else
			timerSeasTemptationCD:Start(5, self.vb.sirenCount+1)
		end
	elseif spellId == 287169 and self.vb.phase == 2 and self:AntiSpam(12, 4) then--Only want to see timer for it in mythic, it's mostly spammed in P1 and doesn't need a timer there
		self.vb.joltingCast = self.vb.joltingCast + 1
		warnJoltingVolley:Show(self.vb.joltingCast)
		timerJoltingVolleyCD:Start(43.6, self.vb.joltingCast+1)
	elseif spellId == 284106 then
		self.vb.cracklingCast = self.vb.cracklingCast + 1
		if self:CheckBossDistance(args.sourceGUID, true) then
			timerCracklingLightningCD:SetFade(false)
		else
			timerCracklingLightningCD:SetFade(true)
		end
		if self:IsLFR() then
			timerCracklingLightningCD:Start(30)
		else
			if self.vb.cracklingCast % 2 == 0 then
				timerCracklingLightningCD:Start(21.9)--21.9 (usually 23.1 but I have one log showing 21.9)
			else
				timerCracklingLightningCD:Start(12.1)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285000 then
		local amount = args.amount or 1
		--if args:IsPlayer() then
		--	yellKepWrapped:Cancel()
			--yellKepWrapped:Countdown(18)
		--end
		warnKelpWrapped:Show(args.destName, amount)
	elseif spellId == 286558 then
		if self:CheckBossDistance(args.destGUID, true) then
			warnTidalShroud:Show(args.destName)
			timerTidalShroudCD:SetFade(false)
		else
			timerTidalShroudCD:SetFade(true)
		end
		timerTidalShroudCD:Start()
	elseif spellId == 287995 then
		if self:CheckBossDistance(args.destGUID, true) then
			warnElecShroud:Show(args.destName)
			timerElecShroudCD:SetFade(false)
		else
			timerElecShroudCD:SetFade(true)
		end
		timerElecShroudCD:Start()
	elseif spellId == 284405 then
		if args:IsPlayer() then
			specWarnTemptingSong:Show()
			specWarnTemptingSong:Play("justrun")
			yellTemptingSong:Yell()
		else
			warnTemptingSong:Show(args.destName)
		end
	elseif spellId == 285382 then
		if self.Options.NPAuraOnKepWrapping then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 10)
		end
	elseif spellId == 285350 or spellId == 285426 then
		if args:IsPlayer() then
			specWarnStormsWail:Show(freezingTidePod)
			specWarnStormsWail:Play("targetyou")
			yellStormsWail:Yell()
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			if expireTime then
				local remaining = expireTime-GetTime()
				specWarnStormsWail:Schedule(remaining-4.5, DBM_CORE_BACK)
				yellStormsWailFades:Countdown(remaining)
			end
		else
			warnStormsWail:Show(args.destName)
		end
		timerStormsWail:Start(12, args.destName)
		if not tContains(stormTargets, args.destName) then
			table.insert(stormTargets, args.destName)
		end
		if self.Options.SetIconWail then
			self:SetIcon(args.destName, self.vb.stormsWailIcon)
		end
		--Smart rotation code that'll automatically rotate betwen needed number of icons based on number of debuffs out
		--Automatically reset icon to 1 if icon higher than our max count.
		--ie 2 debuffs out, it'll alternate icons 1 and 2. 3 out, it'll cycle through icons 1-3, a single debuff, it'll basically keep resetting to 1
		self.vb.stormsWailIcon = self.vb.stormsWailIcon + 1
		if self.vb.stormsWailIcon > self.vb.stormsActive then
			self.vb.stormsWailIcon = 1
		end
	elseif spellId == 288205 then
		if args:IsPlayer() then
			specWarnCracklingLightning:Show()
			specWarnCracklingLightning:Play("runout")
			yellCracklingLightning:Yell()
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			if expireTime then
				local remaining = expireTime-GetTime()
				yellCracklingLightningFades:Countdown(remaining)
			end
		else
			warnCracklingLightning:Show(args.destName)
		end
	elseif spellId == 284361 then
		warnSeaStorm:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSeaStorm:Show()
			specWarnSeaStorm:Play("runout")
			yellSeaStorm:Yell()
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			if expireTime then
				local remaining = expireTime-GetTime()
				yellSeaStormFades:Countdown(remaining)
			end
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286558 then
		if self:CheckInterruptFilter(args.destGUID, false, true) then
			specWarnTidalEmpowerment:Show(args.destName)
			specWarnTidalEmpowerment:Play("kickcast")
		end
	--elseif spellId == 285000 then
		--if args:IsPlayer() then
		--	yellKepWrapped:Cancel()
		--end
	elseif spellId == 285382 then
		if self.Options.NPAuraOnKepWrapping then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 285350 or spellId == 285426 then
		if self:AntiSpam(5, 1) then
			specWarnEnergizedStorm:Show()
			specWarnEnergizedStorm:Play("targetchange")
		end
		if args:IsPlayer() then
			yellStormsWailFades:Cancel()
			specWarnStormsWail:Cancel()
		end
		timerStormsWail:Stop(12, args.destName)
		tDeleteItem(stormTargets, args.destName)
		if self.Options.SetIconWail then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 288205 then
		if args:IsPlayer() then
			yellCracklingLightningFades:Cancel()
		end
	elseif spellId == 284361 then
		if args:IsPlayer() then
			yellSeaStormFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 285075 and destGUID == UnitGUID("player") and self:AntiSpam(2, 6) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 288696 then
		self.vb.phase = 2
		self.vb.sirenCount = 0
		timerSeaSwellCD:Stop()
		timerCataTides:Stop()
		countdownSeaSwell:Cancel()
		if self:IsMythic() then
			timerVoltaicFlashCD:SetFade(false)
			timerSeasTemptationCD:SetFade(false)
			--Same on all difficulties but some variation because they can actually come in different orders. in reality probably all start with same timer then randomized order by spell queue
			timerIreoftheDeepCD:Start(3.2)
			timerStormsWailCD:Start(6.6)
			timerSeaSwellCD:Start(7.2)
			countdownSeaSwell:Start(7.2)
			--Mythic Only
			timerJoltingVolleyCD:Start(10.2, 1)
			timerVoltaicFlashCD:Start(18.7)
			timerSeasTemptationCD:Start(38.7, 1)
		elseif self:IsLFR() then
			--LFR seems to do it's own thing with timers across the board
			timerSeaSwellCD:Start(5.3)
			countdownSeaSwell:Start(5.3)
			timerIreoftheDeepCD:Start(7)
			timerStormsWailCD:Start(16.7)
		else
			--Same on all difficulties but some variation because they can actually come in different orders. in reality probably all start with same timer then randomized order by spell queue
			timerIreoftheDeepCD:Start(3.2)
			timerStormsWailCD:Start(6.6)
			timerSeaSwellCD:Start(7.2)
			countdownSeaSwell:Start(7.2)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146251 then--Sister
		timerVoltaicFlashCD:Stop()
		timerCracklingLightningCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		timerElecShroudCD:Stop()
	elseif cid == 146251 then--Brother
		timerSeaStormCD:Stop()
		timerSeasTemptationCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		timerTidalShroudCD:Stop()
	end
end
