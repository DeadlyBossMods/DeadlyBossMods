if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
L= DBM:GetModLocalization(2368)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Maut --
---------------------------
L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetMiscLocalization({
	ObeliskSpawn	= "¡Obeliscos de sombras, arriba!"--Only as backup, in case the NPC target check stops working --Translator's Note: may have changed since when I tested it on the PTR
})

---------------------------
--  The Hivemind --
---------------------------
L= DBM:GetModLocalization(2372)

L:SetMiscLocalization({
	Together	= "Jefes juntos",
	Apart		= "Jefes separados"
})

---------------------------
--  Shad'har the Insatiable --
---------------------------
L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetMiscLocalization({
	Furthest	= "Objetivo más lejano",
	Closest		= "Objetivo más cercano"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "Poner icono a la Sangre de Ny'alotha con la salud más baja solo cuando una muera (de lo contrario cambia constantemente a la más baja)",
	InterruptBehavior	= "Patrón de interrupción de Sangre bombeante (sobrescribe al resto si eres el líder)",
	Two					= "Dos jugadores",--Default
	Three				= "Tres jugadores",
	Four				= "Cuatro jugadores",
	Five				= "Cinco jugadores"
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetMiscLocalization({
	ExitMind		= "Sal de la mente"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

