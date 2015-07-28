if GetLocale() ~= "koKR" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "오멘"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive	= "훔멜 활성화",
	BaxterActive	= "벡스터 활성화",
	FryeActive		= "프라이 활성화"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "각 우두머리 활성화 바 보기"
})

L:SetMiscLocalization({
	SayCombatStart		= "저들이 내가 누군지와 왜 이 일을 하는지 말해주려고 귀찮게 하든가?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "등장",
	specWarnAttack	= "아훈 약화 - 공격 시작!"
})

L:SetTimerLocalization{
	SubmergTimer	= "잠수",
	EmergeTimer		= "등장"
}

L:SetOptionLocalization({
	Emerged			= "등장 알림 보기",
	specWarnAttack	= "아훈 약화 특수 경고 보기",
	SubmergTimer	= "잠수 바 보기",
	EmergeTimer		= "등장 바 보기"
})

L:SetMiscLocalization({
	Pull			= "얼음 기둥이 녹아 내렸다!"
})

--------------------
-- Coren Direbrew --
--------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "가방에 있는 맥주 사용!",
	specWarnBrewStun	= "맥주를 미리 사용하셔야 기절하지 않습니다!"
})

L:SetOptionLocalization({
	specWarnBrew		= "$spell:47376 특수 경고 보기",
	specWarnBrewStun	= "$spell:47340 특수 경고 보기",
	YellOnBarrel		= "$spell:51413 대상이 된 경우 대화로 알리기"
})

L:SetMiscLocalization{
	YellBarrel			= "저에게 맥주통!"
}

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "%d 단계",
	warnHorsemanSoldiers	= "고동치는 호박 생성",
	warnHorsemanHead		= "저주받은 기사의 머리 생성"
})

L:SetOptionLocalization({
	WarnPhase				= "단계 전환 알림 보기",
	warnHorsemanSoldiers	= "고동치는 호박 생성 알림 보기",
	warnHorsemanHead		= "저주받은 기사 머리 생성 알림 보기"
})

L:SetMiscLocalization({
	HorsemanSummon		= "기사여, 일어나라...",
	HorsemanSoldiers	= "일어나라, 병사들이여. 나가서 싸워라! 이 쇠락한 기사에게 승리를 안겨다오!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "썩은내 그린치"
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
