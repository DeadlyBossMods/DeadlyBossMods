if GetLocale() ~= "koKR" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "인간 대포알"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "놀 때려잡기"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "게임 종료. 획득 점수 %d 점, 이 게임의 최대 점수 : %d 점",
	warnGameOverNoQuest	= "게임 종료. 이 게임의 최대 점수 : %d 점",
	warnGnoll			= "놀 등장",
	warnHogger			= "들창코 놀 등장",
	specWarnHogger		= "들창코 놀 등장!"
})

L:SetOptionLocalization({
	warnGameOver	= "진행 게임의 최대 점수 알림 보기",
	warnGnoll		= "놀 등장 알림 보기",
	warnHogger		= "들창코 놀 등장 알림 보기",
	specWarnHogger	= "들창코 놀 등장 특수 경고 보기"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "사격 연습장"
})

L:SetOptionLocalization({
	SetBubbles	= "$spell:101871 중일때 대화 말풍선을 숨김<br/>(전투 종료 후 원상태로 복구됨)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "통통 전차 게임"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "다크문 토끼"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "달송곳니"
})

L:SetWarningLocalization({
	specWarnCallPack		= "무리 소환 - 40미터 이상 떨어지세요!",
	specWarnMoonfangCurse	= "달송곳니의 저주 - 10미터 이상 떨어지세요!"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "평온초 대 구울"
})

L:SetWarningLocalization({
	warnTotalAdds	= "총공격 전까지 생성된 적 수 : %d",
	specWarnWave	= "총공격!"
})

L:SetTimerLocalization{
	timerWave		= "다음 총공격"
}

L:SetOptionLocalization({
	warnTotalAdds	= "각 총공격마다 이전 단계에 생성된 적 수 보기",
	specWarnWave	= "총공격 특수 경고 보기",
	timerWave		= "다음 총공격 바 보기"
})

L:SetMiscLocalization({
	MassiveWave		= "좀비의 총공격이 시작됐습니다!"
})
