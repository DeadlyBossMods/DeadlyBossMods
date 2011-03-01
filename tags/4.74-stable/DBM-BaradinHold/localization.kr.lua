if GetLocale() ~= "koKR" then return end
local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "아르갈로스"
})

L:SetWarningLocalization({
	WarnFirestormSoon		= "곧 지옥 화염폭풍!"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnFirestormSoon		= "$spell:88972 사전 경고 보기 ",
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
