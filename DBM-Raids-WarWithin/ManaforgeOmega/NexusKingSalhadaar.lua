local mod	= DBM:NewMod(2690, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237763)
mod:SetEncounterID(3134)
mod:SetBossHPInfoToHighest()--Boss Heals
mod:SetHotfixNoticeRev(20250820000000)
mod:SetMinSyncRevision(20250731000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--NOTES, 1224731/439 is oathbound, but it has no purpose being it's cast instantly on pull
--Tyranny/440 is equally useless
--Events 449 and 450 are linked to non existent spellIds 1234536 and 1230659
--Sounds
mod:AddCustomAlertSoundOption(1227470, true, 2)
mod:AddCustomAlertSoundOption(1224906, true, 2)
mod:AddCustomAlertSoundOption(1238975, true, 1)
mod:AddCustomAlertSoundOption(1227891, true, 3)--Coalesce Voidwing
mod:AddCustomAlertSoundOption(1228065, true, 1)--Rally the Shadowguard
mod:AddCustomAlertSoundOption(1228293, true, 1)--King's Hunger
--Timers
mod:AddCustomTimerOptions(1224776, true, 5, 0)--Subjugation Rule
mod:AddCustomTimerOptions(1224827, true, 3, 0)--Behead
mod:AddCustomTimerOptions(1227470, true, 3, 0)--Besiege
mod:AddCustomTimerOptions(1224906, true, 2, 0)--Invoke the Oath
mod:AddCustomTimerOptions(1227529, true, 3, 0)--Banishment
mod:AddCustomTimerOptions(1238975, true, 5, 0)--Vengeful Oath
mod:AddCustomTimerOptions(1228115, true, 3, 0)--Netherbreaker
mod:AddCustomTimerOptions(1228065, true, 1, 0)--Rally the Shadowguard
mod:AddCustomTimerOptions(1228293, true, 6, 0)--King's Hunger
mod:AddCustomTimerOptions(1226648, true, 3, 0)--Galactic Smash
mod:AddCustomTimerOptions(1226442, true, 3, 0)--Starkiller Swing
mod:AddCustomTimerOptions(1225634, true, 6, 0)--World in Twilight
--Pre midnight private auras
mod:AddPrivateAuraSoundOption(1224855, true, 1224827, 1, 1)--Behead
mod:AddPrivateAuraSoundOption(1237108, true, 1237106, 1, 1)--Twilight Massacre
mod:AddPrivateAuraSoundOption(1228114, true, 1228115, 1, 1)--Netherbreaker
mod:AddPrivateAuraSoundOption(1225316, true, 1226648, 1, 1)--Galactic Smash
mod:AddPrivateAuraSoundOption(1226018, true, 1226442, 1, 1)--Starkiller Swing
--Post midnight private auras
mod:AddPrivateAuraSoundOption(1227549, true, 1227529, 1, 1)--Banishment
mod:AddPrivateAuraSoundOption(1231097, true, 1231097, 1, 2)--GTFO

function mod:OnLimitedCombatStart(delay)
	self:DisableSpecialWarningSounds()
	self:EnableAlertOptions(1227470, 443, "breathsoon", 2)
	self:EnableAlertOptions(1224906, 444, "findmc", 2)
	self:EnableAlertOptions(1238975, 446, "ghostsoon", 2)
	self:EnableAlertOptions(1227891, 447, "carefly", 2)
	self:EnableAlertOptions(1228065, 451, "killmob", 2)
	self:EnableAlertOptions(1228293, 453, "targetchange", 2)

	self:EnableTimelineOptions(1224776, 441)
	self:EnableTimelineOptions(1224827, 442)
	self:EnableTimelineOptions(1227470, 443)
	self:EnableTimelineOptions(1224906, 444)
	self:EnableTimelineOptions(1227529, 445)
	self:EnableTimelineOptions(1238975, 446)
	self:EnableTimelineOptions(1228115, 448)
	self:EnableTimelineOptions(1228065, 451)
	self:EnableTimelineOptions(1228293, 453)--Iffy, not sure if blizzard even had a duration bar
	self:EnableTimelineOptions(1226648, 454)
	self:EnableTimelineOptions(1226442, 455)
	self:EnableTimelineOptions(1225634, 456)

	self:EnablePrivateAuraSound({1224855,1224857,1224858,1224859,1224864,1225060,1224860,1225055,1225056,1225057,1225059,1224828,1225058}, "lineyou", 17)--Behead
	self:EnablePrivateAuraSound(1237108, "behindmob", 2)--Twilight Massacre
	self:EnablePrivateAuraSound(1228114, "lineyou", 17)--Netherbreaker
	self:EnablePrivateAuraSound({1225316,1248128,1226601,1226602}, "runout", 2)--Galactic Smash
	self:EnablePrivateAuraSound(1226018, "runout", 2)--Starkiller Swing
	self:EnablePrivateAuraSound(1227549, "scatter", 2)--Banishment
	self:EnablePrivateAuraSound(1231097, "watchfeet", 8)--GTFO
end
