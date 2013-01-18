local Silvershard	= DBM:NewMod("SilvershardMines", "DBM-PvP", 2)
local L			= Silvershard:GetLocalizedStrings()

Silvershard:SetZone(DBM_DISABLE_ZONE_DETECTION)

Silvershard:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_WORLD_STATES"
)

local cartTimer		= Silvershard:NewTimer(9.5, "TimerCart", "Interface\\Icons\\INV_Misc_PocketWatch_01")

local bgzone = false

Silvershard:RemoveOption("HealthFrame")
Silvershard:RemoveOption("SpeedKillTimer")

function Silvershard:OnInitialize()
	if select(2, IsInInstance()) == "pvp" and GetCurrentMapAreaID() == 860 then
		bgzone = true
	elseif bgzone then
		bgzone = false
	end
end
Silvershard.ZONE_CHANGED_NEW_AREA = Silvershard.OnInitialize


function Silvershard:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if not bgzone then return end
	if msg:find(L.Capture) then	
		cartTimer:Start()
	end
end

Silvershard.CHAT_MSG_BG_SYSTEM_ALLIANCE = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
Silvershard.CHAT_MSG_BG_SYSTEM_HORDE = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
Silvershard.CHAT_MSG_BG_SYSTEM_NEUTRAL = Silvershard.CHAT_MSG_RAID_BOSS_EMOTE
