if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Garnisonsinvasionen"
})

L:SetWarningLocalization({
	specWarnRylak	= "Darkwing Scavenger Incoming",--translate
	specWarnWorker	= "Ein panischer Arbeiter ist schutzlos.",
	specWarnSpy		= "Ein Spion hat sich eingeschlichen.",
	specWarnBuilding= "Ein Gebäude wird angegriffen."
})

L:SetOptionLocalization({
	specWarnRylak	= "Show special warning when a rylak is incoming",--translate
	specWarnWorker	= "Spezialwarnung, wenn ein panischer Arbeiter schutzlos ist",
	specWarnSpy		= "Spezialwarnung, wenn sich ein Spion eingeschlichen hat",
	specWarnBuilding= "Spezialwarnung, wenn ein Gebäude angegriffen wird"
})

L:SetMiscLocalization({
	--General
	preCombat			= "Zu den Waffen! Auf eure Posten!",
	preCombat2			= "So ein gewisser Gestank liegt in der Luft. Dämonen...",
	rylakSpawn			= "The commotion of the battle attracts a rylak!",--translate, Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "Ein panischer Arbeiter ist schutzlos!",
	sneakySpy			= "hat das Chaos genutzt, um sich einzuschleichen!",
	buildingAttack		= "wird angegriffen!",--needs to be verified (guessed)
	--Ogre
	GorianwarCaller		= "A Gorian Warcaller joins the battle to raise morale!",--translate
	WildfireElemental	= "Ein Wildfeuerelementar wird am Haupttor beschworen!",
	--Iron Horde
	Assassin			= "An Assassin is hunting your guards!"--translate
})

-----------------
--  Annihilon  --
-----------------
L = DBM:GetModLocalization("Annihilon")

L:SetGeneralLocalization({
	name = "Annihilon"
})

--------------
--  Teluur  --
--------------
L = DBM:GetModLocalization("Teluur")

L:SetGeneralLocalization({
	name = "Teluur"
})

----------------------
--  Lady Fleshsear  --
----------------------
L = DBM:GetModLocalization("LadyFleshsear")

L:SetGeneralLocalization({
	name = "Lady Schindflamme"
})

-------------------------
--  Commander Dro'gan  --
-------------------------
L = DBM:GetModLocalization("Drogan")

L:SetGeneralLocalization({
	name = "Kommandant Dro'gan"
})

-----------------------------
--  Mage Lord Gogg'nathog  --
-----------------------------
L = DBM:GetModLocalization("Goggnathog")

L:SetGeneralLocalization({
	name = "Magierfürst Gogg'nathog"
})

------------
--  Gaur  --
------------
L = DBM:GetModLocalization("Gaur")

L:SetGeneralLocalization({
	name = "Gaur"
})
