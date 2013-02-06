if GetLocale() ~= "zhTW" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "輪到小隊:%s",
	specWarnYourGroup	= "輪到你的小隊!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "提示$spell:118191的隊伍輪班(目前只支援25人5,2,2,2,戰術)",
	specWarnYourGroup	= "為$spell:118191顯示特別警告當輪到你的隊伍時\n(只適用於25人)",
	RangeFrame			= "為$spell:111850顯示距離框(8碼)(當你有debuff時只顯示其他沒有debuff的玩家)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetOptionLocalization({
	warnLightOfDay	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(123716)
})

L:SetMiscLocalization{
	Victory					= "謝謝你，陌生人。我重獲自由了。"
}


-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s結束",
	warnHideProgress		= "擊中:%s. 傷害:%s. 時間:%s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "特別技能冷卻(%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "為$spell:123244結束顯示警告",
	warnHideProgress		= "當$spell:123244結束後顯示統計",
	timerSpecialCD			= "為下一次特別技能冷卻顯示計時器",
	SetIconOnProtector		= "為$journal:6224標示團隊圖示(超過一名以上的團隊助理時不可靠)",
	RangeFrame				= "為$spell:123121顯示距離框(3碼)(只有顯示坦)",
	GWHealthFrame			= "為$spell:123461顯示需求血量框架(首領血量框架需要開啟)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory					= "我...啊..喔!我曾經...?我是不是...?這一切...都太...模糊了。"--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "向前穿過去",
	MoveRight					= "向右移動",
	MoveBack					= "回到原本位置",
	specWarnBreathOfFearSoon	= "恐懼之息來臨 - 移動到光牆裡!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "下一次特別技能",
	timerSpoHudCD				= "恐懼畏縮/水魄冷卻",
	timerSpoStrCD				= "水魄/嚴厲襲擊冷卻",
	timerHudStrCD				= "恐懼畏縮/嚴厲襲擊冷卻"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "當你在平台時顯示$spell:119414警告(不建議使用，給團隊隊長)",
	specWarnBreathOfFearSoon	= "為$spell:119414顯示提前特別警告如果你身上沒有$spell:117964增益",
	specWarnMovement			= "當$spell:120047施放時顯示移動的特別警告",
	warnWaterspout				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120519),
	warnHuddleInTerror			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120629),
	timerSpecialAbility 		= "為下一次特別技能施放顯示計時器",
	RangeFrame					= "為$spell:119519顯示距離框(2碼)",
	SetIconOnHuddle				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})
