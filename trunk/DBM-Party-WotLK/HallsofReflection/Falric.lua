local mod = DBM:NewMod("Falric", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(38112)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnImpendingDespair		= mod:NewTargetAnnounce(72426, 3)
local warnQuiveringStrike		= mod:NewTargetAnnounce(72453, 3)

local timerImpendingDespair		= mod:NewTargetTimer(6, 72426)
local timerQuiveringStrike		= mod:NewTargetTimer(5, 72453)


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72422, 72453) then
		timerQuiveringStrike:Show(args.destName)
		warnQuiveringStrike:Show(args.destName)
	elseif args:IsSpellID(72426) then
		timerImpendingDespair:Show(args.destName)
		warnImpendingDespair:Show(args.destName)
	end
end