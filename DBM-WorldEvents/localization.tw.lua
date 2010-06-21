if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "寇仁·恐酒"
})

L:SetWarningLocalization({
	specWarnBrew		= "在他再丟你一個前喝掉酒!",
	specWarnBrewStun	= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	specWarnBrew		= "為黑鐵啤酒辣妹的啤酒顯示特別警告",
	specWarnBrewStun	= "為黑鐵啤酒辣妹昏迷顯示特別警告",
	YellOnBarrel		= "當你中了空桶(暈)時大喊"
})

L:SetMiscLocalization({
	YellBarrel		= "我中了空桶(暈)"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "無頭騎士"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "跳動的南瓜出現了!",
	specWarnHorsemanHead	= "旋風斬 - 轉換目標!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "為跳動的南瓜出現顯示警告",
	specWarnHorsemanHead	= "為旋風斬顯示特別警告 (第二次及最後的頭顱出現)"
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
	name = "藥劑師三人組"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	HummelActive	= "胡默爾 開始活動",
	BaxterActive	= "巴克斯特 開始活動",
	FryeActive		= "弗萊伊 開始活動"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "為藥劑師三人組開始活動顯示計時器"
})

L:SetMiscLocalization({
	SayCombatStart		= "他們有告訴你我是誰還有我為什麼這麼做嗎?"
})
