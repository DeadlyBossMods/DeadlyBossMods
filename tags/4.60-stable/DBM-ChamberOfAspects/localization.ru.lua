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
	WarningSplitSoon	= "Скоро разделение"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Предупреждать заранее о разделении",
	RangeFrame			= "Показывать окно проверки дистанции (12 м)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Савиана Огненная Пропасть"
})

L:SetWarningLocalization({
	SpecialWarningTranq		= "Исступление - усмирите сейчас"
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
	WarnAdds	= "Новые помощники",
	warnCleaveArmor	= "%s на |3-5(>%s<) (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Новые помощники"
})

L:SetOptionLocalization({
	WarnAdds		= "Объявлять новых помощников",
	TimerAdds		= "Отсчет времени до новых помощников",
	warnCleaveArmor	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(74367, GetSpellInfo(74367) or "unknown")
})

L:SetMiscLocalization({
	SummonMinions	= "Слуги! Обратите их в пепел!"
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
	WarnPhase3Soon		= "Скоро фаза 3",
	TwilightCutterCast	= "Применение заклинания Лезвие сумерек: 5 сек"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Предупреждать заранее о фазе 2 (на ~79%)",
	WarnPhase3Soon			= "Предупреждать заранее о фазе 3 (на ~54%)",
	TwilightCutterCast		= "Предупреждать о применении заклинания $spell:77844",
	AnnounceAlternatePhase	= "Показывать предупреждения и таймеры для обоих миров",
	SoundOnConsumption		= "Звуковой сигнал при $spell:74562 и $spell:74792",--We use localized text for these functions
	SetIconOnConsumption	= "Устанавливать метки на цели заклинаний $spell:74562 и\n$spell:74792",--So we can use single functions for both versions of spell.
	YellOnConsumption		= "Кричать, когда $spell:74562 или $spell:74792 на вас",
	WhisperOnConsumption	= "Шепот целям заклинаний $spell:74562 и $spell:74792"
})

L:SetMiscLocalization({
	NormalHalion			= "Физический Халион",
	TwilightHalion			= "Сумеречный Халион",
	MeteorCast				= "Небеса в огне!",
	Phase2					= "В мире сумерек вы найдете лишь страдания! Входите, если посмеете!",
	Phase3					= "Я есть свет и я есть тьма! Трепещите, ничтожные, перед посланником Смертокрыла!",
	twilightcutter			= "Во вращающихся сферах пульсирует темная энергия!",
	YellCombustion			= "Пылающий огонь на мне!",
	WhisperCombustion		= "Пылающий огонь на вас! Бегите к стене!",
	YellConsumption			= "Пожирание души на мне!",
	WhisperConsumption		= "Пожирание души на вас! Бегите к стене!",
	Kill					= "Это ваша последняя победа. Насладитесь сполна ее вкусом. Ибо когда вернется мой господин, этот мир сгинет в огне!"
})