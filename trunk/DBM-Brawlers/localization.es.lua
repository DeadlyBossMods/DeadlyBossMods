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
	warnQueuePosition2	= "Estás en el puesto %d de la cola",
	specWarnYourNext	= "¡Eres el siguiente!",
	specWarnYourTurn	= "¡Te toca!",
	specWarnRumble		= "¡Reyerta!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "Anunciar tu puesto en la cola cada vez que cambie",
	specWarnYourNext	= "Mostrar aviso especial cuando seas el primero en cola",
	specWarnYourTurn	= "Mostrar aviso especial cuando sea tu turno",
	specWarnRumble		= "Mostrar aviso especial cuando se inicie una reyerta",
	SpectatorMode		= "Mostrar avisos y temporizadores al espectar combates (tus avisos especiales personales no se mostrarán a los espectadores)",
	SpeakOutQueue		= "Anunciar tu número en la cola cuando esta se actualice",
	NormalizeVolume		= "Normalizar automáticamente el volumen del canal de sonido de diálogos para que coincida con el del canal de efectos de sonido mientras estés en la arena, de forma que los ánimos y aplausos no suenen tan alto."
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Jefa Zumbarriel",--Horde
	--Alliance pre-berserk
	BizmoIgnored	= "We Don't have all night. Hurry it up already!", --WIP
	BizmoIgnored2	= "Do you smell smoke?", --WIP
	BizmoIgnored3	= "I think it's about time to call this fight.", --WIP
	BizmoIgnored4	= "¿Es cosa mía o está subiendo la temperatura?",
	BizmoIgnored5	= "The fire's coming!", --WIP
	BizmoIgnored6	= "I think we've seen just about enough of this. Am I right?", --WIP
	BizmoIgnored7	= "We've got a whole list of people who want to fight, you know.", --WIP
	--Horde pre-berserk
	BazzelIgnored	= "Sheesh, guys! Hurry it up already!", --WIP
	BazzelIgnored2	= "Uh oh... I smell smoke...", --WIP
	BazzelIgnored3	= "Time's almost up!", --WIP
	BazzelIgnored4	= "Is it gettin' hot in here?", --WIP
	BazzelIgnored5	= "Fire's comin'!", --WIP
	BazzelIgnored6	= "Let's keep it movin' in there!", --WIP
	BazzelIgnored7	= "Alright, alright. We've got a line going out here, you know.", --WIP
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Rango 1",
	Rank2			= "Rango 2",
	Rank3			= "Rango 3",
	Rank4			= "Rango 4",
	Rank5			= "Rango 5",
	Rank6			= "Rango 6",
	Rank7			= "Rango 7",
	Rank8			= "Rango 8",
--	Rank9			= "Rango 9",
--	Rank10			= "Rango 10",
	Rumbler			= "peleón",
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

L:SetOptionLocalization({
	SetIconOnBlat	= "Poner icono (calavera) en el verdadero Blat"
})

L:SetMiscLocalization({
	Sand			= "Arena"
})

-------------
-- Rango 3 --
-------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Rango 3"
})

-------------
-- Rango 4 --
-------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Rango 4"
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

--[[
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
--]]

--------------
-- Reyertas --
--------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "Reyertas"
})

------------
-- Legado --
------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Desafíos de legado"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Anunciar número de $spell:141190"
})

----------------
-- Especiales --
----------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Desafíos especiales"
})

L:SetWarningLocalization({
	specWarnRPS			= "¡Usa %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Mostrar flecha para $spell:140868, $spell:140862 y $spell:140886",
	specWarnRPS			= "Mostrar aviso especial con qué usar para $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Piedra",
	paper			= "Papel",
	scissors		= "Tijeras"
})