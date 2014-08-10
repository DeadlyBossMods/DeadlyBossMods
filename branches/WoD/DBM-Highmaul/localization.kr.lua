if GetLocale() ~= "koKR" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

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
	supressionTarget3	= "Quiet!"
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
