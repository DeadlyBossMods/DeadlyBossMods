local mod = DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32927)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

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

local warnSupercharge			= mod:NewAnnounce("WarningSupercharge", 3, 61920)

-- Stormcaller Brundir
-- High Voltage ... 63498
local warnChainlight			= mod:NewAnnounce("WarningChainlight", 1, 64215)
local timerOverload				= mod:NewCastTimer(6, 63481)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarning("LightningTendrils")  -- 63486
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486)
local specwarnOverload			= mod:NewSpecialWarning("Overload") 
mod:AddBoolOption("AllwaysWarnOnOverload", false, "announce")
mod:AddBoolOption("PlaySoundOnOverload", true, "announce")
mod:AddBoolOption("PlaySoundLightningTendrils", true, "announce")

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch			= mod:NewAnnounce("WarningFusionPunch", 4, 61903)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local warnOverwhelmingPower		= mod:NewAnnounce("WarningOverwhelmingPower", 2, 61888)
local timerOverwhelmingPower	= mod:NewNextTimer(25, 61888)
local warnStaticDisruption		= mod:NewAnnounce("WarningStaticDisruption", 3, 61912) 
mod:AddBoolOption("SetIconOnOverwhelmingPower")
mod:AddBoolOption("SetIconOnStaticDisruption")

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
local timerRunicBarrier			= mod:NewBuffActiveTimer(20, 62338)
local warnRuneofPower			= mod:NewAnnounce("WarningRuneofPower", 1, 64320)
local warnRuneofDeath			= mod:NewAnnounce("WarningRuneofDeath", 2, 63490)
local warnRuneofSummoning		= mod:NewAnnounce("WarningRuneofSummoning", 3, 62273)
local specwarnRuneofDeath		= mod:NewSpecialWarning("RuneofDeath")
local timerRuneofDeathDura		= mod:NewNextTimer(30, 63490)
local timerRuneofPower			= mod:NewCDTimer(30, 61974)
local timerRuneofDeath			= mod:NewCDTimer(30, 63490)
mod:AddBoolOption("PlaySoundDeathRune", true, "announce")

local enrageTimer				= mod:NewEnrageTimer(900)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)	
end
function mod:OnCombatEnd()
--	if DBM.RangeCheck:IsShown() then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(61920) then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.	
		warnSupercharge:Show()

	elseif args:IsSpellID(63479, 61879) then	-- Chain light
		warnChainlight:Show()

	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Start()

	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if mod:IsDifficulty("heroic10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(30, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			if mod:IsDifficulty("heroic10") then
				mod:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else
				mod:SetIcon(args.destName, 8, 30) -- skull for 30 seconds (until meltdown)
			end
		end
--		if args:IsPlayer() then
--			if self.Options.RangeFrame then
--				DBM.RangeCheck:Show(30)
--			end
--		end

	elseif args:IsSpellID(62338) then				-- Runic Barrier
		timerRunicBarrier:Start()
	elseif args:IsSpellID(62273) then				-- Rune of Summoning
		warnRuneofSummoning:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeathDura:Start()

	elseif args:IsSpellID(64321, 61974) then	-- Rune of Power
		warnRuneofPower:Show()
		timerRuneofPower:Start()

	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()

		if self.Options.AllwaysWarnOnOverload or UnitName("target") == L.StormcallerBrundir then
			specwarnOverload:Show()
			if self.Options.PlaySoundOnOverload then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end
end


local disruptTargets = {}
function mod:DisruptAnnounce()
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
end
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)

	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			if self.Options.PlaySoundDeathRune then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		if self.Options.PlaySoundLightningTendrils then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end

	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		if self.Options.SetIconOnStaticDisruption then 
			self:SetIcon(args.destName, 8 - #disruptTargets, 20)
		end
		table.insert(disruptTargets, args.destName)
		self:UnscheduleMethod("DisruptAnnounce")
		self:ScheduleMethod(0.15, "DisruptAnnounce")
	end
end



