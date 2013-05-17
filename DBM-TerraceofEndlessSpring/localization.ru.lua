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
	RangeFrame			= "Показывать окно проверки дистанции (8 м) для $spell:111850\n(Показывает всех, если на вас дебафф, иначе только игроков с дебаффом)"
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
	warnHideOver			= "%s has ended"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Спец-способность (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Предупреждение о появлении босса после $spell:123244",
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
	MoveForward					= "Пробегите через босса",
	MoveRight					= "Перейдите направо",
	MoveBack					= "Вернитесь назад",
	specWarnBreathOfFearSoon	= "Скоро дыхание страха - зайдите в конус света!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "Следующая спец-способность",
	timerSpoHudCD			= "Восст. Страх / Изводень",
	timerSpoStrCD			= "Восст. Изводень / Клив",
	timerHudStrCD			= "Восст. Страх / Клив"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "Предупреждать о $spell:119414 когда вы на платформе\n(не рекомендуется, для рейд лидера)",
	specWarnBreathOfFearSoon	= "Предупреждать заранее о $spell:119414, если на вас нет баффа $spell:117964",
	specWarnMovement			= "Спец-предупреждение куда двигаться при выстрелах $spell:120047\n(http://mysticalos.com/terraceofendlesssprings.jpg)",
	timerSpecialAbility			= "Отсчет времени до следующей спец-способности на второй фазе",
	RangeFrame					= "Показывать окно проверки дистанции (2 м) для $spell:119519"
})