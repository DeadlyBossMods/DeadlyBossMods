-- Simplified Chinese by Diablohu(diablohudream@gmail.com) & yleaf(yaroot@gmail.com)
-- Last update: 1/26/2013

if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "常规设置"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "得分板上玩家按职业着色",
	ShowInviteTimer		= "计时条：进入战场",
	AutoSpirit			= "自动释放灵魂",
	HideBossEmoteFrame	= "隐藏团队首领表情框体"
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
	TimerShadow	= "暗影之眼"
})

L:SetOptionLocalization({
	TimerShadow 	= "计时条：暗影之眼"
})

L:SetMiscLocalization({
	Start15 = "竞技场战斗将在十五秒后开始！"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetTimerLocalization({
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetOptionLocalization({
	TimerTower 	= "计时条：占领哨塔",
	TimerGY 	= "计时条：占领墓地",
	AutoTurnIn 	= "自动递交任务物品"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("z529")

L:SetMiscLocalization({
	ScoreExpr 	= "(%d+)/1600",
	WinBarText 	= "%s 获胜",
	BasesToWin 	= "胜利需要占领资源点: %d",
	Flag 		= "旗帜"
})

L:SetTimerLocalization({
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerWin 				= "计时条：获胜",
	TimerCap 				= "计时条：占领资源点",
	ShowAbEstimatedPoints 	= "显示战斗结束时双方资源统计",
	ShowAbBasesToWin 		= "显示获胜需要占领的资源点"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("z566")

L:SetMiscLocalization({
	ScoreExpr	 	= "(%d+)/1600",
	WinBarText 		= "%s 获胜",
	FlagReset 		= "旗帜被重新放置了。!",
	FlagTaken 		= "(.+)夺走了旗帜！",
	FlagCaptured 	= "(.+)夺得了旗帜！",
	FlagDropped 	= "旗帜被扔掉了！",

})

L:SetTimerLocalization({
	TimerFlag = "旗帜重置",
})

L:SetOptionLocalization({
	TimerWin 		= "计时条：获胜",
	TimerFlag 		= "计时条：旗帜重置",
	ShowPointFrame 	= "显示旗帜携带着和预计获胜点数",
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("z489")

L:SetMiscLocalization({
	BgStart60 = "战歌峡谷战斗将在1分钟内开始。",
	BgStart30 = "战歌峡谷战斗将在30秒钟内开始。做好准备！",
	InfoErrorText = "携带旗帜者目标功能会在你脱离战斗后恢复。",
	ExprFlagPickUp = "(.+)的旗帜被(.+)拔起了！",
	ExprFlagCaptured = "(.+)夺取了(.+)的旗帜！",
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
	TimerStart  = "计时条：战斗开始",
	TimerFlag = "计时条：旗帜重置",
	ShowFlagCarrier = "显示旗帜携带者",
	ShowFlagCarrierErrorNote = "战斗中显示旗帜携带者错误信息",
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine			= "攻城机具准备好了！",
	WarnSiegeEngineSoon		= "10秒后 攻城机具就绪"
})

L:SetTimerLocalization({
	TimerPOI			= "%s",
	TimerSiegeEngine		= "攻城机具修复"
})

L:SetOptionLocalization({
	TimerPOI			= "计时条：占领",
	TimerSiegeEngine	= "计时条：攻城器的建造",
	WarnSiegeEngine		= "警报：攻城器准备就绪",
	WarnSiegeEngineSoon	= "预警：攻城器准备就绪",
	ShowGatesHealth		= "生命值框：城门破损状况（中途加入战场，该数据可能不准确）"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "城门破损状况",
	SiegeEngine			= "攻城器",
	GoblinStartAlliance		= "看到那些爆盐炸弹了吗？当我维修攻城机具的时候用它们来轰破大门！",
	GoblinStartHorde		= "修理攻城机具的工作就交给我，帮我看着点就够了。如果你想要轰破大门的话，尽管把那些爆盐炸弹拿去用吧！",
	GoblinHalfwayAlliance		= "我已经修好一半了！别让部落靠近。工程学院可没有教我们如何作战喔！",
	GoblinHalfwayHorde		= "我已经修好一半了！别让联盟靠近 - 我的合约里可没有作战这一条！",
	GoblinFinishedAlliance		= "我有史以来最得意的作品！这台攻城机具已经可以上场啰！",
	GoblinFinishedHorde		= "这台攻城机具已经可以上场啦！",
	GoblinBrokenAlliance		= "这么快就坏啦？！别担心，再坏的情况我都可以修得好。",
	GoblinBrokenHorde		= "又坏掉了吗？！让我来修理吧……但别指望产品的保固会帮你支付这一切。"
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("z726")

L:SetMiscLocalization({
	BgStart60 = "战斗将在1分钟内开始。",
	BgStart30 = "战斗将在30秒钟内开始。做好准备！",
	InfoErrorText		= "携带旗帜者目标功能会在你脱离战斗后恢复。",
	ExprFlagPickUp = "(.+)的旗帜被(.+)拔起了！",
	ExprFlagCaptured = "(.+)夺取了(.+)的旗帜！",
	ExprFlagReturn = "(.+)的旗帜被(.+)还到了它的基地中！",
	FlagAlliance = "联盟: ",
	FlagHorde = "部落: ",
	FlagBase = "基地",
	Vulnerable1		= "The flag carriers have become vulnerable to attack!",
	Vulnerable2		= "The flag carriers have become increasingly vulnerable to attack!"
})

L:SetTimerLocalization({
	TimerStart = "战斗即将开始",
	TimerFlag = "旗帜重置",
})

L:SetOptionLocalization({
	TimerStart  = "计时条：战斗开始",
	TimerFlag = "计时条：旗帜重置",
	ShowFlagCarrier = "显示旗帜携带者",
	ShowFlagCarrierErrorNote = "战斗中显示旗帜携带者错误信息",
})

--------------------------
--  Battle for Gilneas  --
--------------------------
L = DBM:GetModLocalization("z761")

L:SetMiscLocalization({
	ScoreExpr = "(%d+)/2000",
	WinBarText = "%s 获胜",
	BasesToWin = "胜利需要占领资源点: %d",
	Flag = "旗帜"
})

L:SetTimerLocalization({
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerWin = "计时条：获胜",
	TimerCap = "计时条：占领",
	ShowGilneasEstimatedPoints = "显示战斗结束时双方资源统计",
	ShowGilneasBasesToWin = "显示获胜需要占领的资源点"
})


-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerCart	= "矿车刷新"
})

L:SetOptionLocalization({
	TimerCart	= "计时条：矿车刷新"
})

L:SetMiscLocalization({
	Capture = "控制了"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	TimerWin			= "计时条：获胜",
	ShowKotmoguEstimatedPoints	= "显示战斗结束时双方资源统计",
	ShowKotmoguOrbsToWin		= "显示获胜需要控制的宝珠数量"
})

L:SetMiscLocalization({
	OrbTaken 	= "(%S+)取走了(%S+)的球！",
	OrbReturn 	= "(%S+)宝珠被放回了！",
	ScoreExpr	= "(%d+)/1600",
	WinBarText	= "预计：%s获胜",
	OrbsToWin	= "胜利需要控制宝珠：%d"
})
