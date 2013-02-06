if GetLocale() ~= "ruRU" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Ротация: группа %s",
	specWarnYourGroup	= "Ваша группа должна получить дебафф!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Объявлять ротацию для $spell:118191\n(Опция расчитана на стратегию для 25-ппл: 5,2,2,2, и т.д.)",
	specWarnYourGroup	= "Спец-предупреждение, когда ваша группа должна получить $spell:118191\n(только для 25-ппл)",
	RangeFrame			= "Показывать окно проверки дистанции (8 м) для $spell:111850\n(Показывает всех, если на вас дебафф, иначе только игроков с дебаффом)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Спасибо вам, незнакомцы. Я свободен."
}
 

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s has ended",
	warnHideProgress		= "Ударов: %s. Урон: %s. Время: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Спец-способность (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Предупреждение о появлении босса после $spell:123244",
	warnHideProgress		= "Показывать статистику после завершения $spell:123244",
	timerSpecialCD			= "Отсчет времени до следующей спец-способности",
	SetIconOnProtector		= "Ставить метки на $journal:6224",
	RangeFrame				= "Показывать окно проверки дистанции (3 м) для $spell:123121\n(Показывает всех во время $spell:123244, иначе только танков)",
	GWHealthFrame			= "Показывать полоску здоровья босса для $spell:123461" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory	= "Я... а... о! Я?.. Все было таким... мутным."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	warnWaterspout				= "%s (%d) : %s",
	warnHuddleInTerror			= "%s (%d) : %s",
	MoveWarningForward			= "Пробегите через босса",
	MoveWarningRight			= "Перейдите направо",
	MoveWarningBack				= "Вернитесь назад",
	specWarnBreathOfFearSoon	= "Скоро дыхание страха - зайдите в конус света!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Следующая спец-способность",
	timerSpoHudCD				= "Страх / Изводень CD",
	timerSpoStrCD				= "Изводень / Клив CD",
	timerHudStrCD				= "Страх / Клив CD"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "Предупреждать заранее о $spell:119414 (если на вас нет $spell:117964)",
	SetIconOnHuddle				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	RangeFrame					= "Показывать окно проверки дистанции (2 м) для $spell:119519",
	MoveWarningForward			= "Предупреждать, когда нужно пробежать через босса во время $spell:120047",
	MoveWarningRight			= "Предупреждать, когда нужно перейти направо, во время $spell:120047",
	MoveWarningBack				= "Предупреждать, когда нужно вернуть назад, во время $spell:120047",
	warnWaterspout				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120519),
	warnHuddleInTerror			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120629),
	timerSpecialAbilityCD		= "Отсчет времени до следующей спец-способности на второй фазе",
	timerSpoHudCD				= "Отсчет времени до следующих возможных $spell:120629 или $spell:120519",
	timerSpoStrCD				= "Отсчет времени до следующих возможных $spell:120519 или $spell:120672",
	timerHudStrCD				= "Отсчет времени до следующих возможных $spell:120629 или $spell:120672"
})
