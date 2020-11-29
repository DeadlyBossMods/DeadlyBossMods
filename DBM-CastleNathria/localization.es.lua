if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "Ordenar el marco de información de $spell:334755 de mayor a menor cantidad de acumulaciones (en lugar de de menor a mayor).",
	ShowTimeNotStacks		= "Mostrar duración restante en el marco de información de $spell:334755 en lugar de cantidad de acumulaciones."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
L= DBM:GetModLocalization(2418)

L:SetMiscLocalization({
	Phase2			= "The anticipation to use this relic is killing me! Though, it will more likely kill you.",
	Phase2Demonic	= "Lok zennshinagas xi ril zila refir il rethule no Rakkas az alar alar archim maev shi ",--Boss has Curse of Tongues
	Phase3			= "I hope this wondrous item is as lethal as it looks!",
	Phase3Demonic	= "X ante zila romathis alar il re thorje re az modas "--Boss has Curse of Tongues
})

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "Deseo lleno",
	timerBottledContainer		= "Ánima embotellada lleno",
	timerSinsContainer			= "Pecado lleno",
	timerConcentrateContainer	= "Ánima concentrada lleno"
}

L:SetOptionLocalization({
	timerContainers				= "Mostrar temporizadores con el tiempo restante para que se llenen los contenedores"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
--L= DBM:GetModLocalization(2425)

---------------------------
--  Sire Denathrius --
---------------------------
L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	CrimsonSpawn	= "Crimson Cabalists answer the call of Denathrius."
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
