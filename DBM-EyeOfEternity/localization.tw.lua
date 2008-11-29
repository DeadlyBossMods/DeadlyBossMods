if GetLocale() ~= "zhTW" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "瑪里苟斯"
})

L:SetWarningLocalization({
	WarningSpark		= "力量火花出現",
	WarningVortex		= "漩渦",
	WarningBreathSoon	= "即將深呼吸",
	WarningBreath		= "深呼吸!",
	WarningSurge		= "奔騰在 >%s<",
	WarningVortexSoon	= "即將漩渦",
	WarningSurgeYou		= "力量奔騰在你身上!"
})

L:SetTimerLocalization({
	TimerSpark		= "下次力量火花",
	TimerVortex		= "漩渦",
	TimerBreath		= "深呼吸",
	TimerVortexCD	= "漩渦冷卻"
})

L:SetOptionLocalization({
	WarningSpark		= "顯示力量火花警告",
	WarningVortex		= "顯示漩渦警告",
	WarningBreathSoon	= "顯示深呼吸預先警告",
	WarningBreath		= "顯示深呼吸警告",
	WarningSurge		= "顯示力量奔騰警告",
	TimerSpark			= "顯示力量火花計時",
	TimerVortex			= "顯示漩渦計時",
	TimerBreath			= "顯示深呼吸計時",
	TimerVortexCD		= "顯示漩渦冷卻計時 (inaccurate)",
	WarningVortexSoon	= "顯示漩渦預先警告 (inaccurate)",
	WarningSurgeYou		= "顯示特殊警告當你被力量奔騰"
})

L:SetMiscLocalization({
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
	YellPhase3		= "Now your benefactors make their"
})

