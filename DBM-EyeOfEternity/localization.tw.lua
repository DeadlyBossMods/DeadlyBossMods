if GetLocale() ~= "zhTW" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "瑪里苛斯"
})

L:SetWarningLocalization({
	WarningSpark		= "力量火花 出現了",
	WarningVortex		= "旋渦",
	WarningBreathSoon	= "深呼吸 即將到來",
	WarningBreath		= "深呼吸!",
	WarningSurge		= "力量奔騰: >%s<",
	WarningVortexSoon	= "旋渦 即將到來",
	WarningSurgeYou		= "你中了力量奔騰!"
})

L:SetTimerLocalization({
	TimerSpark		= "下一個火花",
	TimerVortex		= "旋渦",
	TimerBreath		= "深呼吸",
	TimerVortexCD		= "旋渦冷卻"
})

L:SetOptionLocalization({
	WarningSpark		= "顯示力量火花警告",
	WarningVortex		= "顯示旋渦警告",
	WarningBreathSoon	= "顯示深呼吸的預先警告",
	WarningBreath		= "顯示深呼吸警告",
	WarningSurge		= "顯示力量奔騰警告",
	TimerSpark		= "顯示力量火花計時器",
	TimerVortex		= "顯示旋渦計時器",
	TimerBreath		= "顯示深呼吸計時器",
	TimerVortexCD		= "顯示旋渦的冷卻計時器 (不準確)",
	WarningVortexSoon	= "顯示旋渦的預先警告 (不準確)",
	WarningSurgeYou		= "當你中了力量奔騰時顯示特別警告"
})

L:SetMiscLocalization({
	YellPull		= "My patience has reached its limit. I will be rid of you!",
	EmoteSpark		= "A Power Spark forms from a nearby rift!",
	YellPhase2		= "I had hoped to end your lives quickly",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "You will not succeed while I draw breath!",
	YellPhase3		= "Now your benefactors make their"
})
