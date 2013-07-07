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

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetMiscLocalization({
	newForces1				= "Warriors, on the double!",--translate (trigger)
	newForces2				= "Defend the gate!",--translate (trigger)
	newForces3				= "Rally the forces!",--translate (trigger)
	newForces4				= "Kor'kron, at my side!",--translate (trigger)
	newForces5				= "Next squad, to the front!"--translate (trigger)
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	mineTarget	= "A Crawler Mine has targeted you!",--translate (trigger)
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",--translate (trigger)
	newShredder	= "An Automated Shredder draws near!"--translate (trigger)
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "You are vulnerable to %s - Avoid!",--translate later
	specWarnCriteriaLinked			= "You are linked to %s!"--translate later
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Show special warning when a paragon you are vulnerable to activating paragons",--translate later
	specWarnCriteriaLinked			= "Show special warning when you are linked to $spell:144095",--translate later
})

L:SetMiscLocalization({
	--translate later (triggers)
	calculatedTarget	= "calculating eye!",
	yellow				= "Yellow",
	red					= "Red",
	blue				= "Blue",
	purple				= "Purple",
	green				= "Green",
	bomb				= "Bomb",
	sword				= "Swords",
	drums				= "Drums",
	mantid				= "Mantid",--Assumed
	staff 				= "Staff",--Assumed
	one					= "One",
	two					= "Pair",
	three				= "Three",
	four				= "Four",--Assumed
	five				= "Five",--Assumed
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
	name =	"Trash der Belagerung Orgrimmars"
})
