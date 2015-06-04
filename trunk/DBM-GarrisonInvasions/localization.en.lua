local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Garrison Invasions"
})

L:SetWarningLocalization({
	specWarnRylak	= "Darkwing Scavenger Incoming",
	specWarnWorker	= "Terrified worker in open",
	specWarnSpy		= "A spy has snuck in",
	specWarnBuilding= "A building is being attacked"
})

L:SetOptionLocalization({
	specWarnRylak	= "Show special warning when a rylak is incoming",
	specWarnWorker	= "Show special warning when a terrified worker is caught in open",
	specWarnSpy		= "Show special warning when a spy has snuck in",
	specWarnBuilding= "Show special warning when a building is under attack"
})

L:SetMiscLocalization({
	--General
	preCombat			= "To arms! To your posts!",--Common in all yells, rest varies based on invasion
	preCombat2			= "The air has taken a turn for the foul...",--Shadow Council doesn't follow format of others :\
	rylakSpawn			= "The commotion of the battle attracts a rylak!",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "A terrified worker is caught in the open!",
	sneakySpy			= "spy has snuck in amidst the chaos!",--Shortened to cut out "horde/alliance"
	buildingAttack		= "Your %s is under attack!",--Your Salvage Yard is under attack!
	--Ogre
	GorianwarCaller		= "A Gorian Warcaller joins the battle to raise morale!",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "A Wildfire Elemental is being summoned at the front gates!",--Maybe combined "add" special warning most adds?
	--Iron Horde
	Assassin			= "An Assassin is hunting your guards!"--Maybe combined "add" special warning most adds?
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
	name = "Lady Fleshsear"
})

----------------------
--  Commander Dro'gan  --
----------------------
L = DBM:GetModLocalization("Drogan")

L:SetGeneralLocalization({
	name = "Commander Dro'gan"
})

----------------------------
-- Mage Lord Gogg'nathog  --
----------------------------
L = DBM:GetModLocalization("Goggnathog")

L:SetGeneralLocalization({
	name = "Mage Lord Gogg'nathog"
})
