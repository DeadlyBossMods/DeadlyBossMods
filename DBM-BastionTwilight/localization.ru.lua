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
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetOptionLocalization({
	YellOnEngulfing			= "Крикнуть если на вас $spell:86622",
	RangeFrame		= "Окно проверки дистанции (10)"
})

L:SetMiscLocalization{
	YellEngulfing				= "На МНЕ избыточная магия!"
}

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
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Совет Перерожденных"
})

L:SetWarningLocalization({
	SpecWarnGrounded	= "Получите Ауру Заземление",
	SpecWarnSearingWinds	= "Получите Аура Кружащихся ветров"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Quake			= "The ground beneath you rumbles ominously....",
	Thundershock	= "The surrounding air crackles with energy....",
	Switch			= "We will handle them!",
	Phase3			= "BEHOLD YOUR DOOM!",
	Ignacious		= "Огнис",
	Feludius		= "Акварион",
	Arion			= "Аэрон",
	Terrastra		= "Террастра",
	Monstrosity		= "Элементиевое чудовище"
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Показать особое предупреждение, когда у вас не хватает ауры $spell:83581\n(~10сек перед началом применения)",
	SpecWarnSearingWinds	= "Показать особое предупреждение, когда у вас не хватает ауры $spell:83500\n(~10сек перед началом применения)",
	HeartIceIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660)
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Чо'Галл"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Скоро 2-ая фаза"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Показывать предупреждение о переходе на 2-ую фазу"
})