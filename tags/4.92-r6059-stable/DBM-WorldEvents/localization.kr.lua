if GetLocale() ~= "koKR" then return end

local L

--------------------
-- Coren Direbrew --
--------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "코렌 다이어브루"
})

L:SetWarningLocalization({
	specWarnBrew			= "흑맥주요정이 맥주를 다시 던지기전에 마셔버리세요!",
	specWarnBrewStun		= "힌트: 맥주를 들고있네요. 흑맥주요정의 맥주가 오기전에 마셔버리면 됩니다!"
})

L:SetOptionLocalization({
	specWarnBrew			= "$spell:47376의 특수 경고 보기",
	specWarnBrewStun		= "$spell:47340의 특수 경고 보기",
	YellOnBarrel			= "$spell:51413 외치기"
})

L:SetMiscLocalization{
	YellBarrel				= "저에게 맥주통!"
}

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "저주받은 기사"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "고동치는 호박 생성!",
	warnHorsemanHead			= "머리 생성! 머리로 대상 전환!"
})

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작"
}

L:SetOptionLocalization({
	TimerCombatStart			= "전투 시작 타이머 보기",
	warnHorsemanSoldiers		= "고동치는 호박 소환 경고 보기",
	warnHorsemanHead			= "저주받은 기사의 머리 대상 전환 특수 경고 보기"
})

L:SetMiscLocalization({
	HorsemanSummon				= "기사여 일어나라...",
	HorsemanHead				= "냉큼 이리 와라, 이 얼간아!",
	HorsemanSoldiers			= "일어나라, 병사들이여. 나가서 싸워라! 이 쇠락한 기사에게 승리를 안겨다오!",
	SayCombatEnd				= "죽음은 이미 겪어 보았노라. 이제 어떤 모험이 날 기다리는가?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "화학회사 삼인방"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "훔멜 활성화",
	BaxterActive	= "벡스터 활성화",
	FryeActive		= "프라이 활성화"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "화학회사 삼인방 활성화 타이머 보기"
})

L:SetMiscLocalization({
	SayCombatStart		= "저들이 내가 누군지와 왜 이 일을 하는지 말해주려고 귀찮게 하든가?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "아훈"
})

L:SetWarningLocalization({
	Submerged		= "아훈 잠수",
	Emerged			= "아훈 등장",
	specWarnAttack	= "아훈이 약해졌습니다. - 딜링 고고싱!"
})

L:SetTimerLocalization{
	SubmergTimer	= "잠수",
	EmergeTimer		= "등장",
	TimerCombat		= "전투 시작"
}

L:SetOptionLocalization({
	Submerged		= "아훈 잠수 경고 보기",
	Emerged			= "아훈 등장 경고 보기",
	specWarnAttack	= "아훈이 약해 질때 공격 특수 경보 보기",
	SubmergTimer	= "잠수 타이머 보기",
	EmergeTimer		= "등장 타이머 보기",
	TimerCombat		= "전투 시작 타이머 보기",
})

L:SetMiscLocalization({
	Pull			= "얼음 기둥이 녹아 내렸다!"
})