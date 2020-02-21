if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"어그로 수치"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "쓰레기 처리 장치 열림 - 곧 쫄 등장"
})

L:SetTimerLocalization({
	chuteTimer		= "다음 쓰레기 처리 장치 (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "쓰레기 처리 장치가 열리고 쫄 생성이 시작되면 사전 경고 보기",
	chuteTimer		= "쓰레기 처리 장치 열림 타이머 보기"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "구슬 (%s) 떨어짐"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"타락의 보주가 나오면 타이머 바 보기",
	EarlyTankSwap	 =	"산산조각을 맞으면 2번째 공허의 채찍을 기다리지 않고 바로 탱커 교대 경고 보기"
})

L:SetMiscLocalization({
	CThunDisc	 =	"원반 접속 완료. 크툰 데이터를 불러옵니다.",
	YoggDisc	 =	"원반 접속 완료. 요그사론 데이터를 불러옵니다.",
	CorruptedDisc =	"원반 접속 완료. 오염된 데이터를 불러옵니다."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"중첩이 높은 순서대로 정보 창에 잔존하는 감염 대상자를 정렬합니다. (중첩 낮은순 대신) 파티원만 보기 설정을 껐을때만 적용됩니다.",
	ShowOnlyParty		 =	"내 파티원의 잔존하는 감염 중첩만 표시합니다. 정보 창이 항상 파티원 순서대로 정렬됩니다.",
	SetIconsRegardless	 =	"빅윅 사용자 승급 여부에 관계없이 공격대 징표 설정 기능 사용 (고급 사용자용)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"징표 충돌을 방지하기 위해 DBM의 징표 기능을 권한이 있는 공격대 내 빅윅 사용자에게 넘겨줬습니다. 빅윅 사용자가 징표 기능을 켰는지 확인하시고 DBM의 징표 기능을 활성화하고 싶을땐 빅윅 사용자의 등급을 내리면 됩니다. 또는 벡티스 설정에서 빅윅 사용자 무시 옵션을 사용할 수도 있습니다."
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "다음 크로그 웅덩이 (%s)",
	timerCallofHexerCD 		= "다음 혈사술사 웅덩이 (%s)",
	timerCallofCrusherCD	= "다음 분쇄자 웅덩이 (%s)",
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "크로그 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerCallofHexerCD 		= "혈사술사 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerCallofCrusherCD	= "분쇄자 웅덩이가 형성되기 시작하면 타이머 바 보기",
	timerAddIncoming		= "쫄이 공격 가능해지면 타이머 바 보기",
	TauntBehavior			= "탱커 교대 도발 알림 설정",
	TwoHardThreeEasy		= "영웅/신화에서 2중첩마다 교대, 그 외 난이도에선 3중첩시 교대",--Default
	TwoAlways				= "난이도에 관계없이 항상 2중첩마다 교대",
	ThreeAlways				= "난이도에 관계없이 항상 3중첩마다 교대"
})

L:SetMiscLocalization({
	Crusher			=	"분쇄자",
	Bloodhexer		=	"혈사술사",
	Crawg			=	"크로그"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "동력 매트릭스 배달 실패"
})

L:SetOptionLocalization({
	warnMatrixFail		= "동력 매트릭스가 바닥에 떨어졌을 때 경고를 표시합니다."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"현재 매트릭스:",--Mythic
	NextMatrix			=	"다음 매트릭스:",--Mythic
	CurrentMatrixLong	=	"현재 매트릭스 (%s):",--Non Mythic
	NextMatrixLong		=	"다음 매트릭스 (%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"울디르 일반몹"
})
