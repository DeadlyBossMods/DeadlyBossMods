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
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
--L= DBM:GetModLocalization(2420)

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
--L= DBM:GetModLocalization(2424)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"나스리아 성채 일반몹"
})
