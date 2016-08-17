if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------
-- Camorristas --
-----------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Opciones generales"
})

L:SetWarningLocalization({
	warnQueuePosition	= "Estás en el puesto %d de la cola",
	specWarnYourNext	= "¡Te toca el siguiente!",
	specWarnYourTurn	= "¡Te toca!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "Anunciar tu puesto en la cola cada vez que cambie",
	specWarnYourNext	= "Mostrar aviso especial cuando seas el primero en cola",
	specWarnYourTurn	= "Mostrar aviso especial cuando sea tu turno",
	SpectatorMode		= "Mostrar avisos y temporizadores al espectar combates (tus avisos especiales personales no se mostrarán a los espectadores)",
	SpeakOutQueue		= "Anunciar tu número en la cola cuando esta se actualice"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Jefa Zumbarriel",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Rango 1",
	Rank2			= "Rango 2",
	Rank3			= "Rango 3",
	Rank4			= "Rango 4",
	Rank5			= "Rango 5",
	Rank6			= "Rango 6",
	Rank7			= "Rango 7",
	Rank8			= "Rango 8",
	Rank9			= "Rango 9",
	Rank10			= "Rango 10",
	Proboskus		= "Oh, no... Lo siento, pero parece que te va a tocar luchar contra Proboskus.",--Alliance
	Proboskus2		= "¡Ja, ja, ja! ¡Qué mala suerte tienes! ¡Es Proboskus! ¡Ja, ja, ja, ja! Me apuesto veinticinco monedas de oro a que mueres en el fuego."--Horde
})

-------------
-- Rango 1 --
-------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Rango 1"
})

-------------
-- Rango 2 --
-------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Rango 2"
})

-------------
-- Rango 3 --
-------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Rango 3"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Poner icono (calavera) en el verdadero Blat"
})

-------------
-- Rango 4 --
-------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Rango 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Poner icono (calavera) en la verdadera Dominika la Ilusionista"
})

-------------
-- Rango 5 --
-------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Rango 5"
})

-------------
-- Rango 6 --
-------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Rango 6"
})

-------------
-- Rango 7 --
-------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Rango 7"
})

-------------
-- Rango 8 --
-------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Rango 8"
})

-------------
-- Rango 9 --
-------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Rango 9"
})

------------
-- Legado --
------------
L= DBM:GetModLocalization("BrawlRare1")

L:SetGeneralLocalization({
	name = "Desafíos de legado"
})

----------------
-- Especiales --
----------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "Desafíos especiales"
})

L:SetWarningLocalization({
	specWarnRPS			= "¡Usa %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Mostrar flecha para $spell:140868, $spell:140862 y $spell:140886",
	specWarnRPS			= "Mostrar aviso especial con qué usar para $spell:141206",
	SpeakOutStrikes		= "Anunciar número de $spell:141190"
})

L:SetMiscLocalization({
	rock			= "Piedra",
	paper			= "Papel",
	scissors		= "Tijeras"
})
