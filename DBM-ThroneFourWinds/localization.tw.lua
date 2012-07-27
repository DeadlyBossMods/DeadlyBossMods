if GetLocale() ~= "zhTW" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "颶風/微風/冰雨風暴啟動",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "特別技能啟動!",
	warnSpecialSoon			= "10秒後特別技能啟動!"
})

L:SetTimerLocalization({
	timerSpecial			= "特別技能冷卻",
	timerSpecialActive		= "特別技能啟動"
})

L:SetOptionLocalization({
	warnSpecial			= "當颶風/微風/冰雨風暴施放時顯示警告",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "當特別技能施放時顯示特別警告",
	timerSpecial			= "為特別技能冷卻顯示計時器",
	timerSpecialActive		= "為特別技能持續時間顯示計時器",
	warnSpecialSoon			= "特別技能施放前10秒顯示預先警告",
	OnlyWarnforMyTarget		= "只為當前或焦點目標顯示警告\n(隱藏所有其他。這包括進入戰鬥)"
})

L:SetMiscLocalization({
	gatherstrength			= "開始從剩下的風領主那裡取得力量!"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 			= "回饋(%d)"
})

L:SetOptionLocalization({
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback			= "為$spell:87904的持續時間顯示計時器",
	RangeFrame				= "為當中了$spell:89668時顯示距離框(20碼)"
})
