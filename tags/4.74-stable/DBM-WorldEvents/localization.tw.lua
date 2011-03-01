if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name 			= "寇仁·恐酒"
})

L:SetWarningLocalization({
	specWarnBrew		= "在他再丟你一個前喝掉酒!",
	specWarnBrewStun	= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	specWarnBrew		= "為$spell:47376顯示特別警告",
	specWarnBrewStun	= "為$spell:47340顯示特別警告",
	YellOnBarrel		= "當你中了$spell:51413時大喊"
})

L:SetMiscLocalization({
	YellBarrel		= "我中了空桶(暈)"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name 			= "無頭騎士"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "跳動的南瓜出現了!",
	warnHorsemanHead	= "旋風斬 - 轉換目標!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "為跳動的南瓜出現顯示警告",
	warnHorsemanHead	= "為旋風斬顯示特別警告 (第二次及最後的頭顱出現)"
})

L:SetMiscLocalization({
	HorsemanHead		= "過來這裡，你這白痴!",
	HorsemanSoldiers	= "士兵們起立，挺身奮戰!讓這個位死去的騎士得到最後的勝利!",
	SayCombatEnd		= "我也曾面對過這樣的末路。還有什麼新的冒險在等著呢?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name 			= "藥劑師三人組"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	HummelActive		= "胡默爾 開始活動",
	BaxterActive		= "巴克斯特 開始活動",
	FryeActive		= "弗萊伊 開始活動"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "為藥劑師三人組開始活動顯示計時器"
})

L:SetMiscLocalization({
	SayCombatStart		= "他們有告訴你我是誰還有我為什麼這麼做嗎?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name 			= "艾胡恩"
})

L:SetWarningLocalization({
	Submerged		= "艾胡恩已隱沒",
	Emerged			= "艾胡恩已現身",
	specWarnAttack		= "艾胡恩擁有易傷 - 現在攻擊!"
})

L:SetTimerLocalization({
	SubmergTimer		= "隱沒",
	EmergeTimer		= "現身",
	TimerCombat		= "戰鬥開始"
})

L:SetOptionLocalization({
	Submerged		= "當艾胡恩隱沒時顯示警告",
	Emerged			= "當艾胡恩現身時顯示警告",
	specWarnAttack		= "當艾胡恩擁有易傷時顯示特別警告",
	SubmergTimer		= "為隱沒顯示計時器",
	EmergeTimer		= "為現身顯示計時器",
	TimerCombat		= "為戰鬥開始顯示計時器"
})

L:SetMiscLocalization({
	Pull			= "冰石已經溶化了!"
})