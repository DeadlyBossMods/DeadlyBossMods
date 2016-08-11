if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Nythendra --
---------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Il'gynoth, Heart of Corruption --
---------------------------
L= DBM:GetModLocalization(1738)

---------------------------
-- Elerethe Renferal --
---------------------------
L= DBM:GetModLocalization(1744)

---------------------------
-- Ursoc --
---------------------------
L= DBM:GetModLocalization(1667)

L:SetMiscLocalization({
	SoakersText		=	"分傷分配: %"
})

---------------------------
-- Dragons of Nightmare --
---------------------------
L= DBM:GetModLocalization(1704)

------------------
-- Cenarius --
------------------
L= DBM:GetModLocalization(1750)

------------------
-- Xavius --
------------------
L= DBM:GetModLocalization(1726)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"翡翠夢魘小怪"
})
