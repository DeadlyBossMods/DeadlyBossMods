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
	Arcanotron	= "Чаротрон",
	SayBomb		= "На МНЕ Химическая бомба!"
})

L:SetOptionLocalization({
	SayBombTarget	= "Сказать в чат о том что вы являетесь целью способности $spell:80157",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094)
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Малориак"
})

L:SetWarningLocalization({
	WarnPhase		= "%s фаза",
	WarnRemainingAdds	= "Осталось %d аберрации"
})

L:SetTimerLocalization({
	TimerPhase		= "Следующая фаза"
})

L:SetMiscLocalization({
	YellRed			= "Mix and stir, apply heat...",
	YellBlue		= "How well does the mortal shell handle extreme temperature change? Must find out! For science!",
	YellGreen		= "This one's a little unstable, but what's progress without failure?",
	YellDark		= "Your mixtures are weak, Maloriak! They need a bit more... kick!",
	Red			= "Красный",
	Blue			= "Синий",
	Green			= "Зеленый",
	Dark			= "Тёмный"
})

L:SetOptionLocalization({
	WarnPhase		= "Показывать предупреждения о том какая фаза наступает",
	WarnRemainingAdds	= "Показывать предупреждения о том сколько осталось аберрации",
	TimerPhase		= "Показать таймер до следующей фазы",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
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
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown")
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
	Airphase		= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Показывать предупреждение когда Атрамед взлетает",
	WarnGroundphase		= "Показывать предупреждение когда Атрамед приземляется",
	WarnShieldsLeft		= "Показывать предупреждение когда используется Древний дворфийский щит",
	TimerAirphase		= "Показывать таймер до следующей воздушной фазы",
	TimerGroundphase	= "Показывать таймер до следующей наземной фазы"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Нефариан"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellPhase2		= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	ChromaticPrototype	= "Хроматический прообраз"
})

L:SetOptionLocalization({
})
