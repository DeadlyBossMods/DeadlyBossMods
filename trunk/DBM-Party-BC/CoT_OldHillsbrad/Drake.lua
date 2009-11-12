local mod	= DBM:NewMod("Drake", "DBM-Party-BC", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17848)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnShot      = mod:NewTargetAnnounce(33792)
local timerShot     = mod:NewTargetTimer(6, 33792)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(33792) then
		warnShot:Show(args.destName)
		timerShot:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(33792) then
		timerShot:Cancel(args.destName)
	end
end