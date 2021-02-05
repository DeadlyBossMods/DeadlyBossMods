if GetLocale() ~= "ruRU" then return end
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
	SortDesc 				= "Sort $spell:334755 Infoframe by highest debuff stack (instead of lowest).",
	ShowTimeNotStacks		= "Show time remaining on $spell:334755 Infoframe instead of stack count."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
L= DBM:GetModLocalization(2418)

L:SetMiscLocalization({
	Phase2			= "Что же делает эта штука? Любопытно до смерти. Правда, умрете, скорее всего, вы.",
	Phase2Demonic	= "Lok zennshinagas xi ril zila refir il rethule no Rakkas az alar alar archim maev shi ",--Boss has Curse of Tongues
	Phase3			= "Надеюсь, эта вещица не только выглядит опасной!",
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
	timerDesiresContainer		= "Desires full",
	timerBottledContainer		= "Bottled full",
	timerSinsContainer			= "Sins full",
	timerConcentrateContainer	= "Concentrate full"
}

L:SetOptionLocalization({
	timerContainers2			= "Show timer that will show container fill progress and time remaining until full"
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
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "Automatically adjust timers when abilities get spell queued by other abilities"
})

---------------------------
--  Sire Denathrius --
---------------------------
L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	CrimsonSpawn	= "Алые кабалисты откликнулись на призыв Денатрия."
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"Castle Nathria Trash"
})
