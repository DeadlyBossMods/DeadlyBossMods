local mod	= DBM:NewMod(2827, "DBM-Midnight", nil, 1312)
--local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(244762)
mod:SetEncounterID(3454)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

--No events exist yet
