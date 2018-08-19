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
L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

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
	ShowHighestFirst	 =	"중첩이 높은 순서대로 정보 프레임에 끈질긴 감염 대상자 정렬 (중첩 낮은순 대신)"
})

---------------
-- Mythrax the Unraveler --
---------------
L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "다음 크로그 (%s)",
	timerCallofHexerCD 		= "다음 혈사술사 (%s)",
	timerCallofCrusherCD	= "다음 분쇄자 (%s)",
})

L:SetOptionLocalization({
	timerAddIncoming		= "쫄이 공격 가능해지면 타이머 바 보기"
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

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"울디르 일반몹"
})
