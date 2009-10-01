if GetLocale() ~= "esES" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetWarningLocalization({
	WarningSpark		= "Aparece Chispazo",
	WarningVortex		= "Vórtice",
	WarningBreathSoon	= "Respira hondo pronto",
	WarningBreath		= "Respira Hondo!",
	WarningSurge		= "Oleada en >%s<",
	WarningVortexSoon	= "Vórtice pronto",
	WarningSurgeYou		= "Oleada de poder en ti!"
})

L:SetTimerLocalization({
	TimerSpark		= "Chizpazo en",
	TimerVortex		= "Vórtice",
	TimerBreath		= "Respira Hondo",
	TimerVortexCD	= "Vórtice CD"
})

L:SetOptionLocalization({
	WarningSpark		= "Mostrar aviso de Chizpaso",
	WarningVortex		= "Mostrar aviso de Vórtice",
	WarningBreathSoon	= "Mostrar aviso antes de Respira Hondo",
	WarningBreath		= "Mostrar aviso de Respira Hondo",
	WarningSurge		= "Mostrar aviso de Oleada de poder",
	TimerSpark			= "Mostrar tiempo para Chizpazo",
	TimerVortex			= "Mostrar tiempo para Vórtice",
	TimerBreath			= "Mostrar tiempo para Respira Hondo",
	TimerVortexCD		= "Mostrar tiempo de cd de Vórtice",
	WarningVortexSoon	= "Mostrar aviso de Vórtice pronto",
	WarningSurgeYou		= "Mostrar aviso especial si te afecta Oleada de poder"
})

L:SetMiscLocalization({
	YellPull		= "Habeis agotado mi paciencia. ¡Me desharé de vosotros!",
	EmoteSpark		= "¡Un Chispazo toma forma a partir de una falla cercana!",
	YellPhase2		= "Esperaba acabar con vuestras vidas rápidamente, pero habéis resultado más... resistentes de lo que pensaba. Aun así, vuestros esfuerzos son en vano. Esta guerra es culpa vuestra, imprudentes mortales descuidados. Yo hago lo que debo... y si eso implica vuestra extinción... ¡QUE ASÍ SEA!",
	EmoteBreath		= "%s respira hondo.",
	YellBreath		= "¡No lo conseguiréis mientras me quede aliento!",
	YellPhase3		= "Ahora aparecen vuestros benefactores, ¡pero llegan demasiado tarde! Los poderes aquí contenidos son suficientes para destruir el mundo diez veces. ¿Qué creéis que os harán a vosotros?"
})

