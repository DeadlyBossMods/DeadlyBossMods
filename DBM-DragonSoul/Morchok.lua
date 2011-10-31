if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(311, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55265)
mod:SetModelID(39094)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnCrushArmor	= mod:NewStackAnnounce(103687, 3, nil, mod:IsTank() or mod:IsHealer())
local warnCrystal		= mod:NewSpellAnnounce(103640, 3)
local warnStomp			= mod:NewSpellAnnounce(108571, 3)
local warnVortex		= mod:NewSpellAnnounce(110047, 4)
local warnFurious		= mod:NewSpellAnnounce(103846, 3)

local specwarnCrushArmor	= mod:NewSpecialWarningStack(103687, mod:IsTank(), 3)
local specwarnVortexAfter	= mod:NewSpecialWarning("SpecwarnVortexAfter")	-- show a specwarning when Vortex ends
local specwarnBlood			= mod:NewSpecialWarningMove(108570)

local timerCrushArmor	= mod:NewTargetTimer(20, 103687, nil, mod:IsTank())
local timerCrystal		= mod:NewCDTimer(12, 103640)	-- 12-14sec variation (is also time till 'detonate')
local timerStomp 		= mod:NewCDTimer(12, 108571)	-- 12-14sec variation
local timerVortex		= mod:NewBuffActiveTimer(5, 110047)
local timerVortexNext	= mod:NewNextTimer(97, 110047)
local timerBlood		= mod:NewBuffActiveTimer(19, 103851)

local spamCrystal = 0		-- might be just on PTR, but 2 events are shown for 1 crystal
local spamBlood = 0

function mod:OnCombatStart(delay)
	spamCrystal = 0
	spamBlood = 0
	timerCrystal:Start(-delay)
	timerStomp:Start(6-delay)	-- first after 6-8secs
	timerVortex:Start(50-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(103687) then
		warnCrushArmor:Show(args.destName, args.amount or 1)
		timerCrushArmor:Start(args.destName)
		if (args.amount or 1) > 3 then
			specwarnCrushArmor:Show(args.amount or 1)
		end
	elseif args:IsSpellID(103851) then
		timerBlood:Start()
	elseif args:IsSpellID(103846) then
		warnFurious:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103414, 108571, 109033, 109034) then
		warnStomp:Show()
		timerStomp:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103640) and GetTime() - spamCrystal > 3 then
		warnCrystal:Show()
		timerCrystal:Start()
		spamCrystal = GetTime()
	elseif args:IsSpellID(103821, 110045, 110046, 110047) then
		warnVortex:Show()
		timerVortex:Start()
		timerVortexNext:Start()
		specwarnAfterVortex:Schedule(5)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(108570, 103179, 103785) and GetTime - spamBlood > 3 then
		specwarnBlood:Show()
		spamBlood = GetTime()
	end
end