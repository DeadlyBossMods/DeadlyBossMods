local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmaw"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s slumps forward, exposing his pincers!",
	HeadExposed		= "%s becomes impaled on the spike, exposing his head!"
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Omnotron Defense System"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "Arcane Blowback",
	timerShadowConductorCast	= "Shadow Conductor"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Show timer for $spell:92053 cast",
	timerArcaneBlowbackCast	= "Show timer for $spell:91879 cast",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron		= "Magmatron",
	Electron		= "Electron",
	Toxitron		= "Toxitron",
	Arcanotron		= "Arcanotron"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "%s phase",
	WarnRemainingAdds	= "%d aberrations remaining"
})

L:SetTimerLocalization({
	TimerPhase		= "Next phase"
})

L:SetMiscLocalization({
	YellRed			= "red|r vial into the cauldron!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue		= "blue|r vial into the cauldron!",
	YellGreen		= "green|r vial into the cauldron!",
	YellDark		= "dark|r magic into the cauldron!",
	Red			= "Red",
	Blue			= "Blue",
	Green			= "Green",
	Dark			= "Dark"
})

L:SetOptionLocalization({
	WarnPhase		= "Show warning which phase is incoming",
	WarnRemainingAdds	= "Show warning how many aberrations remain",
	TimerPhase		= "Show timer for next phase",
	RangeFrame		= "Show range frame (6) during blue phase",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 soon",
	WarnBreak	= "%s on >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Show a prewarning for Phase 2",
	RangeFrame		= "Show range frame (6)",
	WarnBreak		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935)
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Airphase",
	WarnGroundphase		= "Groundphase",
	WarnShieldsLeft		= "Ancient Dwarven Shield used - %d left"
})

L:SetTimerLocalization({
	TimerAirphase		= "Airphase",
	TimerGroundphase	= "Groundphase"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancient Dwarven Shield",
	Soundlevel				= "Sound Level",
	Airphase				= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Show warning when Atramedes lifts off",
	WarnGroundphase		= "Show warning when Atramedes lands",
	WarnShieldsLeft		= "Show warning when a Ancient Dwarven Shield gets used",
	TimerAirphase		= "Show timer for next airphase",
	TimerGroundphase	= "Show timer for next groundphase",
	InfoFrame			= "Show info frame for sound levels",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Tail Lash (Onyxia)",
	NefTailSwipe		= "Tail Lash (Nefarian)",
	OnyBreath			= "Breath (Onyxia)",
	NefBreath			= "Breath (Nefarian)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Tail Lash CD (Ony)",
	NefSwipeTimer		= "Tail Lash CD (Nef)",
	OnyBreathTimer		= "Breath CD (Ony)",
	NefBreathTimer		= "Breath CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Show warning for Onyxia's $spell:77827",
	NefTailSwipe		= "Show warning for Nefarian's $spell:77827",
	OnyBreath			= "Show warning for Onyxia's $spell:94124",
	NefBreath			= "Show warning for Nefarian's $spell:94124",
	OnySwipeTimer		= "Show timer for Onyxia's $spell:77827 cooldown",
	NefSwipeTimer		= "Show timer for Nefarian's $spell:77827 cooldown",
	OnyBreathTimer		= "Show timer for Onyxia's $spell:94124 cooldown",
	NefBreathTimer		= "Show timer for Nefarian's $spell:94124 cooldown"
})

L:SetMiscLocalization({
	NefAoe				= "The air crackles with electricity!",
	YellPhase2			= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	ShadowblazeCast		= "Flesh turns to ash!",
	ChromaticPrototype	= "Chromatic Prototype"
})