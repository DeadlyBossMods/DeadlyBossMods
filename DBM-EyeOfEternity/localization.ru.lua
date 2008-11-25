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
	WarningBreathSoon	= "Скоро Дыхание Чар",
	WarningBreath		= "Дыхание Чар!",
	WarningSurge		= ">%s< в поле сверкающей энергии",
	WarningVortexSoon	= "Скоро Воронка",
	WarningSurgeYou		= "На вас аура Прилива мощи!"
})

L:SetTimerLocalization({
	TimerSpark			= "Следующий призыв Искры мощи",
	TimerVortex			= "Воронка",
	TimerBreath			= "Дыхание Чар",
	TimerVortexCD		= "Перезарядка Воронки"
})

L:SetOptionLocalization({
	WarningSpark		= "Показать предупреждение для призыва Искры мощи",
	WarningVortex		= "Показать предупреждение для Воронки",
	WarningBreathSoon	= "Показать пред-предупреждение Дыхания Чар",
	WarningBreath		= "Показать предупреждение для Дыхания Чар",
	WarningSurge		= "Показать предупреждение для Прилива мощи",
	TimerSpark			= "Показать отсчет времени до призыва Искры мощи",
	TimerVortex			= "Показать отсчет времени до Воронки",
	TimerBreath			= "Показать отсчет времени до Дыхания Чар",
	TimerVortexCD		= "Показать отсчет времени до перезарядки Воронки (неточно)",
	WarningVortexSoon	= "Показать пред-предупреждение Воронки (неточно)",
	WarningSurgeYou		= "Показать спец-предупреждение для Прилива мощи"
})

L:SetMiscLocalization({
	YellPull			= "My patience has reached its limit. I will be rid of you!", -- correct this
	EmoteSpark			= "A Power Spark forms from a nearby rift!", -- correct this
	YellPhase2			= "I had hoped to end your lives quickly", -- correct this
	EmoteBreath			= "%s takes a deep breath.", -- correct this
	YellBreath			= "You will not succeed while I draw breath!", -- correct this
	YellPhase3			= "Now your benefactors make their" -- correct this
})

