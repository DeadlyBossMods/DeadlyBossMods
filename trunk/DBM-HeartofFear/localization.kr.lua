if GetLocale() ~= "koKR" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "단상 이동!"
})

L:SetOptionLocalization({
	specwarnPlatform	= "보스가 단상 이동시 특수 경고 보기",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "황실 장로 조르로크가 단상으로 날아갑니다!",
	Defeat		= "우리는 어두운 공허의 절망에 지지 않으리라. 우리가 죽는 것이 그분의 뜻이라면, 그대로 따르리라."
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "$spell:122949 주문의 영향을 누군가 받은 경우 DBM 화살표 보기",
	RangeFrame			= "$spell:123175 주문의 영향을 받은 경우 거리 프레임 표시(8m)"
})

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetOptionLocalization({
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "지원"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnAmberExplosion			= "%s 주문시전: %s",
	warnInterruptsAvailable		= "%s의 주문 차단 가능: %s",
	specwarnWillPower			= "의지력 낮음!",
	specwarnAmberExplosionYou	= "당신에게 %s 사용 - 차단!"
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "다음 %s: %s"
}

L:SetOptionLocalization({
	warnAmberExplosion			= "$spell:122398 시전시 알림 보기(시전자 포함)",
	warnInterruptsAvailable		= "호박석 괴수 탑승자중, 누가 $spell:122402 주문을 차단할 수 있는지 알림 보기",
	specwarnWillPower			= "피조물 탑승 도중 의지력이 낮을 때 특수 경고 보기",
	specwarnAmberExplosionYou	= "자신의 호박석 괴수가 $spell:122402 주문을 시전할때 특수 경고 보기(차단)",
	timerAmberExplosionAMCD		= "호박석 괴수의 다음 $spell:122402 바 표시",
	InfoFrame					= "의지력 정보 프레임 보기 (현재 임시 적용)"
})

L:SetMiscLocalization({
	WillPower					= "의지력"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame		= "$spell:125390 주문의 영향을 받은 플레이어를 정보 프레임에 표시",
	RangeFrame		= "$spell:123735 주문의 영향을 받은 경우 거리 프레임 표시(5m)"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "시선 집중 대상"
})
