if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
