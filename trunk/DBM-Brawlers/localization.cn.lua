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
	Bizmo			= "比兹莫",
	Bazzelflange	= "Boss Bazzelflange",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "1级",
	Rank2			= "2级",
	Rank3			= "3级",
	Rank4			= "4级",
	Rank5			= "5级",
	Rank6			= "6级",
	Rank7			= "7级",
	Rank8			= "8级",
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus."
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