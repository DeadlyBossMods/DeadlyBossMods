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

L:SetOptionLocalization({
	InfoFrameBehavior	= "Mostrar en el marco de información",
	TimeRelease			= "Jugadores afectados por Liberación temporal",
	TimeBomb			= "Jugadores afectados por Bomba de relojería"
})

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

---------------------------
-- Augur estelar Etraeus --
---------------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ConjunctionYellFilter	= "Desactivar todos los demás mensajes de chat durante $spell:205408 y repetir el mensaje de tu signo estelar hasta que acabe la conjunción"
})

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
	noCLEU4EchoRings		= "¡Que las mareas del tiempo os ahoguen!",
	noCLEU4EchoOrbs			= "Veréis que el tiempo puede ser muy volátil.",
	prePullRP				= "Vaticiné vuestra llegada, por supuesto. Los hilos del destino que os trajeron a este lugar; vuestros desesperados intentos por detener a la Legión..."
})

-------------
-- Gul'dan --
-------------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "Es hora de devolver el alma del cazador de demonios a su cuerpo...", --Incomplete until I get to see it in a video or by myself
	prePullRP			= "Ah, sí, los héroes han llegado. Tan persistentes y seguros de sí mismos. ¡Pero vuestra arrogancia será vuestra perdición!"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

