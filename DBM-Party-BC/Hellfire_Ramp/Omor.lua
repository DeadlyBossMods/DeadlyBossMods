local mod	= DBM:NewMod("Omor", "DBM-Party-BC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17308)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBane      = mod:NewTargetAnnounce(37566)
local timerBane     = mod:NewTargetTimer(15, 37566)
local specwarnBane  = mod:NewSpecialWarning("specwarnBane")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37566 then
		warnBane:Show(args.destName)
		timerBane:Start(args.destName)
		if args:IsPlayer() then
            specwarnBane:Show()
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 37566 then
		timerBane:Cancel(args.destName)
	end
end