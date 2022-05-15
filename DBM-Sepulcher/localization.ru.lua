if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle --
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "Установить поведение настройки меток Ритуалистов. Используется предпочтение рейд-лидеров, если они используют DBM.",
	SetOne					= "Отличие от семян / Ночного охотника (без конфликтов) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (по умолчанию)
	SetTwo					= "Совпадение семян / Ночного охотника (конфликтует, если семена и ритуалисты в одно и то же время) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "Match seeds/Night Hunter (no conflicts, but requires raid members having extended icons properly installed to see them) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "Deathtouch",
	Dispel			= "Dispel",
	ExtendReset		= "Your Ritualist icon dropdown setting has been reset due to fact you were using extended icons before, but aren't any longer"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~Танковое комбо (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "Показать таймер (с отсчетом) перезарядки танкового комбо"
})

---------------------------
--  Halondrus the Reclaimer --
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "Частице"
})

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "Установить поведение мода для 'Кощунства'. Используется предпочтение рейд-лидеров, если они используют DBM.",
	Auto				= "Оповещать 'на тебе' с автоматически назначенным партнером. Облачка чата показывают уникальные символы для совпадений.",
	Generic				= "Оповещать 'на тебе' без назначенного партнера. Облачка чата показывают общие символы для двух дебаффов.",--По умолчанию
	None				= "Оповещать 'на тебе' без назначенного партнера. Без облачков чата."
})

---------------------------
--  Lords of Dread --
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --
---------------------------
L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "Исцеление Азерот (%s)",
	warnDispel			= "Рассеивание (%s)"
})

L:SetTimerLocalization{
	timerPits			= "Лунки открываются",
	timerHealAzeroth	= "Исцеление Азерот (%s)",
	timerDispels		= "Рассеивания (%s)"
}

L:SetOptionLocalization({
	timerPits			= "Показать таймер, когда открываются лунки в полу, в которые можно упасть",
	warnHealAzeroth		= "Показать предупреждение о том, когда Вам нужно исцелить Азерот (через механику боя) на мифической сложности, основываясь на стратегии гильдии Эхо",
	warnDispel			= "Показать предупреждение о том, когда нужно рассеять 'Смертный приговор' на мифической сложности, основываясь на стратегии гильдии Эхо",
	timerHealAzeroth	= "Показать таймер, когда Вам нужно исцелить Азерот (через механику боя) на мифической сложности, основываясь на стратегии гильдии Эхо",
	timerDispels		= "Показать таймер, когда нужно рассеять 'Смертный приговор' на мифической сложности, основываясь на стратегии гильдии Эхо"
})

L:SetMiscLocalization({
	Pylon				= "Пилону",
	AzerothSoak			= "Поглощение Азерот"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Гробницы Предвечных"
})
