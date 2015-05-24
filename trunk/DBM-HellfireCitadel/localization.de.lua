if GetLocale() ~= "deDE" then return end
local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

---------------------------
-- Iron Reaver --
---------------------------
L= DBM:GetModLocalization(1425)

---------------------------
-- Hellfire High Council --
---------------------------
L= DBM:GetModLocalization(1432)

------------------
-- Kormrok --
------------------
L= DBM:GetModLocalization(1392)

--------------
-- Kilrogg Deadeye --
--------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon		=	"Come brothers! Seize your destiny!"--translate
})

--------------------
--Gorefiend --
--------------------
L= DBM:GetModLocalization(1372)

--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"Throw Eye of Anzu to %s!"--translate
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"Show special warning when you need to throw $spell:179202"--translate
})

--------------------------
-- Fel Lord Zakuun --
--------------------------
L= DBM:GetModLocalization(1391)

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

--------------------------
-- Socrethar the Eternal --
--------------------------
L= DBM:GetModLocalization(1427)

--------------------------
-- Tyrant Velhari --
--------------------------
L= DBM:GetModLocalization(1394)

--------------------------
-- Mannoroth --
--------------------------
L= DBM:GetModLocalization(1395)

--------------------------
-- Archimonde --
--------------------------
L= DBM:GetModLocalization(1438)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"Trash der Höllenfeuerzitadelle"
})
