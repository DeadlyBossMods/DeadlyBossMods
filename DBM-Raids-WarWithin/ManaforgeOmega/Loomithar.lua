local mod	= DBM:NewMod(2686, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233815)
mod:SetEncounterID(3131)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20250817000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--Custom Sounds on cast/cooldown expiring
mod:AddCustomAlertSoundOption(1226395, true, 3)--Overinfusion Burst
mod:AddCustomAlertSoundOption(1227226, true, 1)--Writhing Wave
mod:AddCustomAlertSoundOption(1237212, "Tank", 1)--Piercing Strand
mod:AddCustomAlertSoundOption(1237272, "-Tank", 1)--Lair Weaving
mod:AddCustomAlertSoundOption(1247672, true, 1)--Infusion Pylon
mod:AddCustomAlertSoundOption(1227782, true, 2)--Arcane Outrage
--Custom timer colors, countdowns, and disables
mod:AddCustomTimerOptions(1226395, true, 2, 0)--Overinfusion Burst
mod:AddCustomTimerOptions(1226315, true, 1, 0)--Infusion Tether
mod:AddCustomTimerOptions(1226867, true, 5, 0)--Primal Spellstorm
mod:AddCustomTimerOptions(1227226, true, 5, 0)--Writhing Wave
mod:AddCustomTimerOptions(1237212, true, 5, 0)--Piercing Strand
mod:AddCustomTimerOptions(1237272, true, 1, 0)--Lair Weaving
mod:AddCustomTimerOptions(1247672, true, 5, 0)--Infusion Pylon
mod:AddCustomTimerOptions(1227782, true, 2, 0)--Arcane Outrage
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1226311, true, 1226315, 3, 1)--Infusion Tether
mod:AddPrivateAuraSoundOption(1243771, true, 1243771, 1, 2)--GTFO

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1226395, 264, "justrun", 2)
	self:EnableAlertOptions(1227226, 267, "helpsoak", 2)
	self:EnableAlertOptions(1237212, 268, "defensive", 2)
	self:EnableAlertOptions(1237272, {269, 602}, "specialsoon", 2)
	self:EnableAlertOptions(1247672, 270, "soakbeam", 17)
	self:EnableAlertOptions(1227782, 271, "pushbackincoming", 13)
	self:EnableTimelineOptions(1226395, 264)
	self:EnableTimelineOptions(1226315, 265)
	self:EnableTimelineOptions(1226867, 266)--Likely won't work due to event being tied to hidden script
	self:EnableTimelineOptions(1227226, 267)
	self:EnableTimelineOptions(1237212, 268)
	self:EnableTimelineOptions(1237272, 269, 602)
	self:EnableTimelineOptions(1247672, 270)
	self:EnableTimelineOptions(1227782, 271)
	self:EnablePrivateAuraSound(1226311, "lineyou", 17)
	self:EnablePrivateAuraSound(1243771, "watchfeet", 8)
end
