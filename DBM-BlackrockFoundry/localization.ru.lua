if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "Настройка получения стаков от Инфернального удара для спец предупреждений (эпох. сложность)",
	ThreeGroup			= "3 группы по 1 стаку каждая",
	TwoGroup			= "2 группы по 2 стака каждая"
})

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

L:SetOptionLocalization({
	InterruptBehavior	= "Настройка поведения предупреждений для прерывания",
	Smart				= "Основываясь на стаках",
	Fixed				= "Фиксированная последовательность из 5 или 3"
})

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "Осталось Регуляторов температуры: %d",
	warnBlastFrequency		= "Частота взрывов увеличилась: каждые ~%d сек",
	specWarnTwoVolatileFire	= "Два Неустойчивых огня на Вас!"
})

L:SetOptionLocalization({
	warnRegulators			= "Объявлять сколько Регуляторов температуры осталось",
	warnBlastFrequency		= "Объявлять когда увеличивается частота $spell:155209",
	specWarnTwoVolatileFire	= "Спец-предупреждение когда на Вас два $spell:176121",
	InfoFrame				= "Информационное окно для $spell:155192 и $spell:155196",
	VFYellType2				= "Тип крика для Неустойчивого огня (только Эпохальный режим)",
	Countdown				= "Отсчет до спадения",
	Apply					= "Только получение дебаффа"
})

L:SetMiscLocalization({
	heatRegulator		= "Регулятор температуры",
	Regulator			= "Регулятор %d",--Can't use above, too long for infoframe
	bombNeeded			= "%d |4бомба:бомбы:бомб;"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s отправил присвоенные позиции рун. Ваша позиция: %s"
})

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "Разделение рейда через 10 сек"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "Спец-предупредение за 10 секунд до разделения рейда",
	InfoFrameSpeed		= "Настройка отображения след. поезда в информационном окне",
	Immediately			= "Как только открываются двери для текущего поезда",
	Delayed				= "После того как текущий поезд выехал",
	HudMapUseIcons		= "Использовать рейдовые метки для HudMap вместо зеленого круга",
	TrainVoiceAnnounce	= "Настройка голосовых оповещений о поездах",
	LanesOnly			= "Анонсировать только прибывающие пути",
	MovementsOnly		= "Анонсировать только передвижения по путям (только Эпох.)",
	LanesandMovements	= "Анонсировать прибывающие пути и передвижения (только Эпох.)"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "Путь",
	oneTrain		= "1 случайный путь: Поезд",
	oneRandom		= "Появляется на 1 случайном пути",
	threeTrains		= "3 случайных пути: Поезд",
	threeRandom		= "Появляются на 3 случайных путях",
	helperMessage	= "Этот бой может быть упрощен с помощью аддона 'Thogar Assist' или одного из множества доступных голосовых пакетов DBM, которые можно найти на http://wow.curse.com/."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "Возвращайтесь на причал!"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Спец-предупреждение когда игрок на борту может безопасно вернуться на причал",
	filterBladeDash3	= "Не показывать спец-предупреждения для $spell:155794 когда на ком-то $spell:170395",
	filterBloodRitual3	= "Не показывать спец-предупреждения для $spell:158078 когда на ком-то $spell:170405"
})

L:SetMiscLocalization({
	shipMessage		= "готовится занять позицию у главного орудия дредноута!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "Позиция метки: %s",
	specWarnSlagPosition	= "Позиция бомбы: %s"
})

L:SetOptionLocalization({
	PositionsAllPhases	= "Задавать позиции для $spell:156096 криков во время всех фаз (вместо только 3 фазы, данная опция не рекомендуется)",
	InfoFrame			= "Информационное окно для $spell:155992 и $spell:156530"
})

L:SetMiscLocalization({
	customMFDSay	= "Метка %s на %s",
	customSlagSay	= "Бомба %s на %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Литейной клана Черной горы"
})
