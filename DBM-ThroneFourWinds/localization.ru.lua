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
	gatherstrength			= "%s близок к обретению абсолютной силы"
})

L:SetOptionLocalization({
	warnSpecial			= "Сообщить о применении Урагана/Зефира/Вихря стали",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Спец-предупреждение о применении особых способностя",
	timerSpecial		= "Отсчет времени до восстановления особых способностей",
	timerSpecialActive	= "Отсчет времени действия особых способностей"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Ал'акир"
})

L:SetWarningLocalization({
	WarnFeedback	= "%s на >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd			= "Появляется Буревик!"
})

L:SetTimerLocalization({
	TimerFeedback 	= "Ответная реакция (%d)",
	TimerAddCD		= "Следующий помощник"
})

L:SetOptionLocalization({
	WarnFeedback	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "unknown"),
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Отсчет времени действия $spell:87904",
	WarnAdd			= "Предупреждать о призыве помощников",
	TimerAddCD		= "Отсчет времени до новых помощников"	
})

L:SetMiscLocalization({
	summonSquall    ="Буря! Приди мне на помощь!", -- or this: Ветра! Повинуйтесь моей воле!
--	phase2          ="Ваши жалкие попытки сопротивления приводят меня в ярость!",--Not used, Acid rain is, but just in case there is reliability issues with that, localize this anyways.
	phase3          ="Довольно! Меня ничто не в силах сдерживать!"
})