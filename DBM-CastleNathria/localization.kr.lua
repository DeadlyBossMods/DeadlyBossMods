if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

--L:SetOptionLocalization({
--})

--L:SetMiscLocalization({
--})

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "디버프 중첩이 높은 순서대로 정보 창에 $spell:334755 대상자를 정렬합니다. (중첩 낮은순 대신)",
	ShowTimeNotStacks		= "정보 창에 $spell:334755의 중첩 대신 남은 시간을 표시합니다."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
L= DBM:GetModLocalization(2418)

L:SetMiscLocalization({
	Phase2			= "이 유물을 써 보고 싶어서 숨이 멎을 뻔했답니다! 뭐, 당신네는 진짜로 멎겠지만.",
	Phase3			= "보기만큼 치명적인 물건이어야 할 텐데!",
})

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "욕망의 용기 가득참",
	timerBottledContainer		= "병에 담긴 용기 가득참",
	timerSinsContainer			= "죄악의 용기 가득참",
	timerConcentrateContainer	= "농축된 용기 가득참"
}

L:SetOptionLocalization({
	timerContainers2			= "용기가 채워지고 있는 상황과 가득찰때까지 남은 시간을 표시하는 타이머 보기"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "다른 스킬에 의해 대기중인 스킬의 타이머를 자동으로 조정"
})

---------------------------
--  Sire Denathrius --
---------------------------
L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	CrimsonSpawn	= "진홍의 밀사가 데나트리우스 대영주의 부름에 응합니다."
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"나스리아 성채 일반몹"
})
