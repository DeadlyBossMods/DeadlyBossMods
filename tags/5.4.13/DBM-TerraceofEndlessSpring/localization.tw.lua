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
	warnGroupOrder		= "提示$spell:118191的隊伍輪班<br/>(目前只支援25人5,2,2,2,戰術)",
	specWarnYourGroup	= "為$spell:118191顯示特別警告當輪到你的隊伍時(只適用於25人)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(當你有debuff時只顯示其他沒有debuff的玩家)"
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory					= "謝謝你，陌生人。我重獲自由了。"
}


-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s結束"
})

L:SetTimerLocalization({
	timerSpecialCD			= "特別技能冷卻(%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "為$spell:123244結束顯示警告",
	timerSpecialCD			= "為下一次特別技能冷卻顯示計時器",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(消失時顯示所有玩家其餘時間只有顯示坦)",
	GWHealthFrame			= "為$spell:123461退去顯示血量框架(首領血量框架需要開啟)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory					= "我...啊..喔!我曾經...?我是不是...?這一切...都太...模糊了。"
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
	warnBreathOnPlatform		= "當你在平台時顯示$spell:119414警告<br/>(不建議使用，團隊隊長使用)",
	specWarnBreathOfFearSoon	= "為$spell:119414顯示提前特別警告如果你身上沒有$spell:117964增益",
	specWarnMovement			= "當$spell:120047施放時顯示移動的特別警告<br/>(點擊去複製連結<a href=\"http://mysticalos.com/terraceofendlesssprings.jpg\">|cff3588ffhttp://mysticalos.com/terraceofendlesssprings.jpg|r</a>)",
	timerSpecialAbility 		= "為下一次特別技能施放顯示計時器"
})
