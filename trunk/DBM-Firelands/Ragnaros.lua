local mod	= DBM:NewMod("Ragnaros-Cata", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetModelID(31188) -- temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

function mod:OnCombatStart(delay)
end