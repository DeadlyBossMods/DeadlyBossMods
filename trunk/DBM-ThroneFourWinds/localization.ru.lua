if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Активация - Урагана/Зефира/Вихря",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Активация особой способности!",
	warnSpecialSoon		= "Особые способности через 10 сек!"
})

L:SetTimerLocalization({
	timerSpecial		= "Перезарядка особой способности",
	timerSpecialActive	= "Активация особой способности"
})

L:SetOptionLocalization({
	warnSpecial			= "Сообщить о применении Урагана/Зефира/Вихря стали",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Спец-предупреждение о применении особых способностя",
	timerSpecial		= "Отсчет времени до восстановления особых способностей",
	timerSpecialActive	= "Отсчет времени действия особых способностей",
	warnSpecialSoon		= "Показывать предупреждение за 10 секунд до применения особых способностей",
	OnlyWarnforMyTarget	= "Показывать только таймеры/предупреждения для текуйщей цели и фокуса\n(Скрывает все остальное. ВКЛЮЧАЯ ПУЛЛ)"
})

L:SetMiscLocalization({
	gatherstrength		= "%s близок к обретению абсолютной силы"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 	= "Ответная реакция (%d)"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Отсчет времени действия $spell:87904",
	RangeFrame		= "Показывать окно проверки дистанции (20), когда на вас $spell:89668"
})
