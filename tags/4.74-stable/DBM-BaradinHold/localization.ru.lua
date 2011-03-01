if GetLocale() ~= "ruRU" then return end

local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "Аргалот"
})

L:SetWarningLocalization({
	WarnFirestormSoon		= "Скоро Огненная буря Скверны"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnFirestormSoon		= "Показывать предупреждение о способности $spell:88972 ",
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
