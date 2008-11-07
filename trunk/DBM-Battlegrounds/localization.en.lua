local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "General BG Functions"
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
	name = "Arenas"
})

L:SetTimerLocalization({
	TimerStart	= "Game starts in",
})

L:SetOptionLocalization({
	TimerStart = "Show start timer"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "Alterac Valley"
})

L:SetTimerLocalization({
	TimerStart = "Game starts", 
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetMiscLocalization({
	BgStart60 = "1 minute until the battle for Alterac Valley begins.",
	BgStart30 = "The Battle for Arathi Basin will begin in 30 seconds.",
	ZoneName = "Alterac Valley",
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
	name = "Arathi Basin"
})

L:SetMiscLocalization({
	BgStart60 = "The Battle for Arathi Basin will begin in 1 minute.",
	BgStart30 = "The Battle for Arathi Basin will begin in 30 seconds.",
	ZoneName = "Arathi Basin",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Alliance",
	Horde = "Horde",
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
	name = "Eye of the Storm"
})

L:SetMiscLocalization({
	BgStart60 = "The battle begins in 1 minute!",
	BgStart30 = "The battle begins in 30 seconds!",
	ZoneName = "Eye of the Storm",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Alliance",
	Horde = "Horde",
	WinBarText = "%s wins",
	FlagReset = "The flag has been reset!",
	FlagTaken = "(.+) has taken the flag!",
	FlagCaptured = "The .+ ha%w+ captured the flag!",
	FlagDropped = "The flag has been dropped!",

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
	name = "Warsong Gulch"
})

L:SetMiscLocalization({
	BgStart60 = "The battle for Warsong Gulch begins in 1 minute.",
	BgStart30 = "The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!",
	ZoneName = "Warsong Gulch",
	Alliance = "Alliance",
	Horde = "Horde",	
	InfoErrorText = "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp = "The (%w+) .lag was picked up by (.+)!",
	ExprFlagCaptured = "(.+) captured the (%w+) flag!",
	ExprFlagReturn = "The (%w+) .lag was returned to its base by (.+)!",
	FlagAlliance = "Alliance Flag: ",
	FlagHorde = "Horde Flag: ",
	FlagBase = "Base",
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



