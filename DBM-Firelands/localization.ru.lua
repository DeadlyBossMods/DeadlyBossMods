if GetLocale() ~= "ruRU" then return end
local L

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
	yellPhase2			= "Целую вечность я спокойно спал… Маленькие кусочки мяса… Вы СГОРИТЕ!"
})

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
	Initiate			= "Новообращенный друид-огнеястреб",
	YellPhase2			= "Небо над вами принадлежит МНЕ!",
	FullPower			= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms			= "На поверхность вылезают огненные лавовые паразиты!",
	PowerLevel			= "Опаляющее перо",
	East				= "на востоке",
	West				= "на западе",
	Both				= "обе стороны"
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
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	timerStrike			= "След. %s",
	TimerBladeNext		= "Следующее лезвие"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "Отсчитывать кристаллы группами по 3(25 ппл)/2(10 ппл) в каждой",
	warnStrike			= "Предупреждение о лезвиях",
	timerStrike			= "Отсчет времени между ударами лезвий",
	TimerBladeActive	= "Отсчет времени действия активного лезвия",
	TimerBladeNext		= "Отсчет времени до следующего лезвия",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "Показывать стрелку DBM, когда на вас $spell:99516",
	InfoFrame			= "Информационное окно для стаков искр",
	RangeFrame			= "Показывать окно проверки дистанции (5м) для $spell:99404"
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
	timerNextSpecial		= "След. %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial		= "Отсчет времени до следующей особой способности",
	RangeFrameSeeds			= "Показывать окно проверки дистанции (12м) для $spell:98450",
	RangeFrameCat			= "Показывать окно проверки дистанции (10м) для $spell:98374",
	LeapArrow				= "Показывать стрелку DBM, когда босс приземляется около вас",
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
	WarnRemainingAdds	= "Показывать количество оставшихся элементалей",
	TimerPhaseSons		= "Отсчет времени до окончания \"фазы Сыновей пламени\"",
	RangeFrame			= "Показывать окно проверки дистанции",
	InfoHealthFrame		= "Информационное окно для игроков с низким уровнем здоровья (<110к хп)",
	MeteorFrame			= "Информационное окно для целей $spell:99849",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "на востоке",
	West				= "на западе",
	Middle				= "в центре",
	North				= "в мили",
	South				= "сзади",
	HealthInfo			= "Уровень здоровья",
	MeteorTargets		= "ОМФГ Метеоры!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Довольно! Пора покончить с этим.",--More reliable then adds method.
	TransitionEnded2	= "Сульфурас уничтожит вас!",--More reliable then adds method.
	TransitionEnded3	= "На колени, смертные!",
	Defeat				= "Слишком рано!.. Вы пришли слишком рано…",
	Phase4				= "Too soon..."
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
	StaffEvent				= "Ветвь Нордрассила яростно реагирует на прикосновение",--Partial, not sure if pull detection will work with partials yet :\
	StaffTrees				= "Из-под земли появляются пылающие древни, чтобы помощь защитнику!",--Might add a spec warning for this later.
	StaffTransition			= "Пламя, пожирающее измученного заступника, меркнет."
})