if GetLocale() ~= "ruRU" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Общие функции ПБ"
})
L:SetTimerLocalization({
	TimerInvite = "%s"
})
L:SetOptionLocalization({
	ColorByClass	= "Set name color to class color in the score frame",
	ShowInviteTimer	= "Show battleground join timer",
	AutoSpirit	= "Auto-release spirit"
})
--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Арены"
})
L:SetTimerLocalization({
	TimerStart	= "Game starts in",
})
L:SetOptionLocalization({
	TimerStart = "Show start timer"
})
L:SetMiscLocalization({
	Start60 = "One minute until the Arena battle begins!",
	Start30 = "Thirty seconds until the Arena battle begins!",
	Start15 = "Fifteen seconds until the Arena battle begins!"
})
---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "Альтеракская долина"
})
L:SetTimerLocalization({
	TimerStart = "Game starts", 
	TimerTower = "%s",
	TimerGY = "%s",
})
L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту.",
	BgStart30 = "Битва начнется через 30 секунд.",
	ZoneName = "Альтеракская долина",
})
L:SetOptionLocalization({
	TimerStart  = "Show start timer",
	TimerTower = "Show tower capture timer",
	TimerGY = "Show graveyard capture timer",
	AutoTurnIn = "Auto turn-in quests"
})
---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name = "Низина Арати"
})
L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту.",
	BgStart30 = "Битва начнется через 30 секунд.",
	ZoneName = "Низина Арати",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Альянс",
	Horde = "Орда",
	WinBarText = "%s wins",
	BasesToWin = "Bases to win: %d",
	Flag = "Flag"
})
L:SetTimerLocalization({
	TimerStart = "Game starts", 
	TimerCap = "%s",
})
L:SetOptionLocalization({
	TimerStart  = "Show start timer",
	TimerWin = "Show win timer",
	TimerCap = "Show capture timer",
	ShowAbEstimatedPoints = "Show estimated points on win/lose",
	ShowAbBasesToWin = "Show bases required to win"
})
-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "Око Бури"
})
L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту.",
	BgStart30 = "Битва начнется через 30 секунд.",
	ZoneName = "Око Бури",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Альянса",
	Horde = "Орды",
	WinBarText = "Победа %s",
	FlagReset = "Флаг возвращается на место.",
	FlagTaken = "(.+) захватывает флаг!",
	FlagCaptured = ".+ ha%w+ захватывает флаг!",
	FlagDropped = "Флаг был уронен!",

})
L:SetTimerLocalization({
	TimerStart = "Game starts", 
	TimerFlag = "Flag respawn",
})
L:SetOptionLocalization({
	TimerStart  = "Show start timer",
	TimerWin = "Show win timer",
	TimerFlag = "Show flag respawn timer",
	ShowPointFrame = "Show flag carrier and estimated points",
})
--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name = "Ущелье Песни Войны"
})
L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту.",
	BgStart30 = "Битва начнется через 30 секунд.",
	ZoneName = "Ущелье Песни Войны",
	Alliance = "Альянса",
	Horde = "Орды",	
	InfoErrorText = "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp = "(.+) взял флаг (%w+)",
	ExprFlagCaptured = "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn = "(.+) возвращает флаг (%w+) на базу!",
	FlagAlliance = "Флаг Альянса: ",
	FlagHorde = "Флаг Орды: ",
	FlagBase = "База",
})

L:SetTimerLocalization({
	TimerStart = "Game starts", 
	TimerFlag = "Flag respawn",
})
L:SetOptionLocalization({
	TimerStart  = "Show start timer",
	TimerWin = "Show win timer",
	TimerFlag = "Show flag respawn timer",
	ShowFlagCarrier = "Show flag carrier",
	ShowFlagCarrierErrorNote = "Shows flag carrier error message when in combat",
})
----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Склеп Аркавона"
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