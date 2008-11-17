if GetLocale() ~= "deDE" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetWarningLocalization({
	WarningSpark		= "Energiefunke da!",
	WarningVortex		= "Vortex",
	WarningBreathSoon	= "Tiefer Atem bald",
	WarningBreath		= "Tiefer Atem!",
	WarningSurge		= "Kraftsog auf >%s<",
	WarningVortexSoon	= "Vortex bald"
})

L:SetTimerLocalization({
	TimerSpark		= "Energiefunke",
	TimerVortex		= "Vortex",
	TimerBreath		= "Tiefer Atem",
	TimerVortexCD	= "Vortex Cooldown"
})

L:SetOptionLocalization({
	WarningSpark		= "Warnung für Energiefunke anzeigen",
	WarningVortex		= "Warnung für Vortex anzeigen",
	WarningBreathSoon	= "Vorwarnung für Tiefen Atem anzeigen",
	WarningBreath		= "Warnung für Tiefen Atem anzeigen",
	WarningSurge		= "Warnung für Kraftsog anzeigen",
	TimerSpark			= "Timer für Energiefunke anzeigen",
	TimerVortex			= "Timer für Vortex anzeigen",
	TimerBreath			= "Timer für Tiefen Atem anzeigen",
	TimerVortexCD		= "Timer für Vortex Cooldown anzeigen (ungenau)",
	WarningVortexSoon	= "Vorwarnung für Vortex anzeigen (ungenau)"
})

L:SetMiscLocalization({ -- todo!
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
	YellPhase3		= "Now your benefactors make their"
})

