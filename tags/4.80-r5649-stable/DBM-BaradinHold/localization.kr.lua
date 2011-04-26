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
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
