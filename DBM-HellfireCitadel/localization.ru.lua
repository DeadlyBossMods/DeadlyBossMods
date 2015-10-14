if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "След. осад. машина %s",
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"Отсчет времени до появления новой осадной машины"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"Comin' in hot!",--Blizzard seems to have disabled these
	AddsSpawn2		=	"Fire in the hole!",--Blizzard seems to have disabled these
	BossLeaving		=	"Я вернусь..."
})

---------------------------
-- Iron Reaver --
---------------------------
L= DBM:GetModLocalization(1425)

---------------------------
-- Hellfire High Council --
---------------------------
L= DBM:GetModLocalization(1432)

L:SetWarningLocalization({
	reapDelayed =	"Жатва после Лика закончилась"
})

------------------
-- Kormrok --
------------------
L= DBM:GetModLocalization(1392)

L:SetMiscLocalization({
	ExRTNotice		= "%s отправил присвоенные позиции ExRT. Ваши позиции: оранж.:%s, зел.:%s, фиол.:%s"
})

--------------
-- Kilrogg Deadeye --
--------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon		=	"Ко мне, братья! Ваша судьба ждет!"
})

--------------------
--Gorefiend --
--------------------
L= DBM:GetModLocalization(1372)

L:SetTimerLocalization({
	SoDDPS2		= "След. Тени (%s)",
	SoDTank2	= "След. Тени (%s)",
	SoDHealer2	= "След. Тени (%s)"
})

L:SetOptionLocalization({
	SoDDPS2			= "Отсчет времени до след. $spell:179864 (дд)",
	SoDTank2		= "Отсчет времени до след. $spell:179864 (танки)",
	SoDHealer2		= "Отсчет времени до след. $spell:179864 (хилы)",
	ShowOnlyPlayer	= "Показывать HudMap для $spell:179909 только если вы участник"
})

--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"Бросьте Глаз Анзу %s!"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"Спец-предупреждение когда вы должны кинуть $spell:179202"
})

--------------------------
-- Fel Lord Zakuun --
--------------------------
L= DBM:GetModLocalization(1391)

L:SetOptionLocalization({
	SeedsBehavior		= "Поведение крика для Семя разрушения (требуется лидер рейда)",
	Iconed				= "Метки на полу: Звезда, Круг, Ромб, Треугольник, Луна",--Default
	Numbered			= "Нумерованные позиции: 1, 2, 3, 4, 5",
	DirectionLine		= "Лево, Слева от середины, Середина, Справа от середины, Право. Для стратегии в одну линию",
	FreeForAll			= "Свободное. Позиция не задается, используется обычный крик"
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Конфигурация для Семя разрушения установлена в %s, чтобы соответствовать конфигурации рейд лидера.",
	BWConfigMsg			= "Рейд лидер использует Bigwigs, DBM автоматически настроен на использование нумерованных позиций"
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "Поведение предупреждения для Цепи Скверны",
	Cast				= "Выдавать только начальную цель в начале каста. Таймер синхронизируется по началу каста.",
	Applied				= "Выдавать цели в конце каста. Таймер синхронизируется по окончанию каста.",
	Both				= "Выдавать начальную цель в начале каста и другие цели в конце каста."
})

--------------------------
-- Socrethar the Eternal --
--------------------------
L= DBM:GetModLocalization(1427)

L:SetOptionLocalization({
	InterruptBehavior	= "Поведение ротации прерывания для рейда (требуется лидер рейда)",
	Count3Resume		= "Ротация из 3 чел., которая продолжается когда барьер спадает",--Default
	Count3Reset			= "Ротация из 3 чел., которая начинается заново когда барьер спадает",
	Count4Resume		= "Ротация из 4 чел., которая продолжается когда барьер спадает",
	Count4Reset			= "Ротация из 4 чел., которая начинается заново когда барьер спадает"
})

--------------------------
-- Tyrant Velhari --
--------------------------
L= DBM:GetModLocalization(1394)

--------------------------
-- Mannoroth --
--------------------------
L= DBM:GetModLocalization(1395)

L:SetMiscLocalization({
	felSpire		=	"начинает усиливать шпиль Скверны!"
})

--------------------------
-- Archimonde --
--------------------------
L= DBM:GetModLocalization(1438)

L:SetWarningLocalization({
	specWarnBreakShackle	= "Скованное страдание: разорвать связь %s!"
})

L:SetOptionLocalization({
	specWarnBreakShackle	= "Спец-предупреждение для $spell:184964. Это предупреждение автоматически назначает последовательность разрывания, чтобы минимизировать урон.",
	ExtendWroughtHud2		= "Продлять линии HUD за цель $spell:185014 (может уменьшить точность линии)",
	AlternateHudLine		= "Использовать альтернативную текстуру линии для HUD между целями $spell:185014",
	NamesWroughtHud			= "Отображать имена игроков для целей $spell:185014",
	FilterOtherPhase		= "Фильтровать предупреждения для событий из другой фазы"
})

L:SetMiscLocalization({
	phase2point5		= "Узрите несметные войска Пылающего Легиона и осознайте всю тщетность борьбы!",--3 seconds faster than CLEU, used as primary, slower CLEU secondary
	First				= "Первый",
	Second				= "Второй",
	Third				= "Третий",
	Fourth				= "Четвертый",--Just in case, not sure how many targets in 30 man raid
	Fifth				= "Пятый"--Just in case, not sure how many targets in 30 man raid
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"ЦАП: Трэш"
})
