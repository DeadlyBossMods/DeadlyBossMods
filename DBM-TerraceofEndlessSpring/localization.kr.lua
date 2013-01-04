if GetLocale() ~= "koKR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "$spell:111850 주문에 대한 거리 창 보기(8m)\n(영향을 받은 경우 모든 공격대원을 표시, 그 외에는 대상자만 표시)",
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
	warnHideProgress		= "공격횟수 : %s, 피해량: %s, 경과시간: %s초"
})

L:SetTimerLocalization({
	timerSpecialCD			= "숨기/저리 가! 가능 (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "$spell:123244 종료 알림 보기",
	warnHideProgress		= "$spell:123244 종료 후 공격 내용에 대한 알림 보기",
	timerSpecialCD			= "$spell:123244 또는 $spell:123461 대기시간 바 표시",
	SetIconOnGuard			= "$journal:6224에 전술 목표 아이콘 설정",
	RangeFrame				= "$spell:123121 주문에 대한 거리 창 보기(3m)\n(숨기 중일때는 모든 공격대원 보임, 그 외에는 방어전담만 보임)",
	GWHealthFrame			= "우두머리 체력 바 사용시 $spell:123461 사라짐까지 남은 체력도 함께 보기"
})

L:SetMiscLocalization{
	Victory	= "아... 앗! 내가 무슨...? 혹시...? 너무... 흐릿해."
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "건너편으로 이동!",
	MoveWarningRight			= "오른쪽으로 이동!",
	MoveWarningBack				= "이전 위치로 이동!",
	specWarnBreathOfFearSoon	= "곧 공포 숨결 - 장벽 안으로 이동하세요!",
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "다음 용오름/혼비백산/일격",
	timerSpoHudCD				= "혼비백산/용오름 가능",
	timerSpoStrCD				= "용오름/일격 가능",
	timerHudStrCD				= "혼비백산/일격 가능"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "$spell:119414 시전 전에 $spell:117964 효과가 없을 경우 특수 경고 보기",
})

L:SetOptionLocalization({
	RangeFrame					= "$spell:119519 주문에 대한 거리 창 보기(2m)",
	MoveWarningForward			= "$spell:120047 시전 도중 건너편으로 이동 특수 경고 보기",
	MoveWarningRight			= "$spell:120047 시전 도중 오른쪽으로 이동 특수 경고 보기",
	MoveWarningBack				= "$spell:120047 종료 후 원래 위치로 이동 특수 경고 보기",
	timerSpecialAbilityCD		= "다음 $spell:120519 또는 $spell:120629 또는 $spell:120672 바 표시",
	timerSpoHudCD				= "$spell:120629 또는 $spell:120519 대기시간 바 표시",
	timerSpoStrCD				= "$spell:120519 또는 $spell:120672 대기시간 바 표시",
	timerHudStrCD				= "$spell:120629 또는 $spell:120672 대기시간 바 표시"
})
