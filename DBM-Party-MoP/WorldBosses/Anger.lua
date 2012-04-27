local mod	= DBM:NewMod(691, "DBM-Party-MoP", 10, 322)	-- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(50063)
--mod:SetModelID(41448)
--mod:SetZone(809)--Kun-Lai Summit (zoneid not yet known)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

