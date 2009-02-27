local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetWarningLocalization({
	WarningSpark		= "Power Spark spawned",
	WarningVortex		= "Vortex",
	WarningBreathSoon	= "Deep Breath soon",
	WarningBreath		= "Deep Breath!",
	WarningSurge		= "Surge on >%s<",
	WarningVortexSoon	= "Vortex soon",
	WarningSurgeYou		= "Surge of Power on You!"
})

L:SetTimerLocalization({
	TimerSpark		= "Next Spark",
	TimerVortex		= "Vortex",
	TimerBreath		= "Deep Breath",
	TimerVortexCD	= "Vortex Cooldown"
})

L:SetOptionLocalization({
	WarningSpark		= "Show Power Spark warning",
	WarningVortex		= "Show Vortex warning",
	WarningBreathSoon	= "Show Deep Breath pre-warning",
	WarningBreath		= "Show Deep Breath warning",
	WarningSurge		= "Show Surge of Power warning",
	TimerSpark			= "Show Power Spark timer",
	TimerVortex			= "Show Vortex timer",
	TimerBreath			= "Show Deep Breath timer",
	TimerVortexCD		= "Show Vortex Cooldown timer (inaccurate)",
	WarningVortexSoon	= "Show Vortex pre-warning (inaccurate)",
	WarningSurgeYou		= "Show special warning when you are afflicted by Surge of Power"
})

L:SetMiscLocalization({
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
	YellPhase3		= "Now your benefactors make their"
})

