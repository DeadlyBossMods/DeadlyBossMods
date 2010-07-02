-- yleaf(yaroot@gmail.com)

if GetLocale() ~= "zhCN" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "战场模块"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "得分板上玩家按职业着色",
	ShowInviteTimer	= "显示加入计时",
	AutoSpirit	= "自动释放灵魂"
})

L:SetMiscLocalization({
	ArenaInvite	= "竞技场邀请"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "竞技场"
})

L:SetTimerLocalization({
	TimerStart	= "战斗即将开始",
	TimerShadow	= "暗影之眼"
})

L:SetOptionLocalization({
	TimerStart = "显示开始计时",
	TimerShadow 	= "显示暗影水晶计时"
})

L:SetMiscLocalization({
	Start60 = "竞技场战斗将在一分钟后开始！",
	Start30 = "竞技场战斗将在三十秒后开始！",
	Start15 = "竞技场战斗将在十五秒后开始！"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "奥特兰克山谷"
})

L:SetTimerLocalization({
	TimerStart = "战斗即将开始", 
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetMiscLocalization({
	BgStart60 = "奥特兰克山谷的战斗将在1分钟之后开始。",
	BgStart30 = "奥特兰克山谷的战斗将在30秒之后开始。",
	ZoneName = "奥特兰克山谷",
})

L:SetOptionLocalization({
	TimerStart  = "显示开始计时",
	TimerTower = "显示哨塔占领计时",
	TimerGY = "显示墓地占领计时",
	AutoTurnIn = "自动递交任务物品"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "阿拉希盆地"
})

L:SetMiscLocalization({
	BgStart60 = "阿拉希盆地的战斗将在1分钟后开始。",
	BgStart30 = "阿拉希盆地的战斗将在30秒后开始。",
	ZoneName = "阿拉希盆地",
	ScoreExpr = "(%d+)/1600",
	Alliance = "联盟",
	Horde = "部落",
	WinBarText = "%s 获胜",
	BasesToWin = "胜利需要占领资源: %d",
	Flag = "旗帜"
})

L:SetTimerLocalization({
	TimerStart = "战斗即将开始", 
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerStart  = "显示开始计时",
	TimerWin = "显示获胜计时",
	TimerCap = "显示占领计时",
	ShowAbEstimatedPoints = "显示战斗结束时双方资源统计",
	ShowAbBasesToWin = "显示获胜需要占领的资源点"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "风暴之眼"
})

L:SetMiscLocalization({
	BgStart60 = "战斗将在1分钟后开始！",
	BgStart30 = "战斗将在30秒后开始！",
	ZoneName = "风暴之眼",
	ScoreExpr = "(%d+)/1600",
	Alliance = "联盟",
	Horde = "部落",
	WinBarText = "%s 获胜",
	FlagReset = "旗帜被重新放置了。!",
	FlagTaken = "(.+)夺走了旗帜！",
	FlagCaptured = "(.+)夺得了旗帜！",
	FlagDropped = "旗帜被扔掉了！",

})

L:SetTimerLocalization({
	TimerStart = "战斗即将开始", 
	TimerFlag = "旗帜重置",
})

L:SetOptionLocalization({
	TimerStart  = "显示开始计时",
	TimerWin = "显示获胜计时",
	TimerFlag = "显示旗帜重置计时",
	ShowPointFrame = "显示旗帜携带着和获胜计时",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "战歌峡谷"
})

L:SetMiscLocalization({
	BgStart60 = "战歌峡谷战斗将在1分钟内开始。",
	BgStart30 = "战歌峡谷战斗将在30秒钟内开始。做好准备！",
	ZoneName = "战歌峡谷",
	Alliance = "联盟",
	Horde = "部落",	
	InfoErrorText = "携带旗帜者目标功能会在你脱离战斗后恢复.",
	ExprFlagPickUp = "(.+)的旗帜被(.+)拔起了！",
	ExprFlagCaptured = "(.+)夺取(.+)的旗帜！",
	ExprFlagReturn = "(.+)的旗帜被(.+)还到了它的基地中！",
	FlagAlliance = "联盟: ",
	FlagHorde = "部落: ",
	FlagBase = "基地",
})

L:SetTimerLocalization({
	TimerStart = "战斗即将开始", 
	TimerFlag = "旗帜重置",
})

L:SetOptionLocalization({
	TimerStart  = "显示开始计时",
	TimerWin = "显示获胜计时",
	TimerFlag = "显示旗帜重置计时",
	ShowFlagCarrier = "显示旗帜携带者",
	ShowFlagCarrierErrorNote = "战斗中显示旗帜携带者错误信息",
})
