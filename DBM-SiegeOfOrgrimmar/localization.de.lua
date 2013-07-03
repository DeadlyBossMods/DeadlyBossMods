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

L:SetMiscLocalization({
	bloodRageEnds	= "subsides!"--translate (trigger)
})

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
	specWarnActivatedVulnerable		= "Show special warning when a paragon you are vulnerable to activates",--translate later
	specWarnCriteriaLinked			= "Show special warning when you are linked to $spell:144095",--translate later
})

L:SetMiscLocalization({
	calculatedTarget	= "calculating eye!"--translate (trigger)
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
