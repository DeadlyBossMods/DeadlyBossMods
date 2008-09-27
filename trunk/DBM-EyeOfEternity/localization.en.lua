local L

---------------
--  Shadron  --
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
})

L:SetTimerLocalization({
	TimerSpark	= "Next Spark",
	TimerVortex	= "Vortex",
	TimerBreath	= "Deep Breath",
})

L:SetOptionLocalization({
	WarningSpark		= "Show Power Spark warning",
	WarningVortex		= "Show Vortex warning",
	WarningBreathSoon	= "Show Deep Breath pre-warning",
	WarningBreath		= "Show Deep Breath warning",
	TimerSpark			= "Show Power Spark timer",
	TimerVortex			= "Show Vortex timer",
	TimerBreath			= "Show Deep Breath timer",
})

L:SetMiscLocalization({
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
})

