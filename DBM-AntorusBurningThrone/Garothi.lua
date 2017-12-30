local mod	= DBM:NewMod(1992, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122450)
mod:SetEncounterID(2076)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(16962)
mod:SetMinSyncRevision(16962)
--mod.respawnTime = 29
mod:DisableRegenDetection()--Prevent false combat when fighting trash

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244969 240277",
	"SPELL_CAST_SUCCESS 246220 244399 245294 246919 244294",
	"SPELL_AURA_APPLIED 246220 244410 246919 246965",--246897
	"SPELL_AURA_REMOVED 246220 244410 246919",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"--Assuming cannons are unique boss unitID
)

local annihilator = EJ_GetSectionInfo(15917)
local Decimator = EJ_GetSectionInfo(15915)
--TODO, work in range frame to include searing barrage, for ranged
--[[
(ability.id = 244969 or ability.id = 240277) and type = "begincast"
 or (ability.id = 244399 or ability.id = 245294 or ability.id = 246919 or ability.id = 244294) and type = "cast"
 or (ability.id = 246220) and type = "applydebuff"
--]]
local warnFelBombardment				= mod:NewTargetAnnounce(246220, 2)
local warnDecimation					= mod:NewTargetAnnounce(244410, 4)

local specWarnFelBombardment			= mod:NewSpecialWarningMoveAway(246220, nil, nil, nil, 1, 2)
local yellFelBombardment				= mod:NewFadesYell(246220)
local specWarnFelBombardmentTaunt		= mod:NewSpecialWarningTaunt(246220, nil, nil, nil, 1, 2)
local specWarnApocDrive					= mod:NewSpecialWarningSwitch(244152, nil, nil, nil, 1, 2)
local specWarnEradication				= mod:NewSpecialWarningRun(244969, nil, nil, nil, 4, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Decimator
local specWarnDecimation				= mod:NewSpecialWarningMoveAway(244410, nil, nil, nil, 1, 2)
local yellDecimation					= mod:NewShortYell(244410)
local yellDecimationFades				= mod:NewShortFadesYell(244410)
--Annihilator
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(244761, nil, nil, nil, 1, 2)

local timerFelBombardmentCD				= mod:NewNextTimer(20.7, 246220, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerApocDriveCast				= mod:NewCastTimer(30, 244152, nil, nil, nil, 6)
local timerSpecialCD					= mod:NewNextSpecialTimer(20)--When cannon unknown
mod:AddTimerLine(Decimator)
local timerDecimationCD					= mod:NewNextTimer(31.6, 244410, nil, nil, nil, 3)
mod:AddTimerLine(annihilator)
local timerAnnihilationCD				= mod:NewNextTimer(31.6, 244761, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownChooseCannon				= mod:NewCountdown(15, 245124)
local countdownFelBombardment			= mod:NewCountdown("Alt20", 246220, "Tank")

mod:AddSetIconOption("SetIconOnDecimation", 244410, true)
mod:AddSetIconOption("SetIconOnBombardment", 246220, true)
mod:AddRangeFrameOption("7/17")

mod.vb.deciminationActive = 0
mod.vb.FelBombardmentActive = 0
mod.vb.phase = 1
mod.vb.lastCannon = 1--Anniilator 1 decimator 2
mod.vb.annihilatorHaywire = false

local debuffFilter
local updateRangeFrame
do
	local decimination, mythicDecimination, FelBombardment = GetSpellInfo(244410), GetSpellInfo(246919), GetSpellInfo(246220)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, decimination) or UnitDebuff(uId, mythicDecimination) or UnitDebuff(uId, FelBombardment) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if self.vb.deciminationActive > 0 then
			if UnitDebuff("player", decimination) or UnitDebuff("player", mythicDecimination) then
				DBM.RangeCheck:Show(17)--Show Everyone
			else
				DBM.RangeCheck:Show(17, debuffFilter)--Show only those affected by debuff
			end
		elseif self.vb.FelBombardmentActive > 0 then
			if UnitDebuff("player", FelBombardment) then
				DBM.RangeCheck:Show(7)--Will round to 8
			else
				DBM.RangeCheck:Show(7, debuffFilter)
			end
		else
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.deciminationActive = 0
	self.vb.FelBombardmentActive = 0
	self.vb.lastCannon = 1--Anniilator 1 decimator 2
	self.vb.annihilatorHaywire = false
	self.vb.phase = 1
	timerSpecialCD:Start(8.5-delay)--First one random.
	countdownChooseCannon:Start(8.5-delay)
	timerFelBombardmentCD:Start(9.7-delay)
	countdownFelBombardment:Start(9.7-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244969 and self:AntiSpam(5, 1) then
		specWarnEradication:Show()
		specWarnEradication:Play("justrun")
		if self:IsMythic() then
			specWarnEradication:ScheduleVoice(1.5, "keepmove")
		end
	elseif spellId == 240277 then
		timerDecimationCD:Stop()
		timerFelBombardmentCD:Stop()
		countdownFelBombardment:Cancel()
		countdownChooseCannon:Cancel()
		timerAnnihilationCD:Stop()
		specWarnApocDrive:Show()
		specWarnApocDrive:Play("targetchange")
		timerApocDriveCast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244399 or spellId == 245294 or spellId == 246919 then--Decimation
		self.vb.lastCannon = 2--Anniilator 1 decimator 2
		countdownChooseCannon:Start(15.8)
		if self.vb.phase == 1 or self:IsMythic() then
			timerAnnihilationCD:Start(15.8)
		elseif self.vb.phase > 1 and not self:IsMythic() then
			timerDecimationCD:Start(15.8)
		end
	elseif spellId == 244294 then--Annihilation
		if self.vb.annihilatorHaywire then
			DBM:AddMsg("Blizzard fixed haywire Annihilator, tell DBM author")
		else
			self.vb.lastCannon = 1--Annihilation 1 Decimation 2
			specWarnAnnihilation:Show()
			specWarnAnnihilation:Play("helpsoak")
			countdownChooseCannon:Start(15.8)
			if self.vb.phase == 1 or self:IsMythic() then
				timerDecimationCD:Start(15.8)
			elseif self.vb.phase > 1 and not self:IsMythic() then
				timerAnnihilationCD:Start(15.8)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 246220 then
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive + 1
		if args:IsPlayer() then
			specWarnFelBombardment:Show()
			specWarnFelBombardment:Play("runout")
			specWarnFelBombardment:ScheduleVoice(7, "keepmove")
			yellFelBombardment:Countdown(7)
		elseif self:IsTank() then
			specWarnFelBombardmentTaunt:Show(args.destName)
			specWarnFelBombardmentTaunt:Play("tauntboss")
		else
			warnFelBombardment:Show(args.destName)
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnBombardment then
			self:SetIcon(args.destName, 7, 13)
		end
	elseif spellId == 244410 or spellId == 246919 then
		self.vb.deciminationActive = self.vb.deciminationActive + 1
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			yellDecimation:Yell()
			if spellId ~= 246919 then
				yellDecimationFades:Countdown(5, 3)
			end
			specWarnDecimation:Play("runout")
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, self.vb.deciminationActive)
		end
		updateRangeFrame(self)
	elseif spellId == 246965 then--Haywire (Annihilator)
		self.vb.annihilatorHaywire = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 246220 then
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive - 1
		if args:IsPlayer() then
			yellFelBombardment:Cancel()
		end
		updateRangeFrame(self)
		--if self.Options.SetIconOnBombardment then
			--self:SetIcon(args.destName, 0)
		--end
	elseif spellId == 244410 or spellId == 246919 then
		self.vb.deciminationActive = self.vb.deciminationActive - 1
		if args:IsPlayer() then
			yellDecimationFades:Cancel()
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, 0)
		end
		updateRangeFrame(self)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 245515 or spellId == 245527 then--decimator-cannon-eject/annihilator-cannon-eject
		self.vb.phase = self.vb.phase + 1
		timerApocDriveCast:Stop()
		if self.vb.phase == 2 and not self:IsMythic() then
			if spellId == 245515 then--decimator-cannon-eject
				timerAnnihilationCD:Start(22)
				countdownChooseCannon:Start(22)
			else--245527 (annihilator-cannon-eject)
				timerDecimationCD:Start(22)
				countdownChooseCannon:Start(22)
			end
		elseif self:IsMythic() then
			timerSpecialCD:Start(22)--Random cannon
		end
		timerFelBombardmentCD:Start(23.3)
		countdownFelBombardment:Start(23.3)
	elseif spellId == 244150 then--Fel Bombardment
		if self:IsMythic() then
			timerFelBombardmentCD:Start(15.7)
			countdownFelBombardment:Start(15.7)
		else
			timerFelBombardmentCD:Start(20.7)
			countdownFelBombardment:Start(20.7)
		end
	elseif spellId == 245124 then
		if self.vb.annihilatorHaywire and self.vb.lastCannon == 2 then 
			self.vb.lastCannon = 1
			specWarnAnnihilation:Show()
			specWarnAnnihilation:Play("helpsoak")
			if self.vb.phase == 1 or self:IsMythic() then
				timerDecimationCD:Start(15.8)
				countdownChooseCannon:Start(15.8)
			elseif self.vb.phase > 1 and not self:IsMythic() then
				timerAnnihilationCD:Start(15.8)
				countdownChooseCannon:Start(15.8)
			end
		end
	end
end
