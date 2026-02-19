local mod	= DBM:NewMod(2747, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237861)
mod:SetEncounterID(3133)
mod:SetHotfixNoticeRev(20250818000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:AddCustomAlertSoundOption(1231871, true, 1)
mod:AddCustomAlertSoundOption(1220394, true, 2)

mod:AddCustomTimerOptions(1233416, true, 3, 0)--Designer used 1279371 but it has no tooltip so not using it for option key
mod:AddCustomTimerOptions(1227373, true, 5, 0)
mod:AddCustomTimerOptions(1231871, true, 5, 0)
mod:AddCustomTimerOptions(1220394, true, 2, 0)

mod:AddPrivateAuraSoundOption(1233411, true, 1233416, 3, 1)--Crystalline Shockwave pre-debuff
mod:AddPrivateAuraSoundOption(1247424, true, 1247424, 1, 1)--Null Consumption
mod:AddPrivateAuraSoundOption(1227373, true, 1227373, 1, 1)--Shattershell

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()--commented because designer didn't actually add any event IDs to 3 of the 4 abilities this boss has
	if self:IsTank() then
		self:EnableAlertOptions(1231871, 387, "defensive", 2)
	end
	self:EnableAlertOptions(1220394, 389, "specialsoon", 2)
	self:EnableTimelineOptions(1233416, 386)
	self:EnableTimelineOptions(1231871, 387)
	self:EnableTimelineOptions(1227373, 388)
	self:EnableTimelineOptions(1220394, 389)

	self:EnablePrivateAuraSound(1233411, "lineyou", 17)
	self:EnablePrivateAuraSound(1247424, "runout", 2)
	self:EnablePrivateAuraSound(1227373, "targetyou", 2)
end
