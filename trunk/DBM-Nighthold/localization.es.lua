if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	NoDebuff	= "Sin %s"
})

--------------------------
-- Anomalía cronomática --
--------------------------
L= DBM:GetModLocalization(1725)

--------------
-- Trilliax --
--------------
L= DBM:GetModLocalization(1731)

-----------------------------
-- Hoja de hechizo Aluriel --
-----------------------------
L= DBM:GetModLocalization(1751)

-----------------
-- Tichondrius --
-----------------
L= DBM:GetModLocalization(1762)

L:SetMiscLocalization({
	First				= "Primero",
	Second				= "Segundo",
	Third				= "Tercero"
})

------------
-- Krosus --
------------
L= DBM:GetModLocalization(1713)

---------------------------
-- Gran botánico Tel'arn --
---------------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization{
	warnStarLow				= "Esfera de plasma a poca salud"
}

L:SetOptionLocalization{
	warnStarLow				= "Mostrar aviso especial cuando una esfera de plasma tenga la salud baja (25%)"
}

L:SetMiscLocalization({
	RadarMessage			= "Usar el radar de distancia para buscar aliados sin perjuicio y el indicador en pantalla para evitar otros perjuicios (esta opción se mejorará en el futuro)"
})


---------------------------
-- Augur estelar Etraeus --
---------------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization{
	ShowNeutralColor		= "Mostrar círculos blancos en el indicador en pantalla alrededor de los jugadores que no tengan signos estelares hasta que se eliminen todos los signos",
	FilterOtherSigns		= "Ocultar anuncios de signos estelares por los que no estés afectado"
}

-----------------------------
-- Gran magistrix Elisande --
-----------------------------
L= DBM:GetModLocalization(1743)

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Let the waves of time crash over you!"--Can't get data on the Spanish localization for this line; will check again in a few days
})

-------------
-- Gul'dan --
-------------
L= DBM:GetModLocalization(1737)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("SuramarTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
