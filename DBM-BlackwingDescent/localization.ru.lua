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
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s внезапно падает, выставляя клешки!",
	HeadExposed		= "%s насаживается на пику, обнажая голову!"
})

L:SetOptionLocalization({
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
})

L:SetMiscLocalization({
	Magmatron	= "Магматрон",
	Electron	= "Электрон",
	Toxitron	= "Токситрон",
	Arcanotron	= "Чаротрон"
})

L:SetOptionLocalization({
	AcquiringTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
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
	WarnRemainingAdds	= "Осталось %d аберрации"
})

L:SetTimerLocalization({
	TimerPhase		= "Следующая фаза"
})

L:SetMiscLocalization({
	YellRed			= "красный|r пузырек в котел!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue		= "синий|r пузырек в котел!",
	YellGreen		= "зеленый|r пузырек в котел!",
	YellDark		= "магию на котле!",--guesswork, this isn't confirmed but if it's consistent with other strings is probably right.
	Red		     	= "Огненная",
	Blue			= "Ледяная",
	Green			= "Кислотная",
	Dark			= "Тёмная"
})

L:SetOptionLocalization({
	WarnPhase			= "Показывать предупреждения о том какая фаза наступает",
	WarnRemainingAdds	= "Показывать предупреждения о том сколько осталось аберрации",
	TimerPhase			= "Показать таймер до следующей фазы",
	RangeFrame			= "В ходе синей фазы, показать окно проверки дистанции (6)",
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
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Показывать предупреждение о начале 2-ой фазы",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	RangeFrame		= "Окно проверки дистанции (6)"
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
	Airphase		= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Показывать предупреждение когда Атрамед взлетает",
	WarnGroundphase		= "Показывать предупреждение когда Атрамед приземляется",
	WarnShieldsLeft		= "Показывать предупреждение когда используется Древний дворфийский щит",
	TimerAirphase		= "Показывать таймер до следующей воздушной фазы",
	TimerGroundphase	= "Показывать таймер до следующей наземной фазы",
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
	NefBreathTimer		= "Показывать таймер перезарядки для $spell:94124 Нефариана"
})

L:SetMiscLocalization({
	NefAoe				= "В воздухе трещат электрические разряды!",
	YellPhase2			= "Дерзкие смертные! Неуважение к чужой собственности нужно пресекать самым жестоким образом!",
	ShadowblazeCast		= "И плоть превратится в прах!",
	ChromaticPrototype	= "Хроматический прообраз"
})