if GetLocale() ~= "ruRU" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Смена платформы"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Спец-предупреждение, когда босс меняет платформу",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s летит к одной из своих платформ!",
	Defeat		= "Мы не погрузимся в отчаяние. Если она хочет, чтобы мы погибли – так и будет."
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Показывать стрелку DBM, когда на ком-то $spell:122949 ",
	RangeFrame			= "Окно проверки дистанции (8м) для $spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetOptionLocalization({
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnAmberExplosion			= ">%s< кастует %s",
	warnInterruptsAvailable		= "Сбить %s могут: %s",
	specwarnWillPower			= "Низкая сила воли!",
	specwarnAmberExplosionYou	= "Сбейте СВОЙ %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Amber Montrosity	
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "%s CD: %s"
}

L:SetOptionLocalization({
	warnAmberExplosion			= "Предупреждать (с указанием источника) о начале применения $spell:122398",
	warnInterruptsAvailable		= "Показывать кто может сбить $spell:122402",
	specwarnWillPower			= "Спец-предупреждение, когда уровень силы воли слишком низок",
	specwarnAmberExplosionYou	= "Спец-предупреждение для прерывания своего $spell:122398",
	timerAmberExplosionAMCD		= "Отсчет времени до следующего $spell:122402 у Янтарного чудовища",
	specwarnAmberExplosionAM	= "Спец-предупреждение для прерывания $spell:122402 у Янтарного чудовища",
	specwarnAmberExplosionOther	= "Спец-предупреждение для прерываения $spell:122398 у Мутировавшего организма",	
	InfoFrame					= "Информационное окно для игроков с низким уровнем силы воли"
})

L:SetMiscLocalization({
	WillPower					= "Сила воли"
})


------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame		= "Информационное окно для игроков с $spell:125390",
	RangeFrame		= "Окно проверки дистанции (5м) для $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Сосредоточение",
	YellPhase3		= "Больше никаких оправданий, императрица! Избавься от этих кретинов или я сам убью тебя!"
})
