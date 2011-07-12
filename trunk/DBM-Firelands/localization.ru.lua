if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Фаза %d",
	WarnNewInitiate		= "Новообращенный друид-огнеястреб (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Фаза %d",
	TimerHatchEggs		= "Вылупление яиц",
	timerNextInitiate	= "Следующий друид"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждение о смене фаз",
	WarnNewInitiate		= "Предупреждение о появлении нового друида-огнеястреба",
	timerNextInitiate	= "Отсчет времени до появления нового друида-огнеястреба",
	TimerPhaseChange	= "Отсчет времени до следующей фазы",
	TimerHatchEggs		= "Отсчет времени до вылупления яиц",
	InfoFrame			= "Информационное окно для $spell:99461"
})

L:SetMiscLocalization({
	YellPull			= "Теперь я служу новому господину, смертные!",
	YellInitiate1		= "Взываем к тебе, Повелитель огня!",
	YellInitiate2		= "Узрите его силу!",
	YellInitiate3		= "Пусть неверные горят в огне!",
	YellInitiate4		= "Узрите величие огня.",
	YellPhase2			= "Небо над вами принадлежит МНЕ!",
	PowerLevel			= "Пылающая энергия"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "Появление элементалей"
})

L:SetTimerLocalization({
	TimerElementals		= "Следущие элементали"
})

L:SetOptionLocalization({
	WarnElementals		= "Предупреждение о появлении элементалей",
	TimerElementals		= "Отсчет времени до следующих элементалей"
})

L:SetMiscLocalization({
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Следующие Пеплопряды-ткачи",
	TimerSpiderlings	= "Следующие Паучата",
	TimerDrone			= "Следующий Трутень"
})

L:SetOptionLocalization({
	TimerSpinners		= "Отсчет времени до следующих $journal:2770",
	TimerSpiderlings	= "Отсчет времени до следующих $journal:2778",
	TimerDrone			= "Отсчет времени до следующего $journal:2773",
	RangeFrame			= "Показывать окно проверки дистанции (10м)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
	Riplimb		= "Лютогрыз",
	Rageface	= "Косоморд"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Следующее лезвие"
})

L:SetOptionLocalization({
	TimerBladeActive	= "Отсчет времени действия активного лезвия",
	TimerBladeNext		= "Отсчет времени до следующего лезвия",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "Показывать стрелку DBM, когда на вас $spell:99516",
	InfoFrame			= "Информационное окно для стаков искр"
})

L:SetMiscLocalization({
	VitalSpark			= GetSpellInfo(99262).." стаки"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrameSeeds			= "Показывать окно проверки дистанции (12м) для $spell:98450",
	RangeFrameCat			= "Показывать окно проверки дистанции (10м) для $spell:98374",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Окончание фазы с помощниками"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "Отсчет времени до окончания \"фазы Сыновей Пламени\"",
	RangeFrame			= "Показывать окно проверки дистанции",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
})


-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Треш-мобы"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame			= "Показывать окно проверки дистанции (10м) для $spell:100012",
})

L:SetMiscLocalization({
})