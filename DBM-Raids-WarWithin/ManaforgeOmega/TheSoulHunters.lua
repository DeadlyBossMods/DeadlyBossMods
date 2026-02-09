local mod	= DBM:NewMod(2688, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237660, 237661, 237662)
mod:SetEncounterID(3122)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20250818000000)
mod:SetMinSyncRevision(20250818000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--Sound alerts
mod:AddCustomAlertSoundOption(1241306, true, 2)--Blade Dance
mod:AddCustomAlertSoundOption(1227809, false, 2)--The Hunt
mod:AddCustomAlertSoundOption(1242259, true, 2)--Spirit Bombs
mod:AddCustomAlertSoundOption(1240891, true, 2)--Fracture
mod:AddCustomAlertSoundOption(1227355, true, 2)--Void Step
mod:AddCustomAlertSoundOption(1245743, true, 2)--Eradicate
mod:AddCustomAlertSoundOption(1228381, true, 1)--Phase Change
--Timers
mod:AddCustomTimerOptions(1218103, true, 5, 0)--Eye Beam
mod:AddCustomTimerOptions(1227809, true, 3, 0)--The Hunt
mod:AddCustomTimerOptions(1241833, true, 5, 0)--Fracture
mod:AddCustomTimerOptions(1242259, true, 2, 0)--Spirit Bombs
mod:AddCustomTimerOptions(1240891, true, 2, 0)--Sigil of Chains
mod:AddCustomTimerOptions(1227355, true, 3, 0)--Void Step
mod:AddCustomTimerOptions(1245743, true, 3, 0)--Eradicate
mod:AddCustomTimerOptions(1228381, true, 6, 0)--Phase Change
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1227847, true, 1227809, 1)--The Hunt
mod:AddPrivateAuraSoundOption(1222232, true, 1222232, 1)--Devourer's Ire
mod:AddPrivateAuraSoundOption(1221490, true, 1218103, 1)--Fel Singed. Eyebeam Debuff
mod:AddPrivateAuraSoundOption(1235045, false, 1235045, 1)--GTFO for void step (LEAVE OFF BY DEFAULT)
mod:AddPrivateAuraSoundOption(1248464, false, 1241833, 1)--Fracture Debuff

function mod:OnLimitedCombatStart()
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1241306, 314, "farfromline", 2)
	self:EnableAlertOptions(1227809, 315, "groupsoak", 2)
	self:EnableAlertOptions(1242259, 317, "aesoon", 2)
	self:EnableAlertOptions(1240891, 318, "pullin", 2)
	self:EnableAlertOptions(1227355, 319, "watchstep", 2)
	self:EnableAlertOptions(1245743, 320, "frontal", 15)
	self:EnableAlertOptions(1228381, 321, "phasechange", 2)

	self:EnableTimelineOptions(1218103, 222)
	self:EnableTimelineOptions(1227809, 314)
	self:EnableTimelineOptions(1241306, 315)
	self:EnableTimelineOptions(1241833, 316)
	self:EnableTimelineOptions(1242259, 317)
	self:EnableTimelineOptions(1240891, 318)
	self:EnableTimelineOptions(1227355, 319)
	self:EnableTimelineOptions(1245743, 320)
	self:EnableTimelineOptions(1228381, 321)

	self:EnablePrivateAuraSound(1227847, "lineyou", 17)
	self:EnablePrivateAuraSound(1222232, "debuffyou", 17)
	self:EnablePrivateAuraSound(1235045, "watchfeet", 8)
	if self:IsTank() then
		self:EnablePrivateAuraSound(1221490, "defensive", 2)
	end
	self:EnablePrivateAuraSound(1248464, "defensive", 2)
end
