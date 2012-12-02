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
	ArrowOnAttenuation	= "$spell:127834 시전 중에 이동해야 될 방향을 DBM 화살표로 표시",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "황실 장로 조르로크가 단상으로 날아갑니다!",
	Defeat				= "우리는 어두운 공허의 절망에 지지 않으리라. 우리가 죽는 것이 그분의 뜻이라면, 그대로 따르리라."
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "$spell:122949 주문의 영향을 누군가 받은 경우 DBM 화살표 보기",
	RangeFrame			= "$spell:123175 주문에 대한 거리 프레임 표시(8m)"
})

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "보라색 원 바깥으로 나가세요!"
})

L:SetOptionLocalization({
	specwarnUnder	= "보스의 보라색 원 안에 있을때 특수 경고 보기",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "있는 것을 감지하고"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "원군"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLifeTutor		= "1: 대상 차단/공격, 2: 본인 차단, 3: 체력/의지력 회복, 4: 피조물에서 탈출",
	warnAmberExplosion			= "주문시전 %2$s : >%1$s<",
	warnInterruptsAvailable		= "%s의 호박석 폭발 차단 가능: >%s<",
	specwarnWillPower			= "의지력 낮음!",
	specwarnAmberExplosionYou	= "당신에게 %s 사용 - 2번으로 차단!",
	specwarnAmberExplosionAM	= "%s 시전: %s - 1번으로 차단!",
	specwarnAmberExplosionOther	= "%s 시전: %s - 1번으로 차단!"
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "%s 대기시간: %s"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "돌연변이 피조물 탑승시 피조물 주문에 대한 설명 보기",
	warnAmberExplosion			= "$spell:122398 시전시 알림 보기(시전자 포함)",
	warnInterruptsAvailable		= "누가 $spell:122402 주문을 차단할 수 있는지에 대한 알림 보기",
	specwarnWillPower			= "피조물 탑승 도중 의지력이 낮을 때 특수 경고 보기",
	specwarnAmberExplosionYou	= "자신의 피조물이 $spell:122402 주문을 시전할때 특수 경고 보기(차단)",
	specwarnAmberExplosionAM	= "호박석 괴수가 $spell:122402 주문을 시전할때 특수 경고 보기(차단)",
	specwarnAmberExplosionOther	= "탑승자가 없는 피조물이 $spell:122398 주문을 시전할때 특수 경고 보기(차단)",
	timerAmberExplosionAMCD		= "호박석 괴수의 다음 $spell:122402 바 표시",
	InfoFrame					= "의지력 정보 프레임 보기",
	FixNameplates				= "전투 시작시 이름표 겹침 기능 끄기\n(전투 종료시에 원래 설정대로 돌아감)"
})

L:SetMiscLocalization({
	WillPower					= "의지력"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "호박석 덪 생성중 (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "$spell:125826 생성 과정 알림 보기", 
	InfoFrame			= "$spell:125390 주문의 영향을 받은 플레이어를 정보 프레임에 표시",
	RangeFrame			= "$spell:123735 주문에 대한 거리 프레임 표시(5m)",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "시선 집중 대상",
	YellPhase3			= "변명은 이제 지겹다, 여제! 당장 이 멍청이들을 쓸어버리지 않으면 내가 몸소 널 죽이겠다!"
})
