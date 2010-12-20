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
	warnSpecial			= "Huracan/Céfiro/Tormenta de granizo activados",
	specWarnSpecial		= "¡Habilidades especiales activas!"
})

L:SetTimerLocalization({
	timerSpecial			= "Habilidades especiales CD",
	timerSpecialActive		= "Habilidades especiales activas"
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	warnSpecial			= "Mostrar aviso cuando Huracan/Céfiro/Tormenta de granizo sean lanzados",
	specWarnSpecial		= "Mostrar aviso especial cuando se lanzan habilidades especiales",
	timerSpecial		= "Mostrar cooldown de habilidades especiales",
	timerSpecialActive	= "Mostrar tiempo de duración de habilidades especiales"
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
