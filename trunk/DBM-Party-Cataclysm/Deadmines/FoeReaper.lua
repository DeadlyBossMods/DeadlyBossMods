local mod	= DBM:NewMod("FoeReaper", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43778)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(59304) and mod:IsInCombat() then
		warnSpiritStrike:Show()
	end
end