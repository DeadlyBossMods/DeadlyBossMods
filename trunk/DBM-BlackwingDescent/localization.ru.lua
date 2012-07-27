if GetLocale() ~= "ruRU" then return end

local L

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetWarningLocalization({
	SpecWarnActivated			= "Смена цели на: %s!",
	specWarnGenerator			= "Генератор энергии - Двигайтесь %s!"
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "Проводник тьмы",
	timerArcaneLockout			= "Волшебный уничтожитель",
	timerArcaneBlowbackCast		= "Чародейская обратная вспышка",
	timerNefAblity				= "Восст. баффа" --Ability Buff CD
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Отсчет времени применения заклинания $spell:92053",
	timerArcaneLockout			= "Отсчет времени блокировки $spell:91542",
	timerArcaneBlowbackCast		= "Отсчет времени применения заклинания $spell:91879",
	timerNefAblity				= "Отсчет времени восстановления баффа (героический режим)",
	SpecWarnActivated			= "Спец-предупреждение при активации нового босса",
	specWarnGenerator			= "Спец-предупреждение, когда босс стоит в $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Устанавливать метку на появившегося босса"
})

L:SetMiscLocalization({
	YellTargetLock				= "На МНЕ - Обрамляющие тени! Прочь от меня!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "Появляется Пыляющее костяное создание! (~4сек)",
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Предупреждать заранее о $spell:92190 (~4сек)",
	RangeFrame		= "Показывать окно проверки дистанции на второй фазе (5м)"
})

L:SetMiscLocalization({
	Slump			= "%s внезапно падает, выставляя клешки!",
	HeadExposed		= "%s насаживается на пику, обнажая голову!",
	YellPhase2		= "Непостижимо! Вы, кажется, можете уничтожить моего лавового червяка! Пожалуй, я помогу ему."
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetOptionLocalization({
	InfoFrame				= "Показывать информационное окно для уровня звуков",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	NefAdd					= "Атрамед, они вон там!",
	Airphase				= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции (6м)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Показывать информационное окно со здоровьем (<10к хп)"
})

L:SetMiscLocalization({
	HealthInfo	= "Инфо о здоровье"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s фаза"
})

L:SetTimerLocalization({
	TimerPhase			= "Следующая фаза"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждать о переходе фаз",
	TimerPhase			= "Показывать таймер до следующей фазы",
	RangeFrame			= "В ходе синей фазы, показывать окно проверки дистанции (6м)",
	SetTextures			= "Автоматически отключить \"Проецирование текстур\" в темной фазе\n(включается обратно при выходе из фазы)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "красный|r пузырек в котел!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "синий|r пузырек в котел!",
	YellGreen			= "зеленый|r пузырек в котел!",
	YellDark			= "магию на котле!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	OnyTailSwipe		= "Удар хвостом (Ониксия)",
	NefTailSwipe		= "Удар хвостом (Нефариан)",
	OnyBreath			= "Дыхание темного огня (Ониксия)",
	NefBreath			= "Дыхание темного огня (Нефариан)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding		= "Приземление Нефариана",
	OnySwipeTimer		= "Удар хвостом - перезарядка (Ониксия)",
	NefSwipeTimer		= "Удар хвостом - перезарядка (Нефариан)",
	OnyBreathTimer		= "Дыхание темного огня (Ониксия)",
	NefBreathTimer		= "Дыхание темного огня (Нефариан)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Предупреждение для $spell:77827 Ониксии",
	NefTailSwipe		= "Предупреждение для $spell:77827 Нефариана",
	OnyBreath			= "Предупреждение для $spell:94124 Ониксии",
	NefBreath			= "Предупреждение для $spell:94124 Нефариана",
	specWarnCinderMove	= "Спец-предупреждение за 5 секунд до взрыва $spell:79339",
	warnShadowblazeSoon	= "Отсчитывать время до $spell:81031 (за 5 секунд до каста)\n(Отсчет пойдет только после первой синхронизации с эмоцией босса)",
	specWarnShadowblazeSoon	= "Предупреждать заранее о $spell:81031\n(За 5 секунд до первого каста, за 1 секунду до каждого следующего)",
	timerNefLanding		= "Отсчет времени до приземления Нефариана",
	OnySwipeTimer		= "Отсчет времени до восстановления $spell:77827 Ониксии",
	NefSwipeTimer		= "Отсчет времени до восстановления $spell:77827 Нефариана",
	OnyBreathTimer		= "Отсчет времени до восстановления $spell:94124 Ониксии",
	NefBreathTimer		= "Отсчет времени до восстановления $spell:94124 Нефариана",
	InfoFrame			= "Показывать информационное окно для Электрического заряда Ониксии",
	SetWater			= "Автоматически отключать настройку Брызги воды\n(Включается обратно при выходе из боя)",	
	TankArrow			= "Показывать стрелку для кайтера Оживших костяных воинов\n(Работает только для стратегии с одним кайтером)",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame			= "Окно проверки дистанции (10м) для $spell:79339\n(Если на вас дебафф - показывает всех, иначе только игроков с метками)"
})

L:SetMiscLocalization({
	NefAoe				= "В воздухе трещат электрические разряды!",
	YellPhase2			= "Дерзкие смертные! Неуважение к чужой собственности нужно пресекать самым жестоким образом!",
	YellPhase3			= "Я пытался следовать законам гостеприимства, но вы всё никак не умрете!",
	YellShadowBlaze		= "И плоть превратится в прах!",
	ShadowBlazeExact		= "Вспышка пламени тени через %d",
	ShadowBlazeEstimate		= "Скоро вспышка пламени тени (~5с)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Существа Твердыни Крыла Тьмы"
})
