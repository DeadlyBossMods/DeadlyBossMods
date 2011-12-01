local mod	= DBM:NewMod("ForgemasterThrongus", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40177)
mod:SetModelID(33429)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnPickWeapon		= mod:NewSpellAnnounce(75000, 3)
local warnDualBlades		= mod:NewSpellAnnounce(74981, 3)
local warnEncumbered		= mod:NewSpellAnnounce(75007, 3)
local warnPhalanx			= mod:NewSpellAnnounce(74908, 3)
local warnImpalingSlam		= mod:NewTargetAnnounce(75056, 3)
local warnDisorientingRoar	= mod:NewSpellAnnounce(90737, 3)

local specWarnCaveIn		= mod:NewSpecialWarningMove(74987)

local timerDualBlades		= mod:NewBuffActiveTimer(30, 74981)
local timerEncumbered		= mod:NewBuffActiveTimer(30, 75007)
local timerPhalanx			= mod:NewBuffActiveTimer(30, 74908)
local timerImpalingSlam		= mod:NewTargetTimer(5, 75056)

local spamRoar = 0

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74981) then
		warnDualBlades:Show()
		timerDualBlades:Start()
	elseif args:IsSpellID(75007, 90729) then
		warnEncumbered:Show()
		timerEncumbered:Start()
	elseif args:IsSpellID(74908, 76481) then
		warnPhalanx:Show()
		timerPhalanx:Start()
	elseif args:IsSpellID(75056, 90756) then
		warnImpalingSlam:Show(args.destName)
		timerImpalingSlam:Start(args.destName)
	elseif args:IsSpellID(90737) and GetTime() - spamRoar >= 10 then
		warnDisorientingRoar:Show()
		spamRoar = GetTime()
	elseif args:IsSpellID(74987) and args:IsPlayer() then
		specWarnCaveIn:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75000) then
		warnPickWeapon:Show()
	end
end