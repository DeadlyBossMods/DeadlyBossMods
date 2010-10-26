if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Cónclave del Viento"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

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
