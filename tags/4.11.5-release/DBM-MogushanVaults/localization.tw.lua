if GetLocale() ~= "zhTW" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s即將超載",
	specWarnBreakJasperChains	= "扯斷碧玉鎖鏈!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "為即將超載顯示特別警告",
	specWarnBreakJasperChains	= "當可安全扯斷$spell:130395時顯示特別警告",
	ArrowOnJasperChains			= "當受到$spell:130395時顯示DBM箭頭",
	InfoFrame					= "為首領能量,玩家石化和那個王施放石化顯示訊息框"
})

L:SetMiscLocalization({
	Overload	= "%s要超載了!"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "階段%d"
})

L:SetOptionLocalization({
	WarnPhase	= "提示轉換階段",
	RangeFrame	= "在祕法階段時顯示距離框(6碼)"
})

L:SetMiscLocalization({
	Fire		= "噢，至高的神啊!藉由我來融化他們的血肉吧!",
	Arcane		= "噢，上古的賢者!賜予我祕法的智慧!",
	Nature		= "噢，偉大的靈魂!賜予我大地之力!",
	Shadow		= "英雄之靈!以盾護我之身!"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	RangeFrame			= "顯示距離框(8碼)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull				= "受死吧，你們!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "顯示距離框(8碼)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "地板將在六秒內消失!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "地板消失"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "為地板消失之前顯示特別警告",
	timerDespawnFloor			= "為地板消失顯示計時器",
	SetIconOnDestabilized		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226)
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "為受到$spell:116525的玩家顯示訊息框",
	ArrowOnCombo	= "為$journal:5673顯示DBM箭頭\n注:這是假設坦克在前方而其他人在後方"
})

L:SetMiscLocalization({
	Pull		= "這台機器啟動了!到下一層去!",--Emote
	Rage		= "大帝之怒響徹群山。",--Yell
	Strength	= "帝王之力出現在壁龜裡!",--Emote
	Courage		= "帝王之勇出現在壁龜裡!",--Emote
	Boss		= "兩個泰坦魁儡出現在大壁龜裡!"--Emote
})

