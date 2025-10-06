local mod	= DBM:NewMod(2736, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID()--Yes, they're all used
mod:SetEncounterID(3179)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
