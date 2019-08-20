if GetLocale() ~= "itIT" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
-----------------------
-- Priestess Alun'za --
-----------------------
L= DBM:GetModLocalization(2082)

-----------------------
-- Vol'kaal --
-----------------------
L= DBM:GetModLocalization(2036)

-----------------------
-- Rezan --
-----------------------
L= DBM:GetModLocalization(2083)

-----------------------
-- Yazma --
-----------------------
L= DBM:GetModLocalization(2030)

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
-- Skycap'n Kragg --
-----------------------
L= DBM:GetModLocalization(2102)

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

-----------------------
-- Harlan Sweete --
-----------------------
L= DBM:GetModLocalization(2095)

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
-----------------------
-- The Golden Serpent --
-----------------------
L= DBM:GetModLocalization(2165)

-----------------------
-- Mummification Construct --
-----------------------
L= DBM:GetModLocalization(2171)

-----------------------
-- The Warring Warlords --
-----------------------
L= DBM:GetModLocalization(2170)

-----------------------
-- Dazar, The First King --
-----------------------
L= DBM:GetModLocalization(2172)

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
-- Agu'sirr --
-----------------------
L= DBM:GetModLocalization(2153)

-----------------------
-- Tidesage Council --
-----------------------
L= DBM:GetModLocalization(2154)

-----------------------
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "Pare che tu abbia ossspiti, Ser Sacraonda."
})

-----------------------
-- Vol'zith the Whisperer --
-----------------------
L= DBM:GetModLocalization(2156)

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
-----------------------
-- Dread Captain Lockwood --
-----------------------
L= DBM:GetModLocalization(2173)

-----------------------
-- Chopper Redhook / Sergeant Bainbridge --
-----------------------
L= DBM:GetModLocalization(2132)

L= DBM:GetModLocalization(2133)

-----------------------
-- Hadal Darkfathom --
-----------------------
L= DBM:GetModLocalization(2134)

-----------------------
-- Kraken --
-----------------------
L= DBM:GetModLocalization(2140)

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
-----------------------
-- Adderis and Aspix --
-----------------------
L= DBM:GetModLocalization(2142)

-----------------------
-- Merektha --
-----------------------
L= DBM:GetModLocalization(2143)

-----------------------
-- Lighting Elemental --
-----------------------
L= DBM:GetModLocalization(2144)

-----------------------
-- Avaar of Sethraliss --
-----------------------
L= DBM:GetModLocalization(2145)

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
-----------------------
-- Coin-operated Crowd Pummeler --
-----------------------
L= DBM:GetModLocalization(2109)

-----------------------
-- Tik'ali --
-----------------------
L= DBM:GetModLocalization(2114)

-----------------------
-- Rixxa Fluxflame --
-----------------------
L= DBM:GetModLocalization(2115)

-----------------------
-- Mogul Razzdunk --
-----------------------
L= DBM:GetModLocalization(2116)

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
-----------------------
-- Elder Leaxa --
-----------------------
L= DBM:GetModLocalization(2157)

-----------------------
-- Infested Crawg --
-----------------------
L= DBM:GetModLocalization(2131)

-----------------------
-- Sporecaller Zancha --
-----------------------
L= DBM:GetModLocalization(2130)

-----------------------
-- Unbound Monstrosity --
-----------------------
L= DBM:GetModLocalization(2158)

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
-----------------------
-- The Sand Queen --
-----------------------
L= DBM:GetModLocalization(2097)

-----------------------
-- Jes Howlis --
-----------------------
L= DBM:GetModLocalization(2098)

-----------------------
-- Knight Captain Valyri --
-----------------------
L= DBM:GetModLocalization(2099)

-----------------------
-- Overseer Korgus --
-----------------------
L= DBM:GetModLocalization(2096)

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
-----------------------
-- Heartsbane Triad --
-----------------------
L= DBM:GetModLocalization(2125)

-----------------------
-- Soulbound Goliath --
-----------------------
L= DBM:GetModLocalization(2126)

-----------------------
-- Raal the Gluttonous --
-----------------------
L= DBM:GetModLocalization(2127)

-----------------------
-- Lord and Lady Waycrest --
-----------------------
L= DBM:GetModLocalization(2128)

-----------------------
-- Gorak Tul --
-----------------------
L= DBM:GetModLocalization(2129)

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
-- King Gobbamak --
-----------------------
L= DBM:GetModLocalization(2357)

-----------------------
-- Gunker --
-----------------------
L= DBM:GetModLocalization(2358)

-----------------------
-- Trixie & Naeno --
-----------------------
L= DBM:GetModLocalization(2360)

-----------------------
-- HK-8 Aerial Oppression Unit --
-----------------------
L= DBM:GetModLocalization(2355)

-----------------------
-- Tussle Tonks --
-----------------------
L= DBM:GetModLocalization(2336)

-----------------------
-- K.U.-J.0. --
-----------------------
L= DBM:GetModLocalization(2339)

-----------------------
-- Machinist's Garden --
-----------------------
L= DBM:GetModLocalization(2348)

-----------------------
-- King Mechagon --
-----------------------
L= DBM:GetModLocalization(2331)

---------
--Trash--
---------
L = DBM:GetModLocalization("MechagonTrash")

L:SetGeneralLocalization({
	name =	"Scartini Meccagon"
})
