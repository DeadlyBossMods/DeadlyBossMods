-- Arenas mod v3.0
-- rewrite by Tandanu
--

local Arenas	= DBM:NewMod("Arenas", "DBM-PvP", 1)
local L			= Arenas:GetLocalizedStrings()

Arenas:RemoveOption("HealthFrame")
Arenas:RemoveOption("SpeedKillTimer")
Arenas:SetZone(DBM_DISABLE_ZONE_DETECTION)

Arenas:RegisterEvents("CHAT_MSG_BG_SYSTEM_NEUTRAL")

local timerShadow	= Arenas:NewTimer(90, "TimerShadow", 34709)

function Arenas:CHAT_MSG_BG_SYSTEM_NEUTRAL(args)
	if not IsActiveBattlefieldArena() then return end
	if args == L.Start15 then
		timerShadow:Schedule(16)
	end
end

