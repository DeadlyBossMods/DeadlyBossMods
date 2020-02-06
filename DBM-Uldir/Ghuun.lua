local mod	= DBM:NewMod(2147, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(132998)
mod:SetEncounterID(2122)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(17906)
mod:SetMinSyncRevision(18056)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267509 267427 267412 273406 273405 267409 267462 267579 263482 263503 263307 275160",
	"SPELL_CAST_SUCCESS 263235 263482 263503 263373 270373 270428 276839 274582 272505 275756 263416",
	"SPELL_AURA_APPLIED 268074 267813 277079 272506 274262 263372 270447 263235 270443 273405 267409 263284 277007 263436",
	"SPELL_AURA_APPLIED_DOSE 270447",
	"SPELL_AURA_REMOVED 268074 267813 277079 272506 274262 263235 263372 277007 273405 267409 263436",
	"SPELL_PERIODIC_DAMAGE 270287",
	"SPELL_PERIODIC_MISSED 270287",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 267509 or ability.id = 273406 or ability.id = 273405 or ability.id = 267579 or ability.id = 263482 or ability.id = 263503 or ability.id = 275160 or ability.id = 269455) and type = "begincast"
 or (ability.id = 272505 or ability.id = 275756 or ability.id = 263235 or ability.id = 263482 or ability.id = 263503 or ability.id = 263373 or ability.id = 270373 or ability.id = 270428 or ability.id = 276839 or ability.id = 274582 or ability.id = 276994) and type = "cast"
 or ability.id = 270443
 or (ability.id = 267462 or ability.id = 267412 or ability.id = 267409) and type = "begincast"
 or ability.id = 270443 and type = "applybuff"
 or (ability.id = 277079 or ability.id = 272506 or ability.id = 274262 or ability.id = 263504) and (type = "applydebuff" or type = "removedebuff")
--]]
--Arena Floor
local warnMatrixSpawn					= mod:NewCountAnnounce(263420, 1)
local warnMatrixFail					= mod:NewAnnounce("warnMatrixFail", 4, 263420)
local warnPowerMatrix					= mod:NewTargetNoFilterAnnounce(263420, 2, nil, false)--No Filter announce, but off by default since infoframe is more productive way of showing it
local warnBloodHost						= mod:NewTargetAnnounce(267813, 3)--Mythic
local warnDarkPurpose					= mod:NewTargetAnnounce(268074, 4, nil, false)--Mythic
local warnThousandMaws					= mod:NewCountAnnounce(267509, 2)
local warnDarkBargain					= mod:NewSpellAnnounce(267409, 1)
local warnBurrow						= mod:NewSpellAnnounce(267579, 2)
local warnBurstingBoil					= mod:NewCountAnnounce(277007, 4)--Mythic

--Arena Floor
local specWarnBloodHost					= mod:NewSpecialWarningClose(267813, nil, nil, nil, 1, 2, 4)--Mythic
--local specWarnSpawnofGhuun			= mod:NewSpecialWarningSwitch("ej13699", "Dps", nil, nil, 1, 2)
local yellBloodHost						= mod:NewYell(267813)--Mythic
local specWarnDarkPurpose				= mod:NewSpecialWarningRun(268074, nil, nil, nil, 4, 2, 4)--Mythic
local yellDarkPurpose					= mod:NewYell(268074)--Mythic
local specWarnExplosiveCorruption		= mod:NewSpecialWarningMoveAway(272506, nil, nil, 2, 1, 2)
local specWarnVirulentCorruption		= mod:NewSpecialWarningDodge(277081, nil, nil, nil, 2, 2)--Orbs spawned by ExplosiveCorruption
local yellExplosiveCorruption			= mod:NewYell(272506)
local yellExplosiveCorruptionFades		= mod:NewShortFadesYell(272506)
local specWarnThousandMaws				= mod:NewSpecialWarningSwitch(267509, false, nil, 2, 1, 2)
local specWarnTorment					= mod:NewSpecialWarningInterrupt(267427, "HasInterrupt", nil, nil, 1, 2)
local specWarnMassiveSmash				= mod:NewSpecialWarningSpell(267412, "Tank", nil, 2, 1, 2)
local specWarnDarkBargain				= mod:NewSpecialWarningDodge(267409, nil, nil, 2, 3, 2)
local specWarnDarkBargainOther			= mod:NewSpecialWarningTaunt(267409, false, nil, 2, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(270287, nil, nil, nil, 1, 8)
local specWarnDecayingEruption			= mod:NewSpecialWarningInterruptCount(267462, "HasInterrupt", nil, nil, 1, 2, 4)--Mythic
----Arena Floor P2+
local specWarnGrowingCorruption			= mod:NewSpecialWarningCount(270447, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(5, 270447), nil, 1, 2)
local specWarnGrowingCorruptionOther	= mod:NewSpecialWarningTaunt(270447, nil, nil, nil, 1, 2)
local specWarnExplosiveCorruptionOther	= mod:NewSpecialWarningTaunt(272506, nil, nil, nil, 1, 2)
local specWarnBloodFeast				= mod:NewSpecialWarningYou(263235, nil, nil, nil, 1, 2)
local yellBloodFeast					= mod:NewYell(263235, nil, nil, nil, "YELL")
local yellBloodFeastFades				= mod:NewIconFadesYell(263235, nil, nil, nil, "YELL")
local specWarnBloodFeastTarget			= mod:NewSpecialWarningTargetCount(263235, nil, nil, nil, 1, 8)
local specWarnMindNumbingChatter		= mod:NewSpecialWarningCast(263307, "SpellCaster", nil, nil, 1, 2)
local specWarnBurstingBoilCast			= mod:NewSpecialWarningDodge(277007, nil, nil, nil, 2, 2)
local specWarnBurstingBoil				= mod:NewSpecialWarningYou(277007, nil, nil, nil, 1, 2, 4)--Mythic
----Arena Floor P3
local specWarnCollapse					= mod:NewSpecialWarningDodge(276839, nil, nil, nil, 2, 2)
local specWarnMalignantGrowth			= mod:NewSpecialWarningDodge(274582, nil, nil, nil, 2, 2)
local specWarnGazeofGhuun				= mod:NewSpecialWarningLookAway(275160, nil, nil, 2, 3, 2)
--Upper Platforms
local specWarnPowerMatrix				= mod:NewSpecialWarningYou(263420, nil, nil, nil, 1, 8)--New voice "Matrix on you"
local yellPowerMatrix					= mod:NewYell(263420)
local specWarnReorginationBlast			= mod:NewSpecialWarningSpell(263482, nil, nil, nil, 2, 2)

mod:AddTimerLine("Arena Floor")--Dungeon journal later
local timerExplosiveCorruptionCD		= mod:NewCDCountTimer(13, 272506, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerThousandMawsCD				= mod:NewCDCountTimer(23.9, 267509, nil, nil, nil, 1)--23.9-26.7
----Adds
local timerMassiveSmashCD				= mod:NewCDTimer(9.7, 267412, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDarkBargainCD				= mod:NewCDTimer(23.1, 267409, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerBurrowCD						= mod:NewCDTimer(30, 267579, nil, nil, nil, 6)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerWaveofCorruptionCD			= mod:NewCDCountTimer(15, 270373, nil, nil, nil, 3)
local timerBloodFeastCD					= mod:NewCDCountTimer(15, 263235, nil, nil, nil, 2, nil, nil, nil, 2, 4)
local timerBurstingBoil					= mod:NewCastCountTimer(8, 277007, nil, nil, 2, 5, nil, DBM_CORE_MYTHIC_ICON)
local timerBurstingBoilCD				= mod:NewCDCountTimer(20.5, 277007, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON)
----Horror
local timerMindNumbingChatterCD			= mod:NewCDTimer(13.4, 263307, nil, "SpellCaster", nil, 2)
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerMalignantGrowthCD			= mod:NewCDTimer(25.6, 274582, nil, nil, nil, 3, nil, nil, nil, 2, 4)
local timerGazeofGhuunCD				= mod:NewCDTimer(26.8, 275160, 195503, nil, nil, 2, nil, nil, nil, 3, 3)--26.8-29.1 (shortname "Gaze")
mod:AddTimerLine("Upper Platforms")--Dungeon journal later
local timerMatrixCD						= mod:NewNextCountTimer(12.1, 263420, nil, nil, nil, 5)
local timerReOrgBlast					= mod:NewBuffActiveTimer(25, 263482, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(5, 270428)
mod:AddInfoFrameOption(nil, true)
mod:AddNamePlateOption("NPAuraOnFixate", 268074)
mod:AddNamePlateOption("NPAuraOnUnstoppable", 275204)
mod:AddSetIconOption("SetIconOnBloodHost", 267813, true, false, {7})
mod:AddSetIconOption("SetIconOnBurstingBoil", 277007, true, false, {1, 2, 3, 4, 5, 6})
mod:AddSetIconOption("SetIconOnExplosiveCorruption", 272506, false, false, {1, 2, 3, 4, 5, 6, 7, 8})

mod.vb.phase = 1
mod.vb.mawCastCount = 0
mod.vb.matrixCount = 0
mod.vb.matrixSide = DBM_CORE_RIGHT
mod.vb.explosiveCount = 0
mod.vb.waveCast = 0
mod.vb.bloodFeastCount = 0
mod.vb.burstingIcon = 0
mod.vb.burstingCount = 0
mod.vb.explosiveIcon = 0
mod.vb.matrixActive = false
mod.vb.bloodFeastTarget = nil
local playerHasImperfect, playerHasBursting, playerHasBargain, playerHasMatrix = false, false, false, false
local matrixTargets = {}
local thousandMawsTimers = {25.4, 26.3, 25.5, 24.2, 23.9, 23.1, 21.5, 21.9, 19.4}
local thousandMawsTimersLFR = {27.78, 29.2, 27.9, 26.46, 26.13, 25.26, 23.51, 23.95, 21.21}--Timers 4+ extrapolated using 1.093x greater formula
local seenAdds = {}
local castsPerGUID = {}

local function checkThrowFail(self)
	--If this function runs it means matrix was not caught after a throw and is lost
	self:Unschedule(checkThrowFail)
	timerMatrixCD:Stop()
	timerMatrixCD:Start(6, self.vb.matrixCount+1)--TODO: Confirm
	self.vb.matrixActive = false
end

local updateInfoFrame
do
	local matrixSpellName, bloodFeastName = DBM:GetSpellInfo(263372), DBM:GetSpellInfo(263235)
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
		--Ghuun Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--Matrix Stuff
		if mod.vb.phase < 3 then
			local currentPower2, maxPower2 = UnitPower("boss2"), UnitPowerMax("boss2")
			if maxPower2 and maxPower2 ~= 0 then
				if currentPower2 / maxPower2 * 100 >= 0 then
					local matrixCount = (currentPower2 == 35) and 1 or (currentPower2 == 70) and 2 or (currentPower2 == 100) and 3 or 0
					addLine(UnitName("boss2"), matrixCount.."/3")
				end
			end
			--Scan raid for notable debuffs and add them
			for i=1, #matrixTargets do
				local name = matrixTargets[i]
				addLine(i.."-"..matrixSpellName, name)
			end
			if mod.vb.matrixActive then
				if mod:IsMythic() then--No side, short text
					addLine(L.CurrentMatrix, mod.vb.matrixCount)
				else--Side, long text
					addLine(L.CurrentMatrixLong:format(mod.vb.matrixSide), mod.vb.matrixCount)
				end
			else
				if mod:IsMythic() then
					addLine(L.NextMatrix, mod.vb.matrixCount+1)
				else
					local sideText = (mod.vb.matrixSide == DBM_CORE_LEFT) and DBM_CORE_RIGHT or DBM_CORE_LEFT
					addLine(L.NextMatrixLong:format(sideText), mod.vb.matrixCount+1)
				end
			end
		end
		if mod.vb.bloodFeastTarget then
			addLine(bloodFeastName, mod.vb.bloodFeastTarget)
		end
		--Player personal checks
		if playerHasImperfect then
			local spellName3, _, _, _, _, expireTime = DBM:UnitDebuff("player", 263436)
			if spellName3 and expireTime then--Personal Imperfect Physiology
				local remaining = expireTime-GetTime()
				addLine(spellName3, math.floor(remaining))
			end
		end
		if playerHasBursting then
			local spellName5, _, _, _, _, expireTime2 = DBM:UnitDebuff("player", 277007)
			if spellName5 and expireTime2 then--Personal Bursting Boil
				local remaining2 = expireTime2-GetTime()
				addLine(spellName5, math.floor(remaining2))
			end
		end
		if playerHasBargain then
			local spellName6, _, _, _, _, expireTime3 = DBM:UnitDebuff("player", 273405, 267409)
			if spellName6 and expireTime3 then--Personal Dark Bargain
				local remaining3 = expireTime3-GetTime()
				addLine(spellName6, math.floor(remaining3))
			end
		end
		return lines, sortedLines
	end
end

--Handles the ICD that Gaze of G'huun triggers on other abilities
local function updateAllTimers(self, ICD)
	DBM:Debug("updateAllTimers running", 3)
	if self.vb.phase == 3 then
		if timerWaveofCorruptionCD:GetRemaining(self.vb.waveCast+1) < ICD then
			local elapsed, total = timerWaveofCorruptionCD:GetTime(self.vb.waveCast+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerWaveofCorruptionCD extended by: "..extend, 2)
			timerWaveofCorruptionCD:Stop()
			timerWaveofCorruptionCD:Update(elapsed, total+extend, self.vb.waveCast+1)
		end
		if timerMalignantGrowthCD:GetRemaining() < ICD then
			local elapsed, total = timerMalignantGrowthCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerMalignantGrowthCD extended by: "..extend, 2)
			timerMalignantGrowthCD:Stop()
			timerMalignantGrowthCD:Update(elapsed, total+extend)
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(matrixTargets)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	self.vb.bloodFeastTarget = nil
	self.vb.phase = 1
	self.vb.mawCastCount = 0
	self.vb.matrixCount = 0
	self.vb.explosiveCount = 0
	self.vb.waveCast = 0
	self.vb.bloodFeastCount = 0
	self.vb.burstingIcon = 0
	self.vb.burstingCount = 0
	self.vb.explosiveIcon = 0
	self.vb.matrixActive = false
	playerHasImperfect, playerHasBursting, playerHasBargain, playerHasMatrix = false, false, false, false
	timerMatrixCD:Start(5.3, 1)
	if self:IsLFR() then
		timerThousandMawsCD:Start(27.7-delay, 1)
	else
		timerThousandMawsCD:Start(24.3-delay, 1)
	end
	if not self:IsMythic() then
		self.vb.matrixSide = DBM_CORE_RIGHT
		timerExplosiveCorruptionCD:Start(8-delay, 1)--SUCCESS
	else
		timerExplosiveCorruptionCD:Start(10-delay, 1)--SUCCESS
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnUnstoppable then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnUnstoppable then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 277007) then
		playerHasBursting = true
	end
	if DBM:UnitDebuff("player", 277007) then
		playerHasImperfect = true
	end
	if DBM:UnitDebuff("player", 273405, 267409) then
		playerHasBargain = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267509 then
		self.vb.mawCastCount = self.vb.mawCastCount + 1
		if self.Options.SpecWarn267509switch2 then
			specWarnThousandMaws:Show()
			specWarnThousandMaws:Play("killmob")
		else
			warnThousandMaws:Show(self.vb.mawCastCount)
		end
		local timer = self:IsLFR() and thousandMawsTimersLFR[self.vb.mawCastCount+1] or thousandMawsTimers[self.vb.mawCastCount+1]
		if timer then
			timerThousandMawsCD:Start(timer, self.vb.mawCastCount+1)
		end
	elseif spellId == 267427 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTorment:Show(args.sourceName)
		specWarnTorment:Play("kickcast")
	elseif spellId == 267462 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnDecayingEruption:Show(args.sourceName, count)
			if count == 1 then
				specWarnDecayingEruption:Play("kick1r")
			elseif count == 2 then
				specWarnDecayingEruption:Play("kick2r")
			elseif count == 3 then
				specWarnDecayingEruption:Play("kick3r")
			elseif count == 4 then
				specWarnDecayingEruption:Play("kick4r")
			elseif count == 5 then
				specWarnDecayingEruption:Play("kick5r")
			else
				specWarnDecayingEruption:Play("kickcast")
			end
		end
	elseif spellId == 267412 and self:CheckInterruptFilter(args.sourceGUID, true) then
		specWarnMassiveSmash:Show()
		specWarnMassiveSmash:Play("carefly")
		timerMassiveSmashCD:Start(9.7, args.sourceGUID)
	elseif (spellId == 273406 or spellId == 273405 or spellId == 267409) then
		timerDarkBargainCD:Start(23, args.sourceGUID)
		if self:AntiSpam(3.5, 1) then--Dark Bargains
			if spellId ~= 273406 and DBM:UnitDebuff("player", 273405, 267409) then--Run out or get MCed
				specWarnDarkBargain:Show()
				specWarnDarkBargain:Play("runaway")
			else
				warnDarkBargain:Show()
			end
		end
	elseif spellId == 267579 then
		warnBurrow:Show()
		timerBurrowCD:Start(29.5, args.sourceGUID)
	elseif (spellId == 263482 or spellId == 263503) then
		self.vb.matrixActive = false
		self.vb.matrixSide = DBM_CORE_RIGHT--Actually left, but this makes it so the way it's coded works
		specWarnReorginationBlast:Show()
		specWarnReorginationBlast:Play("aesoon")--Or phase change
		timerMatrixCD:Stop()
		timerMatrixCD:Start(29, self.vb.matrixCount+1)
	elseif spellId == 263307 then
		specWarnMindNumbingChatter:Show()
		specWarnMindNumbingChatter:Play("stopcast")
		if self:IsMythic() then
			timerMindNumbingChatterCD:Start(9.8, args.sourceGUID)
		else
			timerMindNumbingChatterCD:Start(13.4, args.sourceGUID)
		end
	elseif spellId == 275160 then
		specWarnGazeofGhuun:Show(args.sourceName)
		specWarnGazeofGhuun:Play("turnaway")
		local timer = self:IsMythic() and 21.97 or self:IsHard() and 26.7 or self:IsEasy() and 31.6--TODO, LFR, easy is assumed
		timerGazeofGhuunCD:Start(timer)
		if self:IsMythic() then
			updateAllTimers(self, 3.6)
		else
			updateAllTimers(self, 2.4)--3.6 mythic only?
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 263235 then--Blood Feast
		self.vb.waveCast = 0
		timerWaveofCorruptionCD:Start(15.5, 1)--Wave of corruption is next, not blood Feast
	elseif (spellId == 263482 or spellId == 263503) then
		timerReOrgBlast:Start()
		if self.vb.phase < 2 then--Phase 1 to Phase 2 Transition
			self.vb.phase = 2
			self.vb.explosiveCount = 0
			timerThousandMawsCD:Stop()
			timerExplosiveCorruptionCD:Stop()
			timerMassiveSmashCD:Stop()--Technically should AddTime(25) each add, but honestly, if the adds don't die in this 25 second window you done fucked up
			timerDarkBargainCD:Stop()--Technically should AddTime(25) each add, but honestly, if the adds don't die in this 25 second window you done fucked up
			if self:IsMythic() then
				timerWaveofCorruptionCD:Start(34, 1)
			end
		else--Drive cast in Phase 2
			if self.vb.waveCast == 2 then--Current timer is blood feast
				local elapsed, total = timerBloodFeastCD:GetTime(self.vb.bloodFeastCount+1)
				local extend = (total+25) - elapsed
				timerBloodFeastCD:Update(elapsed, total+25, self.vb.bloodFeastCount+1)
			else--Current timer is wave of corruption
				timerWaveofCorruptionCD:AddTime(25, self.vb.waveCast+1)
			end
			local elapsed2, total2 = timerExplosiveCorruptionCD:GetTime(self.vb.explosiveCount+1)
			local extend2 = (total2+25) - elapsed2
			timerExplosiveCorruptionCD:Update(elapsed2, total2+25, self.vb.explosiveCount+1)
			if self:IsMythic() then
				timerBurstingBoilCD:AddTime(25, self.vb.burstingCount+1)
			end
		end
	elseif spellId == 263373 then--Deposit Matrix
		timerMatrixCD:Stop()
		timerMatrixCD:Start(10, self.vb.matrixCount+1)
		self:Unschedule(checkThrowFail)
		self.vb.matrixActive = false
	elseif spellId == 270373 or spellId == 270428 then--Wave of Corruption
		self.vb.waveCast = self.vb.waveCast + 1
		if self.vb.phase == 2 then
			if self.vb.waveCast == 1 then
				timerWaveofCorruptionCD:Start(15.5, 2)
			else
				timerBloodFeastCD:Start(15.6, self.vb.bloodFeastCount+1)
			end
		else--P3, No more blood feast, only waves
			--Faster on easy because no growth
			local timer = self:IsMythic() and 15.84 or self:IsHard() and 25.5 or self:IsEasy() and 20.4
			timerWaveofCorruptionCD:Start(timer, self.vb.waveCast+1)
		end
	elseif spellId == 276839 then
		self.vb.phase = 3
		self.vb.explosiveCount = 0
		self.vb.waveCast = 0
		specWarnCollapse:Show()
		specWarnCollapse:Play("watchstep")
		timerReOrgBlast:Stop()
		timerBloodFeastCD:Stop()
		timerWaveofCorruptionCD:Stop()
		timerBurstingBoilCD:Stop()
		timerExplosiveCorruptionCD:Stop()
		if not self:IsLFR() then
			timerMalignantGrowthCD:Start(33.7)--33.7-34.1
		end
		if self:IsMythic() then
			timerBurstingBoilCD:Start(28, self.vb.burstingCount+1)
			timerExplosiveCorruptionCD:Start(44.5, 1)--SUCCESS
		else
			timerExplosiveCorruptionCD:Start(29.8, 1)--SUCCESS
		end
		local timer1 = self:IsMythic() and 44.9 or self:IsHeroic() and 47.4 or self:IsEasy() and 52.2--Gaze of G'huun
		local timer2 = self:IsHeroic() and 49.9 or 37.6--Wave of Corruption (Mythic, normal, and LFR are all 37.6, heroic is 49.9 cause it's delayed by other casts)
		timerGazeofGhuunCD:Start(timer1)
		timerWaveofCorruptionCD:Start(timer2, 1)
	elseif spellId == 272505 or spellId == 275756 then
		self.vb.explosiveIcon = 0
		self.vb.explosiveCount = self.vb.explosiveCount + 1
		if self.vb.phase == 1 then
			local timer = self:IsMythic() and 44 or 26
			timerExplosiveCorruptionCD:Start(timer, self.vb.explosiveCount+1)
		elseif self.vb.phase == 2 then
			timerExplosiveCorruptionCD:Start(15.8, self.vb.explosiveCount+1)--15.8 in all, except mythic, doesn't exist in mythic P2
		else--Phase 3
			local timer = self:IsMythic() and 25.5 or self:IsHeroic() and 13.2 or self:IsEasy() and 15.8--TODO, LFR
			timerExplosiveCorruptionCD:Start(timer, self.vb.explosiveCount+1)
		end
		if args:IsPlayer() then--Success event can be up to 2.5 seconds faster than applied event, but only tanks will get success event
			if self:AntiSpam(3, 8) then
				specWarnExplosiveCorruption:Show()
				specWarnExplosiveCorruption:Play("runout")
				yellExplosiveCorruption:Yell()
				--Yell countdown scheduled on APPLIED event
			end
		else--This event is only ever on tank, so no need for tank filter
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId, "boss1", nil, true) then
				--However, in case 3 tank strat, do need to make sure it's tank actually on Ghuun to avoid notifying unnessesary taunts
				specWarnExplosiveCorruptionOther:Show(args.destName)
				specWarnExplosiveCorruptionOther:Play("tauntboss")
			end
		end
	elseif spellId == 274582 then--Malignant Growth
		specWarnMalignantGrowth:Show()
		specWarnMalignantGrowth:Play("watchstep")
		timerMalignantGrowthCD:Start()--25.6
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 268074 then
		warnDarkPurpose:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 9) then
				specWarnDarkPurpose:Show()
				specWarnDarkPurpose:Play("justrun")
				yellDarkPurpose:Yell()
			end
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, nil, nil, true, {0.5, 0, 0.55, 0.75})
			end
		end
	elseif spellId == 275204 then
		if self.Options.NPAuraOnUnstoppable then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 267813 then
		if args:IsPlayer() then
			yellBloodHost:Yell()
		end
		if self:CheckNearby(11, args.destName) and self:AntiSpam(3.5, 3) then
			specWarnBloodHost:Show(args.destName)
			specWarnBloodHost:Play("runaway")
		else
			warnBloodHost:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnBloodHost and not self:IsLFR() then
			--This assumes no fuckups. Because honestly coding this around fuckups is not worth the effort
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 277079 or spellId == 272506 or spellId == 274262 then--272506 spread, 274262 initial targets, 277079 probably LFR with 6 second duration
		self.vb.explosiveIcon = self.vb.explosiveIcon + 1
		if args:IsPlayer() then
			if self:AntiSpam(3, 8) then
				specWarnExplosiveCorruption:Show()
				specWarnExplosiveCorruption:Play("runout")
				yellExplosiveCorruption:Yell()
			end
			yellExplosiveCorruptionFades:Countdown(spellId)
		end
		if self.Options.SetIconOnExplosiveCorruption then
			self:SetIcon(args.destName, self.vb.explosiveIcon)
		end
	elseif spellId == 263372 then
		self:Unschedule(checkThrowFail)
		if args:IsPlayer() then
			specWarnPowerMatrix:Show()
			specWarnPowerMatrix:Play("newmatrix")
			yellPowerMatrix:Yell()
			playerHasMatrix = true
		else
			if self:IsMythic() then
				warnPowerMatrix:CombinedShow(1, args.destName)
			else
				warnPowerMatrix:Show(args.destName)
			end
		end
		if not tContains(matrixTargets, args.destName) then
			table.insert(matrixTargets, args.destName)
		end
	elseif spellId == 270447 then
		local amount = args.amount or 1
		if (amount == 5 or amount >= 8) and self:AntiSpam(5, 4) then--First warning at 4, then a decent amount of time until 8. then spam every 3 seconds
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnGrowingCorruption:Show(amount)
				specWarnGrowingCorruption:Play("changemt")
			elseif not playerHasMatrix and self:CheckTankDistance(args.destGUID, 30) then--if player has matrix, or is > 30 yards away from active tank, don't show taunt warnings
				specWarnGrowingCorruptionOther:Show(args.destName)
				specWarnGrowingCorruptionOther:Play("tauntboss")
			end
		end
	elseif spellId == 263235 then
		self.vb.bloodFeastCount = self.vb.bloodFeastCount + 1
		if args:IsPlayer() then
			specWarnBloodFeast:Show()
			specWarnBloodFeast:Play("targetyou")
			yellBloodFeast:Yell()
			yellBloodFeastFades:Countdown(spellId, nil, 7)
		else
			specWarnBloodFeastTarget:Show(self.vb.bloodFeastCount, args.destName)
			specWarnBloodFeastTarget:Play("bloodfeast")
			local count = self.vb.bloodFeastCount
			specWarnBloodFeastTarget:ScheduleVoice(1, nil, "Interface\\AddOns\\DBM-VP"..DBM.Options.ChosenVoicePack.."\\count\\"..count..".ogg")
		end
		self.vb.bloodFeastTarget = args.destName
	elseif spellId == 270443 then--Bite
		--Start wave timer when boss activates, vs when he's first stunned.
		self.vb.waveCast = 0
		if self:IsMythic() then
			--Wave seem cast instantly on mythic so no timer for first.
			timerBurstingBoilCD:Start(14.3, 1)--14.3-18
		else
			timerExplosiveCorruptionCD:Start(9, 1)
			timerWaveofCorruptionCD:Start(15, 1)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	elseif (spellId == 273405 or spellId == 267409) then
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) and not args:IsPlayer() then--DBM:UnitDebuff("player", spellId)
			specWarnDarkBargainOther:Show(args.destName)
			specWarnDarkBargainOther:Play("changemt")
		end
		if args:IsPlayer() then
			playerHasBargain = true
		end
	elseif spellId == 263284 then--Horror Spawn
		if self:IsMythic() then
			timerMindNumbingChatterCD:Start(7, args.destGUID)
		else
			timerMindNumbingChatterCD:Start(10, args.destGUID)
		end
	elseif spellId == 277007 then
		self.vb.burstingIcon = self.vb.burstingIcon + 1
		if args:IsPlayer() then
			playerHasBursting = true
			specWarnBurstingBoil:Show()
			specWarnBurstingBoil:Play("targetyou")
		end
		if self.Options.SetIconOnBurstingBoil then
			self:SetIcon(args.destName, self.vb.burstingIcon)
		end
	elseif spellId == 263436 and args:IsPlayer() then
		playerHasImperfect = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 268074 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 275204 then
		if self.Options.NPAuraOnUnstoppable then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 267813 then
		if self.Options.SetIconOnBloodHost and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 277079 or spellId == 272506 or spellId == 274262 then
		if args:IsPlayer() then
			yellExplosiveCorruptionFades:Cancel()
		end
		if self:AntiSpam(7.5, 8) then--Adjust throttle as needed for shit shows
			specWarnVirulentCorruption:Show()
			specWarnVirulentCorruption:Play("watchorb")
		end
		if self.Options.SetIconOnExplosiveCorruption then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 263235 then
		if args:IsPlayer() then
			yellBloodFeastFades:Cancel()
		end
		self.vb.bloodFeastTarget = nil
	elseif spellId == 263372 then
		tDeleteItem(matrixTargets, args.destName)
		self:Unschedule(checkThrowFail)
		self:Schedule(3.5, checkThrowFail, self)
		if args:IsPlayer() then
			playerHasMatrix = false
		end
	elseif spellId == 277007 then
		if args:IsPlayer() then
			playerHasBursting = false
		end
		if self.Options.SetIconOnBurstingBoil then
			self:SetIcon(args.destName, 0)
		end
	elseif (spellId == 273405 or spellId == 267409) and args:IsPlayer() then
		playerHasBargain = false
	elseif spellId == 263436 and args:IsPlayer() then
		playerHasImperfect = false
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270287 and destGUID == UnitGUID("player") and self:AntiSpam(2, 6) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 263326 and destGUID == UnitGUID("player") and self:AntiSpam(2, 6) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 138529 or cid == 134635 then--Dark Young (P1, P2)
		timerMassiveSmashCD:Stop(args.destGUID)
		timerDarkBargainCD:Stop(args.destGUID)
	elseif cid == 134590 then--Blightspreader Tendril
		timerBurrowCD:Stop(args.destGUID)
	elseif cid == 134010 then--Gibbering Horror
		timerMindNumbingChatterCD:Stop(args.destGUID)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:263420") and self:AntiSpam(10, 7) then
		self.vb.matrixActive = true
		self.vb.matrixCount = self.vb.matrixCount + 1
		if not self:IsMythic() then
			if self.vb.matrixSide == DBM_CORE_LEFT then
				self.vb.matrixSide = DBM_CORE_RIGHT
			else
				self.vb.matrixSide = DBM_CORE_LEFT
			end
			warnMatrixSpawn:Show(self.vb.matrixCount.."-"..self.vb.matrixSide)
		else
			warnMatrixSpawn:Show(self.vb.matrixCount)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 134590 then--Big Adds
				timerBurrowCD:Start(30.5, GUID)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 277057 then--Summon Bursting Boil
		self.vb.burstingIcon = 0
		self.vb.burstingCount = self.vb.burstingCount + 1
		timerBurstingBoil:Start(8, self.vb.burstingCount)
		timerBurstingBoilCD:Start(20.5, self.vb.burstingCount+1)
		if playerHasBursting then--Need to avoid the new boils
			specWarnBurstingBoilCast:Show()
			specWarnBurstingBoilCast:Play("watchstep")
		else--Need to help soak them
			warnBurstingBoil:Show(self.vb.burstingCount)
		end
	end
end
