if GetLocale() ~= "zhCN" then return end

local L

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
	warnHorsemanSoldiers	= "跳动的南瓜出现了！",
	warnHorsemanHead		= "旋风斩 - 转换目标!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "为跳动的南瓜出现显示警报",
	warnHorsemanHead		= "为旋风斩显示特别警报(第二次及最后的头颅出现)"
})

L:SetMiscLocalization({
	HorsemanHead		= "过来这里，你这白痴!",
	HorsemanSoldiers	= "士兵们起立，挺身奋战!让这个位死去的骑士得到最后的胜利!",
	SayCombatEnd		= "我也曾面对过这样的末路。还有什么新的冒险在等着呢?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name 			= "药剂师三人组"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	HummelActive		= "胡默尔 开始活动",
	BaxterActive		= "巴克斯特 开始活动",
	FryeActive		= "弗莱伊 开始活动"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "为药剂师三人组开始活动显示计时条"
})

L:SetMiscLocalization({
	SayCombatStart		= "他们有告诉你我是谁还有我为什么这么做吗?"
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
