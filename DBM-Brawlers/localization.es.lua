if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------
-- Camorristas --
-----------------
L= DBM:GetModLocalization("BrawlersGeneral")

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
	BizmoIgnored	= "No tenemos toda la noche. ¡Date prisa!",
	BizmoIgnored2	= "¿Hueles humo?",
	BizmoIgnored3	= "Ya es hora de que esto sea una lucha.",
	BizmoIgnored4	= "¿Es cosa mía o está subiendo la temperatura?",
	BizmoIgnored5	= "¡Se acerca el fuego!",
	BizmoIgnored6	= "Creo que ya hemos visto suficiente, ¿verdad?",
	BizmoIgnored7	= "Tenemos una lista repleta de gente que quiere luchar, sabes.",
	--Horde pre-berserk
	BazzelIgnored	= "¡Agh, chicos! ¡Espabilar de una vez!",
	BazzelIgnored2	= "Oh oh... huelo humo...",
	BazzelIgnored3	= "¡Queda poco tiempo!",
	BazzelIgnored4	= "¿No hace demasiado calor aquí?",
	BazzelIgnored5	= "¡Viene fuego!",
	BazzelIgnored6	= "Sigamos en marcha.",
	BazzelIgnored7	= "Vale, vale. Tenemos una línea ahí, sabes.",
    --Ranks
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
