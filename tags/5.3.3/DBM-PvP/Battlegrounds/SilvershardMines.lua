local Silvershard	= DBM:NewMod("z727", "DBM-PvP", 2)
local L			= Silvershard:GetLocalizedStrings()

Silvershard:SetZone(DBM_DISABLE_ZONE_DETECTION)

Silvershard:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

local cartTimer		= Silvershard:NewTimer(9.5, "TimerCart", "Interface\\Icons\\INV_Misc_PocketWatch_01")

local bgzone = false

Silvershard:RemoveOption("HealthFrame")
Silvershard:RemoveOption("SpeedKillTimer")

function Silvershard:OnInitialize()
	if DBM:GetCurrentArea() == 860 then
		bgzone = true
		Silvershard:RegisterShortTermEvents(
			"CHAT_MSG_MONSTER_YELL",
			"CHAT_MSG_BG_SYSTEM_HORDE",
			"CHAT_MSG_BG_SYSTEM_ALLIANCE",
			"CHAT_MSG_BG_SYSTEM_NEUTRAL",
			"CHAT_MSG_RAID_BOSS_EMOTE",
			"UPDATE_WORLD_STATES"
		)
	elseif bgzone then
		bgzone = false
		Silvershard:UnregisterShortTermEvents()
	end
end

function Silvershard:ZONE_CHANGED_NEW_AREA()
	self:ScheduleMethod(1, "OnInitialize")
end

function Silvershard:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if not bgzone then return end
	if msg:find(L.Capture) then	
		cartTimer:Start()
	end
end

Silvershard.CHAT_MSG_BG_SYSTEM_ALLIANCE = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
Silvershard.CHAT_MSG_BG_SYSTEM_HORDE = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
Silvershard.CHAT_MSG_BG_SYSTEM_NEUTRAL = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
