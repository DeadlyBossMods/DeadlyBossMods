if GetLocale() ~= "koKR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "$spell:111850 주문에 대한 거리 프레임 표시(8m)\n(영향을 받은 경우 모든 공격대원을 표시, 그 외에는 대상자만 표시)",
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
	warnHideOver			= "%s 종료",
	warnHideProgress		= "숨기 진행상황 - 공격회수 : %s, 피해량: %s, 시간: %s초"
})

L:SetTimerLocalization({
	timerSpecialCD			= "숨기/저리 가! 대기시간"
})

L:SetOptionLocalization({
	warnHideOver			= "$spell:123244 종료 알림 보기",
	warnHideProgress		= "$spell:123244 진행 상황 알림 보기",
	timerSpecialCD			= "$spell:123244 또는 $spell:123461 대기시간 바 표시",
	SetIconOnGuard			= "$journal:6224에 전술 목표 아이콘 설정",
	RangeFrame				= "$spell:123121 주문에 대한 거리 프레임 표시(3m)\n(숨기 중일때는 모든 공격대원 보임, 그 외에는 방어전담만 보임)",
	GWHealthFrame			= "$spell:123461 주문 사라짐까지 남은 체력을 체력 프레임에 표시\n(보스 체력 프레임이 켜져 있어야 작동함)"
})

L:SetMiscLocalization{
	Victory	= "아... 앗! 내가 무슨...? 혹시...? 너무... 흐릿해."
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetOptionLocalization({
	RangeFrame			= "$spell:119519 주문에 대한 거리 프레임 표시(2m)"
})
