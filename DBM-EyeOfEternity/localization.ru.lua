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
	WarningBreath		= "Дыхание чар"
})

L:SetTimerLocalization({
	TimerSpark	= "Искра мощи",
	TimerBreath	= "Дыхание чар"
})

L:SetOptionLocalization({
	WarningSpark		= "Объявлять появление Искры мощи",
	WarningBreathSoon	= "Предупреждать о приближающемся Дыхании чар",
	WarningBreath		= "Объявлять Дыхание чар",
	TimerSpark			= "Отображать отсчет времени до призыва Искры мощи",
	TimerBreath			= "Отображать отсчет времени до Дыхания чар",
})

L:SetMiscLocalization({
	YellPull	= "Мое терпение лопнуло! Пора от вас избавиться!",
	EmoteSpark	= "Искра мощи появляется из ближайшей расселины!",
	YellPhase2	= "Я надеялся быстро с вами покончить",
	EmoteBreath	= "%s глубоко вдыхает.",
	YellBreath	= "Пока я дышу, вам не добиться своего!",
	YellPhase3	= "Вот и ваши благодетели появились"
})

