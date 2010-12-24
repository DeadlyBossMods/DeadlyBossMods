local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona & Theralion"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetOptionLocalization({
	YellOnEngulfing			= "Yell on $spell:86622",
	RangeFrame		= "Show range frame (10)"
})

L:SetMiscLocalization{
	Trigger1				= "Theralion, I will engulf the hallway. Cover their escape!",--Terrible phase trigger, even transcriptor couldn't grab anything more usefull than this :(
	YellEngulfing				= "Engulfing Magic on me!"
}

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
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Twilight Ascendant Council"
})

L:SetWarningLocalization({
	SpecWarnGrounded	= "Get Grounded buff",
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
	Monstrosity		= "Elementium Monstrosity"
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Show special warning when you are missing $spell:83581 buff\n(~10sec before cast)",
	SpecWarnSearingWinds	= "Show special warning when you are missing $spell:83500 buff\n(~10sec before cast)",
	timerTransition		= "Show Phase transition timer",
	HeartIceIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948)
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
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Show pre-warning for Phase 2"
})