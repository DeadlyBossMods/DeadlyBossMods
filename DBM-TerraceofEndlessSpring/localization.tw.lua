if GetLocale() ~= "zhTW" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "為$spell:111850顯示距離框(8碼)\n(當你有debuff時只顯示其他沒有debuff的玩家)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "謝謝你，陌生人。我重獲自由了。"
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
	timerSpecialCD			= "下一次特別技能"
})

L:SetOptionLocalization({
	warnHideOver			= "為$spell:123244結束顯示警告",
	warnHideProgress		= "當$spell:123244結束後顯示統計",
	timerSpecialCD			= "為下一次特別技能冷卻顯示計時器",
	SetIconOnGuard			= "為$journal:6224標示團隊圖示",
	RangeFrame				= "為$spell:123121顯示距離框(3碼)(只有顯示坦)",
	GWHealthFrame			= "為$spell:123461顯示需求血量框架\n(首領血量框架需要開啟)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory					= "我...啊..喔!我曾經...?我是不是...?這一切...都太...模糊了。"--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	specWarnBreathOfFearSoon	= "恐懼之息來臨 - 移動到光牆裡!",
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "為$spell:119414顯示提前特別警告如果你身上沒有$spell:117964增益",
})

L:SetOptionLocalization({
	RangeFrame					= "為$spell:119519顯示距離框(8碼)"
})
