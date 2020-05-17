if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("AtalDazarTrash")

L:SetGeneralLocalization({
	name =	"Trash von Atal'Dazar"
})

-----------------------
-- <<<Freehold >>> --
-----------------------
-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "Schließt Eure Wetten ab! Wir haben Frischflei.... äh, neue Herausforderer! Und nun Applaus für: Gurgthock und Wodin!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("FreeholdTrash")

L:SetGeneralLocalization({
	name =	"Trash des Freihafens"
})

-----------------------
-- <<<Kings' Rest >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("KingsRestTrash")

L:SetGeneralLocalization({
	name =	"Trash der Königsruh"
})

-----------------------
-- <<<Shrine of the Storm >>> --
-----------------------
-----------------------
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "Mir scheint, Ihr habt Gäste, Lord Sturmsang."
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SotSTrash")

L:SetGeneralLocalization({
	name =	"Trash des Schreins des Sturms"
})

-----------------------
-- <<<Siege of Boralus >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"Trash der Belagerung von Boralus"
})

-----------------------
-- <<<Temple of Sethraliss>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("SethralissTrash")

L:SetGeneralLocalization({
	name =	"Trash des Tempels von Sethraliss"
})

-----------------------
-- <<<MOTHERLOAD>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"Trash des Riesenflözes"
})

-----------------------
-- <<<The Underrot>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"Trash des Tiefenpfuhls"
})

-----------------------
-- <<<Tol Dagor >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("TolDagorTrash")

L:SetGeneralLocalization({
	name =	"Trash von Tol Dagor"
})

-----------------------
-- <<<Waycrest Manor>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"Trash des Kronsteiganwesens"
})
