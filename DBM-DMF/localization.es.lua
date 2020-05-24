if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------------
--  Ultracañón Pimpampum 5000  --
---------------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Ultracañón Pimpampum 5000"
})

-----------------------
--  Golpea al gnoll  --
-----------------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Golpea al gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Has ganado %d de %d puntos posibles",
	warnGameOverNoQuest	= "La partida ha terminado con un total de %d puntos posibles",
	warnGnoll			= "Sale un gnoll",
	warnHogger			= "Sale Hogger",
	specWarnHogger		= "¡Sale Hogger!"
})

L:SetOptionLocalization({
	warnGameOver	= "Anunciar máximo de puntos posibles cuando termine la partida",
	warnGnoll		= "Anunciar cuándo sale un gnoll",
	warnHogger		= "Anunciar cuándo sale Hogger",
	specWarnHogger	= "Mostrar aviso especial cuando salga Hogger"
})

---------------------------------
--  Galería de tiro al blanco  --
---------------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Galería de tiro al blanco"
})

L:SetOptionLocalization({
	SetBubbles			= "Desactivar automáticamente los bocadillos de chat durante $spell:101871 (se restaurarán al terminar la partida)"
})

--------------------------
--  Batalla de tonques  --
--------------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Batalla de tonques"
})

-----------------------------------
--  Desafío del pájaro de fuego  --
-----------------------------------
L = DBM:GetModLocalization("Rings")

L:SetGeneralLocalization({
	name = "Desafío del pájaro de fuego"
})

-------------------------------
--  Conejo de la Luna Negra  --
-------------------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Conejo de la Luna Negra"
})

------------------
--  Dienteluna  --
------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Dienteluna"
})

L:SetWarningLocalization({
	specWarnCallPack		= "Llamar a la manada - ¡Aléjate a más de 40 m de Dienteluna!",
	specWarnMoonfangCurse	= "Maldición de Dienteluna - ¡Aléjate a más de 10 m de Dienteluna!"
})
