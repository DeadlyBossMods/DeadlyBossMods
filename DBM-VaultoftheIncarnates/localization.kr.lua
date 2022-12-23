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
