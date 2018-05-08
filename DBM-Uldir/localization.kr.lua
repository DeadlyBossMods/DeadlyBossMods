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

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerAddIncoming		= "쫄이 공격 가능해지면 타이머 바 보기"
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
