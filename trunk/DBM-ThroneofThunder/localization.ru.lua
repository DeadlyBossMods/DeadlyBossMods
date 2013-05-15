if GetLocale() ~= "ruRU" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "Скоро %s - выйдите из Проводящей воды!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Спец-предупреждение, если вы стоите в $spell:138470\n(В случае, если скоро $spell:137313 или спадает дебафф $spell:138732)",
	RangeFrame			= "Показывать окно проверки дистанции (8/4 м)"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Появилась сфера контроля",
	specWarnOrbofControl	= "Появилась сфера контроля!"
})

L:SetTimerLocalization({
	timerDoor				= "Следующие ворота племени",
	timerAdds				= "Следующие %s"
})

L:SetOptionLocalization({
	warnAdds				= "Объявлять когда спрыгивают новые адды",
	warnOrbofControl		= "Предупреждение о появлении $journal:7092",
	specWarnOrbofControl	= "Спец-предупреждение о появлении $journal:7092",
	timerDoor				= "Отсчёт времени до следующей фазы ворот племени",
	timerAdds				= "Отсчёт времени до спрыгивания следующих аддов",
	RangeFrame				= "Показывать окно проверки дистанции (5 м) для $spell:136480"
})

L:SetMiscLocalization({
	newForces				= "прибывают из-за ворот",--Войска племени Амани прибывают из-за ворот племени Амани!
	chargeTarget			= "бьет хвостом!"--Хорридон останавливает свой взгляд на Тентаклюме и бьет хвостом!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s на %s - переключитесь"
})

L:SetOptionLocalization({
	PHealthFrame		= "Показывать оставшееся здоровье босса до спадения $spell:136442\n(Требуется включить окно отображения здоровья босса)",
	RangeFrame			= "Показывать окно проверки дистанции",
	AnnounceCooldowns	= "Отсчитывать (до 3) какой сейчас каст $spell:137166 для рейдовых кулдаунов",
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s использован >%s< (осталось %d)",
	specWarnCrystalShell	= "Получите %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Спец-предупреждение, когда на Вас нет дебаффа $spell:137633",
	InfoFrame				= "Информационное окно для игроков без $spell:137633",
	SetIconOnTurtles		= "Устанавливать метки на $journal:7129",
	ClearIconOnTurtles		= "Убирать метки с $journal:7129, когда активируется $spell:133971",
	AnnounceCooldowns		= "Отсчитывать какой сейчас каст $spell:134920 для рейдовых кулдаунов"
})

L:SetMiscLocalization({
	WrongDebuff				= "Нет %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "Следующее дыхание"
})

L:SetOptionLocalization({
	timerBreaths			= "Отсчёт времени до следующего дыхания",
	AnnounceCooldowns		= "Отсчитывать какой сейчас каст Буйство для рейдовых кулдаунов",
	Never					= "Никогда",
	Every					= "Каждый (последовательно)",
	EveryTwo				= "Кулдауны каждый 2",
	EveryThree				= "Кулдауны каждый 3",
	EveryTwoExcludeDiff		= "Кулдауны каждый 2 (искл. Диффузия)",
	EveryThreeExcludeDiff	= "Кулдауны каждый 3 (искл. Диффузия)"
})

L:SetMiscLocalization({
	rampageEnds				= "Ярость Мегеры идет на убыль."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "Страж гнезда: %s",
	specWarnBigBirdSoon	= "Скоро Страж гнезда: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Выводок (%d): %s"
})

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции (10 м) для $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "Яйца в одном из нижних гнезд начинают проклевываться!",
	eggsHatchU		= "Яйца в одном из верхних гнезд начинают проклевываться!",
	Upper			= "Верхний",
	Lower			= "Нижний",
	UpperAndLower	= "Верхний и Нижний",
	TrippleD		= "Тройной (2 нижних)",
	TrippleU		= "Тройной (2 верхних)",
	SouthWest		= "ЮЗ",
	SouthEast		= "ЮВ",
	NorthWest		= "СЗ",
	NorthEast		= "СВ",
	West			= "З",
	Middle			= "Середина"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Лучи - |cffff0000Красный|r : >%s<, |cff0000ffСиний|r : >%s<",
	warnBeamHeroic				= "Лучи - |cffff0000Красный|r : >%s<, |cff0000ffСиний|r : >%s<, |cffffff00Желтый|r : >%s<",
	warnAddsLeft				= "Туманов осталось: %d",
	specWarnBlueBeam			= "Синий луч на Вас - избегайте движения!",
	specWarnFogRevealed			= "%s обнаружен!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Объявлять цели лучей",
	warnAddsLeft				= "Объявлять сколько осталось туманов",
	specWarnFogRevealed			= "Спец-предупреждение при обнаружении туманов",
	ArrowOnBeam					= "Показывать стрелку DBM во время $journal:6882, чтобы указать, в каком направлении двигаться",
	InfoFrame					= "Информационное окно для кол-ва стаков $spell:133795",
	SetParticle					= "Автоматически устанавливать минимальную плотность частиц на пулле\n(Настройка восстановится после выхода из боя)"
})

L:SetMiscLocalization({
	LifeYell		= "Похищение жизни на %s (%d)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Прогресс мутации: %d/5 хороших и %d плохих"
})

L:SetOptionLocalization({
	warnDebuffCount				= "Показывать предупреждения о числе дебаффов, когда Вы поглощаете лужи",
	RangeFrame					= "Показывать окно проверки дистанции (5/2 м)",
	SetIconOnBigOoze			= "Устанавливать метки на $journal:6969"
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
	Pull				= "Сфера взрывается!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone		= "%s: %s и %s защитованы"
})

L:SetOptionLocalization({
	RangeFrame			= "Показывать динамическое окно проверки дистанции (10 м)",
	InfoFrame			= "Информационное окно для игроков с $spell:136193"
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
	timerDayCD		= "След. дневная фаза",
	timerDuskCD		= "След. фаза сумерек"
})

L:SetOptionLocalization({
	warnNight		= "Объявлять ночную фазу",
	warnDay			= "Объявлять дневную фазу",
	warnDusk		= "Объявлять фазу сумерек",
	timerDayCD		= "Отсчёт времени до следующей дневной фазы",
	timerDuskCD		= "Отсчёт времени до следующей фазы сумерек",
	RangeFrame		= "Показывать окно проверки дистанции (8 м)"
})

L:SetMiscLocalization({
	DuskPhase		= "Мне нужна твоя сила, Лу'линь!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Скоро смена фаз"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Спец-предупреждение перед началом промежуточной фазы",
	RangeFrame					= "Показывать окно проверки дистанции (8/6 м)",--Для двух разных спеллов
	StaticShockArrow			= "Показывать стрелку DBM, когда на ком-то $spell:135695",
	OverchargeArrow				= "Показывать стрелку DBM, когда на ком-то $spell:136295"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetMiscLocalization({
	Defeat		= "Остановитесь! Я… не враг вам."
})

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