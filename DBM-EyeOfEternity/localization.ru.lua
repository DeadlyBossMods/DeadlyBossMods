if GetLocale() ~= "ruRU" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Малигос"
})

L:SetWarningLocalization({
	WarningSpark		= "Искра мощи",
	WarningBreathSoon	= "Скоро Дыхание чар",
	WarningBreath		= "Дыхание чар!",
	WarningSurge		= ">%s< под воздействием Прилива мощи",
	WarningSurgeYou		= "На вас аура Прилива мощи!"
})

L:SetTimerLocalization({
	TimerSpark		= "Искра мощи",
	TimerBreath		= "Дыхание чар"
})

L:SetOptionLocalization({
	WarningSpark		= "Объявлять появление Искры мощи",
	WarningBreathSoon	= "Предупреждать о приближающемся Дыхании чар",
	WarningBreath		= "Объявлять Дыхание чар",
	WarningSurge		= "Объявлять Прилив мощи",
	TimerSpark		= "Отображать отсчет времени до призыва Искры мощи",
	TimerBreath		= "Отображать отсчет времени до Дыхания чар",
	WarningSurgeYou		= "Отображать спец-предупреждение для Прилива мощи"
})

L:SetMiscLocalization({
	YellPull		= "Все, моему терпению пришел конец. Я от тебя избавлюсь!",
	EmoteSpark		= "Искра мощи появляется из ближайшей расселины!",
	YellPhase2		= "Я рассчитывал быстро покончить с вами",
	EmoteBreath		= "Малигос глубоко вздыхает.",
	YellBreath		= "Тебе не добиться своего, пока бьется мое сердце!",
	YellPhase3		= "А-а, вот и твои благодетели!"
})

