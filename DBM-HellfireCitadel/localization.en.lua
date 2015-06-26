local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "Next Vehicle %s",
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"Show timer for when new siege vehicles spawn"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"Comin' in hot!",--Blizzard seems to have disabled these
	AddsSpawn2		=	"Fire in the hole!",--Blizzard seems to have disabled these
	BossLeaving		=	"I'll be back..."
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

L:SetTimerLocalization({
	SoDDPS		= "Next Shadows (%s)",
	SoDTank		= "Next Shadows (%s)",
	SoDHealer	= "Next Shadows (%s)"
})

L:SetOptionLocalization({
	SoDDPS		= "Show timer for next $spell:179864 affecting Damagers",
	SoDTank		= "Show timer for next $spell:179864 affecting Tanks",
	SoDHealer	= "Show timer for next $spell:179864 affecting Healers"
})

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

L:SetWarningLocalization({
	specWarnSeedPosition =	"Seed Position: %s"
})

L:SetOptionLocalization({
	SeedsBehavior		= "Set seeds yell behavior for raid (Requires raid leader)",
	Iconed				= "Skull, Cross, Square, Moon, Triangle. Usuable for any strat using flare positions",--Default
	Numbered			= "1, 2, 3, 4, 5. Usable for any strat using numbered positions.",
	DirectionLine		= "Left, Middle Left, Middle, Middle Right, Right. Typical for straight line strat",
	FreeForAll			= "Free for all. Assign no positions, just use basic yell",
	--Currently these 3 below are unused unless I see anyone want/need them
	CrossPerception		= "Front, Back, Left, Right, Middle. Typical for Cross strat",--Unsure if viable with 5 targets/will remain
	CrossCardinal		= "North, South, East, West, Middle. Typical for Cross strat",--Unsure if viable 5 targets/will remain
	ExCardinal			= "NorthEast, Southeast, Northwest, Southwest, Middle. Typical for Ex strat"--Unsure if viable 5 targets/will remain
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Seed configuration set to %s to match raid leaders configuration.",
	BWConfigMsg			= "Raid leader is using Bigwigs, configuring DBM to <Insert whatever the hell bigwigs ends up doing for this here> to match BW for seeds.",
	customSeedsSay		= "Seeds %s on %s"
	--TODO, talk to some guilds, maybe trim list above, add finalized directions here
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "Set Fel Chains warning behavior",
	Cast				= "Only give original target on cast start. Timer syncs to cast start.",
	Applied				= "Only give targets affected on cast end. Timer syncs to cast end.",
	Both				= "Give original target on cast start and targets affected on cast end. Timer syncs to cast start."
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

L:SetWarningLocalization({
	specWarnBreakShackle	= "Shackled Torment: Break %s!"
})

L:SetOptionLocalization({
	specWarnBreakShackle	= "Show special warning when affected by $spell:184964. This warning auto assigns break order to minimize similtanious damage.",
	FilterOtherPhase		= "Filter out warnings for events not in same phase as you"
})

L:SetMiscLocalization({
	phase2				= "I grow tired of this pointless game. You face the immortal Legion, scourge of a thousand worlds.",--1 second faster than CLEU. Probably not needed, but just in case
	phase2point5		= "Look upon the endless forces of the Burning Legion and know the folly of your resistance.",--3 seconds faster than CLEU, used as primary, slower CLEU secondary
	phase3				= "Enough! Your meaningless struggle ends now!",--6 seconds faster than CLEU, used as primary, slower CLEU secondary
	phase3point5		= "I will shatter this pathetic world! Its broken husk will be torn apart in the twisting nether for all time!",--Not currently used. seems fire at same time as UNIT event that's present. Here only in case things change from now and live
	First				= "First",
	Second				= "Second",
	Third				= "Third",
	Fourth				= "Fourth",--Just in case, not sure how many targets in 30 man raid
	Fifth				= "Fifth",--Just in case, not sure how many targets in 30 man raid
	customShackledSay	= "%s Shackle on %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"Hellfire Citadel Trash"
})
