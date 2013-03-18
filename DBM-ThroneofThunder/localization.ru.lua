if GetLocale() ~= "ruRU" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds		= "%s",
	warnOrbofControl	= "Сфера контроля упала",
	specWarnOrbofControl	= "Сфера контроля упала!"
})

L:SetTimerLocalization({
	timerDoor		= "Следующие ворота племени",
	timerAdds		= "Следующие %s"
})

L:SetOptionLocalization({
	warnAdds		= "Объявлять когда спрыгивают новые адды",
	warnOrbofControl	= "Объявлять когда падает $journal:7092",
	specWarnOrbofControl	= "Спец-предупреждение когда падает $journal:7092",
	timerDoor		= "Отображать таймер до следующей фазы ворот племени",
	timerAdds		= "Отображать таймер до спрыгивания следующих аддов"
})

L:SetMiscLocalization({
	newForces		= "прибывают из-за ворот",--Войска племени Амани прибывают из-за ворот племени Амани!
	chargeTarget		= "бьет хвостом!"--Хорридон останавливает свой взгляд на Тентаклюме и бьет хвостом!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s на %s - смените цель"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	warnSandBolt		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	PHealthFrame		= "Показывать оставшееся здоровье босса до спадения $spell:136442\n(Требуется включить окно отображения здоровья босса)",
	RangeFrame		= "Показывать окно проверки дистанции"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell		= "%s использован >%s< (осталось %d)",
	specWarnCrystalShell	= "Получите %s"
})

L:SetOptionLocalization({
	warnKickShell		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Спец-предупреждение когда на Вас нет дебаффа $spell:137633",
	InfoFrame		= "Информационное окно для игроков без $spell:137633",
	SetIconOnTurtles	= "Ставить метки на $journal:7129 \n(Может быть не надежно, если помощник более чем у 1 человека)"
})

L:SetMiscLocalization({
	WrongDebuff		= "Нет %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds		= "Ярость Мегеры идет на убыль."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%s)",
	specWarnFlock		= "%s %s (%s)"
})

L:SetTimerLocalization({
	timerFlockCD		= "Выводок (%d): %s"
})

L:SetOptionLocalization({
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD		= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame		= "Показывать окно проверки дистанции (8 м) для $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "Яйца в одном из нижних гнезд начинают проклевываться!",
	eggsHatchU		= "Яйца в одном из верхних гнезд начинают проклевываться!",
	Upper			= "Верхний",
	Lower			= "Нижний",
	UpperAndLower		= "Верхний и Нижний"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnAddsLeft			= "Туманов осталось: %d",
	specWarnFogRevealed		= "%s обнаружен!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnAddsLeft			= "Объявлять сколько осталось туманов",
	specWarnFogRevealed		= "Спец-предупреждение когда обнаружен туман",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam			= "Показывать стрелку DBM во время $journal:6882, чтобы указать, в каком направлении двигаться",
	SetIconRays			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891")
})

L:SetMiscLocalization({
	Eye				= "глаз"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame			= "Показывать окно проверки дистанции (5/2 м)"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< и >%s< поменялись"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Объявлять цели, измененные $spell:138618"
})

L:SetMiscLocalization({
	Pull			= "Сфера взрывается!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone		= "%s: %s и %s защитованы"
})

L:SetOptionLocalization({
	warnDeadZone		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	RangeFrame		= "Показывать динамическое окно проверки дистанции",
	InfoFrame		= "Информационное окно для игроков с $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "Ночная фаза",
	warnDay			= "Дневная фаза",
	warnDusk		= "Фаза сумерек"
})

L:SetTimerLocalization({
	timerDayCD		= "Следущая дневная фаза",
	timerDuskCD		= "Следущая фаза сумерек"
})

L:SetOptionLocalization({
	warnNight		= "Объявлять ночную фазу",
	warnDay			= "Объявлять дневную фазу",
	warnDusk		= "Объявлять фазу сумерек",
	timerDayCD		= "Отображать таймер до следующей дневной фазы",
	timerDuskCD		= "Отображать таймер до следующей фазы сумерек",
	RangeFrame		= "Показывать окно проверки дистанции (8 м)"
})

L:SetMiscLocalization({
	--DuskPhase		= "Lu'lin! Lend me your strength!"--Not in use, but a backup just in case, so translate in case it's switched to on moments notice on live or next PTR test
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции",--Для двух разных спеллов
	StaticShockArrow	= "Показывать стрелку DBM когда на ком-то $spell:135695",
	OverchargeArrow		= "Показывать стрелку DBM когда на ком-то $spell:136295",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name 			= "Трэш мобы Престола Гроз"
})

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции (10 м)"--Для 3 разных спеллов
})
