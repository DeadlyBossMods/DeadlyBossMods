local mod	= DBM:NewMod(725, "DBM-Pandaria", nil, 322)	-- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62346)--Salyis not dies. Only Galleon attackable and dies.
mod:SetModelID(42468)	--Galleon=42439
mod:SetZone(807)--Valley of the Four winds

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

