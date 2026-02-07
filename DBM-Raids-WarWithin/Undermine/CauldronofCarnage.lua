local mod	= DBM:NewMod(2640, "DBM-Raids-WarWithin", 2, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(229181, 229177)
mod:SetEncounterID(3010)
mod:SetHotfixNoticeRev(20250131000000)
mod:SetMinSyncRevision(20250131000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--[[
(ability.id = 473650 or ability.id = 472233 or ability.id = 1214190 or ability.id = 473994 or ability.id = 466178) and type = "begincast"
 or ability.id = 463900 and type = "cast"
 or (ability.id = 473201 or ability.id = 473202 or ability.id = 465863 or ability.id = 465872) and type = "cast"
 or (ability.id = 465863 or ability.id = 465872) and type = "removebuff"
--]]
