if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Конклав Ветра"
})

L:SetWarningLocalization({
	warnSpecial			= "Активация - Урагана/Зефира/Вихря",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Активация особой способности!"
})

L:SetTimerLocalization({
	timerSpecial			= "Перезарядка особой способности",
	timerSpecialActive		= "Активация особой способности"
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	warnSpecial			= "Сообщить о применении Урагана/Зефира/Вихря стали",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Сообщить о применении особых способностя",
	timerSpecial		= "Показать таймер восстановления особых способностей",
	timerSpecialActive	= "Показать таймер длительности особых способностей"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Ал'акир"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
