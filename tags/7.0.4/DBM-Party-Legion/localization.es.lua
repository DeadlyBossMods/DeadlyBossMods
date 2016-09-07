if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Torreón Grajo Negro --
-------------------------
-----------------------
-- Amalgama de almas --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------------
-- Illysanna Cresta Cuervo --
-----------------------------
L= DBM:GetModLocalization(1653)

----------------------------
-- Atizarrabias el Odioso --
----------------------------
L= DBM:GetModLocalization(1664)

----------------------------------
-- Lord Kur'talos Cresta Cuervo --
----------------------------------
L= DBM:GetModLocalization(1672)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-----------------------------
-- Arboleda Corazón Oscuro --
-----------------------------
-----------------------
-- Archidruida Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

----------------------
-- Corazón de Roble --
----------------------
L= DBM:GetModLocalization(1655)

--------------
-- Dresaron --
--------------
L= DBM:GetModLocalization(1656)

----------------------
-- Sombra de Xavius --
----------------------
L= DBM:GetModLocalization(1657)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})


--------------------
-- Ojo de Azshara --
--------------------
--------------------------------
-- Señor de la guerra Parjesh --
--------------------------------
L= DBM:GetModLocalization(1480)

--------------------------
-- Lady Espiral de Odio --
--------------------------
L= DBM:GetModLocalization(1490)

-----------------------
-- Rey Barbaprofunda --
-----------------------
L= DBM:GetModLocalization(1491)

----------------
-- Serpentrix --
----------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Cólera de Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------
-- Salas del Valor --
---------------------
-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

------------
-- Fenryr --
------------
L= DBM:GetModLocalization(1487)

----------------------
-- Rey dios Skovald --
----------------------
L= DBM:GetModLocalization(1488)

----------
-- Odyn --
----------
L= DBM:GetModLocalization(1489)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------------
-- Guarida de Neltharion --
---------------------------
-------------
-- Rokmora --
-------------
L= DBM:GetModLocalization(1662)

--------------------------
-- Ularogg Formarriscos --
--------------------------
L= DBM:GetModLocalization(1665)

-------------
-- Naraxas --
-------------
L= DBM:GetModLocalization(1673)

--------------------------
-- Dargrul el Infrarrey --
--------------------------
L= DBM:GetModLocalization(1687)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-----------------
-- La Arquería --
-----------------
------------
-- Ivanyr --
------------
L= DBM:GetModLocalization(1497)

---------------
-- Corstilax --
---------------
L= DBM:GetModLocalization(1498)

-------------------
-- General Xakal --
-------------------
L= DBM:GetModLocalization(1499)

L:SetMiscLocalization({
	batSpawn		=	"¡Refuerzos, a mí! ¡AHORA!"--Comprobar posibles cambios a la localización
})

--------------
-- Nal'tira --
--------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Consejero Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------------
-- Corte de las Estrellas --
----------------------------
----------------------------------
-- Capitán de patrulleros Gerdo --
----------------------------------
L= DBM:GetModLocalization(1718)

-----------------------------
-- Talixae Corona de Fuego --
-----------------------------
L= DBM:GetModLocalization(1719)

-------------------------
-- Consejero Melandrus --
-------------------------
L= DBM:GetModLocalization(1720)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

--------------------
-- Fauce de Almas --
--------------------
--------------------------
-- Ymiron, el Rey Caído --
--------------------------
L= DBM:GetModLocalization(1502)

--------------
-- Harbaron --
--------------
L= DBM:GetModLocalization(1512)

-----------
-- Helya --
-----------
L= DBM:GetModLocalization(1663)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-------------------------------
-- Asalto al Bastión Violeta --
-------------------------------
---------------------------
-- Destripamentes Kaahrj --
---------------------------
L= DBM:GetModLocalization(1686)

-------------------------------
-- Malífica Tormenta de Maná --
-------------------------------
L= DBM:GetModLocalization(1688)

----------------
-- Fazinfecta --
----------------
L= DBM:GetModLocalization(1693)

------------------
-- Estremefauce --
------------------
L= DBM:GetModLocalization(1694)

---------------------------------
-- Princesa de Sangre Thal'ena --
---------------------------------
L= DBM:GetModLocalization(1702)

----------------
-- Anub'esset --
----------------
L= DBM:GetModLocalization(1696)

--------------
-- Sael'orn --
--------------
L= DBM:GetModLocalization(1697)

----------------------
-- Señor vil Betrug --
----------------------
L= DBM:GetModLocalization(1711)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Siguiente portal en breve",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Mostrar aviso cuando aparezca un portal",
	WarningPortalSoon		= "Mostrar aviso previo para el siguiente portal",
	WarningBossNow			= "Mostrar aviso previo para el siguiente jefe",
	TimerPortal				= "Mostrar temporizador para el siguiente portal (después de jefe)"
})

L:SetMiscLocalization({
	Malgath		=	"Lord Malgath"
})

-----------------------------
-- Cámara de las Celadoras --
-----------------------------
------------------------
-- Tirathon Saltheril --
------------------------
L= DBM:GetModLocalization(1467)

----------------------------
-- Inquisidor Tormentorum --
----------------------------
L= DBM:GetModLocalization(1695)

----------------
-- Ceniz'golm --
----------------
L= DBM:GetModLocalization(1468)

----------------
-- Observador --
----------------
L= DBM:GetModLocalization(1469)

----------------------
-- Cordana Cantovil --
----------------------
L= DBM:GetModLocalization(1470)
