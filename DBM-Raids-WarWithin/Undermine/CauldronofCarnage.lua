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

--TODO, if we ever revisit this, add boss headers and missing stuff when added (like PAs)
--Custom Sounds on cast/cooldown expiring
mod:AddCustomAlertSoundOption(465833, true, 2)
--Custom timer colors, countdowns, and disables
mod:AddCustomTimerOptions(463900, true, 3, 0)
mod:AddCustomTimerOptions(466178, true, 5, 0)
mod:AddCustomTimerOptions(1213994, true, 3, 0)
mod:AddCustomTimerOptions(472231, true, 3, 0)
mod:AddCustomTimerOptions(1214083, true, 3, 0)
mod:AddCustomTimerOptions(1214190, true, 5, 0)
mod:AddCustomTimerOptions(465833, true, 6, 0)
--Midnight private aura replacements
--mod:AddPrivateAuraSoundOption(1226311, true, 1226315, 3)

function mod:OnLimitedCombatStart()
	self:EnableAlertOptions(465833, 338, "phasechange", 2)
	self:EnableTimelineOptions(463900, 331)
	self:EnableTimelineOptions(466178, 332)
	self:EnableTimelineOptions(1213994, 333)
	self:EnableTimelineOptions(472231, 335)
	self:EnableTimelineOptions(1214083, 336)
	self:EnableTimelineOptions(1214190, 337)
	self:EnableTimelineOptions(465833, 338)
end
