if GetLocale() ~= "deDE" then return end
local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "Argaloth"
})

L:SetWarningLocalization({
	WarnFirestormSoon		= "Teufelsfeuersturm bald"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnFirestormSoon		= "Zeige Vorwarnung für $spell:88972 ",
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
