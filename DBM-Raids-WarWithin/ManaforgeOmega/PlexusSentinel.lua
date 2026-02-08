local mod	= DBM:NewMod(2684, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233814)
mod:SetEncounterID(3129)
mod:SetHotfixNoticeRev(20250813000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--Custom Sounds on cast/cooldown expiring
mod:AddCustomAlertSoundOption(1220489, true, 1)--Protocol: Purge
--Custom timer colors, countdowns, and disables
mod:AddCustomTimerOptions(1219263, true, 5, 0)--Obliteration Arcanocannon
mod:AddCustomTimerOptions(1219450, true, 3, 0)--Manifest Matrices
mod:AddCustomTimerOptions(1219532, true, 3, 0)--Eradicating Salvo
mod:AddCustomTimerOptions(1234733, true, 6, 0)--Cleanse the Chamber
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1219439, true, 1219263, 1)--Obliteration Arcanocannon, only person who needs alert so no cast alert
mod:AddPrivateAuraSoundOption(1219459, true, 1219450, 1)--Manifest Matrices
mod:AddPrivateAuraSoundOption(1219607, true, 1219532, 1)--Eradicating Salvo
mod:AddPrivateAuraSoundOption(1219354, true, 1219354, 1)--GTFO

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1220489, {231, 232, 233}, "carefly", 2)--3 spellids for protocol purge
	self:EnableTimelineOptions(1219263, 227)
	self:EnableTimelineOptions(1219450, 228)
	self:EnableTimelineOptions(1219531, 229)
	self:EnableTimelineOptions(1234733, 230)
	self:EnablePrivateAuraSound(1219439, "runout", 2)
	self:EnablePrivateAuraSound(1219459, "runout", 2)
	self:EnablePrivateAuraSound(1219607, "gathershare", 2)
	self:EnablePrivateAuraSound(1219531, "gathershare", 2, 1219607)
	self:EnablePrivateAuraSound(1219354, "watchfeet", 8)
end
