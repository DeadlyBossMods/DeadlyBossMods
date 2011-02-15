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
	YellOnMeteor			= "Крикнуть если на вас $spell:88518",
	YellOnTwilightBlast		= "Крикнуть если на вас $spell:92898",
	TwilightBlastArrow		= "Показать стрелку DBM когда $spell:92898 около вас",
	RangeFrame				= "Окно проверки дистанции (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Тералион, я подожгу коридор. Не дай им уйти!",--Terrible phase trigger, even transcriptor couldn't grab anything more usefull than this :(
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

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Показать здоровье подчиненного дракона"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Совет Перерожденных"
})

L:SetWarningLocalization({
	specWarnBossLow			= ">%s< ниже 30%",
	SpecWarnGrounded		= "Получите ауру заземления!",
	SpecWarnSearingWinds	= "Получите ауру кружащихся ветров!"
})

L:SetTimerLocalization({
	timerTransition		= "Смена фаз"
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

L:SetOptionLocalization({
	specWarnBossLow		= "Показать особое предупреждение, когда здоровье у боссов ниже 30%",
	SpecWarnGrounded	= "Показать особое предупреждение, когда у вас не хватает ауры $spell:83581\n(~10сек перед началом применения)",
	SpecWarnSearingWinds= "Показать особое предупреждение, когда у вас не хватает ауры $spell:83500\n(~10сек перед началом применения)",
	timerTransition		= "Показать таймер перехода в другую фазу",
	RangeFrame			= "Автоматически показать окно проверки дистанции при надобности",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
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

L:SetMiscLocalization({
	YellCrash		= "На МНЕ - Оскверняющее сокрушение!",
	Bloodlevel				= "Порча"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Показывать предупреждение о переходе на 2-ую фазу",
	YellOnCorrupting		= "Крикнуть если на вас $spell:93178",
	CorruptingCrashArrow	= "Показать стрелку DBM когда $spell:93178 около вас",
	InfoFrame				= "Показывать информационное окно для $spell:82235",
	RangeFrame				= "Показать окно проверки дистанции (6м) для $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317)
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Синестра"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})