if GetLocale() ~= "koKR" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "말리고스"
})

L:SetWarningLocalization({
	WarningSpark		= "마력의 불꽃 생성",
	WarningVortex		= "회오리",
	WarningBreathSoon	= "Deep Breath soon",
	WarningBreath		= "Deep Breath!",
	WarningSurge		= "Surge on >%s<",
	WarningVortexSoon	= "곧 회오리",
	WarningSurgeYou		= "Surge of Power on You!"
})

L:SetTimerLocalization({
	TimerSpark		= "Next Spark",
	TimerVortex		= "회오리",
	TimerBreath		= "Deep Breath",
	TimerVortexCD	= "회오리 대기시간"
})

L:SetOptionLocalization({
	WarningSpark		= "Show Power Spark warning",
	WarningVortex		= "회오리 경보 보기",
	WarningBreathSoon	= "Show Deep Breath pre-warning",
	WarningBreath		= "Show Deep Breath warning",
	WarningSurge		= "Show Surge of Power warning",
	TimerSpark			= "Show Power Spark timer",
	TimerVortex			= "회오리 타이머 보기",
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

