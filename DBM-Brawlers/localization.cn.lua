-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/19/2012

if GetLocale() ~= "zhCN" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "搏击俱乐部：设置"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "该你上场了！"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "特殊警报：轮到玩家登场",
	SpectatorMode		= "在观看比赛时显示警报与计时条"
})

L:SetMiscLocalization({
--	Bizmo			= "比兹莫",
	--I wish there was a better way to do this....so much localizing. :(
	Rank			= "(%d+)级",--Experimental "Entering arena" detection by scanning for Rank plus number
--	EnteringArena1	= "Now entering the arena",
--	EnteringArena2	= "Here's our challenger",
--	EnteringArena3	= "Look out... here comes",
--	EnteringArena4	= "Put your hands together",
	Rank1			= "1级",
	Rank2			= "2级",
	Rank3			= "3级",
	Rank4			= "4级",
	Rank5			= "5级",
	Rank6			= "6级",
	Rank7			= "7级",
	Rank8			= "8级",
	Victory1		= "胜利者是：",
	Victory2		= "官方消息！",
	Victory3		= "辉煌的胜利",
	Victory4		= "啊哈哈哈！真血腥！很好。",
	Victory5		= "让他们放马过来吧",
	Victory6		= "祝贺你，",
	Lost1			= "were you even trying",
	Lost2			= "Now would you kindly remove your corpse",
	Lost3			= "So much blood! Nice",
	Lost4			= "Get back in line and try again",
	Lost5			= "想要收获，你就得先付出。",
	Lost6			= "拜托你下回别再死那么多次了。",
	Lost7			= "呃……真是一团糟",
	Lost8			= "的名字是",--LoL at fight club reference here
	Lost9			= "did not end well"
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "搏击俱乐部：1级"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "搏击俱乐部：2级"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "搏击俱乐部：3级"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "搏击俱乐部：4级"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "搏击俱乐部：5级"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "搏击俱乐部：6级"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "搏击俱乐部：7级"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "搏击俱乐部：8级"
})