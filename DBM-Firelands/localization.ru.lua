if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Фаза %d",
	WarnNewInitiate		= "Новообращенный друид-огнеястреб (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Фаза %d",
	TimerHatchEggs		= "Вылупление яиц",
	timerNextInitiate	= "Следующий друид (%s)",
	TimerCombatStart	= "Начало боя"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Отсчет времени до начала боя",
	WarnPhase			= "Предупреждение о смене фаз",
	WarnNewInitiate		= "Предупреждение о появлении нового друида-огнеястреба",
	timerNextInitiate	= "Отсчет времени до появления нового друида-огнеястреба",
	TimerPhaseChange	= "Отсчет времени до следующей фазы",
	TimerHatchEggs		= "Отсчет времени до вылупления яиц",
	InfoFrame			= "Информационное окно для $spell:97128"
})

L:SetMiscLocalization({
	YellPull			= "Теперь я служу новому господину, смертные!",
	YellInitiate1		= "Взываем к тебе, Повелитель огня!",
	YellInitiate2		= "Узрите его силу!",
	YellInitiate3		= "Пусть неверные горят в огне!",
	YellInitiate4		= "Узрите величие огня.",
	YellPhase2			= "Небо над вами принадлежит МНЕ!",
	FullPower			= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms			= "На поверхность вылезают огненные лавовые паразиты!",
	PowerLevel			= "Опаляющее перо",
	East				= "на востоке",
	West				= "на западе",
	Both				= "обе стороны"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	EmoteSpiderlings 	= "Сверху свисают пеплопряды-ткачи!"
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
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
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
	IconOnLeapingFlames		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnSplittingBlow	= "%s %s",--Spellname in Location
	warnEngulfingFlame	= "%s %s",--Spellname in Location
	WarnRemainingAdds	= "Осталось элементалей: %d"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Окончание переходной фазы"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "Предупреждение для $spell:100877",
	warnEngulfingFlame	= "Предупреждение для $spell:99171",
	WarnRemainingAdds	= "Показывать количество оставщихся элементалей",
	TimerPhaseSons		= "Отсчет времени до окончания \"фазы Сыновей пламени\"",
	RangeFrame			= "Показывать окно проверки дистанции",
	InfoFrame			= "Информационное окно для целей $spell:99849",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "на востоке",
	West				= "на западе",
	Middle				= "в центре",
	North				= "в мили",
	South				= "сзади",
	MeteorTargets		= "ОМФГ Метеоры!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Довольно! Пора покончить с этим.",--More reliable then adds method.
	TransitionEnded2	= "Сульфурас уничтожит вас!",--More reliable then adds method.
	Defeat				= "Слишком рано!.. Вы пришли слишком рано…"
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
	TrashRangeFrame			= "Показывать окно проверки дистанции (10м) для $spell:100012",
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Вулканий"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "Следующая фаза"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Отсчет времени до перехода фаз"
})

L:SetMiscLocalization({
	StaffEvent				= "The Branch of Nordrassil reacts violently to %S+ touch!",--Partial, not sure if pull detection will work with partials yet :\
	StaffTrees				= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition			= "The fires consuming the Tormented Protector wink out!"
})