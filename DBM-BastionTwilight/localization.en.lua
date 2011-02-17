local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona & Theralion"
})

L:SetWarningLocalization({
	WarnDazzlingDestruction	= "%s (%d)",
	WarnDeepBreath			= "%s (%d)",
	WarnTwilightShift		= "%s : >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnDazzlingDestruction	= "Show warning for $spell:86408",
	WarnDeepBreath			= "Show warning for $spell:86059",
	WarnTwilightShift		= "Show warning for $spell:93051",
	YellOnEngulfing			= "Yell on $spell:86622",
	YellOnMeteor			= "Yell on $spell:88518",
	YellOnTwilightBlast		= "Yell on $spell:92898",
	TwilightBlastArrow		= "Show DBM arrow when $spell:92898 is near you",
	RangeFrame				= "Show range frame (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Deep Breath",
	YellEngulfing			= "Engulfing Magic on me!",
	YellMeteor				= "Twilight Meteorite on me!",
	YellTwilightBlast		= "Twilight Blast on me!"
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Wyrmbreaker"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Show the health of released drakes"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Twilight Ascendant Council"
})

L:SetWarningLocalization({
	SpecWarnGrounded		= "Get Grounded buff",
	SpecWarnSearingWinds	= "Get Searing Winds buff"
})

L:SetTimerLocalization({
	timerTransition		= "Phase Transition"
})

L:SetMiscLocalization({
	Quake			= "The ground beneath you rumbles ominously....",
	Thundershock	= "The surrounding air crackles with energy....",
	Switch			= "Enough of this foolishness!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "An impressive display...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Ignacious		= "Ignacious",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Elementium Monstrosity",
	Kill			= "Impossible...."
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Show special warning when you are missing $spell:83581 buff\n(~10sec before cast)",
	SpecWarnSearingWinds= "Show special warning when you are missing $spell:83500 buff\n(~10sec before cast)",
	timerTransition		= "Show Phase transition timer",
	RangeFrame			= "Show range frame automatically when needed",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 soon"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellCrash			= "Corrupting Crash on me!",
	Bloodlevel				= "Corruption"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Show pre-warning for Phase 2",
	YellOnCorrupting		= "Yell on $spell:93178",
	CorruptingCrashArrow	= "Show DBM arrow when $spell:93178 is near you",
	InfoFrame				= "Show info frame for $spell:82235",
	RangeFrame				= "Show range frame (6) for $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317)
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Sinestra"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})