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
	WarningSpark		= "Призыв Искры мощи",
	WarningVortex		= "Воронка",
	WarningBreathSoon	= "Скоро Дыхание чар",
	WarningBreath		= "Дыхание чар!",
	WarningSurge		= ">%s< в поле сверкающей энергии",
	WarningVortexSoon	= "Скоро Воронка",
	WarningSurgeYou		= "На вас аура Прилива мощи!"
})

L:SetTimerLocalization({
	TimerSpark			= "Следующая Искра мощи",
	TimerVortex			= "Воронка",
	TimerBreath			= "Дыхание чар",
	TimerVortexCD		= "Перезарядка Воронки"
})

L:SetOptionLocalization({
	WarningSpark		= "Объявлять появление Искры мощи",
	WarningVortex		= "Объявлять появление Воронки",
	WarningBreathSoon	= "Предупреждать о приближающемся Дыхании чар",
	WarningBreath		= "Объявлять Дыхание чар",
	WarningSurge		= "Объявлять Прилив мощи",
	TimerSpark			= "Отображать отсчет времени до призыва Искры мощи",
	TimerVortex			= "Отображать отсчет времени до Воронки",
	TimerBreath			= "Отображать отсчет времени до Дыхания чар",
	TimerVortexCD		= "Отображать временя до перезарядки Воронки (неточно)",
	WarningVortexSoon	= "Предупреждать о скором появлении Воронки (неточно)",
	WarningSurgeYou		= "Отображать спец-предупреждение для Прилива мощи"
})

L:SetMiscLocalization({
	YellPull			= "Все, моему терпению пришел конец. Я от тебя избавлюсь!",
	EmoteSpark			= "Искра мощи появляется из ближайшей расселины!",
	YellPhase2			= "Я рассчитывал быстро покончить с вами",
	EmoteBreath			= "Малигос глубоко вздыхает.",
	YellBreath			= "Тебе не добиться своего, пока бьется мое сердце!",
	YellPhase3			= "А-а, вот и твои благодетели!"
})

