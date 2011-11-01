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
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnCrushArmor	= mod:NewStackAnnounce(103687, 3, nil, mod:IsTank() or mod:IsHealer())
local warnCrystal		= mod:NewSpellAnnounce(103639, 3)
local warnStomp			= mod:NewSpellAnnounce(108571, 3)
local warnVortex		= mod:NewSpellAnnounce(110047, 3)
local warnBlood			= mod:NewSpellAnnounce(103851, 4)
local warnFurious		= mod:NewSpellAnnounce(103846, 3)

local specwarnCrushArmor	= mod:NewSpecialWarningStack(103687, mod:IsTank(), 3)
local specwarnVortexAfter	= mod:NewSpecialWarning("SpecwarnVortexAfter")	-- show a specwarning when Vortex ends
local specwarnBlood			= mod:NewSpecialWarningMove(108570)

local timerCrushArmor	= mod:NewTargetTimer(20, 103687, nil, mod:IsTank())
local timerCrystal		= mod:NewCDTimer(12, 103640)	-- 12-14sec variation (is also time till 'detonate')
local timerStomp 		= mod:NewCDTimer(12, 108571)	-- 12-14sec variation
local timerVortex		= mod:NewBuffActiveTimer(5, 110047)
local timerVortexNext	= mod:NewNextTimer(71, 110047)--97 sec after last vortex, but only 71 after last blood ended. More efficent this way.
local timerBlood		= mod:NewBuffActiveTimer(21, 103851)

local spamBlood = 0
local crystalCount = 0--3 crystals between each vortex

function mod:OnCombatStart(delay)
	spamBlood = 0
	crystalCount = 1--2 before first however so we superficially set it to 1 on pull.
	timerStomp:Start(-delay)
	timerCrystal:Start(19-delay)
	timerVortex:Start(54-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(103687) then
		warnCrushArmor:Show(args.destName, args.amount or 1)
		timerCrushArmor:Start(args.destName)
		if (args.amount or 1) > 3 then
			specwarnCrushArmor:Show(args.amount or 1)
		end
	elseif args:IsSpellID(103846) then
		warnFurious:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(103851) then
		timerStomp:Start(15)
		timerCrystal:Start(21)
		timerVortexNext:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103414, 108571, 109033, 109034) then
		warnStomp:Show()
		if crystalCount < 3 then
			timerStomp:Start()
		end
	elseif args:IsSpellID(103851) then
		warnBlood:Show()
		timerBlood:Start()
		specwarnVortexAfter:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(103639) then
		crystalCount = crystalCount + 1
		warnCrystal:Show()
		if crystalCount < 3 then
			timerCrystal:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103821, 110045, 110046, 110047) then
		crystalCount = 0
		warnVortex:Show()
		timerVortex:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(103785, 108570, 110287, 110288) and GetTime() - spamBlood > 3 then--103785 10 man confirmed.
		specwarnBlood:Show()
		spamBlood = GetTime()
	end
end
