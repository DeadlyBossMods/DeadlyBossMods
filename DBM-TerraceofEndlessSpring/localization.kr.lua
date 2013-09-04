if GetLocale() ~= "koKR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "타락한 정수 순번 : %s 파티",
	specWarnYourGroup	= "타락한 정수 받을 차례입니다. 준비하세요!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "$spell:118191 파티 순서 알림 보기(25인 전용)<br/>참고: 1파-5번/2파-2번/3파-2번/4파-2번, 그 후 1/2/2/2 순서대로 알립니다.",
	specWarnYourGroup	= "$spell:118191를 받을 차례가 된 경우 특수 경고 보기(25인 전용)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(대상이 된 경우 모든 공격대원을 보임, 그 외에는 대상자만 보임)"
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
	timerSpecialCD			= "숨기/저리 가! 가능 (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "$spell:123244 종료 알림 보기",
	timerSpecialCD			= "$spell:123244 또는 $spell:123461 대기시간 바 보기",
	SetIconOnProtector		= "$journal:6224에 전술 목표 아이콘 설정<br/>(승급자가 1명 이상일 경우에는 오작동 할 수 있습니다.)",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 123121).."<br/>(숨기 중일때는 모든 공격대원 보임, 그 외에는 방어전담만 보임)",
	GWHealthFrame			= "우두머리 체력 바 사용시 $spell:123461 사라짐까지 남은체력도 함께 보기"
})

L:SetMiscLocalization{
	Victory	= "아... 앗! 내가 무슨...? 혹시...? 너무... 흐릿해."
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "건너편으로 이동!",
	MoveRight					= "오른쪽으로 이동!",
	MoveBack					= "이전 위치로 이동!",
	specWarnBreathOfFearSoon	= "곧 공포 숨결 - 장벽 안으로 이동하세요!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "다음 용오름/혼비백산/일격",
	timerSpoHudCD				= "혼비백산/용오름 가능",
	timerSpoStrCD				= "용오름/일격 가능",
	timerHudStrCD				= "혼비백산/일격 가능"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "외부 정자에 있을 때도 $spell:119414 알림 보기<br/>(가급적 설정하지 않기를 권장합니다. 공격대 진행자용 설정입니다.)",
	specWarnBreathOfFearSoon	= "$spell:119414 전에 $spell:117964 효과가 없을 경우 특수 경고 보기",
	specWarnMovement			= "$spell:120047 활성화 중에 이동 경고 보기<br/>(<a href=\"http://mysticalos.com/terraceofendlesssprings.jpg\">|cff3588ffhttp://mysticalos.com/terraceofendlesssprings.jpg|r</a> 또는 ShaOfFearAssist 애드온의 위치 정보 참고)",
	timerSpecialAbility			= "다음 $spell:120519 또는 $spell:120629 또는 $spell:120672 바 보기"
})
