if GetLocale() ~= "koKR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "$spell:111850 주문에 대한 거리 프레임 표시(8m)\n(효과가 있을 경우 모든 플레이어를 표시, 효과가 없으면 효과가 있는 플레이어만 표시)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})

------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "고맙다, 이방인이여. 날 자유롭게 해줘서."
}

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s 종료"
})

L:SetTimerLocalization({
	timerSpecialCD			= "다음 특수 공격"
})

L:SetOptionLocalization({
	warnHideOver			= "$spell:123244 종료 알림 보기",
	timerSpecialCD			= "다음 특수 공격까지 남은시간 바 표시",
	SetIconOnGuard			= "$journal:6224에 전술 목표 아이콘 설정"
})

L:SetMiscLocalization{
	Victory	= "아... 앗! 내가 무슨...? 혹시...? 너무... 흐릿해."--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

