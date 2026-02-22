local mod	= DBM:NewMod(2687, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233817)
mod:SetEncounterID(3132)
mod:SetHotfixNoticeRev(20250821000000)
mod:SetMinSyncRevision(20250821000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--Custom Sounds on cast/cooldown expiring
mod:AddCustomAlertSoundOption(1231015, true, 1)
mod:AddCustomAlertSoundOption(1228215, true, 1)
mod:AddCustomAlertSoundOption(1228161, false, 1)--In case you have problematic melee that can't watch debuffs
mod:AddCustomAlertSoundOption(1227631, true, 2)
mod:AddCustomAlertSoundOption(1231720, true, 1)
mod:AddCustomAlertSoundOption(1232221, true, 2)
mod:AddCustomAlertSoundOption(1232590, true, 1)
--Custom timer colors, countdowns, and disables
mod:AddCustomTimerOptions(1228502, true, 5, 0)--Overwhelming Power
mod:AddCustomTimerOptions(1231015, true, 1, 0)--Astral Harvest
mod:AddCustomTimerOptions(1228161, true, 3, 0)--Silencing Tempest
mod:AddCustomTimerOptions(1227631, true, 2, 0)--Arcane Expulsion
mod:AddCustomTimerOptions(1231720, true, 1, 0)--Invoke Collector
mod:AddCustomTimerOptions(1243874, true, 1, 0)--Void Harvest
mod:AddCustomTimerOptions(1238873, true, 3, 0)--Echoing Tempest
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1228188, true, 1228161, 1, 1)--Silencing Tempest
mod:AddPrivateAuraSoundOption(1233979, true, 1231015, 3, 1)--Astral Harvest
mod:AddPrivateAuraSoundOption(1243873, true, 1243874, 3, 1)--Void Harvest
mod:AddPrivateAuraSoundOption(1228215, true, 1228502, 1, 1)--Overwhelming Power
mod:AddPrivateAuraSoundOption(1238874, true, 1238873, 1, 1)--Echoing Tempest

local berserkTimer = mod:NewBerserkTimer(600)

function mod:OnLimitedCombatStart()
	self:EnableAlertOptions(1231015, 323, "mobsoon", 2)
	self:EnableAlertOptions(1228161, 325, "watchfeet", 2)
	if not self:IsTank() then
		self:EnableAlertOptions(1228215, 324, "helpsoak", 2)
	end
	self:EnableAlertOptions(1227631, 326, "carefly", 2)
	self:EnableAlertOptions(1231720, {327, 328}, "bigmob", 2)
	self:EnableAlertOptions(1232221, 330, "carefly", 2)
	self:EnableAlertOptions(1232590, 340, "aesoon", 2, 0)--This event has no timer so we cannot use timer finished for sound
	self:EnableTimelineOptions(1228502, 322)
	self:EnableTimelineOptions(1231015, 323)
	self:EnableTimelineOptions(1228161, 325)
	self:EnableTimelineOptions(1227631, 326)
	self:EnableTimelineOptions(1231720, 327, 328)
	self:EnableTimelineOptions(1243874, 329)
	self:EnableTimelineOptions(1238873, 466)
	self:EnablePrivateAuraSound(1228188, "runout", 2)
	self:EnablePrivateAuraSound(1233979, "orbrun", 2)
	self:EnablePrivateAuraSound(1243873, "orbrun", 2)
	self:EnablePrivateAuraSound(1228215, "gathershare", 2)
	self:EnablePrivateAuraSound(1238874, "runout", 2)
	berserkTimer:Start(600)
end
