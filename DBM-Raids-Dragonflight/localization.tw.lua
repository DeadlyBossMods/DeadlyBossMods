if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "攻擊 (%s)",
	timerAvoidCD = "屏障 (%s)",
	timerUltimateCD = "洪荒之終 (%s)",
	timerAddEnrageCD = "激怒 (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "顯示針對目標攻擊：$spell:382563, $spell:373678, $spell:391055, $spell:373487 的計時器",
	timerAvoidCD = "顯示屏障階段：$spell:373329, $spell:391019, $spell:395893, $spell:390920 的計時器",
	timerUltimateCD = "顯示洪荒之終：$spell:374022, $spell:372456, $spell:374691, $spell:374215 的計時器",
	timerAddEnrageCD = "顯示在傳奇難度上增加的激怒計時器"
})

L:SetMiscLocalization({
	Fire	= "烈焰",
	Frost	= "冰霜",
	Earth	= "大地",
	Storm	= "風暴"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff		= "巨杖",
	eStaff	= "強化巨杖"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
L= DBM:GetModLocalization(2499)

L:SetOptionLocalization({
	SetBreathToBait = "在過場階段調整吐息計時器，到期根據誘餌計時而不是施法計時 (吐息施放時施放時警報仍會觸發)"
})

L:SetMiscLocalization({
	negative = "負極",
	positive = "正極",
	BreathEmote	= "深呼吸..."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"洪荒化身牢獄小怪"
})

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

---------------------------
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "在第1階段中積極掃描與每個首領的距離，並自動隱藏您非接近首領的某些警報和淡出的計時器（超過43距離）"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
--L= DBM:GetModLocalization(2530)

L:SetMiscLocalization({
	SafeClear		= "安全清除"
})

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "大怪出現 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "顯示新來獵人和護衛爬牆的計時器"
})

L:SetMiscLocalization({
	northWall		= "北方的城垛",
	southWall		= "南方的城垛"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "設定坦克切換的模組行為",
	OnlyIfDanger		= "僅當其他坦克即將被不安全的擊中時才顯示嘲諷警告",
	MinMaxSoak			= "僅當第一次連續攻擊之後，或其他坦克即將被不安全的擊中時，才顯示嘲諷警告",
	DoubleSoak			= "僅當第一次連續攻擊結束以後，或其他坦克即將被不安全的擊中時，才顯示嘲諷警告"--Default
})

L:SetMiscLocalization({
	pool		= "{rt%d}圈 %d",--<icon> Pool 1,2,3
	soakpool	= "踩圈"
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}池 %d",--<icon> Pool 1,2,3
	soakpool	= "吸收池"
})

---------------------------
--  Echo of Neltharion --
---------------------------
L= DBM:GetModLocalization(2523)

L:SetMiscLocalization({
	WallBreaker	= "破牆者"
})

---------------------------
--  Scalecommander Sarkareth --
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "設置資訊框架層數堆疊追蹤的行為",
	OblivionOnly			= "只顯示空寂湮沒的層數 (階段 1 2 與 3)",--Default
	HowlOnly				= "只顯示壓制嚎叫的層數 (階段 1，否則關閉)",
	Hybrid					= "在階段1顯示壓制嚎叫層數，並且在階段2與3顯示空寂湮沒層數"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"亞貝魯斯小怪"
})

---------------------------
--  Amirdrassil, the Dream's Hope --
---------------------------
---------------------------
--  Gnarlroot --
---------------------------
--L= DBM:GetModLocalization(2564)

---------------------------
--  Igira the Cruel --
---------------------------
--L= DBM:GetModLocalization(2554)

---------------------------
--  Volcoross --
---------------------------
L= DBM:GetModLocalization(2557)

L:SetMiscLocalization({
	DebuffSoaks			= "減益吸收 (%s)"--Might be common localized later
})

---------------------------
--  Council of Dreams --
---------------------------
L= DBM:GetModLocalization(2555)

L:SetMiscLocalization({
	Ducks		= "鴨子 (%s)"
})

---------------------------
--  Larodar, Keeper of the Flame --
---------------------------
L= DBM:GetModLocalization(2553)

L:SetMiscLocalization({
	currentHealth		= "%d%%",
	currentHealthIcon	= "{rt%d}%d%%",
	Roots				= "樹根 (%s)",
	HealAbsorb			= "治療吸收 (%s)"--Might be common localized later
})

---------------------------
--  Nymue, Weaver of the Cycle --
---------------------------
L= DBM:GetModLocalization(2556)

L:SetMiscLocalization({
	Threads			= "織物 (%s)"
})

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --
---------------------------
L= DBM:GetModLocalization(2565)

L:SetMiscLocalization({
	TreeForm			= "樹人型態",
	MoonkinForm			= "梟獸型態",
	Feathers			= "羽毛"
})

---------------------------
--  Fyrakk the Blazing --
---------------------------
L= DBM:GetModLocalization(2519)

L:SetTimerLocalization{
	timerMythicDebuffs			= "牢籠 (%s)"
}

L:SetWarningLocalization{
	warnMythicDebuffs			= "牢籠 (%s)"
}

L:SetOptionLocalization{
	warnMythicDebuffs			= "當$spell:428988以及$spell:428970減益施放時通告(包含計數)",
	timerMythicDebuffs			= "顯示$spell:428988以及$spell:428970減益的計時(包含計數)"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"埃達希爾小怪"
})

L:SetMiscLocalization({
	FyrakkRP			= "又來了。可惜我沒時間親自動手。"
})
