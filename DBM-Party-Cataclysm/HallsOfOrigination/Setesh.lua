local mod	= DBM:NewMod("Setesh", "DBM-Party-Cataclysm", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39732)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

-- nothing added yet, he only casts Chaos Bolt in combatlog
-- he spawns adds, they might do something .. will check their names next time :)