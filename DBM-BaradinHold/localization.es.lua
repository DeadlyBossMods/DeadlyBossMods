if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------
--  Argaloth  --
----------------
L = DBM:GetModLocalization("Argaloth")

L:SetGeneralLocalization({
	name = "Argaloth"--translate
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
