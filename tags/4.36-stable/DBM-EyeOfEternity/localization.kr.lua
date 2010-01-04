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
	WarningSpark		= "마력의 불꽃",
	WarningBreathSoon	= "곧 깊은 숨결",
	WarningBreath		= "깊은 숨결!"
})

L:SetTimerLocalization({
	TimerSpark		= "다음 마력의 불꽃",
	TimerBreath		= "다음 깊은 숨결",
})

L:SetOptionLocalization({
	WarningSpark		= "마력의 불꽃 경고 보기",
	WarningBreathSoon	= "깊은 숨결 사전 경고 보기",
	WarningBreath		= "깊은 숨결 경고 보기",
	TimerSpark			= "마력의 불꽃 타이머 보기",
	TimerBreath			= "깊은 숨결 타이머 보기"
})

L:SetMiscLocalization({
	YellPull		= "더는 참을 수가 없구나. 다 없애 버리겠다!",
	EmoteSpark		= "마력의 불꽃이 근처에 있는 틈에서 올라옵니다!",
	YellPhase2		= "되도록 빨리 끝내 주고 싶었다만",
--	EmoteBreath		= "%가 숨을 깊게 들이마십니다.",
	EmoteBreath		= "숨을 깊게 들이마십니다.",	
	YellBreath		= "내가 숨 쉬는 한, 너희는 이길 수 없다!",
	YellPhase3		= "네놈들의 후원자가 나타났구나"
})

