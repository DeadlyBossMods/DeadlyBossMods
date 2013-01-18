local Kotmogu	= DBM:NewMod("Kotmogu", "DBM-PvP", 2)
local L			= Kotmogu:GetLocalizedStrings()

Kotmogu:SetZone(DBM_DISABLE_ZONE_DETECTION)

Kotmogu:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_WORLD_STATES"
)

local bgzone = false

Kotmogu:RemoveOption("HealthFrame")
Kotmogu:RemoveOption("SpeedKillTimer")
