if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Магмарь"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Появляется Пыляющее костяное создание! (~4сек)",
})

L:SetTimerLocalization({
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

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Защитная система Омнотрона"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Смена цели на: %s!",
	specWarnGenerator			= "Генератор энергии - Двигайтесь %s!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Чародейская обратная вспышка",
	timerShadowConductorCast	= "Проводник тьмы",
	timerNefAblity				= "Восст. баффа", --Ability Buff CD
	timerArcaneLockout			= "Волшебный уничтожитель"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Отсчет времени применения заклинания $spell:92053",
	timerArcaneBlowbackCast		= "Отсчет времени применения заклинания $spell:91879",
	timerArcaneLockout			= "Отсчет времени блокировки $spell:91542",
	timerNefAblity				= "Отсчет времени восстановления баффа (героический режим)",
	SpecWarnActivated			= "Спец-предупреждение при активации нового босса",
	specWarnGenerator			= "Спец-предупреждение, когда босс стоит в $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Устанавливать метку на появившегося босса"
})

L:SetMiscLocalization({
	Magmatron					= "Магматрон",
	Electron					= "Электрон",
	Toxitron					= "Токситрон",
	Arcanotron					= "Чаротрон",
	YellTargetLock				= "На МНЕ - Обрамляющие тени! Прочь от меня!"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Малориак"
})

L:SetWarningLocalization({
	WarnPhase			= "%s фаза",
	WarnRemainingAdds	= "Осталось аберраций: %d"
})

L:SetTimerLocalization({
	TimerPhase			= "Следующая фаза"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждать о переходе фаз",
	WarnRemainingAdds	= "Предупреждать об оставшемся количестве аберраций",
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
	YellDark			= "магию на котле!",
	Red		     		= "Огненная",
	Blue				= "Ледяная",
	Green				= "Кислотная",
	Dark				= "Тёмная"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Химерон"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции (6м)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Показывать информационное окно со здоровьем (<10к хп)"
})

L:SetMiscLocalization({
	HealthInfo	= "Инфо о здоровье"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Атрамед"
})

L:SetWarningLocalization({
	WarnAirphase			= "Воздушная фаза",
	WarnGroundphase			= "Наземная фаза",
	WarnShieldsLeft			= "Древний дворфийский щит - %d осталось",
	warnAddSoon				= "Призван Гнусный бес",
	specWarnAddTargetable	= "%s - активен"
})

L:SetTimerLocalization({
	TimerAirphase			= "Воздушная фаза",
	TimerGroundphase		= "Наземная фаза"
})

L:SetOptionLocalization({
	WarnAirphase			= "Предупреждение, когда Атрамед взлетает",
	WarnGroundphase			= "Предупреждение, когда Атрамед приземляется",
	WarnShieldsLeft			= "Предупреждение, когда используется Древний дворфийский щит",
	warnAddSoon				= "Предупреждение, когда Нефариан призывает помощников",
	specWarnAddTargetable	= "Спец-предупреждение, когда Гнусного беса можно взять в цель",
	TimerAirphase			= "Отсчет времени до следующей воздушной фазы",
	TimerGroundphase		= "Отсчет времени до следующей наземной фазы",
	InfoFrame				= "Показывать информационное окно для уровня звуков",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Древний дворфийский щит",
	Soundlevel				= "Уровень звука",
	YellPestered			= "На МНЕ - Гнусный бес!",--npc 49740
	NefAdd					= "Атрамед, они вон там!",
	Airphase				= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Нефариан"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Удар хвостом (Ониксия)",
	NefTailSwipe		= "Удар хвостом (Нефариан)",
	OnyBreath			= "Дыхание темного огня (Ониксия)",
	NefBreath			= "Дыхание темного огня (Нефариан)",
	specWarnShadowblazeSoon	= "Скоро Пламя тени (~5с)"
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
	specWarnShadowblazeSoon	= "Предупреждение для $spell:94085 (~5с)",
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
	Nefarian			= "Нефариан",
	Onyxia				= "Ониксия",
	Charge				= "Электрический заряд"
})

--------------
--  Blackwing Descent Trash  --
--------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Существа Твердыни Крыла Тьмы"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})