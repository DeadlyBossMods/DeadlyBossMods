if GetLocale() ~= "ruRU" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Шадрон"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Тенеброн"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Весперон"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Сартарион"
})

L:SetWarningLocalization({
	WarningTenebron			= "Прибытие Тенеброна",
	WarningShadron			= "Прибытие Шадрона",
	WarningVesperon			= "Прибытие Весперона",
	WarningFireWall			= "Огненная стена",
	WarningVesperonPortal	= "Портал Весперона",
	WarningTenebronPortal	= "Портал Тенеброна",
	WarningShadronPortal	= "Портал Шадрона"
})

L:SetTimerLocalization({
	TimerTenebron	= "Прибытие Тенеброна",
	TimerShadron	= "Прибытие Шадрона",
	TimerVesperon	= "Прибытие Весперона"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Звуковой сигнал при Огненной стене",
	AnnounceFails			= "Объявлять игроков, потерпевших неудачу в Огненной стене и Расщелине тьмы\n(требуются права лидера или помощника)",
	TimerTenebron			= "Отсчет времени до прибытия Тенеброна",
	TimerShadron			= "Отсчет времени до прибытия Шадрона",
	TimerVesperon			= "Отсчет времени до прибытия Весперона",
	WarningFireWall			= "Cпец-предупреждение для Огненной стены",
	WarningTenebron			= "Объявлять прибытие Тенеброна",
	WarningShadron			= "Объявлять прибытие Шадрона",
	WarningVesperon			= "Объявлять прибытие Весперона",
	WarningTenebronPortal	= "Cпец-предупреждение для порталов Тенеброна",
	WarningShadronPortal	= "Cпец-предупреждение для порталов Шадрона",
	WarningVesperonPortal	= "Cпец-предупреждение для порталов Весперона"
})

L:SetMiscLocalization({
	Wall			= "Лава вокруг %s начинает бурлить!",
	Portal			= "%s открывает сумрачный портал!",
	NameTenebron	= "Тенеброн",
	NameShadron		= "Шадрон",
	NameVesperon	= "Весперон",
	FireWallOn		= "Огненная стена: %s",
	VoidZoneOn		= "Расщелина тьмы: %s",
	VoidZones		= "Потерпели неудачу в Расщелине тьмы (за эту попытку): %s",
	FireWalls		= "Потерпели неудачу в Огненной стене (за эту попытку): %s",
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Балтар Рожденный в Битве"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show pre-warning for Split",
	RangeFrame			= "Показывать окно проверки дистанции (12 м)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
	SplitTrigger		= "Twice the Pain and half the fun."
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Савиана Огненная Пропасть"
})

L:SetWarningLocalization({
	SpecialWarningTranq		= "Enrage - Tranq now"
})

L:SetOptionLocalization({
	SpecialWarningTranq		= "Спец-предупреждение о $spell:78722 (для усмирения)",
	RangeFrame				= "Показывать окно проверки дистанции (10 м)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

L:SetMiscLocalization{
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "Генерал Заритриан"
})

L:SetWarningLocalization({
	WarnAdds	= "Новые помощники"
})

L:SetTimerLocalization({
	TimerAdds	= "Новые помощники"
})

L:SetOptionLocalization({
	WarnAdds		= "Объявлять новых помощников",
	TimerAdds		= "Отсчет времени до новых помощников"
})

L:SetMiscLocalization({
	SummonMinions	= "Turn them to ash, minions!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Халион Сумеречный Разрушитель"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "Скоро фаза 2",
	WarnPhase3Soon		= "Скоро фаза 3"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Предупреждать заранее о фазе 2 (на ~79%)",
	WarnPhase3Soon			= "Предупреждать заранее о фазе 3 (на ~54%)",
	SoundOnConsumption		= "Play sound on Combustion",--We use localized text for these functions
	SetIconOnConsumption	= "Set icons on Combustion targets"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	twilightcutter			= "The orbiting spheres pulse with dark energy!"
})