local mod = DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1665 $"):sub(12, -3))
mod:SetCreatureID()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_PERIODIC_DAMAGE"
)

