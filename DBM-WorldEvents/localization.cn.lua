-- Simplified Chinese by Diablohu(diablohudream@gmail.com) & yleaf(yaroot@gmail.com)
-- Last update: 2/12/2012

if GetLocale() ~= "zhCN" then return end

local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "年兽"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name 			= "皇冠药剂公司"
})

L:SetTimerLocalization({
	HummelActive		= "汉摩尔加入战斗",
	BaxterActive		= "拜克斯特加入战斗",
	FryeActive		= "弗莱加入战斗"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "计时条：药剂师何时加入战斗"
})

L:SetMiscLocalization({
	SayCombatStart		= "他们顾得上告诉你我是谁或者我在做些什么吗？"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name 			= "埃霍恩"
})

L:SetWarningLocalization({
	Submerged		= "埃霍恩已隐没",
	Emerged			= "埃霍恩已现身",
	specWarnAttack		= "埃霍恩拥有易伤 - 现在攻击!"
})

L:SetTimerLocalization({
	SubmergTimer		= "隐没",
	EmergeTimer		= "现身",
	TimerCombat		= "战斗开始"
})

L:SetOptionLocalization({
	Submerged		= "当埃霍恩隐没时显示警报",
	Emerged			= "当埃霍恩现身时显示警报",
	specWarnAttack		= "当埃霍恩拥有易伤时显示特别警报",
	SubmergTimer		= "为隐没显示计时条",
	EmergeTimer		= "为现身显示计时条",
	TimerCombat		= "为战斗开始显示计时条"
})

L:SetMiscLocalization({
	Pull			= "冰石已经溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name 			= "科林·烈酒"
})

L:SetWarningLocalization({
	specWarnBrew		= "在他再丢你一个前喝掉酒！",
	specWarnBrewStun	= "提示：你疯狂了，记得下一次喝啤酒！"
})

L:SetOptionLocalization({
	specWarnBrew		= "为黑铁啤酒女郎的啤酒显示特别警报",
	specWarnBrewStun	= "为黑铁啤酒女郎昏迷显示特别警报",
	YellOnBarrel		= "当你中了空桶(晕)时大喊"
})

L:SetMiscLocalization({
	YellBarrel		= "我中了空桶(晕)"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name 			= "无头骑士"
})

L:SetWarningLocalization({
	WarnPhase				= "第%d阶段",
	warnHorsemanSoldiers	= "跃动的南瓜出现了",
	warnHorsemanHead		= "无头骑士激活"
})

L:SetTimerLocalization{
	TimerCombatStart		= "战斗开始"
}

L:SetOptionLocalization({
	WarnPhase				= "警报：阶段转换",
	TimerCombatStart		= "计时条：战斗开始",
	warnHorsemanSoldiers	= "警报：跃动的南瓜出现",
	warnHorsemanHead		= "特殊警报：旋风斩（无头骑士的脑袋出现）"
})

L:SetMiscLocalization({
	HorsemanSummon			= "无头骑士来了……",
	HorsemanSoldiers	= "士兵们，起来战斗吧！为死去的骑士带来胜利的荣耀！"
})


------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "讨厌的格林奇"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
}

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

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
	specWarnHogger		= "霍格出现！"
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