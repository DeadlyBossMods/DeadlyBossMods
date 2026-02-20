local mod	= DBM:NewMod(2829, "DBM-Midnight", nil, 1312)
--local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(249776)
mod:SetEncounterID(3459)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

--NOTE: this is only world boss of the 4 blizzard actually added boss mod support for
--Sounds
mod:AddCustomAlertSoundOption(1257320, true, 2)--Radiant Mote
mod:AddCustomAlertSoundOption(1257825, true, 2)--Scintillating Shard
mod:AddCustomAlertSoundOption(1258136, true, 1)--Rending Claw
mod:AddCustomAlertSoundOption(1258639, true, 2)--Shredding Tendrils
--Timers
mod:AddCustomTimerOptions(1257320, nil, 3, 0)
mod:AddCustomTimerOptions(1257825, nil, 5, 0)
mod:AddCustomTimerOptions(1258136, nil, 3, 0)
mod:AddCustomTimerOptions(1258639, nil, 2, 0)

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1257320, 113, "scattersoon", 2)
	self:EnableAlertOptions(1257825, 114, "catchballs", 12)
	if self:IsTank() then
		--Unfortunately this will just warn every tank fighting boss,not just onea actually tanking it
		self:EnableAlertOptions(1258136, 115, "defensive", 2)
	end
	self:EnableAlertOptions(1258639, 116, "lineapart", 2)

	self:EnableTimelineOptions(1257320, 113)
	self:EnableTimelineOptions(1257825, 114)
	self:EnableTimelineOptions(1258136, 115)
	self:EnableTimelineOptions(1258639, 116)
end
