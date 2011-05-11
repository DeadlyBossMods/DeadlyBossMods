local mod	= DBM:NewMod("Alysrazor", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetModelID(38265) -- Temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

function mod:OnCombatStart(delay)
end