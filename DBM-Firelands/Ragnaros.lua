local mod	= DBM:NewMod(198, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetModelID(37875)
mod:SetZone()
mod:SetUsedIcons(7, 8) -- cross(7) is hard to see in redish environment?
mod:SetModelSound("Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_AGGRO.wav", "Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_KILL_03.wav")
--Long: blah blah blah (didn't feel like transcribing it)
--Short: This is my realm

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local warnHandRagnaros		= mod:NewSpellAnnounce(98237, 3, nil, mod:IsMelee())--Phase 1 only ability
local warnWrathRagnaros		= mod:NewSpellAnnounce(98263, 3, nil, mod:IsRanged())--Phase 1 only ability
local warnBurningWound		= mod:NewStackAnnounce(99399, 3, nil, mod:IsTank() or mod:IsHealer())
local warnMoltenSeed		= mod:NewSpellAnnounce(98520, 4)--Phase 2 only ability
local warnLivingMeteor		= mod:NewSpellAnnounce(99268, 4)--Phase 3 only ability
local warnSplittingBlow		= mod:NewAnnounce("warnSplittingBlow", 4, 100877)
local warnEngulfingFlame	= mod:NewAnnounce("warnEngulfingFlame", 4, 99171)
local warnBlazingHeat		= mod:NewTargetAnnounce(100460, 4)--Second transition adds ability.
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3, 3)

local specWarnSplittingBlow	= mod:NewSpecialWarningSpell(100877)
local specWarnMoltenSeed	= mod:NewSpecialWarningSpell(98520, nil, nil, nil, true)
local specWarnBlazingHeat	= mod:NewSpecialWarningYou(100460)
local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, mod:IsTank(), 4)

local timerMagmaTrap		= mod:NewCDTimer(25, 98164)		-- Phase 1 only ability
local timerSulfurasSmash	= mod:NewCDTimer(40, 98710)		-- might even be a "next" timer
local timerHandRagnaros		= mod:NewCDTimer(25, 98237, nil, mod:IsMelee())-- might even be a "next" timer
local timerWrathRagnaros	= mod:NewCDTimer(30, 98263, nil, mod:IsRanged())--CD will be delayed by Smash in event of an overlap.
local timerBurningWound		= mod:NewTargetTimer(20, 99399, nil, mod:IsTank() or mod:IsHealer())
local timerFlamesCD			= mod:NewCDTimer(40, 99171)
local timerMoltenSeedCD		= mod:NewCDTimer(60, 98520)
local timerMoltenSeed		= mod:NewBuffActiveTimer(10, 98520)
local timerLivingMeteorCD	= mod:NewCDTimer(45, 99268)
local timerPhaseSons		= mod:NewTimer(45, "TimerPhaseSons", 99014)	-- lasts 45secs or till all sons are dead

local soundBlazingHeat		= mod:NewSound(100460)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("BlazingHeatIcons", true)

local wrathRagSpam = 0
local lastSeeds = 0
local lastMeteor = 0
local sonsDied = 0
local phase = 1
local prewarnedPhase2 = false
local prewarnedPhase3 = false
local phase2Started = false
local phase23tarted = false
local blazingHeatIcon = 8

local function showRangeFrame()
	if mod.Options.RangeFrame then
		if phase < 3 then
			DBM.RangeCheck:Show(6)
		else
			DBM.RangeCheck:Show(5)
		end
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFram then
		DBM.RangeCheck:Hide()
	end
end

local function TransitionEnded()
	timerPhaseSons:Cancel()
	if phase == 2 and not phase2Started then
		phase2Started = true
		timerFlamesCD:Start(43)
		timerMoltenSeedCD:Start(25)
		timerSulfurasSmash:Start(18)--18-20sec after last son dies (or 45second push)
		showRangeFrame()--Range 6 for seeds
	elseif phase == 3 and not phase3Started then
		phase3Started = true
		showRangeFrame()--Range 5 for meteors (should it be 8 instead?) Conflicting tooltip information.
		timerFlamesCD:Start(32)
		timerLivingMeteorCD:Start()
	end
end

function mod:OnCombatStart(delay)
	timerMagmaTrap:Start(16-delay)
	timerSulfurasSmash:Start(30-delay)
	wrathRagSpam = 0
	lastSeeds = 0
	lastMeteor = 0
	sonsDied = 0
	phase = 1
	prewarnedPhase2 = false
	prewarnedPhase3 = false
	blazingHeatIcon = 8
	phase2Started = false
	phase23tarted = false
end

function mod:OnCombatEnd()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99399, 101238, 101239, 101240) then
		warnBurningWound:Show(args.destName, args.amount or 1)
		if (args.amount or 0) >= 4 and args:IsPlayer() then
			specWarnBurningWound:Show(args.amount)
		end
		timerBurningWound:Start(args.destName)
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98710, 100890, 100891, 100892) then
		if phase == 1 then
			timerSulfurasSmash:Start(30)--30 second cd in phase 1.
		else
			timerSulfurasSmash:Start()
		end
	elseif args:IsSpellID(98951, 98952, 98953, 100877) or args:IsSpellID(100878, 100879, 100880, 100881) or args:IsSpellID(100882, 100883, 100884, 100885) then--This has 12 spellids, 1 for each possible location for hammer.
		timerMagmaTrap:Cancel()
		timerSulfurasSmash:Cancel()
		timerHandRagnaros:Cancel()
		timerWrathRagnaros:Cancel()
		hideRangeFrame()
		timerPhaseSons:Start(45)--Is this 45 second from spell cast start or spell cast end?
		mod:Schedule(45, TransitionEnded)--^^
		sonsDied = 0
		phase = phase + 1
		specWarnSplittingBlow:Show()
		--Middle: 100877 (25N) (Guessed: 98951, 100878, 100879)
		--East: 100880 (25N) (Guessed: 98952, 100881, 100882)
		--West: 100883 (25N) (Guessed: 98953, 100884, 100885)
		if args:IsSpellID(100877) then--Middle
			warnSplittingBlow(args.spellName, L.Middle)
		elseif args:IsSpellID(100880) then--East
			warnSplittingBlow(args.spellName, L.East)
		elseif args:IsSpellID(100883) then--West
			warnSplittingBlow(args.spellName, L.West)
		end
	elseif args:IsSpellID(99172, 99235, 99236, 100175) or args:IsSpellID(100176, 100177, 100178, 100179) or args:IsSpellID(100180, 100181, 100182, 100183) then--Another scripted spell with a ton of spellids based on location of room.
		if phase == 3 then
			timerFlamesCD:Start(30)--30 second CD in phase 3
		else
			timerFlamesCD:Start()--40 second CD in phase 2
		end
		--North: 100175 (25N) (Guessed: 99172, 100176, 100177)
		--Middle: 100178 (25N) (Guessed: 99235, 100179, 100180)
		--South: 100181 (25N) (Guessed: 99236, 100182, 100183)
		if args:IsSpellID(100175) then--North
			warnEngulfingFlame(args.spellName, L.North)
		elseif args:IsSpellID(100178) then--Middle
			warnEngulfingFlame(args.spellName, L.Middle)
		elseif args:IsSpellID(100181) then--South
			warnEngulfingFlame(args.spellName, L.South)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98237, 100383, 100384, 100387) then
		warnHandRagnaros:Show()
		timerHandRagnaros:Start()
	elseif args:IsSpellID(98164) then	--98164 confirmed
		timerMagmaTrap:Start()
	elseif args:IsSpellID(98263, 100113, 100114, 100115) and GetTime() - wrathRagSpam >= 4 then
		wrathRagSpam = GetTime()
		warnWrathRagnaros:Show()
		timerWrathRagnaros:Start()
	elseif args:IsSpellID(100460, 100981, 100982, 100983) then	-- Blazing heat, drycoded.
		warnBlazingHeat:Show(args.destName)
		if args:IsPlayer() then
			specWarnBlazingHeat:Show()
			soundBlazingHeat:Play()
		end
		if self.Options.BlazingHeatIcons then
			self:SetIcon(args.destName, blazingHeatIcon, 8)
			if blazingHeatIcon == 8 then-- Alternate icons, they are cast too far apart to sort in a table or do icons at once, and there are 2 adds up so we need to do it this way.
				blazingHeatIcon = 7
			else
				blazingHeatIcon = 8
			end
		end
	elseif args:IsSpellID(99268) and GetTime() - lastMeteor >= 4 then
		lastMeteor = GetTime()
		warnLivingMeteor:Show()
		timerLivingMeteorCD:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(98495) or args:IsSpellID(98498, 100579, 100580, 100581) and GetTime() - lastSeeds > 25 then--This has no cast trigger to speak of, only spell damage, so we need anti spam.
		lastSeeds = GetTime()
		warnMoltenSeed:Show()--Not sure if this damage is the cast, or the explosion 10 seconds after, so not sure if warn here, or schedule warn in 50 seconds. will have to pull once and see.
		specWarnMoltenSeed:Show()--^^
		timerMoltenSeed:Start()--^^
		timerMoltenSeedCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then
		sonsDied = sonsDied + 1
		if sonsDied >= 8 then
			self:Unschedule(TransitionEnded)
			TransitionEnded()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 52409 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 80 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 72 and h < 75 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		elseif h > 50 and prewarnedPhase3 then
			prewarnedPhase3 = false
		elseif h > 42 and h < 45 and not prewarnedPhase3 then
			prewarnedPhase3 = true
			warnPhase3Soon:Show()
		end
	end
end