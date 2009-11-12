local mod	= DBM:NewMod("Rokmar", "DBM-Party-BC", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17991)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local WarnFrenzy  = mod:NewSpellAnnounce(34970)
local WarnWound   = mod:NewTargetAnnounce(38801)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(31956, 38801) then
		WarnWound:Show(args.destName)
	elseif args:IsSpellID(34970) then
		WarnFrenzy:Show(args.destName)
	end
end