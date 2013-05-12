local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s soon - get out from Conductive Water!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Show special warning if you standing in $spell:138470\n(Warns at $spell:137313 pre-cast or $spell:138732 debuff fades shortly)",
	RangeFrame			= "Show range frame (8/4)"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Orb of Control dropped",
	specWarnOrbofControl	= "Orb of Control dropped!"
})

L:SetTimerLocalization({
	timerDoor				= "Next Tribal Door",
	timerAdds				= "Next %s"
})

L:SetOptionLocalization({
	warnAdds				= "Announce when new adds jump down",
	warnOrbofControl		= "Announce when $journal:7092 dropped",
	specWarnOrbofControl	= "Show special warning when $journal:7092 dropped",
	timerDoor				= "Show timer for next Tribal Door phase",
	timerAdds				= "Show timer for when next add jumps down",
	RangeFrame				= "Show range frame (5) for $spell:136480",
	SetIconOnCharge			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136769)
})

L:SetMiscLocalization({
	newForces				= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget			= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed		= "%s on %s - switch targets"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	PHealthFrame		= "Show remaining health frame for $spell:136442 fades\n(Requires boss health frame enabled)",
	RangeFrame			= "Show range frame",
	AnnounceCooldowns	= "Count out (up to 3) which $spell:137166 cast it is for raid cooldowns",
	SetIconOnBitingCold	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136992),
	SetIconOnFrostBite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136922)
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s used by >%s< (%d remaining)",
	specWarnCrystalShell	= "Get %s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Show special warning when you are missing\n $spell:137633 debuff",
	InfoFrame				= "Show info frame for players without $spell:137633",
	SetIconOnTurtles		= "Set icons on $journal:7129",
	ClearIconOnTurtles		= "Clear icons on $journal:7129 when affected by $spell:133971",
	AnnounceCooldowns		= "Count out which $spell:134920 cast it is for raid cooldowns"
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "Next Breath"
})

L:SetOptionLocalization({
	timerBreaths			= "Show timer for next breath",
	SetIconOnCinders		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139889),
	AnnounceCooldowns		= "Count out which Rampage cast it is for raid cooldowns",
	Never					= "Never",
	Every					= "Every (consecutive)",
	EveryTwo				= "Cooldown order of 2",
	EveryThree				= "Cooldown order of 3",
	EveryTwoExcludeDiff		= "Cooldown order of 2 (Exluding Diffusion)",
	EveryThreeExcludeDiff	= "Cooldown order of 3 (Exluding Diffusion)"
})

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "Nest Guardian: %s",
	specWarnBigBirdSoon	= "Nest Guardian Soon: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	warnFlock			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	specWarnBigBird		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7827"),
	specWarnBigBirdSoon	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon:format("ej7827"),
	timerFlockCD		= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame			= "Show range frame (10) for $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "The eggs in one of the lower nests begin to hatch!",
	eggsHatchU		= "The eggs in one of the upper nests begin to hatch!",
	Upper			= "Upper",
	Lower			= "Lower",
	UpperAndLower	= "Upper & Lower",
	TrippleD		= "Tripple (2xDwn)",
	TrippleU		= "Tripple (2xUp)",
	SouthWest		= "SW",
	SouthEast		= "SE",
	NorthWest		= "NW",
	NorthEast		= "NE",
	West			= "W",
	Middle			= "M"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<",
	warnBeamHeroic				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<, |cffffff00Yellow|r : >%s<",
	warnAddsLeft				= "Fogs remaining: %d",
	specWarnBlueBeam			= "Blue Beam on you - Avoid Moving",
	specWarnFogRevealed			= "%s revealed!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Announce beam targets",
	warnAddsLeft				= "Announce how many Fogs remain",
	specWarnFogRevealed			= "Show special warning when a fog is revealed",
	specWarnBlueBeam			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "Show DBM Arrow during $journal:6882 to indicate which direction to move",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133795),
	SetIconOnParasite			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133597),
	InfoFrame					= "Show info frame for $spell:133795 stacks",
	SetParticle					= "Automatically set particle density to low on pull\n(Restores previous setting on combat end)"
})

L:SetMiscLocalization({
	LifeYell		= "Life Drain on %s (%d)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Mutate progress : %d/5 good & %d bad"
})

L:SetOptionLocalization({
	warnDebuffCount				= "Show debuff count warnings when you absorb pools",
	RangeFrame					= "Show range frame (5/2)",
	SetIconOnBigOoze			= "Set icon on $journal:6969"
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
	warnDeadZone			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136192),
	RangeFrame				= "Show dynamic range frame (10)\n(This is a smart range frame that shows when too many are too close)",
	InfoFrame				= "Show info frame for players with $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "Night phase",
	warnDay			= "Day phase",
	warnDusk		= "Dusk phase"
})

L:SetTimerLocalization({
	timerDayCD		= "Next day phase",
	timerDuskCD		= "Next dusk phase",
})

L:SetOptionLocalization({
	warnNight		= "Announce night phase",
	warnDay			= "Announce day phase",
	warnDusk		= "Announce dusk phase",
	timerDayCD		= "Show timer for next day phase",
	timerDuskCD		= "Show timer for next dusk phase",
	RangeFrame		= "Show range frame (8)"
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin! Lend me your strength!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Intermission soon"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Show pre-special warning before Intermission",
	RangeFrame					= "Show range frame (8/6)",--For two different spells
	StaticShockArrow			= "Show DBM Arrow when someone is affected by $spell:135695",
	OverchargeArrow				= "Show DBM Arrow when someone is affected by $spell:136295",
	SetIconOnOvercharge			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"Throne of Thunder Trash"
})

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (10)"--For 3 different spells
})
