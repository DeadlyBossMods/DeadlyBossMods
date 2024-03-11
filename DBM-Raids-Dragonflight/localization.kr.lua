if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "디버프 (%s)",
	timerAvoidCD = "피하기 (%s)",
	timerUltimateCD = "궁극기 (%s)",
	timerAddEnrageCD = "격노 (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "대상에게 걸리는 디버프 공격 타이머 바 보기: $spell:382563, $spell:373678, $spell:391055, $spell:373487",
	timerAvoidCD = "회피 가능한 공격 타이머 바 보기: $spell:373329, $spell:391019, $spell:395893, $spell:390920",
	timerUltimateCD = "기력 100 궁극기 타이머 바 보기: $spell:374022, $spell:372456, $spell:374691, $spell:374215",
	timerAddEnrageCD = "신화 난이도에서 쫄 격노 타이머 바 보기"
})

L:SetMiscLocalization({
	Fire	= "화염",
	Frost	= "냉기",
	Earth	= "대지",
	Storm	= "폭풍"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff	= "지팡이",
	eStaff	= "강화된 지팡이"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
L= DBM:GetModLocalization(2499)

L:SetOptionLocalization({
	SetBreathToBait = "사잇페이즈 때 숨결 타이머를 만료시켜 시전 타이밍 대신 유도 타이밍 기반으로 타이머를 조정합니다 (경고는 계속 숨결을 시전할 때 뜸)"
})

L:SetMiscLocalization({
	negative = "음전하",
	positive = "양전하",
	BreathEmote	= "라자게스가 숨을 깊게 들이쉽니다..."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"현신의 금고 일반몹"
})

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

---------------------------
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "1페이즈에서 각 보스간 거리 검사를 적극적으로 해서 근처에 없는 보스의 특정 경고와 타이머 자동으로 숨김 (43미터 이상)"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
L= DBM:GetModLocalization(2530)

L:SetMiscLocalization({
	SafeClear		= "해제 안전"
})

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "큰 쫄 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "새 수렵꾼이나 경비병이 성루를 타고 올라오는 타이머 보기"
})

L:SetMiscLocalization({
	northWall		= "지휘관이 북쪽 성루를 타고 오릅니다!",
	southWall		= "지휘관이 남쪽 성루를 타고 오릅니다!"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "탱커 교대시 모드 작동 방식 설정",
	OnlyIfDanger		= "다른 탱커가 위험한 공격을 받을 때 도발 경고 보기",
	MinMaxSoak			= "연계 공격에서 첫번째 공격 직후 또는 다른 탱커가 위험한 공격을 받을때  도발 경고 보기",
	DoubleSoak			= "연계 공격이 끝난 후 또는 다른 탱커가 위험한 공격을 받을 때 도발 경고 보기"--Default
})

L:SetMiscLocalization({
	pool		= "{rt%d}바닥 %d",--<icon> Pool 1,2,3
	soakpool	= "바닥 밟기"
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}바닥 %d",--<icon> Pool 1,2,3
	soakpool	= "바닥 밟기"
})

---------------------------
--  Echo of Neltharion --
---------------------------
L= DBM:GetModLocalization(2523)

L:SetMiscLocalization({
	WallBreaker	= "벽 파괴 담당"
})

---------------------------
--  Scalecommander Sarkareth --
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "디버프 중첩 정보 창 작동 방식 설정",
	OblivionOnly			= "망각 중첩만 표시 (1 2 3페이즈)",--Default
	HowlOnly				= "억압의 포효 중첩만 표시 (1페이즈, 이후엔 닫힘)",
	Hybrid					= "1페이즈에 억압의 포효 중첩, 2페이즈 3페이즈엔 망각 중첩 표시"
})

L:SetMiscLocalization({
	EarlyStaging			= "생명력 기준점을 넘어서 페이즈 조기 종료"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"에베루스 일반몹"
})

---------------------------
--  Amirdrassil, the Dream's Hope --
---------------------------
---------------------------
--  Gnarlroot --
---------------------------
--L= DBM:GetModLocalization(2564)

---------------------------
--  Igira the Cruel --
---------------------------
--L= DBM:GetModLocalization(2554)

---------------------------
--  Volcoross --
---------------------------
L= DBM:GetModLocalization(2557)

L:SetMiscLocalization({
	DebuffSoaks			= "디버프 같이맞기 (%s)"--Might be common localized later
})

---------------------------
--  Council of Dreams --
---------------------------
L= DBM:GetModLocalization(2555)

L:SetMiscLocalization({
	Ducks		= "오리 (%s)"
})

---------------------------
--  Larodar, Keeper of the Flame --
---------------------------
L= DBM:GetModLocalization(2553)

L:SetMiscLocalization({
	Roots				= "뿌리 (%s)",
	HealAbsorb			= "치유 흡수 (%s)"--Might be common localized later
})

---------------------------
--  Nymue, Weaver of the Cycle --
---------------------------
L= DBM:GetModLocalization(2556)

L:SetMiscLocalization({
	Threads			= "실타래 (%s)"
})

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --
---------------------------
L= DBM:GetModLocalization(2565)

L:SetMiscLocalization({
	TreeForm			= "나무 형상",
	MoonkinForm			= "달빛야수 형상",
	Feathers			= "깃털"
})

---------------------------
--  Fyrakk the Blazing --
---------------------------
L= DBM:GetModLocalization(2519)

L:SetTimerLocalization{
	timerMythicDebuffs			= "우리 (%s)"
}

L:SetWarningLocalization{
	warnMythicDebuffs			= "우리 (%s)"
}

L:SetOptionLocalization{
	warnMythicDebuffs			= "$spell:428988|1과;와; $spell:428970 디버프가 시전되면 알림 (횟수 포함)",
	timerMythicDebuffs			= "$spell:428988|1과;와; $spell:428970 디버프 타이머 보기 (횟수 포함)"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"아미드랏실 일반몹"
})

L:SetMiscLocalization({
	FyrakkRP			= "또 너인가? 미안하지만 널 직접 소멸시킬 여유가 없어서 말이다."
})
