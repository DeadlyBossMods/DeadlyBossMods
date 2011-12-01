if GetLocale() ~= "ruRU" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
--L= DBM:GetModLocalization(156)
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Халфий Змеерез"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Показать здоровье подчиненного дракона\n(Должна быть включена опции отображения здоровья босса)"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
--L= DBM:GetModLocalization(157)
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Валиона и Тералион"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Предупреждение о $spell:92898, когда активно $spell:86788",
	TwilightBlastArrow		= "Показывать стрелку DBM, когда $spell:92898 около вас",
	RangeFrame				= "Показывать окно проверки дистанции (10м)",
	BlackoutShieldFrame		= "Показывать полоску здоровья для $spell:92878",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Глубокий вдох",
	BlackoutTarget			= "Затмение: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
--L= DBM:GetModLocalization(158)
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Совет Перерожденных"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s ниже 30%% - скоро следующая фаза!",
	SpecWarnGrounded		= "Получите ауру заземления!",
	SpecWarnSearingWinds	= "Получите ауру кружащихся ветров!"
})

L:SetTimerLocalization({
	timerTransition			= "Смена фаз"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Спец-предупреждение, когда здоровье боссов опускается до 30%",
	SpecWarnGrounded		= "Спец-предупреждение, когда у вас не хватает ауры $spell:83581\n(~10сек перед началом применения)",
	SpecWarnSearingWinds	= "Спец-предупреждение, когда у вас не хватает ауры $spell:83500\n(~10сек перед началом применения)",
	timerTransition			= "Показывать таймер перехода в другую фазу",
	RangeFrame				= "Автоматически показывать окно проверки дистанции при надобности",
	yellScrewed				= "Кричать, когда на вас одновременно $spell:83099 и $spell:92307",	
	InfoFrame				= "Показывать игроков без $spell:83581 или $spell:83500",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake					= "Земля уходит у вас из-под ног...", -- Yell string: Земля поглатит вас!
	Thundershock			= "Воздух потрескивает от скопившейся энергии...", -- Yell string: Ветер, явись на мой зов!
	Switch					= "Закончим этот фарс!",--"We will handle them!" comes 3 seconds after this one
	Phase3					= "Ваше упорство...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Ignacious				= "Огнис",
	Feludius				= "Акварион",
	Arion					= "Аэрон",
	Terrastra				= "Террастра",
	Monstrosity				= "Элементиевое чудовище",
	Kill					= "Невозможно....",
	blizzHatesMe			= "Сфера и громотвод на МНЕ! С ДОРОГИ!!!",--You're probably fucked, and gonna kill half your raid if this happens, but worth a try anyways :).
	WrongDebuff				= "Отсутствует %s"
})

----------------
--  Cho'gall  --
----------------
--L= DBM:GetModLocalization(167)
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Чо'Галл"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	CorruptingCrashArrow	= "Показывать стрелку DBM, когда $spell:93178 около вас",
	InfoFrame				= "Показывать информационное окно для $spell:81701",
	RangeFrame				= "Показывать окно проверки дистанции (5м) для $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "Устанавливать метки на Смутные творения"
})

L:SetMiscLocalization({
	Bloodlevel				= "Порча"
})

----------------
--  Sinestra  --
----------------
--L= DBM:GetModLocalization(168)
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Синестра"
})

L:SetWarningLocalization({
	WarnDragon			= "Появились сумеречные дракончики",
	WarnOrbSoon			= "Сферы через %d сек!",
	SpecWarnOrbs		= "Скоро появятся сферы!",
	warnWrackJump		= "%s прыгнуло на >%s<",
	warnAggro			= "На >%s< АГРО (возможные цели сфер)",
	SpecWarnAggroOnYou	= "На вас АГРО! Смотрите за сферами!",
	SpecWarnEggWeaken	= "Панцирь снят - весь урон в яйца!",
	SpecWarnEggShield	= "Панцирь восстановился!"
})

L:SetTimerLocalization({
	TimerDragon			= "След. дракончики",
	TimerEggWeakening	= "Снятие зашиты с яиц",
	TimerEggWeaken		= "Восст. Сумеречного панциря",
	TimerOrbs			= "Восст. Сферы Тьмы"
})

L:SetOptionLocalization({
	WarnDragon			= "Предупреждение, когда появляются сумеречные дракончики",
	WarnOrbSoon			= "Предупреждение о появлении сфер (за 5с до начала, каждую 1с)\n(Предупреждение может быть неточным!)",
	warnWrackJump		= "Показывать цели, на которые прыгает $spell:92955",
	warnAggro			= "Показывать игроков, имеющих агро от сфер (возможные цели сфер)",
	SpecWarnAggroOnYou	= "Спец-предупреждение, если на вас есть агро при появлении сфер",
	SpecWarnOrbs		= "Спец-предупреждение при появлении сфер\n(Предупреждение может быть неточным)",
	SpecWarnEggWeaken	= "Спец-предупреждение, когда спадает $spell:87654",
	SpecWarnEggShield	= "Спец-предупреждение, когда восстанавливается $spell:87654",
	TimerDragon			= "Отсчет времени до новых сумеречных дракончиков",
	TimerEggWeakening	= "Отсчет времени до снятия $spell:87654",
	TimerEggWeaken		= "Отсчет времени восстановления $spell:87654",
	TimerOrbs			= "Отсчет времени до следующих сфер (таймер может быть неточным)",
	SetIconOnOrbs		= "Устанавливать метки на игроков, имеющих агро от сфер\n(Предполагаемые цели сфер)",
	OrbsCountdown		= "Звуковой отсчет перед появлением сфер",
	InfoFrame			= "Показывать список игроков, имеющих агро"
})

L:SetMiscLocalization({
	YellDragon			= "Ешьте, дети мои! Пусть их мясо насытит вас!",
	YellEgg				= "Ты так в этом уверен? Глупец!",
	HasAggro			= "Имеют агро"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Существа Сумеречного бастион"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})