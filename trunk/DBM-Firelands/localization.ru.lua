if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "Фаза %d"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Фаза %d",
	TimerHatchEggs		= "Вылупление яиц"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждение о смене фаз",
	TimerPhaseChange	= "Отсчет времени до следующей фазы",
	TimerHatchEggs		= "Отсчет времени до вылупления яиц",
	InfoFrame			= "Информационное окно для $spell:99461"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellPhase2		= "These skies are MINE!",
	PowerLevel		= "Пылающая энергия"
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
	TimerDrone			= "Отсчет времени до следующего $journal:2773"
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
	ArrowOnCountdown	= "Показывать стрелку DBM, когда на вас $spell:99516"
})

L:SetMiscLocalization({
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
	RangeFrame			= "Показывать окно проверки дистанции"
})

L:SetMiscLocalization({
})