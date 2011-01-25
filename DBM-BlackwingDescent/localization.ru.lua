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
	WarnPhase2Soon	= "Скоро 2-ая фаза"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s внезапно падает, выставляя клешки!",
	HeadExposed		= "%s насаживается на пику, обнажая голову!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Предупреждать заранее о $spell:92190 (~4сек)",
	WarnPhase2Soon	= "Предупреждать заранее о переходе во вторую фазу",
	RangeFrame		= "Показывать окно проверки дистанции на второй фазе (8м)"
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Защитная система Омнотрона"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Чародейская обратная вспышка",
	timerShadowConductorCast	= "Проводник тьмы"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Показывать таймер применения $spell:92053",
	timerArcaneBlowbackCast		= "Показывать таймер применения $spell:91879",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron		= "Магматрон",
	Electron		= "Электрон",
	Toxitron		= "Токситрон",
	Arcanotron		= "Чаротрон"
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
	TimerPhase		= "Следующая фаза"
})

L:SetMiscLocalization({
	YellRed			= "красный|r пузырек в котел!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue		= "синий|r пузырек в котел!",
	YellGreen		= "зеленый|r пузырек в котел!",
	YellDark		= "магию на котле!",
	Red		     	= "Огненная",
	Blue			= "Ледяная",
	Green			= "Кислотная",
	Dark			= "Тёмная"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждать о переходе фаз",
	WarnRemainingAdds	= "Предупреждать об оставшемся количестве аберраций",
	TimerPhase			= "Показывать таймер до следующей фазы",
	RangeFrame			= "В ходе синей фазы, показывать окно проверки дистанции (6м)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Химерон"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Скоро 2-ая фаза",
	WarnBreak	= "%s на >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	HealthInfo	= "Инфо о здоровье"
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Показывать предупреждение о начале 2-ой фазы",
	RangeFrame		= "Показывать окно проверки дистанции (6м)",
	WarnBreak		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Показывать информационное окно со здоровьем (<10к хп)"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Атрамед"
})

L:SetWarningLocalization({
	WarnAirphase		= "Воздушная фаза",
	WarnGroundphase		= "Наземная фаза",
	WarnShieldsLeft		= "Древний дворфийский щит - %d осталось"
})

L:SetTimerLocalization({
	TimerAirphase		= "Воздушная фаза",
	TimerGroundphase	= "Наземная фаза"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Древний дворфийский щит",
	Soundlevel				= "Уровень звука",
	Airphase				= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Показывать предупреждение когда Атрамед взлетает",
	WarnGroundphase		= "Показывать предупреждение когда Атрамед приземляется",
	WarnShieldsLeft		= "Показывать предупреждение когда используется Древний дворфийский щит",
	TimerAirphase		= "Показывать таймер до следующей воздушной фазы",
	TimerGroundphase	= "Показывать таймер до следующей наземной фазы",
	InfoFrame			= "Показывать информационное окно для уровня звуков",
	TrackingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
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
	NefBreath			= "Дыхание темного огня (Нефариан)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Удар хвостом - перезарядка (Ониксия)",
	NefSwipeTimer		= "Удар хвостом - перезарядка (Нефариан)",
	OnyBreathTimer		= "Дыхание темного огня (Ониксия)",
	NefBreathTimer		= "Дыхание темного огня (Нефариан)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Показывать предупреждение для $spell:77827 Ониксии",
	NefTailSwipe		= "Показывать предупреждение для $spell:77827 Нефариана",
	OnyBreath			= "Показывать предупреждение для $spell:94124 Ониксии",
	NefBreath			= "Показывать предупреждение для $spell:94124 Нефариана",
	OnySwipeTimer		= "Показывать таймер перезарядки для $spell:77827 Ониксии",
	NefSwipeTimer		= "Показывать таймер перезарядки для $spell:77827 Нефариана",
	OnyBreathTimer		= "Показывать таймер перезарядки для $spell:94124 Ониксии",
	NefBreathTimer		= "Показывать таймер перезарядки для $spell:94124 Нефариана",
	YellOnCinder		= "Кричать, когда на вас $spell:79339",
	RangeFrame			= "Показывать окно проверки дистанции (10м) когда на вас $spell:79339",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe				= "В воздухе трещат электрические разряды!",
	YellPhase2			= "Дерзкие смертные! Неуважение к чужой собственности нужно пресекать самым жестоким образом!",
	YellPhase3			= "Я пытался следовать законам гостеприимства, но вы все никак не умрете! Придется отбросить условности и просто... УБИТЬ ВАС ВСЕХ!",
	YellCinder			= "На МНЕ - Взрывчатая субстанция!"
})