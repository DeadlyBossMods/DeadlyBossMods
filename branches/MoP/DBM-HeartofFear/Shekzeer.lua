local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62837)
mod:SetModelID(42730)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnEyes					= mod:NewStackAnnounce(123707, 4, nil, mod:IsTank())

local specWarnEyes				= mod:NewSpecialWarningStack(123707, mod:IsTank(), 4)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123707) then
		warnEyes:Show(args.destName, args.amount or 1)
--		timerEyes:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnEyes:Show(args.amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED