local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "Next Siege Vehicle",
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"Show timer for when new siege vehicles spawn"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"Comin' in hot!",
	AddsSpawn2		=	"Fire in the hole!"
})

---------------------------
-- Iron Reaver --
---------------------------
L= DBM:GetModLocalization(1425)

---------------------------
-- Hellfire High Council --
---------------------------
L= DBM:GetModLocalization(1432)

------------------
-- Kormrok --
------------------
L= DBM:GetModLocalization(1392)

--------------
-- Kilrogg Deadeye --
--------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon		=	"Come brothers! Seize your destiny!"
})

--------------------
--Gorefiend --
--------------------
L= DBM:GetModLocalization(1372)

--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"Throw Eye of Anzu to %s!"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"Show special warning when you need to throw $spell:179202"
})

--------------------------
-- Fel Lord Zakuun --
--------------------------
L= DBM:GetModLocalization(1391)

L:SetOptionLocalization({
	SeedsBehavior		= "Set seeds yell behavior",
	Numbered			= "1, 2, 3, 4. Usable for any strat using numbered positions.",--Default
	DirectionLine		= "Far Left, Middle Left, Middle Right, Far Right. Typical for straight line strat",
	CrossPerception		= "Front, Back, Left, Right. Typical for Cross strat",
	CrossCardinal		= "North, South, East, West. Typical for Cross strat",
	ExCardinal			= "NorthEast, Southeast, Northwest, Southwest. Typical for Ex strat"
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Raid leader sent %s configuration for seeds.",
	BWConfigMsg			= "Raid leader is using BW, configuring DBM to <Insert whatever the hell bigwigs ends up doing for this here> to match BW for seeds.",
	yellSeeds			+ "Seeds %s on %s"
	--TODO, talk to some guilds, maybe trim list above, add finalized directions here
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "Set Fel Chains warning behavior",
	Cast				= "Only give orininal target on begin cast. Timer syncs to cast start.",
	Applied				= "Only give all targets affected on cast finish. Timer syncs to cast finish.",
	Both				= "Give original target on cast start and all affected targets on cast finish. Timer syncs to cast start."
})

--------------------------
-- Socrethar the Eternal --
--------------------------
L= DBM:GetModLocalization(1427)

--------------------------
-- Tyrant Velhari --
--------------------------
L= DBM:GetModLocalization(1394)

--------------------------
-- Mannoroth --
--------------------------
L= DBM:GetModLocalization(1395)

L:SetMiscLocalization({
	felSpire		=	"begins to empower the Fel Spire!"
})

--------------------------
-- Archimonde --
--------------------------
L= DBM:GetModLocalization(1438)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"Hellfire Citadel Trash"
})
