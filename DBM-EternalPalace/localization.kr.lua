if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"3초 후 동그라미"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "자쿨이 착란의 영역으로 통하는 길을 엽니다!",
	Tear =	"균열"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "쫄 광폭화"
}

L:SetOptionLocalization({
	SortDesc 			= "정보 창에 $spell:298569 디버프 중첩을 높은 순으로 정렬합니다. (낮은순 대신)",
	ShowTimeNotStacks	= "정보 창에 $spell:298569 디버프 중첩 대신 남은 시간을 표시합니다.",
	timerStageThreeBerserk	= "3단계 쫄이 광폭화 상태에 들어가면 타이머 바 보기"
})

L:SetMiscLocalization({
	SoakOrb =	"구슬 먹기",
	AvoidOrb =	"구슬 안먹기",
	GroupUp =	"뭉치기",
	Spread =	"산개",
	Move	 =	"계속 이동",
	DontMove =	"이동 중지",
	--For Yells
	HelpSoakMove	= "{rt3}같이 먹기 이동{rt3}",--Purple Diamond
	HelpSoakStay	= "{rt6}같이 먹기 제자리{rt6}",--Blue Square
	HelpSoak		= "{rt3}같이 먹기{rt3}",--Purple Diamond
	HelpMove		= "{rt4}같이 이동{rt4}",--Green Triangle
	HelpStay		= "{rt7}같이 멈춰{rt7}",--Red X
	SoloSoak 		= "혼자 먹기",
	Solo =			"혼자",
	--Not currently used Yells
	SoloMoving		= "혼자 이동",
	SoloStay		= "혼자 제자리",
	SoloSoakMove	= "혼자 맞기 이동",
	SoloSoakStay	= "혼자 맞기 제자리"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"영원한 궁전 일반몹"
})
