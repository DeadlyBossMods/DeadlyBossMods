local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s soon - get out from Conductive Water!"
})

L:SetOptionLocalization({
	RangeFrame			= "Show range frame"
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
	RangeFrame				= "Show range frame (5) for $spell:136480"
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
	specWarnCrystalShell	= "Show special warning when you are missing $spell:137633 debuff",
	InfoFrame				= "Show info frame for players without $spell:137633",
	SetIconOnTurtles		= "Set icons on $journal:7129 \n(May not be reliable if more than 1 person with assist enables)",
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetOptionLocalization({
	SetIconOnCinders		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139889)
})

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%s)",
	specWarnFlock	= "%s %s (%s)"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD	= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame		= "Show range frame (8) for $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "The eggs in one of the lower nests begin to hatch!",
	eggsHatchU		= "The eggs in one of the upper nests begin to hatch!",
	Upper			= "Upper",
	Lower			= "Lower",
	UpperAndLower	= "Upper & Lower",
	TrippleD		= "Tripple (2xDwn)",
	TrippleU		= "Tripple (2xUp)"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnAddsLeft				= "Fogs remaining: %d",
	specWarnFogRevealed			= "%s revealed!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnAddsLeft				= "Announce how many Fogs remain",
	specWarnFogRevealed			= "Show special warning when a fog is revealed",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "Show DBM Arrow during $journal:6882 to indicate which direction to move",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891")
})

L:SetMiscLocalization({
	Eye		= "Eye"--What to localize here, "<72.0 20:04:19> [CHAT_MSG_MONSTER_EMOTE] CHAT_MSG_MONSTER_EMOTE#The Bright  Light reveals an Amber Fog!#Amber Fog###--------->Yellow Eye<---------##0#0##0#309#nil#0#false#false", -- [13413]
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (5/2)"
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
	RangeFrame		= "Show dynamic range frame\n(This is a smart range frame that shows when too many are too close)",
	InfoFrame		= "Show info frame for players with $spell:136193"
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

L:SetOptionLocalization({
	RangeFrame			= "Show range frame",--For two different spells
	StaticShockArrow	= "Show DBM Arrow when someone is affected by $spell:135695",
	OverchargeArrow		= "Show DBM Arrow when someone is affected by $spell:136295",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
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
