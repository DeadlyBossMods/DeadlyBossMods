local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2565, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(210601)--Could be wrong (209539 moonkin form)
mod:SetEncounterID(2786)
mod:SetUsedIcons(1, 2, 3, 6, 7, 8)
mod:SetHotfixNoticeRev(20230920000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 423260 426669 424581 420236 424495 421398 421603 426016 424140 423265",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 422000 424581 424580 424495 420238 420540 425582 424258 422115 424579 424665",
	"SPELL_AURA_APPLIED_DOSE 422000 424258 424665",
	"SPELL_AURA_REMOVED 424580 424495 424581 420540 421603 425582 424180 422115",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 424499 423649",
	"SPELL_PERIODIC_MISSED 424499 423649"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, https://www.wowhead.com/ptr-2/spell=425888/igniting-growth ?
--TODO, review dream essence for spam
--TODO, https://www.wowhead.com/ptr-2/spell=421636/typhoon might also be used for intermission phase change
--TODO, mythic stuff
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--Stage One: Moonkin of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27488))
----Tindral Sageswift
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27509))
local warnSearingWrath								= mod:NewStackAnnounce(422000, 2, nil, "Tank|Healer")
local warnBlazingMushroom							= mod:NewCountAnnounce(423260, 3, nil, "Tank", nil, nil, nil, 2)
local warnFieryGrowth								= mod:NewTargetCountAnnounce(424581, 3)
local warnMassEntanglement							= mod:NewTargetCountAnnounce(424495, 3)

local specWarnSearingWrath							= mod:NewSpecialWarningTaunt(422000, nil, nil, nil, 1, 2)
--local specWarnBlazingMushroom						= mod:NewSpecialWarningSoakCount(423260, "Tank", nil, nil, 2, 2)--Tank default for sure, anyone else can enable
local specWarnBlazingMushroomAvoid					= mod:NewSpecialWarningDodgeCount(423260, nil, nil, nil, 2, 2)--Everyone default, since it's debuff based
local specWarnFieryGrowth							= mod:NewSpecialWarningMoveAway(424581, nil, nil, nil, 1, 2)
local yellFieryGrowth								= mod:NewShortPosYell(424581)
local specWarnFallingStars							= mod:NewSpecialWarningMoveAway(420236, nil, nil, nil, 1, 2)
local yellFallingStars								= mod:NewShortYell(420236)
local yellFallingStarsFades							= mod:NewShortFadesYell(420236)
local specWarnMassEntanglement						= mod:NewSpecialWarningMoveAway(424495, nil, nil, nil, 1, 2)
local yellMassEntanglement							= mod:NewShortPosYell(424495)
local yellMassEntanglementFades						= mod:NewIconFadesYell(424495)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

local timerBlazingMushroomCD						= mod:NewAITimer(49, 423260, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFieryGrowthCD							= mod:NewAITimer(49, 424581, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFallingStarsCD							= mod:NewAITimer(49, 420236, nil, nil, nil, 3)
local timerMassEntanglementCD						= mod:NewAITimer(49, 424495, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnFieryGrowth", 424581, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnEntangle", 424495, true, false, {6, 7, 8})
----Moonkin of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27495))
local warnIncarnationMoonkin						= mod:NewSpellAnnounce(420540, 2)

local specWarnSunfire								= mod:NewSpecialWarningMoveAway(420238, nil, nil, nil, 1, 2)

local timerFirebeamCD								= mod:NewAITimer(49, 421398, nil, nil, nil, 3)
--Intermission: Burning Pursuit
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27500))
local warnDreamEssence								= mod:NewCountAnnounce(424258, 1, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(424258))
local warnSuperNova									= mod:NewCastAnnounce(424140, 4)
local warnSuperNovaEnded							= mod:NewSpellAnnounce(424140, 1)

local timerSupernova								= mod:NewAITimer(20, 424140, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddInfoFrameOption(424140, true)
--Stage Two: Tree of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27506))
local warnIncarnationTreeofFlame					= mod:NewSpellAnnounce(422115, 2)
local warnSupressiveEmber							= mod:NewTargetAnnounce(424579, 3, nil, false)
local warnSeedofFlame								= mod:NewCountAnnounce(424665, 1, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(424258))

local specWarnSupressingEmber						= mod:NewSpecialWarningYou(424579, nil, nil, nil, 1, 2)
local specWarnTranquilityofFlame					= mod:NewSpecialWarningCount(423265, nil, nil, nil, 2, 2)

local timerTranquilityofFlameCD						= mod:NewAITimer(20, 423265, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

--base abilities
mod.vb.shroomCount = 0
mod.vb.growthCount = 0
mod.vb.growthIcon = 1
mod.vb.starsCount = 0
mod.vb.entangleCount = 0
mod.vb.entangleIcon = 8
--Moonkin/Tree shared counts
mod.vb.beamtreeCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.shroomCount = 0
	self.vb.growthCount = 0
	self.vb.growthIcon = 1
	self.vb.starsCount = 0
	self.vb.entangleCount = 0
	self.vb.entangleIcon = 8
	self.vb.beamtreeCount = 0
	timerBlazingMushroomCD:Start(1-delay)
	timerFieryGrowthCD:Start(1-delay)
	timerFallingStarsCD:Start(1-delay)
	timerMassEntanglementCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 423260 or spellId == 426669 then--Other, Mythic
		self.vb.shroomCount = self.vb.shroomCount + 1
		if not DBM:UnitDebuff("player", 424578) then
			warnBlazingMushroom:Show(self.vb.shroomCount)
			if self.vb.shroomCount % 2 == 0 then
				warnBlazingMushroom:Play("sharetwo")
			else
				warnBlazingMushroom:Play("shareone")
			end
		else
			specWarnBlazingMushroomAvoid:Show()
			specWarnBlazingMushroomAvoid:Play("watchstep")
		end
		if self:AntiSpam(10, 1) then
			timerBlazingMushroomCD:Start()
		end
	elseif spellId == 424581 then
		self.vb.growthCount = self.vb.growthCount + 1
		self.vb.growthIcon = 1
		timerFieryGrowthCD:Start()
	elseif spellId == 420236 then
		self.vb.starsCount = self.vb.starsCount + 1
		timerFallingStarsCD:Start()
	elseif spellId == 424495 then
		self.vb.entangleCount = self.vb.entangleCount + 1
		self.vb.entangleIcon = 8
		timerMassEntanglementCD:Start()
	elseif spellId == 421398 then
		self.vb.beamtreeCount = self.vb.beamtreeCount + 1
		timerFirebeamCD:Start()
	elseif spellId == 421603 then--Incarnation of Owl cast time (likely intermission)
		timerBlazingMushroomCD:Stop()
		timerFieryGrowthCD:Stop()
		timerFallingStarsCD:Stop()
		timerMassEntanglementCD:Stop()
		if self:GetStage(1) then
			self:SetStage(1.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
		else
			self:SetStage(2.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
		end
	elseif spellId == 426016 or spellId == 424140 then
		warnSuperNova:Show()
		timerSupernova:Start()
	elseif spellId == 423265 then
		self.vb.beamtreeCount = self.vb.beamtreeCount + 1
		specWarnTranquilityofFlame:Show(self.vb.beamtreeCount)
		specWarnTranquilityofFlame:Play("aesoon")
		timerTranquilityofFlameCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 422000 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount > 12 then--Placeholder until review
			if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnSearingWrath:Show(args.destName)
				specWarnSearingWrath:Play("tauntboss")
			else
				warnSearingWrath:Show(args.destName, amount)
			end
		else
			warnSearingWrath:Show(args.destName, amount)
		end
	elseif spellId == 424581 then
		local icon = self.vb.growthIcon
		if self.Options.SetIconOnFieryGrowth then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFieryGrowth:Show()
			specWarnFieryGrowth:Play("targetyou")
			yellFieryGrowth:Yell(icon, icon)
		end
		warnFieryGrowth:CombinedShow(0.5, self.vb.growthCount, args.destName)
		self.vb.growthIcon = self.vb.growthIcon + 1
	elseif spellId == 424580 then
		if args:IsPlayer() then
			specWarnFallingStars:Show()
			specWarnFallingStars:Play("runout")
			yellFallingStars:Yell()
			yellFallingStarsFades:Countdown(spellId)
		end
	elseif spellId == 424495 then
		local icon = self.vb.entangleIcon
		if self.Options.SetIconOnEntangle then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMassEntanglement:Show()
			specWarnMassEntanglement:Play("targetyou")
			yellMassEntanglement:Yell(icon, icon)
			yellMassEntanglementFades:Countdown(spellId, nil, icon)
		end
		warnMassEntanglement:CombinedShow(0.5, self.vb.entangleCount, args.destName)
		self.vb.entangleIcon = self.vb.entangleIcon + 1
	elseif spellId == 420238 then
		if args:IsPlayer() then
			specWarnSunfire:Show()
			specWarnSunfire:Play("targetyou")
		end
	elseif spellId == 420540 then--Moonkin Form starting
		self.vb.beamtreeCount = 0--Used for beam casts
		warnIncarnationMoonkin:Show()
		timerFirebeamCD:Start(2)
	elseif spellId == 422115 then--Tree form starting
		self.vb.beamtreeCount = 0--Used for Tranquility casts
		warnIncarnationTreeofFlame:Show()
--	elseif spellId == 425582 then--Mythic in phase owl form
		--Do stuff
	elseif spellId == 424258 then
		if args:IsPlayer() then
			warnDreamEssence:Cancel()
			warnDreamEssence:Schedule(1, args.amount or 1)
		end
	elseif spellId == 424665 then
		if args:IsPlayer() then
			warnSeedofFlame:Cancel()
			warnSeedofFlame:Schedule(1, args.amount or 1)
		end
	elseif spellId == 424180 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs("boss1"))
		end
	elseif spellId == 424579 then
		warnSupressiveEmber:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSupressingEmber:Show()
			specWarnSupressingEmber:Play("targetyou")
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 424580 then
		if args:IsPlayer() then
			specWarnFallingStars:Show()
			specWarnFallingStars:Play("runout")
			yellFallingStars:Yell()
			yellFallingStarsFades:Countdown(spellId)
		end
	elseif spellId == 424581 then
		if self.Options.SetIconOnFieryGrowth then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 424495 then
		if self.Options.SetIconOnEntangle then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMassEntanglementFades:Cancel()
		end
	elseif spellId == 420540 then--Moonkin Form ending
		timerFirebeamCD:Stop()
	elseif spellId == 422115 then--Tree form ending
		timerTranquilityofFlameCD:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
--	elseif spellId == 421603 then--Intermission owl form ending

--	elseif spellId == 425582 then--Mythic owl form ending

	elseif spellId == 424180 then
		warnSuperNovaEnded:Show()
		timerSupernova:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 423649 or spellId == 424499) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 then

	end
end
--]]
