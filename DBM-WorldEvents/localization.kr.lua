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
	TrioActiveTimer		= "각 보스 활성화 타이머 바 보기"
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
	SubmergTimer	= "잠복",
	EmergeTimer		= "등장"
}

L:SetOptionLocalization({
	Emerged			= "등장 경고 보기",
	specWarnAttack	= "아훈 약화 특별 경고 보기",
	SubmergTimer	= "잠복 타이머 바 보기",
	EmergeTimer		= "등장 타이머 바 보기"
})

L:SetMiscLocalization({
	Pull			= "얼음 기둥이 녹아 내렸다!"
})

--------------------
-- Coren Direbrew --
--------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "다른 맥주가 넘어오기 전에 가방에 있는 맥주를 사용하세요!",
	specWarnBrewStun	= "힌트: 기절했습니다. 다음엔 맥주를 꼭 마시세요!"
})

L:SetOptionLocalization({
	specWarnBrew		= "$spell:47376 특별 경고 보기",
	specWarnBrewStun	= "$spell:47340 특별 경고 보기"
})

L:SetMiscLocalization{
	YellBarrel			= "나에게 맥주통!"
}

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "가을 축제"
})

L:SetOptionLocalization({
	NormalizeVolume			= "가을 축제 지역에선 자동으로 대화 음량이 배경음 음량에 맞게 평준화되어 소음을 해소합니다. (배경음이 설정되지 않았을 경우 대화 음량은 음소거 됩니다.)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "%d단계",
	warnHorsemanSoldiers	= "고동치는 호박 생성",
	warnHorsemanHead		= "저주받은 기사의 머리 등장"
})

L:SetOptionLocalization({
	WarnPhase				= "단계 전환 경고 보기",
	warnHorsemanSoldiers	= "고동치는 호박 등장 경고 보기",
	warnHorsemanHead		= "저주받은 기사 머리 등장 경고 보기"
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
	warnTotalAdds	= "총공격 전까지 생성된 적 수: %d",
	specWarnWave	= "총공격!"
})

L:SetTimerLocalization{
	timerWave		= "다음 총공격"
}

L:SetOptionLocalization({
	warnTotalAdds	= "각 총공격마다 이전 단계에 생성된 적 수 보기",
	specWarnWave	= "총공격 특별 경고 보기",
	timerWave		= "다음 총공격 타이머 바 보기"
})

L:SetMiscLocalization({
	MassiveWave		= "좀비의 총공격이 시작됐습니다!"
})

--------------------------
--  Demonic Invasions  --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "악마 침공"
})

--------------------------
--  Memories of Azeroth: Burning Crusade  --
--------------------------
L = DBM:GetModLocalization("BCEvent")

L:SetGeneralLocalization({
	name = "추억: 불타는 성전"
})

--------------------------
--  Memories of Azeroth: Wrath of the Lich King  --
--------------------------
L = DBM:GetModLocalization("WrathEvent")

L:SetGeneralLocalization({
	name = "추억: 리치 왕의 분노"
})

L:SetWarningLocalization{
	WarnEmerge				= "아눕아락 등장",
	WarnEmergeSoon			= "10초 후 등장",
	WarnSubmerge			= "아눕아락 잠복",
	WarnSubmergeSoon		= "10초 후 잠복",
	WarningTeleportNow		= "순간이동",
	WarningTeleportSoon		= "10초 후 순간이동"
}

L:SetTimerLocalization{
	TimerEmerge				= "등장",
	TimerSubmerge			= "잠복",
	TimerTeleport			= "순간이동"
}

L:SetMiscLocalization{
	Emerge					= "땅속에서 모습을 드러냅니다!",
	Burrow					= "땅속으로 숨어버립니다!"
}

L:SetOptionLocalization{
	WarnEmerge				= "등장 경고 보기",
	WarnEmergeSoon			= "등장 사전 경고 보기",
	WarnSubmerge			= "잠복 경고 보기",
	WarnSubmergeSoon		= "잠복 사전 경고 보기",
	TimerEmerge				= "등장 타이머 바 보기",
	TimerSubmerge			= "잠복 타이머 바 보기",
	WarningTeleportNow		= "순간이동 경고 보기",
	WarningTeleportSoon		= "순간이동 사전 경고 보기",
	TimerTeleport			= "순간이동 타이머 바 보기"
}

--------------------------
--  Memories of Azeroth: Cataclysm  --
--------------------------
L = DBM:GetModLocalization("CataEvent")

L:SetGeneralLocalization({
	name = "추억: 대격변"
})

L:SetWarningLocalization({
	warnSplittingBlow		= "%2$s에 %1$s",--Spellname in Location
	warnEngulfingFlame		= "%2$s에 %1$s"--Spellname in Location
})

L:SetOptionLocalization({
	warnSplittingBlow			= "$spell:98951 위치 경고 보기",
	warnEngulfingFlame			= "$spell:99171 위치 경고 보기"
})
