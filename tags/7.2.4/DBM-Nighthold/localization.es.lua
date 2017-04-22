if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

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
	Third				= "Tercero",
	Adds1				= "¡Esbirros! ¡Adelante!",
	Adds2				= "¡Mostrad a estos farsantes cómo se lucha!"
})

------------
-- Krosus --
------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "Ruptura de puente en %ds"
})

L:SetMiscLocalization({
	MoveLeft			= "Ve a la izquierda",
	MoveRight			= "Ve a la derecha"
})

---------------------------
-- Gran botánico Tel'arn --
---------------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "Esfera de plasma a poca salud"
})

L:SetOptionLocalization({
	warnStarLow				= "Mostrar aviso especial cuando una esfera de plasma tenga la salud baja (15%)"
})

L:SetMiscLocalization({
	RadarMessage			= "Usar el radar de distancia para buscar aliados sin perjuicio y el indicador en pantalla para evitar otros perjuicios (esta opción se mejorará en el futuro)"
})

---------------------------
-- Augur estelar Etraeus --
---------------------------
L= DBM:GetModLocalization(1732)

-----------------------------
-- Gran magistrix Elisande --
-----------------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "Cúpula rápida (%d)",
	timerSlowTimeBubble		= "Cúpula lenta (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "Mostrar temporizador para las cúpulas de $spell:209166",
	timerSlowTimeBubble		= "Mostrar temporizador para las cúpulas de $spell:209165"
})

L:SetMiscLocalization({
	noCLEU4EchoRings			= "¡Que las mareas del tiempo os ahoguen!",
	noCLEU4EchoOrbs			= "Veréis que el tiempo puede ser muy volátil."
})

-------------
-- Gul'dan --
-------------
L= DBM:GetModLocalization(1737)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

