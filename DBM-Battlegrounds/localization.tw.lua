if GetLocale() ~= "zhTW" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "一般戰場功能"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "在得分視窗中設置玩家名為職業顏色",
	ShowInviteTimer	= "顯示戰場加入計時",
	AutoSpirit	= "自動釋放靈魂"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "競技場"
})

L:SetTimerLocalization({
	TimerStart	= "戰鬥始於",
})

L:SetOptionLocalization({
	TimerStart = "顯示開始計時"
})

L:SetMiscLocalization({
	Start60 = "競技場戰鬥在1分鐘內開始!",
	Start30 = "競技場戰鬥在30秒內開始!",
	Start15 = "競技場戰鬥在15秒內開始!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "奧特蘭克山谷"
})

L:SetTimerLocalization({
	TimerStart = "戰鬥開始", 
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetMiscLocalization({
	BgStart60 = "奧特蘭克山谷一分鐘後開始戰鬥。",
	BgStart30 = "奧特蘭克山谷30秒後開始戰鬥。",
	ZoneName = "奧特蘭克山谷",
})

L:SetOptionLocalization({
	TimerStart  = "顯示開始計時",
	TimerTower = "顯示哨塔佔領計時",
	TimerGY = "顯示墓地佔領計時",
	AutoTurnIn = "自動繳交聲望物品"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name = "阿拉希盆地"
})

L:SetMiscLocalization({
	BgStart60 = "阿拉希盆地的戰鬥將在1分鐘後開始。",
	BgStart30 = "阿拉希盆地的戰鬥將在30秒後開始。",
	ZoneName = "阿拉希盆地",
	ScoreExpr = "(%d+)/2000",
	Alliance = "聯盟",
	Horde = "部落",
	WinBarText = "%s 勝利",
	BasesToWin = "勝利還需: %d",
	Flag = "旗幟"
})

L:SetTimerLocalization({
	TimerStart = "戰鬥開始", 
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerStart  = "顯示開始計時",
	TimerWin = "顯示勝利計時",
	TimerCap = "顯示佔領計時",
	ShowAbEstimatedPoints = "顯示戰鬥結束時雙方資源預計值.",
	ShowAbBasesToWin = "顯示戰鬥勝利所需基地數目"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "暴風之眼"
})

L:SetMiscLocalization({
	BgStart60 = "戰鬥在1分鐘內開始!",
	BgStart30 = "戰鬥在30秒內開始!",
	ZoneName = "暴風之眼",
	ScoreExpr = "(%d+)/2000",
	Alliance = "聯盟",
	Horde = "部落",
	WinBarText = "%s 勝利",
	FlagReset = "旗幟已重置!",
	FlagTaken = "(.+)已經奪走了旗幟!",
	FlagCaptured = "(.+)已奪得旗幟!",
	FlagDropped = "旗幟已經掉落!",

})

L:SetTimerLocalization({
	TimerStart = "戰鬥開始", 
	TimerFlag = "旗幟重置",
})

L:SetOptionLocalization({
	TimerStart  = "顯示開始計時",
	TimerWin = "顯示勝利計時",
	TimerFlag = "顯示旗幟重置計時",
	ShowPointFrame = "顯示資源奪取進度和旗幟攜帶者",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name = "戰歌峽谷"
})

L:SetMiscLocalization({
	BgStart60 = "戰歌峽谷戰鬥將在1分鐘內開始。",
	BgStart30 = "戰歌峽谷戰鬥將在30秒鐘內開始。做好準備!",
	ZoneName = "戰歌峽谷",
	Alliance = "聯盟",
	Horde = "部落",	
	InfoErrorText = "當你離開戰鬥後，旗幟框架將會回復。",
	ExprFlagPickUp = "(.+)的旗幟被(.+)拔掉了!",
	ExprFlagCaptured = "(.+)佔據了(.+)的旗幟!",
	ExprFlagReturn = "(.+)的旗幟被(.+)還到了它的基地",
	FlagAlliance = "聯盟旗幟: ",
	FlagHorde = "部落旗幟: ",
	FlagBase = "基地",
})

L:SetTimerLocalization({
	TimerStart = "戰鬥開始", 
	TimerFlag = "旗幟重生",
})

L:SetOptionLocalization({
	TimerStart  = "顯示開始計時",
	TimerWin = "顯示勝利計時",
	TimerFlag = "顯示旗幟重置計時",
	ShowFlagCarrier = "顯示旗幟攜帶者",
	ShowFlagCarrierErrorNote = "當正在戰鬥時顯示旗幟錯誤提示",
})



----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "亞夏梵"
})

L:SetWarningLocalization({
	WarningShards	= "Rock Shards on >%s<",
	WarningGrab		= "Archavon grabbed >%s<"
})

L:SetTimerLocalization({
	TimerShards = "岩石裂片: %s"
})

L:SetMiscLocalization({
	TankSwitch = "%%s lunges for (%S+)!"
})

L:SetOptionLocalization({
	TimerShards = "顯示岩石裂片計時",
	WarningShards = "顯示岩石裂片警告",
	WarningGrab = "顯示坦克霸佔警告"
})
