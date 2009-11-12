local mod	= DBM:NewMod("Mennu", "DBM-Party-BC", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17941)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON"
)

local WarnCorruptedNova   = mod:NewSpellAnnounce(31991)

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(31991) then
		WarnCorruptedNova:Show()
	end
end