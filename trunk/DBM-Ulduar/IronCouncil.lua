local mod = DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32927)
mod:SetZone()

mod:RegisterCombat("combat", 32867, 32927, 32857)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

local timerSupercharge		= mod:NewTimer(10, "TimerSupercharge", 61920)
local warnSupercharge		= mod:NewAnnounce("WarningSupercharge", 3, 61920)

-- Stormcaller Brundir
-- High Voltage ... 63498
local warnChainlight		= mod:NewAnnounce("WarningChainlight", 1, 64215)
local timerOverload		= mod:NewCastTimer(6, 63481)
local timerLightningWhirl	= mod:NewTimer(5, "TimerLightningWhirl", 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarning("LightningTendrils")  -- 63486
local timerLightningTendrils	= mod:NewTimer(27, "TimerLightningTendrils", 63486)
mod:AddBoolOption("PlaySoundLightningTendrils", true, "announce")
mod:AddBoolOption("PlaySoundOnOverload", true, "announce")

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch		= mod:NewAnnounce("WarningFusionPunch", 4, 61903)
local timerFusionPunchCast	= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTimer(4, "timerFusionPunchActive", 61903)
local warnOverwhelmingPower	= mod:NewAnnounce("WarningOverwhelmingPower", 2, 61888)
local timerOverwhelmingPower	= mod:NewTimer(25, "timerOverwhelmingPower", 61888)
mod:AddBoolOption("SetIconOnOverwhelmingPower", true, "announce")


-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
local timerRunicBarrier		= mod:NewTimer(20, "timerRunicBarrier", 62338)
local warnRuneofPower		= mod:NewAnnounce("WarningRuneofPower", 1, 64320)
local warnRuneofDeath		= mod:NewAnnounce("WarningRuneofDeath", 2, 63490)
local warnRuneofSummoning	= mod:NewAnnounce("WarningRuneofSummoning", 3, 62273)
local specwarnRuneofDeath	= mod:NewSpecialWarning("RuneofDeath")
local timerRuneofDeathDura	= mod:NewNextTimer(30, 63490)
local timerRuneofPower		= mod:NewCDTimer(30, 61974)
local timerRuneofDeath		= mod:NewCDTimer(30, 63490)
mod:AddBoolOption("PlaySoundDeathRune", true, "announce")

local enrageTimer		= mod:NewEnrageTimer(900)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)	
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61920 then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.	
		timerSupercharge:Start()
		warnSupercharge:Show()

	elseif args.spellId == 63479 then				-- Chain light (need the 10ppl spellid)
		warnChainlight:Show()

	elseif args.spellId == 63483 then				-- LightningWhirl
		timerLightningWhirl:Start()

	elseif args.spellId == 61903 or args.spellId == 63493 then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args.spellId == 61888 then				-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		timerOverwhelmingPower:Start(args.destName)
		if self.Options.SetIconOnOverwhelmingPower then
			mod:SetIcon(args.destName, 8, 25) -- skull for 25 seconds (until meltdown)
		end

	elseif args.spellId == 62338 then				-- Runic Barrier
		timerRunicBarrier:Start()
	elseif args.spellId == 62273 then				-- Rune of Summoning
		warnRuneofSummoning:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63490 then					-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeathDura:Start()

	elseif args.spellId == 64321 or args.spellId == 61974 then	-- Rune of Power
		warnRuneofPower:Show()
		timerRuneofPower:Start()

	elseif args.spellId == 61869 or args.spellId == 63481 then	-- Overload
		timerOverload:Start()
		if self.Options.PlaySoundOnOverload and UnitName("target") == L.StormcallerBrundir then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 61903 or args.spellId == 63493 then
		timerFusionPunchActive:Start(args.destName)

	elseif args.spellId == 62269 or args.spellId == 63490 then	-- Rune of Death - move away from it
		if args.destName == UnitName("player") then
			specwarnRuneofDeath:Show()
			if self.Options.PlaySoundDeathRune then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	elseif args.spellId == 63486 then	-- lightning
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		if self.Options.PlaySoundLightningTendrils then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end


