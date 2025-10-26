local mod	= DBM:NewMod(2795, "DBM-Raids-Midnight", 2, 1314)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID()
mod:SetEncounterID(3306)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2939)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
