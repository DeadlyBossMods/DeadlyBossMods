local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "RISE, MOUNTAINS!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Play countdown sound for Phemos' cooldowns",
	PolSpecial		= "Play countdown sound for Pol's cooldowns"
})

L:SetMiscLocalization({
	PhemosSpecial	= "Play countdown sound for Phemos' cooldowns",
	PolSpecial		= "Play countdown sound for Pol's cooldowns"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetMiscLocalization({
	supressionTarget1	= "I will crush you!",
	supressionTarget2	= "Silence!",
	supressionTarget3	= "Quiet!",
	supressionTarget4	= "I will tear you in half!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetMiscLocalization({
	BrandedYell			= "Branded (%d) on %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Highmaul Trash"
})
