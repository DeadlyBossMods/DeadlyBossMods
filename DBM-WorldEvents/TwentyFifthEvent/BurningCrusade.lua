local mod	= DBM:NewMod("BCEvent", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(17968)
mod:SetEncounterID(2319)
mod:SetModelID(20939)--Archimond
mod:SetZone()
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

--LUL boss, doesn't need anything
