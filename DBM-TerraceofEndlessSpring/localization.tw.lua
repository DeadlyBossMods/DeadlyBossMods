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
	warnHideOver			= "%s結束"
})

L:SetTimerLocalization({
	timerSpecialCD			= "下一次特別技能"
})

L:SetOptionLocalization({
	warnHideOver			= "為$spell:123244結束顯示警告",
	timerSpecialCD			= "為下一次特別技能顯示計時器",
	SetIconOnCreature		= "為$journal:6224標示團隊圖示"
})

L:SetMiscLocalization{
	Victory	= "我...啊..喔!我曾經...?我是不是...?這一切...都...太模糊了。"--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

