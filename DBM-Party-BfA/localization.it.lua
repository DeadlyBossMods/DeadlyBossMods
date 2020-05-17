if GetLocale() ~= "itIT" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("AtalDazarTrash")

L:SetGeneralLocalization({
	name =	"Scartini Atal'Dazar"
})

-----------------------
-- <<<Freehold >>> --
-----------------------
-----------------------
-- Council o' Captains --
-----------------------
L= DBM:GetModLocalization(2093)

L:SetWarningLocalization({
	warnGoodBrew		= "Lancio di %s: 3 sec",
	specWarnBrewOnBoss	= "Birra Buona - vai a %s"
})

L:SetOptionLocalization({
	warnGoodBrew		= "Mostra avviso quando è in lancio la birra buona",
	specWarnBrewOnBoss	= "Mostra avviso speciale quando la birra buona è sotto il boss"
})

L:SetMiscLocalization({
	critBrew		= "Birra Critico",
	hasteBrew		= "Birra Celerità"
})

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "Venite a piazzare le vostre scommesse! Abbiamo nuove vittim... Ehm... dei nuovi sfidanti! Gurgthok, Wodin: dateci dentro!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("FreeholdTrash")

L:SetGeneralLocalization({
	name =	"Scartini Covo della Libertà"
})

-----------------------
-- <<<Kings' Rest >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("KingsRestTrash")

L:SetGeneralLocalization({
	name =	"Scartini Reque dei Re"
})

-----------------------
-- <<<Shrine of the Storm >>> --
-----------------------
-----------------------
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "Pare che tu abbia ossspiti, Ser Sacraonda."
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SotSTrash")

L:SetGeneralLocalization({
	name =	"Scartini Santuario della Tempesta"
})

-----------------------
-- <<<Siege of Boralus >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"Scartini Assedio di Boralus"
})

-----------------------
-- <<<Temple of Sethraliss>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("SethralissTrash")

L:SetGeneralLocalization({
	name =	"Scartini Tempio di Sethraliss"
})

-----------------------
-- <<<MOTHERLOAD>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"Scartini Vena Madre"
})

-----------------------
-- <<<The Underrot>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"Scartini Grottamarcia"
})

-----------------------
-- <<<Tol Dagor >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("TolDagorTrash")

L:SetGeneralLocalization({
	name =	"Scartini Tol Dagor"
})

-----------------------
-- <<<Waycrest Manor>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"Scartini Maniero Crestabianca"
})

-----------------------
-- <<<Operation: Mechagon>>> --
-----------------------
-----------------------
-- Tussle Tonks --
-----------------------
L= DBM:GetModLocalization(2336)

L:SetMiscLocalization({
	openingRP		= "TRANSLATE ME"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("MechagonTrash")

L:SetGeneralLocalization({
	name =	"Scartini Meccagon"
})
