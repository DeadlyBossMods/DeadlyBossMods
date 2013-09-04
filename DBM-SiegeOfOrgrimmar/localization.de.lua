if GetLocale() ~= "deDE" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "Zeige Infofenster für $journal:8252"
})

L:SetMiscLocalization({
	wasteOfTime			= "Very well, I will create a field to keep your corruption quarantined."--translate (trigger)
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "Zeige Infofenster für $journal:8255"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerAddsCD		= "Nächste Adds",
	timerTowerCD	= "Next Tower & Adds"--translate later
})

L:SetOptionLocalization({
	timerAddsCD		= "Zeige Zeit bis nächste Add-Welle",
	timerTowerCD	= "Show timer for next tower assault"--translate later
})

L:SetMiscLocalization({
	newForces1	= "Here they come!",--translate (trigger)
	newForces2	= "Dragonmaw, advance!",--translate (trigger)
	newForces3	= "For Hellscream!",--translate (trigger)
	newForces4	= "Next squad, push forward!",--translate (trigger)
	tower		= "The door barring the"--translate (trigger)
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Prison on %s fades (%d)"--translate later
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Verteidigungshaltung in %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Zeige Vorwarnungscountdown für $spell:143593 (5s zuvor)"
})

L:SetMiscLocalization({
	newForces1					= "Warriors, on the double!",--translate (trigger)
	newForces2					= "Defend the gate!",--translate (trigger)
	newForces3					= "Rally the forces!",--translate (trigger)
	newForces4					= "Kor'kron, at my side!",--translate (trigger)
	newForces5					= "Next squad, to the front!",--translate (trigger)
	allForces					= "All Kor'kron... under my command... kill them... NOW!"--translate (trigger)
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	Module1 = "Module 1's all prepared for system reset.",--translate (trigger)
	Victory	= "Module 2's all prepared for system reset"--translate (trigger)
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Zeige dynamisches Abstandsfenster (10m)<br/>(mit Indikator für den \"Blutrausch\"-Schwellwert)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfertige Waffen werden auf das Fabrikationsband befördert.",--needs to be verified (PTR screenshot-captured translation)
	newShredder	= "An Automated Shredder draws near!"--translate (trigger)
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "%s wird dir erhöhten Schaden zufügen - Meiden!",
	specWarnCriteriaLinked			= "Du bist verbunden mit %s!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Spezialwarnung, wenn dir ein neuer Getreuer erhöhten Schaden zufügen wird",
	specWarnCriteriaLinked			= "Spezialwarnung, wenn du mit einem anderen Spieler verbunden bist ($spell:144095)"
})

L:SetMiscLocalization({
	--translate later (triggers)
	one					= "One",
	two					= "Two",
	three				= "Three",
	four				= "Four",
	five				= "Five",
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("FoOTrash")

L:SetGeneralLocalization({
	name =	"Trash der Schlacht um Orgrimmar"
})
