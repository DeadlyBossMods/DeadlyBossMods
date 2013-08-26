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
	specWarnWaterMove	= "Спец-предупреждение, если вы стоите в $spell:138470<br/>(В случае, если скоро $spell:137313 или спадает дебафф $spell:138732)"
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
	SetIconOnAdds			= "Устанавливать метки на аддов, спрыгивающих с балкона"
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
	PHealthFrame		= "Показывать оставшееся здоровье босса до спадения $spell:136442<br/>(Требуется включить окно отображения здоровья босса)",
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
	specWarnCrystalShell	= "Спец-предупреждение, когда на Вас нет дебаффа $spell:137633 и более 90% здоровья",
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
	ShowNestArrows		= "Показывать стрелку DBM при активации гнезд",
	Never				= "Никогда",
	Northeast			= "Синий - Низ & Верх СВ",
	Southeast			= "Зеленый - Низ & Верх ЮВ",
	Southwest			= "Фиолетовый/Красный - Низ ЮЗ & Верх ЮЗ(25) или Верх Центр(10)",
	West				= "Красный - Низ З & Верх Центр (только 25)",
	Northwest			= "Желтый - Низ & Верх СЗ (только 25)",
	Guardians			= "Стражи гнезда"
})

L:SetMiscLocalization({
	eggsHatch		= "гнезд начинают проклевываться!",
	Upper			= "Верхний",
	Lower			= "Нижний",
	UpperAndLower	= "Верхний и Нижний",
	TrippleD		= "Тройной (2 нижних)",
	TrippleU		= "Тройной (2 верхних)",
	NorthEast		= "|cff0000ffСВ|r",--Синий
	SouthEast		= "|cFF088A08ЮВ|r",--Зеленый
	SouthWest		= "|cFF9932CDЮЗ|r",--Фиолетовый
	West			= "|cffff0000З|r",--Красный
	NorthWest		= "|cffffff00СЗ|r",--Желтый
	Middle10		= "|cFF9932CDЦентр|r",--Фиолетовый (Центр это верх юго-запад для 10 ппл/LFR)
	Middle25		= "|cffff0000Центр|r"--Красный (Центр это верх запад для 25 ппл)
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
	SetParticle					= "Автоматически устанавливать минимальную плотность частиц на пулле<br/>(Настройка восстановится после выхода из боя)"
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

L:SetMiscLocalization({
	DuskPhase		= "Мне нужна твоя сила, Лу'линь!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Скоро смена фаз",
	warnDiffusionChainSpread	= "%s распространилось на >%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "Восст. первый проводник"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Спец-предупреждение перед началом промежуточной фазы",
	warnDiffusionChainSpread	= "Объявлять цели распространения $spell:135991",
	timerConduitCD				= "Отсчет времени до восстановления способности первого проводника",
	StaticShockArrow			= "Показывать стрелку DBM, когда на ком-то $spell:135695",
	OverchargeArrow				= "Показывать стрелку DBM, когда на ком-то $spell:136295"
})

L:SetMiscLocalization({
	StaticYell		= "Статический шок на %s (%d)"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnVitaSoaker			= "Нестабильная жизнь - Вы следующий!",
	warnVitaSoakerSoon			= "Вы второй в очереди на получение Нестабильная жизнь",
	specWarnUnstablVitaJump		= "Нестабильная жизнь перепрыгнула на вас!"
})

L:SetOptionLocalization({
	warnVitaSoakerSoon		= "Объявлять когда вы второй в очереди на получение $spell:138297 (Требуется включить информационное окно)",
	specWarnUnstablVitaJump	= "Спец-предупреждение когда $spell:138297 перепрыгивает на вас",
	specWarnVitaSoaker		= "Спец-предупреждение когда вы следующий в очереди на получение $spell:138297, основываясь на позиции в информационом окне (Требуется включить информационное окно)",
	SetIconsOnVita			= "Устанавливать метки на игрока с дебаффом $spell:138297 и самого дальнего от него игрока",
	InfoFrame				= "Информационное окно последовательности получения $spell:138297 игроками без $spell:138372 (кроме танков)",
	AnnounceVitaSoaker		= "Объявлять с помощью рейдовых предупреждений кто должен получить $spell:138297 следующим (требуется Лидер рейда)"
})

L:SetMiscLocalization({
	Defeat						= "Остановитесь! Я… не враг вам.",
	NoSensitivity				= "Последовательность получения Жизни",
	VitaSoakerOptionConflict	= "Предупреждение: Вы включили предупреждения для Нестабильная жизнь, но отключили информационное окно. Предупреждения не будут работать без информационного окна!",
	VitaChatMessage				= "Следующим получает Нестабильная жизнь: %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name 			= "Трэш мобы Престола Гроз"
})
