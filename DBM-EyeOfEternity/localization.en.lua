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
	WarningBreath		= "Deep Breath",
	WarningSurge		= "Surge of Power on >%s<",
	WarningVortexSoon	= "Vortex soon",
	WarningSurgeYou		= "Surge of Power on you"
})

L:SetTimerLocalization({
	TimerSpark		= "Next Power Spark",
	TimerVortex		= "Vortex",
	TimerBreath		= "Deep Breath",
	TimerVortexCD	= "Vortex cooldown"
})

L:SetOptionLocalization({
	WarningSpark		= "Show warning for Power Spark",
	WarningVortex		= "Show warning for Vortex",
	WarningBreathSoon	= "Show pre-warning for Deep Breath",
	WarningBreath		= "Show warning for Deep Breath",
	WarningSurge		= "Announce Surge of Power targets",
	TimerSpark			= "Show timer for Power Spark",
	TimerVortex			= "Show timer for Vortex",
	TimerBreath			= "Show timer for Deep Breath",
	TimerVortexCD		= "Show timer for Vortex cooldown (unreliable)",
	WarningVortexSoon	= "Show pre-warning for Vortex (unreliable)",
	WarningSurgeYou		= "Show warning when you are affected by Surge of Power"
})

L:SetMiscLocalization({
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
	YellPhase3		= "Now your benefactors make their"
})

