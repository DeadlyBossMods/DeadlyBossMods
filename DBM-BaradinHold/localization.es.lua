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
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})

----------------
--  Occu'thar  --
----------------
L = DBM:GetModLocalization("Occuthar")

L:SetGeneralLocalization({
	name = "Occu'thar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
