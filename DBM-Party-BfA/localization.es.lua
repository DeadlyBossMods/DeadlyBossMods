if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------------
-- <<< Atal'Dazar >>> --
------------------------
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
-- Council o' Captains --
-----------------------
L= DBM:GetModLocalization(2093)

L:SetWarningLocalization({
	warnGoodBrew		= "%s en 3 segundos",
	specWarnBrewOnBoss	= "Brebaje beneficioso - ¡ve a %s!"
})

L:SetOptionLocalization({
	warnGoodBrew		= "Mostrar aviso especial cuando se esté lanzando un brebaje beneficioso",
	specWarnBrewOnBoss	= "Mostrar aviso especial cuando se esté lanzando un brebaje positivo sobre la ubicación de uno de los jefes"
})

L:SetMiscLocalization({
	critBrew		= "Brebaje de crítico",
	hasteBrew		= "Brebaje de celeridad"
})

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "¡Hagan sus apuestas! Tenemos un nuevo grupo de victi... perdón... ¡competidores! ¡Gurthok, Wodin, que empiece la cosa!"
})

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
-------------------------
-- Lord Canto Tormenta --
-------------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "Parece que tienes visita, lord Canto Tormenta."
})

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
----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

--------------------------------
-- <<<Operación: Mecandria>>> --
--------------------------------
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
	name =	"Enemigos menores"
})
