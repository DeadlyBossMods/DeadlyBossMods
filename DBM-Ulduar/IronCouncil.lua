local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32927)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat", 32867, 32927, 32857)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
	    		 or select(2, UnitClass("player")) == "PRIEST"
	    		 or select(2, UnitClass("player")) == "SHAMAN"

local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)

-- Stormcaller Brundir
-- High Voltage ... 63498
local warnChainlight			= mod:NewSpellAnnounce(64215, 1)
local timerOverload				= mod:NewCastTimer(6, 63481)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486)
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486)
local specwarnOverload			= mod:NewSpecialWarningRun(63481) 
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce")
mod:AddBoolOption("PlaySoundOnOverload", true)
mod:AddBoolOption("PlaySoundLightningTendrils", true)

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888)
local warnStaticDisruption		= mod:NewTargetAnnounce(61912, 3) 
mod:AddBoolOption("SetIconOnOverwhelmingPower")
mod:AddBoolOption("SetIconOnStaticDisruption")

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
local timerRuneofShields		= mod:NewBuffActiveTimer(15, 63967)
local warnRuneofPower			= mod:NewTargetAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)
local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490)
local specWarnRuneofShields		= mod:NewSpecialWarningDispel(63967, isDispeller)
local timerRuneofDeath			= mod:NewCDTimer(30, 63490)
local timerRuneofPower			= mod:NewCDTimer(30, 61974)
mod:AddBoolOption("PlaySoundDeathRune", true, "announce")

local enrageTimer				= mod:NewBerserkTimer(900)

local disruptTargets = {}
local disruptIcon = 7

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	table.wipe(disruptTargets)
	disruptIcon = 7
end

function mod:RuneTarget()
	local targetname = self:GetBossTarget(32927)
	if not targetname then return end
		warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets()
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	disruptIcon = 7
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
	elseif args:IsSpellID(62274, 63489) then		-- Shield of Runes
		warnShieldofRunes:Show()
	elseif args:IsSpellID(62273) then				-- Rune of Summoning
		warnRuneofSummoning:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeath:Start()
	elseif args:IsSpellID(64321, 61974) then	-- Rune of Power
		self:ScheduleMethod(0.1, "RuneTarget")
		timerRuneofPower:Start()
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()
		if self.Options.AlwaysWarnOnOverload or UnitName("target") == L.StormcallerBrundir then
			specwarnOverload:Show()
			if self.Options.PlaySoundOnOverload then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end
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
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		specWarnRuneofShields:Show(args.destName)
		timerRuneofShields:Start()
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if mod:IsDifficulty("normal10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(35, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			if mod:IsDifficulty("normal10") then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else
				self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			end
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		if self.Options.PlaySoundLightningTendrils then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption then 
			self:SetIcon(args.destName, disruptIcon, 20)
			disruptIcon = disruptIcon - 1
		end
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32867 then		--Steelbreaker
		timerFusionPunchCast:Cancel()
	elseif cid == 32927 then	--Runemaster
		timerRuneofDeath:Cancel()
		timerRuneofPower:Cancel()
	elseif cid == 32857 then	--Stormcaller
		timerOverload:Cancel()
		timerLightningWhirl:Cancel()
	end
end