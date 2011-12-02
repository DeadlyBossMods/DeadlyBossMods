local mod	= DBM:NewMod("Mannoroth", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54969)
mod:SetModelID(38996)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local specWarnFelStorm		= mod:NewSpecialWarningRun(103888)

local timerFelStorm			= mod:NewBuffActiveTimer(15, 103888)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103888) then
		specWarnFelStorm:Show()
		timerFelStorm:Show()
	end
end