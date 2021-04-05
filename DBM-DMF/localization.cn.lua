-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Mar 5, 2015

if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "炮弹飞人"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "打豺狼人"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "得分：%d / %d（可能的最高分数）",
	warnGameOverNoQuest	= "游戏结束，本次可能的最高分数：%d",
	warnGnoll			= "豺狼人出现",
	warnHogger			= "霍格出现",
	specWarnHogger		= "霍格！"
})

L:SetOptionLocalization({
	warnGameOver	= "游戏结束时通报本次游戏可能的最高分数",
	warnGnoll		= "警报：豺狼人出现",
	warnHogger		= "警报：霍格出现",
	specWarnHogger	= "特殊警报：霍格出现"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "射击场"
})

L:SetOptionLocalization({
	SetBubbles			= "在$spell:101871期间自动关闭聊天气泡（结束后自动恢复）"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "坦克大战"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "暗月兔子"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "月牙"
})

L:SetWarningLocalization({
	specWarnCallPack		= "召唤狼群 － 远离月牙40码以上!",
	specWarnMoonfangCurse	= "月牙的诅咒 － 远离月牙10码以上!"
})
