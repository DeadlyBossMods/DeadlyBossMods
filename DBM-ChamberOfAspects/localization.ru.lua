if GetLocale() ~= "ruRU" then return end

local L
---------------
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
	WarningTenebron		= "Прибытие Тенеброна",
	WarningShadron		= "Прибытие Шадрона",
	WarningVesperon		= "Прибытие Весперона",
	WarningFireWall		= "Огненная стена",
	WarningVesperonPortal	= "Портал Весперона",
	WarningTenebronPortal	= "Портал Тенеброна",
	WarningShadronPortal	= "Портал Шадрона",
})

L:SetTimerLocalization({
	TimerTenebron		= "Прибытие Тенеброна",
	TimerShadron		= "Прибытие Шадрона",
	TimerVesperon		= "Прибытие Весперона"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Звуковой сигнал для волны из \"Огненной стены\"",
	AnnounceFails		= "Объявить в чат рейда игрока миновавшего Огненную стену и Расщелину тьмы (требуются права лидера или помощника)",
	TimerTenebron		= "Отсчет времени до прибытия Тенеброна",
	TimerShadron		= "Отсчет времени до прибытия Шадрона",
	TimerVesperon		= "Отсчет времени до прибытия Весперона",
	WarningFireWall		= "Cпец-предупреждение для \"Огненной стены\"",
	WarningTenebron		= "Предупредить о призыве Тенеброна",
	WarningShadron		= "Объявлять о призыве Шадрона",
	WarningVesperon		= "Объявлять о призыве Весперона",
	WarningTenebronPortal	= "Cпец-предупреждение для порталов Тенеброна",
	WarningShadronPortal	= "Cпец-предупреждение для порталов Шадрона",
	WarningVesperonPortal	= "Cпец-предупреждение для порталов Весперона",
})

L:SetMiscLocalization({
	Wall			= "Лава вокруг %s начинает бурлить!",
	Portal			= "%s открывает сумрачный портал!",
	NameTenebron		= "Тенеброн",
	NameShadron		= "Шадрон",
	NameVesperon		= "Весперон",
	FireWallOn		= "Огненная стена: %s",
	VoidZoneOn		= "Расщелина тьмы: %s",
	VoidZones		= "Расщелина тьмы миновала (в этот раз): %s",
	FireWalls		= "Огненная стена миновала (в этот раз): %s",
})
