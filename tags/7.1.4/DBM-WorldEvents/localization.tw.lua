if GetLocale() ~= "zhTW" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "年獸"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization({
	HummelActive		= "胡默爾開始活動",
	BaxterActive		= "巴克斯特開始活動",
	FryeActive			= "弗萊伊開始活動"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "為藥劑師三人組開始活動顯示計時器"
})

L:SetMiscLocalization({
	SayCombatStart		= "他們有告訴你我是誰還有我為什麼這麼做嗎?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged				= "艾胡恩已現身",
	specWarnAttack		= "艾胡恩變得脆弱 - 現在攻擊!"
})

L:SetTimerLocalization({
	SubmergTimer		= "隱沒",
	EmergeTimer			= "現身"
})

L:SetOptionLocalization({
	Emerged				= "當艾胡恩現身時顯示警告",
	specWarnAttack		= "當艾胡恩變得脆弱時顯示特別警告",
	SubmergTimer		= "為隱沒顯示計時器",
	EmergeTimer			= "為現身顯示計時器"
})

L:SetMiscLocalization({
	Pull				= "冰石已經溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "在他再丟你另一個前喝掉酒!",
	specWarnBrewStun	= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	specWarnBrew		= "為$spell:47376顯示特別警告",
	specWarnBrewStun	= "為$spell:47340顯示特別警告",
	YellOnBarrel		= "當你中了$spell:51413時大喊"
})

L:SetMiscLocalization({
	YellBarrel			= "我中了空桶(暈)"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "啤酒節"
})

L:SetOptionLocalization({
	NormalizeVolume			= "在啤酒節區域時，自動地調整對話聲道以匹配音樂聲道的音量。(如果音樂聲道沒有開啟，則會設成静音。)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "第%d階段",
	warnHorsemanSoldiers	= "跳動的南瓜出現了!",
	warnHorsemanHead		= "旋風斬 - 轉換目標!"
})

L:SetOptionLocalization({
	WarnPhase				= "為每個階段改變顯示警告",
	warnHorsemanSoldiers	= "為跳動的南瓜出現顯示警告",
	warnHorsemanHead		= "為旋風斬顯示特別警告 (第二次及最後的頭顱出現)"
})

L:SetMiscLocalization({
	HorsemanSummon			= "騎士甦醒...",
	HorsemanSoldiers		= "士兵們起立，挺身奮戰!讓這個位死去的騎士得到最後的勝利!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "可惡的格林奇"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "植物大戰僵屍"
})

L:SetWarningLocalization({
	warnTotalAdds	= "總共已進攻的殭屍群:%d",
	specWarnWave	= "大群的殭屍!"
})

L:SetTimerLocalization{
	timerWave		= "下一次大群的殭屍"
}

L:SetOptionLocalization({
	warnTotalAdds	= "提示大群的殭屍的總數量",
	specWarnWave	= "為大群的殭屍顯示特別警告",
	timerWave		= "為下一次大群的殭屍顯示計時器"
})

L:SetMiscLocalization({
	MassiveWave		= "大群的殭屍要來啦!"
})

--------------------------
--  Demonic Invasions  --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "惡魔入侵"
})
