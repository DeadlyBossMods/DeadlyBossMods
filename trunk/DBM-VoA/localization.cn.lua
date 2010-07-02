-- yleaf(yaroot@gmail.com)

if GetLocale() ~= "zhCN" then return end

local L

----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "远古海滩"
})

L:SetWarningLocalization({
	WarningShards	= "Rock Shards on >%s<",
	WarningGrab		= "Archavon grabbed >%s<"
})

L:SetTimerLocalization({
	TimerShards = "Rock Shards: %s"
})

L:SetMiscLocalization({
	TankSwitch = "%%s lunges for (%S+)!"
})

L:SetOptionLocalization({
	TimerShards = "Show Rock Shards timer",
	WarningShards = "Show Rock Shards warning",
	WarningGrab = "Show Tank Grab warning"
})