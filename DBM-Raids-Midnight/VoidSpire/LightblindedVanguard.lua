local mod	= DBM:NewMod(2737, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(250589)--War Chaplain Senn main boss, 250588 Commander Venel Lightblood, 250587 general Amias Bellamy
mod:SetEncounterID(3180)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
