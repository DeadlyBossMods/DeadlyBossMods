if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------------
-- <<< Atal'Dazar >>> --
------------------------
-------------------------
-- Sacerdotisa Alun'za --
-------------------------
L= DBM:GetModLocalization(2082)

--------------
-- Vol'kaal --
--------------
L= DBM:GetModLocalization(2036)

-----------
-- Rezan --
-----------
L= DBM:GetModLocalization(2083)

-----------
-- Yazma --
-----------
L= DBM:GetModLocalization(2030)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AtalDazarTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

--------------------------
-- <<< Fuerte Libre >>> --
--------------------------
-----------------------
-- Skycap'n Kragg --
-----------------------
L= DBM:GetModLocalization(2102)

-----------------------
-- Council o' Captains --
-----------------------
L= DBM:GetModLocalization(2093)

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "¡Hagan sus apuestas! Tneemos un nuevo grupo de victi... perdón... ¡competidores! ¡Gurthok, Wodin, que empiece la cosa!"
})

-----------------------
-- Harlan Sweete --
-----------------------
L= DBM:GetModLocalization(2095)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("FreeholdTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------------------
-- <<< Reposo de los Reyes >>> --
---------------------------------
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

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("KingsRestTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------------------
-- <<< Altar de la Tormenta >>> --
----------------------------------
--------------
-- Agu'sirr --
--------------
L= DBM:GetModLocalization(2153)

-----------------------
-- Tidesage Council --
-----------------------
L= DBM:GetModLocalization(2154)

-------------------------
-- Lord Canto Tormenta --
-------------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "Parece que tienes visita, lord Canto Tormenta."
})

-----------------------
-- Vol'zith the Whisperer --
-----------------------
L= DBM:GetModLocalization(2156)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("SotSTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-------------------------------
-- <<< Asedio de Boralus >>> --
-------------------------------
-----------------------
-- Dread Captain Lockwood --
-----------------------
L= DBM:GetModLocalization(2173)

-----------------------
-- Chopper Redhook --
-----------------------
L= DBM:GetModLocalization(2132)

-----------------------
-- Hadal Darkfathom --
-----------------------
L= DBM:GetModLocalization(2134)

-----------------------
-- Kraken --
-----------------------
L= DBM:GetModLocalization(2140)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------------------
-- <<< Templo de Sethraliss >>> --
----------------------------------
---------------------
-- Adderis y Aspix --
---------------------
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
	name =	"Enemigos menores"
})

-----------------------------
-- <<< ¡La Veta Madre! >>> --
-----------------------------
-----------------------
-- Coin-operated Crowd Pummeler --
-----------------------
L= DBM:GetModLocalization(2109)

-------------
-- Tik'ali --
-------------
L= DBM:GetModLocalization(2114)

-----------------------
-- Rixxa Fluxflame --
-----------------------
L= DBM:GetModLocalization(2115)

-----------------------
-- Mogul Razzdunk --
-----------------------
L= DBM:GetModLocalization(2116)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

------------------------------------
-- <<< Catacumbas Putrefactas >>> --
------------------------------------
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
-- Taloc the Corrupted --
-----------------------
L= DBM:GetModLocalization(2158)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-----------------------
-- <<< Tol Dagor >>> --
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

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("TolDagorTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-------------------------------
-- <<< Mansión Crestavía >>> --
-------------------------------
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

--------------------------
-- Lord y Lady Cestavía --
--------------------------
L= DBM:GetModLocalization(2128)

-----------------------
-- Gorak Tul --
-----------------------
L= DBM:GetModLocalization(2129)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
