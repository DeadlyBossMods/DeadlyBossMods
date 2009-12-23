local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetWarningLocalization({
	WarningSpark		= "Power Spark",
	WarningBreathSoon	= "Deep Breath soon",
	WarningBreath		= "Deep Breath"
})

L:SetTimerLocalization({
	TimerSpark	= "Next Power Spark",
	TimerBreath	= "Next Deep Breath"
})

L:SetOptionLocalization({
	WarningSpark		= "Show warning for Power Spark",
	WarningBreathSoon	= "Show pre-warning for Deep Breath",
	WarningBreath		= "Show warning for Deep Breath",
	TimerSpark			= "Show timer for next Power Spark",
	TimerBreath			= "Show timer for next Deep Breath"
})

L:SetMiscLocalization({
	YellPull	= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark	= "A Power Spark forms from a nearby rift!",
	YellPhase2	= "I had hoped to end your lives quickly",
	EmoteBreath	= "%s takes a deep breath.",
	YellBreath	= "You will not succeed while I draw breath!",
	YellPhase3	= "Now your benefactors make their"
})

