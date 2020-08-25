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
	Phase2			= "The anticipation to use this relic is killing me! Though, it will more likely kill you.",
	Phase3			= "I hope this wondrous item is as lethal as it looks!",
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
	timerDesiresContainer		= "욕망 용기 가득참",
	timerBottledContainer		= "령 용기 가득참",
	timerSinsContainer			= "죄악 용기 가득참",
	timerConcentrateContainer	= "Concentrate 용기 가득참"
}

L:SetOptionLocalization({
	timerContainers				= "용기가 채워지고 있는 상황과 가득찰때까지 남은 시간을 표시하는 타이머 보기"
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
--L= DBM:GetModLocalization(2425)

---------------------------
--  Sire Denathrius --
---------------------------
L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	CrimsonSpawn	= "Crimson Cabalists answer the call of Denathrius."
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"나스리아 성채 일반몹"
})
