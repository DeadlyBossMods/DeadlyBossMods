local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (8) for $spell:139997"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerAddsCD		= "Next Tribal Door",
})

L:SetOptionLocalization({
	timerAddsCD		= "Show timer for next Tribal Door phase",
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnPossessed	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "Show range frame"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	specWarnCrystalShell	= "Get %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Show special warning when you are missing $spell:137633 debuff",
	InfoFrame				= "Show info frame for players without $spell:137633"
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetMiscLocalization({
	eggsHatch	= "The eggs in one of the lower nests begin to hatch!"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(133775)
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (5/2)"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< and >%s< swapped"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Announce targets swapped by $spell:138618"
})

L:SetMiscLocalization({
	Pull		= "The orb explodes!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s and %s shielded"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	RangeFrame		= "Show dynamic range frame\n(This is a smart range frame that shows when too many are too close)"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (8)"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "Show range frame"--For two different spells
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

