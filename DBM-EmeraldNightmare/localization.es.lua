if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
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

-----------------------------------------
-- Il'gynoth, Corazón de la Corrupción --
-----------------------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	InfoFrameBehavior	= "Información mostrada por el marco de información",
	Fixates				= "Jugadores afectados por Fijar",
	Adds				= "Cantidad de esbirros de cada tipo"
})

-----------------------
-- Elerethe Renferal --
-----------------------
L= DBM:GetModLocalization(1744)

-----------
-- Ursoc --
-----------
L= DBM:GetModLocalization(1667)

L:SetMiscLocalization({
	SoakersText		=	"Interceptores asignados: %s"
})

------------------------------
-- Dragones de la Pesadilla --
------------------------------
L= DBM:GetModLocalization(1704)

--------------
-- Cenarius --
--------------
L= DBM:GetModLocalization(1750)

------------
-- Xavius --
------------
L= DBM:GetModLocalization(1726)

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
