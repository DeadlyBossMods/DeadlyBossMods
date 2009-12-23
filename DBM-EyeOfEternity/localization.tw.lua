if GetLocale() ~= "zhTW" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name 			= "瑪里苟斯"
})

L:SetWarningLocalization({
	WarningSpark		= "力量火花 出現了",
	WarningBreathSoon	= "秘法之息 即將到來",
	WarningBreath		= "秘法之息"
})

L:SetTimerLocalization({
	TimerSpark		= "下一次 力量火花",
	TimerBreath		= "下一次 秘法之息"
})

L:SetOptionLocalization({
	WarningSpark		= "為力量火花顯示警告",
	WarningBreathSoon	= "為秘法之息顯示預先警告",
	WarningBreath		= "為秘法之息顯示警告",
	TimerSpark		= "為下一次 力量火花顯示計時器",
	TimerBreath		= "為下一次 秘法之息顯示計時器"
})

L:SetMiscLocalization({
	YellPull		= "我的耐心到此為止了。我要親自消滅你們!",
	EmoteSpark		= "一個力量火花從附近的裂縫中形成。",
	YellPhase2		= "我原本只是想盡快結束你們的生命",
	EmoteBreath		= "%s深深地吸了一口氣。",
	YellBreath		= "只要我的龍息尚存，你們就毫無機會!",
	YellPhase3		= "現在你們幕後的主使終於出現"
})