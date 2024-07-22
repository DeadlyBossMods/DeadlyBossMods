local mod	= DBM:NewMod(2565, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209090)--Primary ID
mod:SetEncounterID(2786)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(20240116000000)
mod:SetMinSyncRevision(20231115000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 423260 426669 424581 420236 424495 421398 426016 424140 423265 421636 429169",
	"SPELL_CAST_SUCCESS 424495",
	"SPELL_AURA_APPLIED 422000 424581 424495 420540 425582 424258 422115 424579 424665 424180 422509 424582 424140 421603",--424580 426686 420238
	"SPELL_AURA_APPLIED_DOSE 422000 424258 424665 424582",
	"SPELL_AURA_REMOVED 424581 421603 424180 422115 424140",--424580
	"SPELL_PERIODIC_DAMAGE 424499 423649",
	"SPELL_PERIODIC_MISSED 424499 423649"
)

--[[
(ability.id = 429169 or ability.id = 425576 or ability.id = 423260 or ability.id = 426669 or ability.id = 424581 or ability.id = 420236 or ability.id = 421398 or ability.id = 421603 or ability.id = 426016 or ability.id = 424140 or ability.id = 423265) and type = "begincast"
 or ability.id = 424495 and type = "cast"
 or (ability.id = 424180 or ability.id = 420540 or ability.id = 422115 or ability.id = 425582 or ability.id = 424140) and (type = "applybuff" or type = "removebuff" or type = "applydebuff" or type = "removedebuff")
 or ability.id = 421603
--]]
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(423649, nil, nil, nil, 1, 8)

local timerPhaseCD									= mod:NewStageTimer(60)
--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: Moonkin of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27488))
----Tindral Sageswift
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27509))
local warnSearingWrath								= mod:NewStackAnnounce(422000, 2, nil, "Tank|Healer")
local warnBlazingMushroom							= mod:NewCountAnnounce(423260, 3, nil, nil, nil, nil, nil, 2)
local warnFieryGrowth								= mod:NewTargetCountAnnounce(424581, 3)
local warnLingeringCinder							= mod:NewCountAnnounce(424582, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(424582))
local warnIncarnationOwl							= mod:NewCountAnnounce(425576, 4)

local specWarnSearingWrath							= mod:NewSpecialWarningTaunt(422000, nil, nil, nil, 1, 2)
local specWarnFieryGrowth							= mod:NewSpecialWarningMoveAway(424581, nil, nil, nil, 1, 2)
local yellFieryGrowth								= mod:NewShortPosYell(424581, nil, false, 2)
local specWarnFallingStars							= mod:NewSpecialWarningCount(420236, nil, nil, nil, 2, 2)
local specWarnMassEntanglement						= mod:NewSpecialWarningYou(424495, nil, nil, nil, 1, 2)

local timerBlazingMushroomCD						= mod:NewNextCountTimer(49, 423260, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFieryGrowthCD							= mod:NewNextCountTimer(49, 424581, DBM_COMMON_L.DISPELS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFallingStarsCD							= mod:NewNextCountTimer(49, 420236, nil, nil, nil, 3)
local timerMassEntanglementCD						= mod:NewNextCountTimer(49, 424495, DBM_COMMON_L.ROOTS.." (%s)", nil, nil, 3)
local timerOwlCD									= mod:NewNextCountTimer(20, 425576, L.Feathers.." (%s)", nil, nil, 6, nil, DBM_COMMON_L.MYTHIC_ICON)--Short name "Feathers"

mod:AddSetIconOption("SetIconOnFieryGrowth", 424581, true, 0, {1, 2, 3, 4})
----Moonkin of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27495))
local warnIncarnationMoonkin						= mod:NewCountAnnounce(420540, 2)

local specWarnFireBeam								= mod:NewSpecialWarningCount(421398, nil, nil, nil, 2, 2)

local timerMoonkinCD								= mod:NewNextCountTimer(20, 420540, L.MoonkinForm.." (%s)", false, nil, 6)--Kinda redundant, ability has own timer
local timerFirebeamCD								= mod:NewNextCountTimer(49, 421398, nil, nil, nil, 3)
--Intermission: Burning Pursuit
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27500))
local warnEmpoweredFeather							= mod:NewYouAnnounce(422509, 1)
local warnDreamEssence								= mod:NewCountAnnounce(424258, 1, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(424258))
local warnSuperNova									= mod:NewCastAnnounce(424140, 4)
local warnSuperNovaEnded							= mod:NewSpellAnnounce(424140, 1)

local specWarnTyphoon								= mod:NewSpecialWarningSpell(421636, nil, nil, nil, 2, 13)

local timerTyphoon									= mod:NewCastTimer(5.5, 421636, DBM_COMMON_L.PUSHBACK, nil, nil, 2)
local timerSupernova								= mod:NewCastTimer(20, 424140, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddInfoFrameOption(424140, true)
--Stage Two: Tree of the Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27506))
local warnIncarnationTreeofFlame					= mod:NewCountAnnounce(422115, 2)
local warnSupressiveEmber							= mod:NewTargetAnnounce(424579, 3, nil, false)
local warnSeedofFlame								= mod:NewCountAnnounce(424665, 1, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(424665))

local specWarnSupressingEmber						= mod:NewSpecialWarningYou(424579, nil, nil, nil, 1, 2)
local specWarnFlamingGermination					= mod:NewSpecialWarningCount(423265, nil, 99727, nil, 2, 2)

local timerTreeofFlameCD							= mod:NewNextCountTimer(20, 422115, L.TreeForm.." (%s)", false, nil, 6)--Kinda redundant, ability has own timer
local timerFlamingGerminationCD						= mod:NewNextCountTimer(20, 423265, 99727, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--Short name "Flame Seeds"
local timerSuperNovaCD								= mod:NewNextTimer(20, 424140, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

--base abilities
mod.vb.shroomCount = 0
mod.vb.growthCount = 0
mod.vb.growthIcon = 1
mod.vb.starsCount = 0
mod.vb.entangleCount = 0
--Forms
mod.vb.moonkinCount = 0
mod.vb.treeCount = 0
mod.vb.owlCount = 0
--Form Abilities
mod.vb.beamCount = 0
mod.vb.tranqCount = 0

local difficultyName = "heroic"
local allTimers = {
	["normal"] = {
		[1] = {--Current as of Live Nov 15th for normal
			--Blazing  Mushroom
			[423260] = {19.0, 34},
			--Fiery Growth
			[424581] = {13.0, 37.0},
			--Falling Stars
			[420236] = {24.0, 34.9},
			--Mass Entanglement
			[424495] = {6.1, 36.9},
			--Moonkin Form
			[420540] = {29.1, 34.9},
			--Fire Beam
			[421398] = {34.1, 33.9},
		},
		[2] = {
			--Blazing  Mushroom
			[423260] = {44.0, 44.0},
			--Fiery Growth
			[424581] = {50.0, 41.9},
			--Falling Stars
			[420236] = {36.0, 44.0},
			--Mass Entanglement
			[424495] = {26.0, 43.9},
			--Tree Form
			[422115] = {53.0, 42.0},
			--Flaming Germination
			[423265] = {57.0, 42.0}
		},
		[3] = {
			--Blazing  Mushroom
			[423260] = {31, 30.9, 40.0, 33.0, 40.0, 33.0, 110.0, 30.9, 40.0, 36.0},
			--Fiery Growth
			[424581] = {24, 91.0, 50.9, 48.9, 23.0, 93.9, 53.0},
			--Falling Stars
			[420236] = {48, 47.9, 66.9, 37.0, 59.9, 49.9, 72.0},
			--Mass Entanglement
			[424495] = {37, 46.9, 68.0, 54.9, 40.9, 50.0, 72.9},
			--Moonkin Form
			[420540] = {50.1, 55.9, 36.0, 47.0, 73.0, 57.9, 39.0},
			--Fire Beam
			[421398] = {52, 58.9, 34.0, 46.9, 73.9, 58.9, 37.0},
			--Tree Form
			[422115] = {70, 51.9, 48.0, 47.9, 65.9, 54.9, 47.9},
			--Flaming Germination
			[423265] = {78, 49.0, 46.0, 47.9, 70.9, 52.0, 46.0},
		},
	},
	["heroic"] = {--Current as of Live Nov 15th for heroic
		[1] = {
			--Blazing  Mushroom
			[423260] = {22.1, 40},
			--Fiery Growth
			[424581] = {25.1, 40},
			--Falling Stars
			[420236] = {6.1, 41.9},
			--Mass Entanglement
			[424495] = {10.1, 40},
			--Moonkin Form
			[420540] = {28.1, 40},
			--Fire Beam
			[421398] = {34, 40},
		},
		[2] = {
			--Blazing  Mushroom
			[423260] = {38.0, 47.9},
			--Fiery Growth
			[424581] = {42.0, 48},
			--Falling Stars
			[420236] = {30.0, 47.9},
			--Mass Entanglement
			[424495] = {20.0, 48},
			--Tree Form
			[422115] = {46.0, 48},
			--Flaming Germination
			[423265] = {55.0, 48},
		},
		[3] = {
			--Blazing  Mushroom
			[423260] = {27.0, 31.0, 43.5, 49.4, 75.9},
			--Fiery Growth
			[424581] = {24.0, 99.9, 60.0, 58.1},
			--Falling Stars
			[420236] = {40.0, 58.5, 68.5, 57.0},
			--Mass Entanglement
			[424495] = {29.0, 56.9, 86.0, 61.5},
			--Moonkin Form
			[420540] = {46.0, 57.5, 52.4, 57.0},
			--Tree Form
			[422115] = {62.0, 69.1, 58.0, 56.0},
			--Fire Beam
			[421398] = {52.0, 59.5, 49.5, 55.0},
			--Flaming Germination
			[423265] = {68.0, 64.0, 62.0, 54.0},
		},
	},
	["mythic"] = {
		[1] = {
			--Blazing  Mushroom (Wild Mushroom on mythic)
			[423260] = {18.0, 40.0},
			--Fiery Growth
			[424581] = {20.0, 40.0},
			--Falling Stars
			[420236] = {14.0, 40.0},
			--Mass Entanglement (Roots)
			[424495] = {27.0, 20.0, 20.0},
			--Moonkin Form
			[420540] = {6.2, 26.0, 40.0},
			--Fire Beam
			[421398] = {7.2, 33.0, 33.0},
			--Owl Form (mythic)
			[425582] = {23.0, 40.0},
		},
		[2] = {
			--Blazing  Mushroom (Wild Mushroom on mythic)
			[423260] = {23.0, 47.0},
			--Fiery Growth
			[424581] = {25.0, 22.0, 25.0},
			--Falling Stars
			[420236] = {20.0, 35.0, 39.0},
			--Mass Entanglement
			[424495] = {32.0, 31.0, 20.0},
			--Tree Form
			[422115] = {36.0, 22.0, 29.0},
			--Flaming Germination (Seeds)
			[423265] = {37.0, 22.0, 29.0},
			--Owl Form (mythic)
			[425582] = {28.0, 51.0},
		},
		[3] = {
			--Blazing  Mushroom (Wild Mushroom on mythic)
			[423260] = {48.0, 60.0, 67.0},
			--Fiery Growth
			[424581] = {50.0, 40.0, 35.0, 45.0, 40.0},
			--Falling Stars
			[420236] = {20.0, 38.0, 40.0, 40.0, 40.0, 40.0, 40.0},
			--Mass Entanglement
			[424495] = {24.0, 42.0, 19.0, 29.0, 19.0, 24.0, 24.0, 21.0},
			--Moonkin Form
			[420540] = {29.0, 63.0, 50.0, 46.0, 19.0},
			--Tree Form
			[422115] = {36.0, 35.0, 47.0, 43.0, 51.0},
			--Fire Beam
			[421398] = {31.0, 63.0, 49.0, 46.1, 19.0},
			--Flaming Germination (Seeds)
			[423265] = {37.0, 35.0, 47.0, 43.0, 51.0},
			--Owl Form (mythic)
			[425582] = {22.0, 40.0, 48.0, 42.0, 47.0},
		},
	},
}

---@param self DBMMod
local function delaySuperNova(self)
	timerSuperNovaCD:Start(self:IsEasy() and 387 or 249)--Blizzard energy, so ~3
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.shroomCount = 0
	self.vb.growthCount = 0
	self.vb.growthIcon = 1
	self.vb.starsCount = 0
	self.vb.entangleCount = 0
	self.vb.moonkinCount = 0
	self.vb.owlCount = 0
	self.vb.treeCount = 0
	self.vb.beamCount = 0
	self.vb.tranqCount = 0
	if self:IsMythic() then
		difficultyName = "mythic"
		timerMoonkinCD:Start(6.2-delay, 1)
		timerFirebeamCD:Start(7, 1)
		timerFallingStarsCD:Start(14-delay, 1)
		timerBlazingMushroomCD:Start(18-delay, 1)
		timerFieryGrowthCD:Start(20-delay, 1)
		timerOwlCD:Start(23-delay, 1)
		timerMassEntanglementCD:Start(27-delay, 1)
		timerPhaseCD:Start(80-delay, 1.5)--Cast Start
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerFallingStarsCD:Start(6.1-delay, 1)
		timerMassEntanglementCD:Start(10.1-delay, 1)
		timerBlazingMushroomCD:Start(22.1-delay, 1)
		timerFieryGrowthCD:Start(25.1-delay, 1)
		timerMoonkinCD:Start(28.1-delay, 1)
		timerFirebeamCD:Start(34.0, 1)
		timerPhaseCD:Start(80.1-delay, 1.5)--Cast start
	else--Normal and LFR are the same
		difficultyName = "normal"
		timerMassEntanglementCD:Start(6.0-delay, 1)
		timerFieryGrowthCD:Start(13.0-delay, 1)
		timerBlazingMushroomCD:Start(19.0-delay, 1)
		timerFallingStarsCD:Start(24.0-delay, 1)
		timerMoonkinCD:Start(29.1-delay, 1)
		timerFirebeamCD:Start(34.1, 1)
		timerPhaseCD:Start(79.1-delay, 1.5)--Applied (cast start not in combat log on normal)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
	else
--		difficultyName = "lfr"
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 423260 or spellId == 426669 then--Other, Mythic
		self.vb.shroomCount = self.vb.shroomCount + 1
		warnBlazingMushroom:Show(self.vb.shroomCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 423260, self.vb.shroomCount+1)
		if timer then
			timerBlazingMushroomCD:Start(timer, self.vb.shroomCount+1)
		end
	elseif spellId == 424581 then
		self.vb.growthCount = self.vb.growthCount + 1
		self.vb.growthIcon = 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.growthCount+1)
		if timer then
			timerFieryGrowthCD:Start(timer, self.vb.growthCount+1)
		end
	elseif spellId == 420236 then
		self.vb.starsCount = self.vb.starsCount + 1
		specWarnFallingStars:Show(self.vb.starsCount)
		specWarnFallingStars:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.starsCount+1)
		if timer then
			timerFallingStarsCD:Start(timer, self.vb.starsCount+1)
		end
	elseif spellId == 421398 then
		self.vb.beamCount = self.vb.beamCount + 1
		specWarnFireBeam:Show(self.vb.beamCount)
		specWarnFireBeam:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.beamCount+1)
		if timer then
			timerFirebeamCD:Start(timer, self.vb.beamCount+1)
		end
	elseif spellId == 426016 or spellId == 424140 or spellId == 429169 then
		warnSuperNova:Show()
	elseif spellId == 423265 then
		self.vb.tranqCount = self.vb.tranqCount + 1
		specWarnFlamingGermination:Show(self.vb.tranqCount)
		specWarnFlamingGermination:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tranqCount+1)
		if timer then
			timerFlamingGerminationCD:Start(timer, self.vb.tranqCount+1)
		end
	elseif spellId == 421636 then
		specWarnTyphoon:Show()
		specWarnTyphoon:Play("pushbackincoming")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 424495 then
		self.vb.entangleCount = self.vb.entangleCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.entangleCount+1)
		if timer then
			timerMassEntanglementCD:Start(timer, self.vb.entangleCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 422000 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 9 then
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnSearingWrath:Show(args.destName)
					specWarnSearingWrath:Play("tauntboss")
				else
					warnSearingWrath:Show(args.destName, amount)
				end
			else
				warnSearingWrath:Show(args.destName, amount)
			end
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
	elseif spellId == 424495 then
		if args:IsPlayer() then
			specWarnMassEntanglement:Show()
			specWarnMassEntanglement:Play("targetyou")
		end
	elseif spellId == 420540 then--Moonkin Form starting
		self.vb.moonkinCount = self.vb.moonkinCount + 1
		warnIncarnationMoonkin:Show(self.vb.moonkinCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.moonkinCount+1)
		if timer then
			timerMoonkinCD:Start(timer, self.vb.moonkinCount+1)
		end
	elseif spellId == 422115 then--Tree form starting
		self.vb.treeCount = self.vb.treeCount + 1
		warnIncarnationTreeofFlame:Show(self.vb.treeCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.treeCount+1)
		if timer then
			timerTreeofFlameCD:Start(timer, self.vb.treeCount+1)
		end
	elseif spellId == 425582 then--Mythic in phase owl form
		self.vb.owlCount = self.vb.owlCount + 1
		warnIncarnationOwl:Show(self.vb.owlCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.owlCount+1)
		if timer then
			timerOwlCD:Start(timer, self.vb.owlCount+1)
		end
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
	elseif spellId == 421603 then--Incarnation of Owl (Intermission version)
		timerBlazingMushroomCD:Stop()
		timerFieryGrowthCD:Stop()
		timerFallingStarsCD:Stop()
		timerMassEntanglementCD:Stop()
		timerFlamingGerminationCD:Stop()
		timerTyphoon:Start()--5.5
		if self:GetStage(1) then
			self:SetStage(1.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			timerPhaseCD:Start(41.2, 2)
		else
			self:SetStage(2.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
			timerPhaseCD:Start(28.1, 3)--28.1-34
		end
	elseif spellId == 424180 or spellId == 424140 then--424140 intermission, 424180 unknown
		timerSupernova:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs("boss1"))
		end
		self.vb.shroomCount = 0
		self.vb.growthCount = 0
		self.vb.starsCount = 0
		self.vb.entangleCount = 0
		self.vb.moonkinCount = 0
		self.vb.owlCount = 0
		self.vb.treeCount = 0
		self.vb.beamCount = 0
		self.vb.tranqCount = 0
		if self:GetStage(2, 1) then
			self:SetStage(2)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			if self:IsMythic() then--Live Vetted
				timerFallingStarsCD:Start(20, 1)
				timerBlazingMushroomCD:Start(23, 1)
				timerFieryGrowthCD:Start(25, 1)
				timerOwlCD:Start(28, 1)
				timerMassEntanglementCD:Start(32, 1)
				timerTreeofFlameCD:Start(36, 1)
				timerFlamingGerminationCD:Start(37, 1)
				timerPhaseCD:Start(100, 2.5)
			elseif self:IsHeroic() then--Live Vetted
				timerMassEntanglementCD:Start(20, 1)
				timerFallingStarsCD:Start(30, 1)
				timerBlazingMushroomCD:Start(38, 1)
				timerFieryGrowthCD:Start(42, 1)
				timerTreeofFlameCD:Start(46, 1)
				timerFlamingGerminationCD:Start(55, 1)
				--timerPhaseCD:Start(100, 2.5)
			elseif self:IsNormal() then--Live Vetted
				timerMassEntanglementCD:Start(26, 1)
				timerFallingStarsCD:Start(36, 1)
				timerBlazingMushroomCD:Start(44, 1)
				timerFieryGrowthCD:Start(50, 1)
				timerTreeofFlameCD:Start(53, 1)
				timerFlamingGerminationCD:Start(57, 1)
			else--LFR unknown again, normal placeholders
				timerMassEntanglementCD:Start(26, 1)
				timerFallingStarsCD:Start(36, 1)
				timerBlazingMushroomCD:Start(39.8, 1)
				timerFieryGrowthCD:Start(44, 1)
				timerTreeofFlameCD:Start(53, 1)
				timerFlamingGerminationCD:Start(57, 1)
			end
		else
			self:SetStage(3)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			if self:IsMythic() then--Live Vetted
				timerFallingStarsCD:Start(20, 1)
				timerOwlCD:Start(22, 1)
				timerMassEntanglementCD:Start(24, 1)
				timerMoonkinCD:Start(29, 1)
				timerFirebeamCD:Start(31, 1)
				timerTreeofFlameCD:Start(36, 1)
				timerFlamingGerminationCD:Start(37, 1)
				timerBlazingMushroomCD:Start(48, 1)
				timerFieryGrowthCD:Start(50, 1)
			elseif self:IsHeroic() then--Live Vetted
				timerFieryGrowthCD:Start(24, 1)
				timerBlazingMushroomCD:Start(27, 1)
				timerMassEntanglementCD:Start(29, 1)
				timerFallingStarsCD:Start(40, 1)
				timerMoonkinCD:Start(46, 1)
				timerFirebeamCD:Start(52, 1)
				timerTreeofFlameCD:Start(62, 1)
				timerFlamingGerminationCD:Start(68, 1)
			elseif self:IsNormal() then--Live Vetted
				timerFieryGrowthCD:Start(24, 1)
				timerBlazingMushroomCD:Start(31, 1)
				timerMassEntanglementCD:Start(37, 1)
				timerFallingStarsCD:Start(48, 1)
				timerMoonkinCD:Start(50, 1)
				timerFirebeamCD:Start(52, 1)
				timerTreeofFlameCD:Start(70, 1)
				timerFlamingGerminationCD:Start(78, 1)
			else--LFR unknown, normal placeholders
				timerFieryGrowthCD:Start(24, 1)
				timerBlazingMushroomCD:Start(31, 1)
				timerMassEntanglementCD:Start(37, 1)
				timerFallingStarsCD:Start(48, 1)
				timerTreeofFlameCD:Start(41.4, 1)
				timerFlamingGerminationCD:Start(42.9, 1)
				timerMoonkinCD:Start(50, 1)
				timerFirebeamCD:Start(52, 1)
			end
			self:Schedule(20, delaySuperNova, self)--So the cd bar is only shown after the existing cast bar is gone (2 supernova bars confusing some users)
		end
	elseif spellId == 424579 then
		warnSupressiveEmber:CombinedShow(0.3, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnSupressingEmber:Show()
			specWarnSupressingEmber:Play("targetyou")
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", spellId)
		end
	elseif spellId == 422509 and args:IsPlayer() then
		warnEmpoweredFeather:Show()
	elseif spellId == 424582 then
		if args:IsPlayer() then
			warnLingeringCinder:Show(args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 424581 then
		if self.Options.SetIconOnFieryGrowth then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 422115 then--Tree form ending
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 424180 or spellId == 424140 then--Supernova ending on boss
		warnSuperNovaEnded:Show()
		timerSupernova:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 423649 or spellId == 424499) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
