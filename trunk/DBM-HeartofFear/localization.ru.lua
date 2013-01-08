if GetLocale() ~= "ruRU" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s у %s (%s)",
	specwarnAttenuation	= "%s у %s (%s)",
	specwarnPlatform	= "Смена платформы"
})

L:SetOptionLocalization({
	warnAttenuation		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(127834),
	specwarnAttenuation	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "Спец-предупреждение, когда босс меняет платформу",
	ArrowOnAttenuation	= "Показывать стрелку DBM во время $spell:127834",	
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s летит к одной из своих платформ!",
	Defeat		= "Мы не погрузимся в отчаяние. Если она хочет, чтобы мы погибли – так и будет.",
	Left		= "Налево",
	Right		= "Направо"
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

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Выйдите из фиолетового круга!"
})

L:SetOptionLocalization({
	warnCrush		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(122774),
	specwarnUnder	= "Спец-предупреждение, когда вы стоите под боссом",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).." (только в героическом режиме)",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "под ним",
	Phase2		= "доспех Гаралона начинает трескаться и расползаться"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Повелитель ветров Мел'джарак призывает подкрепление!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s на >%s< (%d)",
	warnReshapeLifeTutor		= "1: Сбить каст/продебаффать цель, 2: Сбить каст себе, 3: Восстановить здоровье/энергию, 4: Выйти",
	warnAmberExplosion			= ">%s< кастует %s",
	warnAmberExplosionAM		= "Янтарное чудовище кастует ВЗРЫВ - СБЕЙТЕ!",--personal warning.
	warnInterruptsAvailable		= "Сбить %s могут: %s",
	warnWillPower				= "Текущая сила воли: %s",
	specwarnWillPower			= "Низкая сила воли! - осталось 5 секунд",
	specwarnAmberExplosionYou	= "Сбейте СВОЙ %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Amber Montrosity	
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "Взрыв: Чудовище"
}

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "Показывать назначение способностей у мутировавшего организма",	
	warnAmberExplosion			= "Предупреждение (с указанием источника) о начале применения $spell:122398",
	warnInterruptsAvailable		= "Показывать кто может сбить $spell:122402",
	warnWillPower				= "Предупреждать об уровне силы воли на 80, 50, 30, 10 и 4.",
	specwarnWillPower			= "Спец-предупреждение, когда уровень силы воли слишком низок",
	specwarnAmberExplosionYou	= "Спец-предупреждение для прерывания своего $spell:122398",
	specwarnAmberExplosionAM	= "Спец-предупреждение для прерывания $spell:122402 у Янтарного чудовища",
	specwarnAmberExplosionOther	= "Спец-предупреждение для прерываения $spell:122398 у Мутировавшего организма",	
	timerAmberExplosionAMCD		= "Отсчет времени до следующего $spell:122402 у Янтарного чудовища",
	InfoFrame					= "Информационное окно для игроков с низким уровнем силы воли",
	FixNameplates				= "Автоматически отключать полоски здоровья у дружественных целей, когда вы в мутировавшем организме\n(восстанавливает настройку после выхода из боя)"	
})

L:SetMiscLocalization({
	WillPower					= "Сила воли"
})


------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Прогресс создания ловушки: (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap	= "Отображать прогресс создания $spell:125826", -- maybe bad translation.
	InfoFrame		= "Информационное окно для игроков с $spell:125390",
	RangeFrame		= "Окно проверки дистанции (5м) для $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Сосредоточение",
	YellPhase3		= "Больше никаких оправданий, императрица! Избавься от этих кретинов или я сам убью тебя!"
})
