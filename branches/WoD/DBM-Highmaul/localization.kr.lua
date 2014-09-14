if GetLocale() ~= "koKR" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

L:SetTimerLocalization({
	timerCrowdCD	= "Crowd 병력"
})

L:SetOptionLocalization({
	timerCrowdCD	= "Crowd 병력 대기시간 바 보기"
})

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "RISE, MOUNTAINS!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Phemos의 대기시간 초읽기 듣기",
	PolSpecial		= "Pol의 대기시간 초읽기 듣기"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetMiscLocalization({
	supressionTarget1	= "I will crush you!",
	supressionTarget2	= "Silence!",
	supressionTarget3	= "Quiet!",
	supressionTarget4	= "I will tear you in half!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"높은망치: 일반구간"
})
