local mod	= DBM:NewMod(2563, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200927)
mod:SetEncounterID(2824)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20231115000000)
mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 421343 422691 426725 422172",
	"SPELL_CAST_SUCCESS 422277 430677 421343",
	"SPELL_AURA_APPLIED 421656 422577 421455 422067",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 421656 422577 421455 422067",
	"SPELL_PERIODIC_DAMAGE 421532",
	"SPELL_PERIODIC_MISSED 421532",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
 (ability.id = 421343 or ability.id = 422691 or ability.id = 426725 or ability.id = 422172 or ability.id = 425885) and type = "begincast"
  or (ability.id = 430677 or ability.id = 422277) and type = "cast"
  or ability.id = 422067
  or ability.id = 421455 and type = "applydebuff"
--]]
--TODO, better tracking of personal dps buffs in P2?
--general
local warnPhase										= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerPhaseCD									= mod:NewStageTimer(60, 422172)
--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Firelord's Fury
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27637))
local warnCauterizingWound							= mod:NewYouAnnounce(421656, 3)
local warnCauterizingWoundOver						= mod:NewFadesAnnounce(421656, 1)
local warnSearingAftermath							= mod:NewTargetNoFilterAnnounce(422577, 2, nil, "Healer")
local warnOverheated								= mod:NewTargetCountAnnounce(421455, 3, nil, nil, nil, nil, nil, nil, true)
local warnSeekingInferno							= mod:NewIncomingCountAnnounce(425885, 2)

local specWarnBrandofDamnation						= mod:NewSpecialWarningCount(421343, nil, nil, nil, 2, 2)
local yellBrandofDamnation							= mod:NewShortYell(421343, nil, nil, nil, "YELL")
local yellBrandofDamnationFades						= mod:NewShortFadesYell(421343, nil, nil, nil, "YELL")
local specWarnAftermathTaunt						= mod:NewSpecialWarningTaunt(422577, nil, nil, nil, 1, 2)
local specWarnSearingAftermath						= mod:NewSpecialWarningMoveAway(422577, nil, nil, nil, 1, 2)
local yellSearingAftermath							= mod:NewShortYell(422577, 37859)
local yellSearingAftermathFades						= mod:NewShortFadesYell(422577)
local specWarnOverheated							= mod:NewSpecialWarningMoveAway(421455, nil, nil, nil, 1, 2)
local specWarnOverheatedTaunt						= mod:NewSpecialWarningTaunt(421455, nil, nil, nil, 1, 2)
--local yellOverheated								= mod:NewShortYell(421455)
local yellOverheatedFades							= mod:NewShortFadesYell(421455)
local specWarnLavaGeysers							= mod:NewSpecialWarningCount(422691, nil, nil, nil, 2, 2)

local timerBrandofDamnationCD						= mod:NewCDCountTimer(29.9, 421343, nil, nil, nil, 5)
local timerSearingAftermathCD						= mod:NewTargetTimer(6, 422577, 37859, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerOverheatedCD								= mod:NewCDCountTimer(29.9, 421455, nil, nil, nil, 3)
local timerLavaGeysersCD							= mod:NewCDCountTimer(25.9, 422691, nil, nil, nil, 3)
local timerSeekingInfernoCD							= mod:NewCDCountTimer(21.9, 425885, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)--Seeking Inferno
--Stage Two: World In Flames
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27649))
local warnDevourEssence								= mod:NewCountAnnounce(422277, 3)

local specWarnEncroachingDestruction				= mod:NewSpecialWarningSpell(426725, nil, nil, nil, 3, 2)

local timerEncroachingDestructionCD					= mod:NewNextTimer(395, 426725, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--basically soft berserk timer
local specWarnWorldinFlames							= mod:NewSpecialWarningDodgeCount(422172, nil, nil, nil, 2, 2)

local timerDevourEssenceCD							= mod:NewCDCountTimer(49, 422277, nil, nil, nil, 3)
--local timerWorldinFlamesCD							= mod:NewAITimer(49, 422172, nil, nil, nil, 3)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})

mod.vb.brandCount = 0
mod.vb.overheatedCount = 0
mod.vb.geyserCount = 0
mod.vb.cycleCount = 0
mod.vb.infernoCount = 0
mod.vb.encroached = false
local playerWasFirstBrand = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.brandCount = 0
	self.vb.overheatedCount = 0
	self.vb.geyserCount = 0
	self.vb.cycleCount = 0
	self.vb.infernoCount = 0
	self.vb.encroached = false
	playerWasFirstBrand = false
	timerOverheatedCD:Start(10-delay, 1)
	timerBrandofDamnationCD:Start(12.9-delay, 1)
	timerLavaGeysersCD:Start(self:IsMythic() and 24 or 26.9-delay, 1)
	timerPhaseCD:Start(62.7-delay, 2)--62-64.9. Basically phase/world in flames timer
	if self:IsMythic() then
		self:EnablePrivateAuraSound(426010, "justrun", 2)
		timerSeekingInfernoCD:Start(26-delay, 1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421343 then
		self.vb.brandCount = self.vb.brandCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBrandofDamnation:Show(self.vb.brandCount)
			specWarnBrandofDamnation:Play("targetyou")
			yellBrandofDamnation:Yell()
			yellBrandofDamnationFades:Countdown(self:IsEasy() and 4 or 3)
		else
			specWarnBrandofDamnation:Show(self.vb.brandCount)
			specWarnBrandofDamnation:Play("specialsoon")
		end
		if self.vb.brandCount < 8 and self.vb.brandCount % 2 == 1 then--Other timers started in phase change event
			timerBrandofDamnationCD:Start(nil, self.vb.brandCount+1)--29.9
		end
	elseif spellId == 422691 then
		self.vb.geyserCount = self.vb.geyserCount + 1
		specWarnLavaGeysers:Show(self.vb.geyserCount)
		specWarnLavaGeysers:Play("watchstep")
		if self:IsTank() then
			specWarnLavaGeysers:ScheduleVoice(1, "moveboss")
		end
		if self.vb.geyserCount < 8 and self.vb.geyserCount % 2 == 1 then--Other timers started in phase change event
			timerLavaGeysersCD:Start(self:IsMythic() and 25 or 26, self.vb.geyserCount+1)--25.9
		end
	elseif spellId == 426725 then
		self.vb.encroached = true
		specWarnEncroachingDestruction:Show()
		specWarnEncroachingDestruction:Play("stilldanger")
	elseif spellId == 422172 and not self.vb.encroached then
		specWarnWorldinFlames:Show(self.vb.geyserCount)
		specWarnWorldinFlames:Play("watchstep")
--	elseif spellId == 425885 then--Seeking Inferno

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then
		warnDevourEssence:Show(self.vb.overheatedCount)
	elseif spellId == 430677 then
		self.vb.overheatedCount = self.vb.overheatedCount + 1
		if self.vb.overheatedCount < 8 and self.vb.overheatedCount % 2 == 1 then--Other timers started in phase change event
			timerOverheatedCD:Start(nil, self.vb.overheatedCount+1)--29.9
		end
	elseif spellId == 421343 and args:IsPlayer() then
		playerWasFirstBrand = true
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421656 and args:IsPlayer() then
		warnCauterizingWound:Show()
	elseif spellId == 422577 then
		if args:IsPlayer() then
			specWarnSearingAftermath:Show()
			specWarnSearingAftermath:Play("runout")
			yellSearingAftermath:Yell()
			yellSearingAftermathFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnAftermathTaunt:Show(args.destName)
			specWarnAftermathTaunt:Play("tauntboss")
		else
			warnSearingAftermath:Show(args.destName)
		end
	elseif spellId == 421455 then
		warnOverheated:CombinedShow(0.3, self.vb.overheatedCount, args.destName)
		if args:IsPlayer() then
			specWarnOverheated:Show()
			specWarnOverheated:Play("targetyou")
--			yellOverheated:Yell()
			yellOverheatedFades:Countdown(spellId)
		else
			--Check if overheated when on person tanking the main boss, by seeing if you're tanking the main boss
			if not self:IsTanking("player", "boss1", nil, true) and not playerWasFirstBrand then
				local uId = DBM:GetRaidUnitId(args.destName)
				if self:IsTanking(uId) then--Not tanking boss and not overheated target and they are a tank, taunt boss
					specWarnOverheatedTaunt:Show(args.destName)
					specWarnOverheatedTaunt:Play("tauntboss")
				end
			end
		end
	elseif spellId == 422067 then
		self:SetStage(2)
		self.vb.encroached = false
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerBrandofDamnationCD:Stop()
		timerOverheatedCD:Stop()
		timerLavaGeysersCD:Stop()
		timerSeekingInfernoCD:Stop()
		timerPhaseCD:Stop()
		timerDevourEssenceCD:Start(3.7, self.vb.cycleCount+1)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 and args:IsPlayer() then
		warnCauterizingWoundOver:Show()
	elseif spellId == 422577 then
		if args:IsPlayer() then
			yellSearingAftermathFades:Cancel()
		end
	elseif spellId == 421455 then
		if args:IsPlayer() then
			yellOverheatedFades:Cancel()
		end
	elseif spellId == 422067 then
		self:SetStage(1)
		playerWasFirstBrand = false
		self.vb.cycleCount = self.vb.cycleCount + 1
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerEncroachingDestructionCD:Stop()
		timerDevourEssenceCD:Stop()
		timerOverheatedCD:Start(10, self.vb.overheatedCount+1)
		timerBrandofDamnationCD:Start(13, self.vb.brandCount+1)
		timerLavaGeysersCD:Start(self:IsMythic() and 24 or 27, self.vb.geyserCount+1)
		timerPhaseCD:Start(63.8, 2)
		if self:IsMythic() then
			timerSeekingInfernoCD:Start(26, self.vb.infernoCount+1)
		end
		if self.vb.cycleCount == 3 then
			timerEncroachingDestructionCD:Start(100)
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then
		self.vb.infernoCount = self.vb.infernoCount + 1
		warnSeekingInferno:Show(self.vb.infernoCount)
		-- "Seeking Inferno-426144-npc:200927-0000174417 = pull:26.0, 25.0, 74.5, 25.0, 74.2, 25.0, 74.8, 25.0,
		if self.vb.infernoCount < 8 and self.vb.infernoCount % 2 == 1 then--1, 3, 5, 7--Other timers started in phase change event
			timerSeekingInfernoCD:Start(25, self.vb.infernoCount+1)
		end
	end
end
