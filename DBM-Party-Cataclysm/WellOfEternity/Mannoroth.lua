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
local timerFelStormCD			= mod:NewCDTimer(29, 103888)
local timerTyrandeHelp			= mod:NewTimer(82, "TimerTyrandeHelp", 102472)

local felstorms = 0
function mod:OnCombatStart(delay)
	timerFelStormCD:Start(15-delay)
	timerTyrandeHelp:Start(-delay)
	felstorms = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105041) then
		timerFelStormCD:Start()		-- ~30sec after Nether Tear ?
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103888) then
		felstorms = felstorms + 1
		if felstorms < 2 then
			specWarnFelStorm:Show()
			timerFelStorm:Start()
			timerFelStormCD:Start()
		end
	end
end

