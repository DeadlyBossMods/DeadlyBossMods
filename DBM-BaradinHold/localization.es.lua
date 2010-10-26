if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "Argaloth"
})

L:SetWarningLocalization({
	WarnFirestormSoon		= "Tormenta de fuego vil pronto"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnFirestormSoon		= "Mostrar preaviso para $spell:88972",
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})
