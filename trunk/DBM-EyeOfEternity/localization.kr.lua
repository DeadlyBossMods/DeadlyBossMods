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
	WarningBreathSoon	= "곧 깊은 숨결",
	WarningBreath		= "깊은 숨결!",
	WarningSurge		= ">%s< 에게 마력의 쇄도",
	WarningVortexSoon	= "곧 회오리",
	WarningSurgeYou		= "당신에게 마력의 쇄도!"
})

L:SetTimerLocalization({
	TimerSpark		= "다음 마력의 불꽃",
	TimerVortex		= "회오리",
	TimerBreath		= "깊은 숨결",
	TimerVortexCD	= "회오리 대기시간"
})

L:SetOptionLocalization({
	WarningSpark		= "마력의 불꽃 경보 보기",
	WarningVortex		= "회오리 경보 보기",
	WarningBreathSoon	= "깊은 숨결 사전 경보 보기",
	WarningBreath		= "깊은 숨결 경보 보기",
	WarningSurge		= "마력의 쇄도 경보 보기",
	TimerSpark			= "마력의 불꽃 타이머 보기",
	TimerVortex			= "회오리 타이머 보기",
	TimerBreath			= "깊은 숨결 타이머 보기",
	TimerVortexCD		= "회오리 쿨다운 타이머 보기(부정확함;;)",
	WarningVortexSoon	= "회오리 사전 경보 보기 (부정확함;;)",
	WarningSurgeYou		= "마력의 쇄도의 시전 대상의 플레이어에게 전술 표시를 지정합니다.(부정확함)"
})

L:SetMiscLocalization({
	YellPull		= "더는 참을 수가 없구나. 다 없애 버리겠다!",
	EmoteSpark		= "마력의 불꽃이 근처에 있는 틈에서 올라옵니다!",
	YellPhase2		= "되도록 빨리 끝내 주고 싶었다만",
	EmoteBreath		= "%s takes a deep breath.",
	YellBreath		= "내가 숨 쉬는 한, 너희는 이길 수 없다!",
	YellPhase3		= "네놈들의 후원자가 나타났구나"
})

