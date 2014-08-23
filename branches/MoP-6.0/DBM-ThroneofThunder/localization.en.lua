local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s soon - get out from Conductive Water!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Show special warning if you standing in $spell:138470<br/>(Warns at $spell:137313 pre-cast or $spell:138732 debuff fades shortly)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8/4")
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
	SetIconOnAdds			= "Set icons on balcony adds",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 136480),
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
	PHealthFrame		= "Show remaining health frame for $spell:136442 fades<br/>(Requires boss health frame enabled)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(5),
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
	specWarnCrystalShell	= "Show special warning when you are missing<br/> $spell:137633 debuff and are above 90% health",
	InfoFrame				= "Show info frame for players without $spell:137633",
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
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 138923),
	ShowNestArrows		= "Show DBM arrow for nest activations",
	Never				= "Never",
	Northeast			= "Blue - Lower & Upper NE",
	Southeast			= "Green - Lower & Upper SE",
	Southwest			= "Purple/Red - Lower SW & Upper SW(25) or Upper Middle(10)",
	West				= "Red - Lower W & Upper Middle (25 only)",
	Northwest			= "Yellow - Lower & Upper NW (25 only)",
	Guardians			= "Nest Guardians"
})

L:SetMiscLocalization({
	eggsHatch		= "nests begin to hatch!",
	Upper			= "Upper",
	Lower			= "Lower",
	UpperAndLower	= "Upper & Lower",
	TrippleD		= "Tripple (2xDwn)",
	TrippleU		= "Tripple (2xUp)",
	NorthEast		= "|cff0000ffNE|r",--Blue
	SouthEast		= "|cFF088A08SE|r",--Green
	SouthWest		= "|cFF9932CDSW|r",--Purple
	West			= "|cffff0000W|r",--Red
	NorthWest		= "|cffffff00NW|r",--Yellow
	Middle10		= "|cFF9932CDMiddle|r",--Purple (Middle is upper southwest on 10 man/LFR)
	Middle25		= "|cffff0000Middle|r",--Red (Middle is upper west on 25 man)
	ArrowUpper		= " |TInterface\\Icons\\misc_arrowlup:12:12|t ",
	ArrowLower		= " |TInterface\\Icons\\misc_arrowdown:12:12|t "
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
	SetParticle					= "Automatically set particle density to low on pull<br/>(Restores previous setting on combat end)"
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
	RangeFrame					= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("5/3"),
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
	warnMatterSwapped	= "Announce targets swapped by $spell:138618",
	SetIconOnFont           = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138707)
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
	RangeFrame				= "Show dynamic range frame (10)<br/>(This is a smart range frame that shows when too many are too close)",
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
	timerDuskCD		= "Next dusk phase"
})

L:SetOptionLocalization({
	warnNight		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej7641"),
	warnDay			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej7645"),
	warnDusk		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej7633"),
	timerDayCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej7645"),
	timerDuskCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej7633"),
	RangeFrame		= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(5)
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin! Lend me your strength!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Intermission soon",
	warnDiffusionChainSpread	= "%s spread on >%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "First Conduit CD"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Show pre-special warning before Intermission",
	warnDiffusionChainSpread	= "Announce $spell:135991 spread targets",
	timerConduitCD				= "Show timer for first conduit ability cooldown",
	RangeFrame					= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8/6"),--For two different spells
	StaticShockArrow			= "Show DBM Arrow when someone is affected by $spell:135695",
	OverchargeArrow				= "Show DBM Arrow when someone is affected by $spell:136295",
	SetIconOnOvercharge			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

L:SetMiscLocalization({
	StaticYell		= "Static Shock on %s (%d)"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump		= "Unstable Vita jumped to you!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump		= "Show special warning when $spell:138297 jumps to you",
	SetIconsOnVita				= "Set icons on $spell:138297 debuffed player and furthest player from them"
})

L:SetMiscLocalization({
	Defeat						= "Wait!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"Throne of Thunder Trash"
})

L:SetOptionLocalization({
	RangeFrame		= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(10)--For 3 different spells
})
