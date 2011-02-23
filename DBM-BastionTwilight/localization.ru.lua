if GetLocale() ~= "ruRU" then return end

local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Валиона и Тералион"
})

L:SetWarningLocalization({
	WarnDazzlingDestruction	= "%s (%d)",
	WarnDeepBreath			= "%s (%d)",
	WarnTwilightShift		= "%s : >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnDazzlingDestruction	= "Показывать предупреждение для $spell:86408",
	WarnDeepBreath			= "Показывать предупреждение для $spell:86059",
	WarnTwilightShift		= "Показывать предупреждение для $spell:93051",
	YellOnEngulfing			= "Крикнуть если на вас $spell:86622",
	YellOnTwilightMeteor	= "Крикнуть если на вас $spell:88518",
	YellOnTwilightBlast		= "Крикнуть если на вас $spell:92898",
	TwilightBlastArrow		= "Показывать стрелку DBM, когда $spell:92898 около вас",
	RangeFrame				= "Окно проверки дистанции (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Глубокий вдох",--Change this to what deep breath emote is.
	YellEngulfing			= "На МНЕ - Избыточная магия!",
	YellMeteor				= "На МНЕ - Сумеречный метеорит!",
	YellTwilightBlast		= "На МНЕ - Сумеречный взрыв!"
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Халфий Змеерез"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Показать здоровье подчиненного дракона"
})

L:SetMiscLocalization({
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Совет Перерожденных"
})

L:SetWarningLocalization({
	SpecWarnGrounded		= "Получите ауру заземления!",
	SpecWarnSearingWinds	= "Получите ауру кружащихся ветров!",
	warnGravityCoreJump		= "Гравитационное ядро на >%s<",
	warnStaticOverloadJump	= "Статическая перегрузка на >%s<"
})

L:SetTimerLocalization({
	timerTransition		= "Смена фаз"
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Показывать особое предупреждение, когда у вас не хватает ауры $spell:83581\n(~10сек перед началом применения)",
	SpecWarnSearingWinds= "Показывать особое предупреждение, когда у вас не хватает ауры $spell:83500\n(~10сек перед началом применения)",
	timerTransition		= "Показывать таймер перехода в другую фазу",
	RangeFrame			= "Автоматически показывать окно проверки дистанции при надобности",
	warnGravityCoreJump		= "Сообщать о целях, на которых распространяется $spell:92538",
	warnStaticOverloadJump	= "Сообщать о целях, на которых распространяется $spell:92467",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "Земля уходит у вас из-под ног...", -- Yell string: Земля поглатит вас!
	Thundershock	= "Воздух потрескивает от скопившейся энергии...", -- Yell string: Ветер, явись на мой зов!
	Switch			= "Закончим этот фарс!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "Ваше упорство...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Ignacious		= "Огнис",
	Feludius		= "Акварион",
	Arion			= "Аэрон",
	Terrastra		= "Террастра",
	Monstrosity		= "Элементиевое чудовище",
	Kill			= "Невозможно...."
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Чо'Галл"
})

L:SetWarningLocalization({
	WarnPhase2Soon			= "Скоро 2-ая фаза"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Показывать предупреждение о переходе на 2-ую фазу",
	YellOnCorrupting		= "Крикнуть если на вас $spell:93178",
	CorruptingCrashArrow	= "Показывать стрелку DBM, когда $spell:93178 около вас",
	InfoFrame				= "Показывать информационное окно для $spell:82235",
	RangeFrame				= "Показывать окно проверки дистанции (5м) для $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
})

L:SetMiscLocalization({
	YellCrash				= "На МНЕ - Оскверняющее сокрушение!",
	Bloodlevel				= "Порча"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Синестра"
})

L:SetWarningLocalization({
	WarnEggWeaken		= "С яиц убран сумеречный панцирь",
	WarnDragon			= "Появились сумеречные дракончики"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "Снятие зашиты с яиц",
	TimerDragon			= "След. дракончики"
})

L:SetOptionLocalization({
	WarnEggWeaken		= "Показывать предупреждение, когда яйца ослабевают",
	WarnDragon			= "Показывать предупреждение, когда появляются сумеречные дракончики",
	TimerEggWeakening	= "Показывать таймер снятия защиты с яиц",
	TimerDragon			= "Показывать таймер до новых сумеречных дракончиков"
})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",
	YellEgg				= "You mistake this for weakness?  Fool!"   
})