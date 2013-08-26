if GetLocale() ~= "koKR" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "곧 %s - 생존기 준비 또는 수호자 이동!",
	specWarnBreakJasperChains	= "벽옥 석화 푸세요!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "석화중이지 않은 수호자가 과부화되려고 할 때 특수 경고 보기",
	specWarnBreakJasperChains	= "$spell:130395 주문을 안전하게 해제할 수 있을 때 특수 경고 보기",
	ArrowOnJasperChains			= "$spell:130395 주문의 영향을 받은 경우 DBM 화살표 보기",
	InfoFrame					= "수호자 기력, 현재 석화상태, 석화 진행중인 수호자에 대한 정보 창 보기"
})

L:SetMiscLocalization({
	Overload	= "과부하되기 직전입니다!"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "%d 단계",
	specWarnBarrierNow	= "지금 무효화의 장벽 사용!"
})

L:SetOptionLocalization({
	WarnPhase			= "단계 전환 알림 보기",
	specWarnBarrierNow	= "$spell:115817을 사용해야 할 때 특수 경고 보기(무작위 공격대에서만)",
	RangeFrame			= "지팡이의 혼 단계에서" .. DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6")
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
	DarknessSoon		= "$spell:117697 주문의 사전 초읽기 알림 보기(5초 전부터)",
	timerUSRevive		= "$spell:117506 재형성까지 남은시간 바 표시",
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
	SetIconOnCreature			= "$journal:6193에 전술 목표 아이콘 설정"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "$spell:116525 주문의 영향을 받은 대상을 정보 창에서 보기",
	CountOutCombo	= "$journal:5673 시전 횟수를 초읽기 소리로 읽기<br/>알림: 초 읽기 소리가 Corsica (Female)로 설정되어 있을때만 작동합니다.",
	ArrowOnCombo	= "$journal:5673 도중 이동해야 할 방향을 DBM 화살표로 보기<br/>알림: 방어전담이 우두머리 앞에 있고 나머지 공격대원이 뒤에 있을때를 기준으로 합니다."
})

L:SetMiscLocalization({
	Pull		= "기계가 윙윙거리며 동작하기 시작합니다! 아래층으로 가십시오!",--Emote
	Rage		= "황제의 분노가 온 언덕에 울려퍼진다.",--Yell
	Strength	= "황제의 힘이 벽감에 나타납니다!",--Emote
	Courage		= "황제의 용기가 벽감에 나타납니다!",--Emote
	Boss		= "거대한 모구 조형체 둘이 큰 벽감에 나타납니다!"--Emote
})
