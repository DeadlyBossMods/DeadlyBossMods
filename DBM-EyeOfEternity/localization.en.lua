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
	WarningSurgeYou		= "Surge of Power on you!"
})

L:SetTimerLocalization({
	TimerSpark		= "Next Spark",
	TimerVortex		= "Vortex",
	TimerBreath		= "Deep Breath",
	TimerVortexCD	= "Vortex Cooldown"
})

L:SetOptionLocalization({
	WarningSpark		= "Show warning for Power Spark",
	WarningVortex		= "Show warning for Vortex",
	WarningBreathSoon	= "Show pre-warning for Deep Breath",
	WarningBreath		= "Show warning for Deep Breath",
	WarningSurge		= "Show warning for Surge of Power",
	TimerSpark			= "Show Power Spark timer",
	TimerVortex			= "Show Vortex timer",
	TimerBreath			= "Show Deep Breath timer",
	TimerVortexCD		= "Show Vortex cooldown timer (inaccurate)",
	WarningVortexSoon	= "Show pre-warning for Vortex (inaccurate)",
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

