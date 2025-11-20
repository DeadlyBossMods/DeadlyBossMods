local mod	= DBM:NewMod(2735, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(250892)--Vaelgor main boss, 254109 for Ezzorak
mod:SetEncounterID(3178)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
