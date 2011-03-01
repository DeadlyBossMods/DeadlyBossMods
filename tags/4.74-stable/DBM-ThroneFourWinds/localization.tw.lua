if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name 				= "風之議會"
})

L:SetWarningLocalization({
	warnSpecial			= "颶風/微風/冰雨風暴啟動",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "特別技能啟動!",
	warnSpecialSoon			= "10秒後 特別技能啟動!"
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
	gatherstrength			= "%s開始從剩下的風之王那裡取得力量!",
	Anshal				= "安蕭爾",
	Nezir				= "涅茲爾",
	Rohash				= "洛哈許"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name 				= "奧拉基爾"
})

L:SetWarningLocalization({
	WarnFeedback			= "%s: >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd				= "風暴小怪 即將到來"
})

L:SetTimerLocalization({
	TimerFeedback 			= "回饋 (%d)"
})

L:SetOptionLocalization({
	WarnFeedback			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "unknown"),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback			= "為$spell:87904的持續時間顯示計時器"
})

L:SetMiscLocalization({
	summonSquall			= "Storms! I summon you to my side!",--Translate
	phase3				= "Enough! I will no longer be contained!"--Translate
})