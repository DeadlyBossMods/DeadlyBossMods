if GetLocale() ~= "zhTW" then return end

local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "深淵領主阿加羅斯"
})

L:SetWarningLocalization({
	WarnFirestormSoon		= "魔化火颶 即將到來"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnFirestormSoon		= "為$spell:88972顯示預先警告",
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
