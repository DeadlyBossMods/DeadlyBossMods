if GetLocale() ~= "koKR" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "곧 %s - 생존기 준비 또는 보스 이동!",
	specWarnBreakJasperChains	= "벽옥 석화 푸세요!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "석화중이지 않은 보스가 과부화되려고 할 때 특수 경고 보기",
	specWarnBreakJasperChains	= "$spell:130395 주문을 안전하게 해제할 수 있을 때 특수 경고 보기",
	ArrowOnJasperChains			= "$spell:130395 주문의 영향을 받은 경우 DBM 화살표 보기",
	InfoFrame					= "보스 기력, 석화상태, 석화 진행중인 보스에 대한 정보 프레임 보기"
})

L:SetMiscLocalization({
	Overload	= "과부하되기 직전입니다!"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "%d 단계"
})

L:SetOptionLocalization({
	WarnPhase	= "단계 전환 알림 보기",
	RangeFrame	= "지팡이의 혼 단계에서 거리 프레임 표시 (6m)",
	SetIconOnWS	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116784),
	SetIconOnAR	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116417)
})

L:SetMiscLocalization({
	Fire		= "오 고귀한 자여! 나와 함께 발라내자! 뼈에서 살을!",
	Arcane		= "오 세기의 현자여! 내게 비전의 지혜를 불어넣어라!",
	Nature		= "오 위대한 영혼이여! 내게 대지의 힘을 부여하라!",
	Shadow		= "과거의 위대한 영웅들이여! 너희의 방패를 빌려다오!"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	RangeFrame			= "거리 프레임 표시 (8m)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "죽을 시간이다!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "%d초 후 암흑의 방패"
})

L:SetTimerLocalization({
	timerUSRevive		= "불멸의 어둠 재형성",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "$spell:117697 주문의 사전 초읽기 경고 보기(5초 전부터)",
	timerUSRevive		= "$spell:117506 재형성까지 남은 시간 바 표시",
	timerRainOfArrowsCD = DBM_CORE_AUTO_TIMER_OPTIONS.cd:format(118122),
	RangeFrame			= "쑤베타이와 쯔안 단계에서 거리 프레임 표시 (8m)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "6초 후 가운데 바닥 사라짐 - 낙사 주의!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "가운데 바닥 사라짐"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "가운데 바닥이 무너지기 전에 특수 경고 보기",
	timerDespawnFloor			= "가운데 바닥이 무너지기 전까지 남은 시간 바 표시",
	SetIconOnDestabilized		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226)
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "$spell:116525 주문의 영향을 받은 플레이어를 정보 프레임에 표시",
	CountOutCombo	= "$journal:5673 시전 횟수를 초읽기 소리로 읽기\n알림: 초 읽기 소리가 Corsica (Female)로 설정되어 있을때만 작동합니다.",
	ArrowOnCombo	= "$journal:5673 도중 DBM 화살표 표시\n알림: 방어전담이 보스 앞에 있고 나머지 공격대원이 뒤에 있을때를 기준으로 합니다."
})

L:SetMiscLocalization({
	Pull		= "기계가 윙윙거리며 동작하기 시작합니다! 아래층으로 가십시오!",--Emote
	Rage		= "황제의 분노가 온 언덕에 울려퍼진다.",--Yell
	Strength	= "황제의 힘이 벽감에 나타납니다!",--Emote
	Courage		= "황제의 용기가 벽감에 나타납니다!",--Emote
	Boss		= "거대한 모구 조형체 둘이 큰 벽감에 나타납니다!"--Emote
})
