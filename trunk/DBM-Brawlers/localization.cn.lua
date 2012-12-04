-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/5/2012

if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "搏击俱乐部"
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
	--I wish there was a better way to do this....so much localizing. :(
	EnteringArena1	= "请大家鼓掌欢迎——",
	EnteringArena2	= "现在进场的是一位",
	EnteringArena3	= "Look out... here comes",
	Victory1		= "is our victor",
	Victory2		= "Congratulations",
	Victory3		= "辉煌的胜利",
	Victory4		= "获胜！",
	Victory5		= "Keep 'em comin'",
	Victory6		= "Great job not dying",
	Lost1			= "were you even trying",
	Lost2			= "Now would you kindly remove your corpse",
	Lost3			= "So much blood! Nice",
	Lost4			= "Get back in line and try again",
	Lost5			= "you're gonna have to break a few eggs",
	Lost6			= "try not to die so much",
	Lost7			= "呃……真是一团糟",
	Lost8			= "His name was",--LoL at fight club reference here
})
