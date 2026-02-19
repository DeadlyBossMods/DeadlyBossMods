local mod	= DBM:NewMod(2685, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233816)
mod:SetEncounterID(3130)
mod:SetUsedIcons(4, 6)
mod:SetHotfixNoticeRev(20250813000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--NOTE: DO NOT ADD Soul Calling sound under any circomstances, unless you don't like players having eardrums
--Sound alerts
mod:AddCustomAlertSoundOption(1223859, true, 2)
--Timers
mod:AddCustomTimerOptions(1223859, true, 2, 0)--Arcane Expulsion
mod:AddCustomTimerOptions(1227276, true, 3, 0)--Soulfray Annihilation
mod:AddCustomTimerOptions(1237607, true, 5, 0)--Mythic Lash
mod:AddCustomTimerOptions(1225626, true, 3, 0)--Soulfire Convergence
mod:AddCustomTimerOptions(1225582, true, 1, 0)--Soul Calling
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1237607, true, 1237607, 1, 1)--Mythic Lash
mod:AddPrivateAuraSoundOption(1227276, true, 1227276, 1, 1)
mod:AddPrivateAuraSoundOption(1225626, true, 1225626, 1, 1)
mod:AddPrivateAuraSoundOption(1242086, true, 1242086, 1, 2)--GTFO

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1223859, {345, 346}, "carefly", 2)

	self:EnableTimelineOptions(1223859, 345, 346)
	self:EnableTimelineOptions(1227276, 347)
	self:EnableTimelineOptions(1237607, 348)
	self:EnableTimelineOptions(1225626, 349)
	self:EnableTimelineOptions(1225582, 350)

	self:EnablePrivateAuraSound({1237607,1248464}, "defensive", 2)
	self:EnablePrivateAuraSound(1227276, "lineyou", 17)
	self:EnablePrivateAuraSound(1225626, "orbrun", 17)
	self:EnablePrivateAuraSound(1242086, "watchfeet", 8)
end
