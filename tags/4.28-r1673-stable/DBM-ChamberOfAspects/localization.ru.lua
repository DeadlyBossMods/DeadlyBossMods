if GetLocale() ~= "ruRU" then return end

local L
---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Шадрон"
})
---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Тенеброн"
})

---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Весперон"
})

---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Сартарион"
})

L:SetWarningLocalization({
	WarningTenebron			= "Прибытие Тенеброна",
	WarningShadron			= "Прибытие Шадрона",
	WarningVesperon			= "Прибытие Весперона",
	WarningFireWall			= "Огненная стена!",
	WarningVesperonPortal	= "Портал Весперона!",
	WarningTenebronPortal	= "Портал Тенеброна!",
	WarningShadronPortal	= "Портал Шадрона!",
})

L:SetTimerLocalization({
	TimerWall	= "Перезарядка Огненной стены",
	TimerTenebron	= "Прибытие Тенеброна",
	TimerShadron	= "Прибытие Шадрона",
	TimerVesperon	= "Прибытие Весперона"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Звуковой сигнал для волны из \"Огненной стены\"",
	AnnounceFails		= "Объявить в чат рейда игрока миновавшего Огненную стену и Портал Бездны (требуются права лидера или помощника)",

	TimerWall		= "Отображать отсчет времени до \"Огненной стены\"",
	TimerTenebron		= "Отображать отсчет времени для Тенеброна",
	TimerShadron		= "Отображать отсчет времени для Шадрона",
	TimerVesperon		= "Отображать отсчет времени для Весперона",

	WarningFireWall		= "Отображать спец-предупреждение для \"Огненной стены\"",
	WarningTenebron		= "Отображать времея до призыва Тенеброна",
	WarningShadron		= "Отображать времея до призыва Шадрона",
	WarningVesperon		= "Отображать времея до призыва Весперона",

	WarningTenebronPortal	= "Отображать спец-предупреждение для порталов Тенеброна",
	WarningShadronPortal	= "Отображать спец-предупреждение для порталов Шадрона",
	WarningVesperonPortal	= "Отображать спец-предупреждение для порталов Весперона",
})

L:SetMiscLocalization({
	Wall			= "Лава вокруг %s начинает бурлить!",
	Portal			= "%s открывает сумрачный портал!",
	NameTenebron	= "Тенеброн",
	NameShadron		= "Шадрон",
	NameVesperon	= "Весперон",
	FireWallOn		= "Огненная стена: %s",
	VoidZoneOn		= "Портал Бездны: %s",
	VoidZones		= "Портал Бездны миновал (в этот раз): %s",
	FireWalls		= "Огненная стена миновала (в этот раз): %s",
	--[[ not in use; don't translate.
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})
