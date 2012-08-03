local L

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetWarningLocalization({
	SpecWarnActivated			= "Change Target to %s!",
	specWarnGenerator			= "Power Generator - Move %s!"
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "Shadow Conductor",
	timerArcaneLockout			= "Annihilator Lockout",
	timerArcaneBlowbackCast		= "Arcane Blowback",
	timerNefAblity				= "Ability Buff CD"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Show timer for $spell:92048 cast",
	timerArcaneLockout			= "Show timer for $spell:79710 spell lockout",
	timerArcaneBlowbackCast		= "Show timer for $spell:91879 cast",
	timerNefAblity				= "Show timer for heroic ability buff cooldown",
	SpecWarnActivated			= "Show special warning when new boss activated",
	specWarnGenerator			= "Show special warning when a boss gains $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Set icon on last activated boss"
})

L:SetMiscLocalization({
	YellTargetLock				= "Encasing Shadows! Away from me!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "Blazing Bone Construct Soon (~4s)"
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Show pre-special warning for $spell:92154 (~4s)",
	RangeFrame		= "Show range frame in Phase 2 (5)"
})

L:SetMiscLocalization({
	Slump			= "%s slumps forward, exposing his pincers!",
	HeadExposed		= "%s becomes impaled on the spike, exposing his head!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetOptionLocalization({
	InfoFrame				= "Show info frame for $journal:3072",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	NefAdd					= "Atramedes, the heroes are right THERE!",
	Airphase				= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (6)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Show info frame for health (<10k hp)"
})

L:SetMiscLocalization({
	HealthInfo	= "Health Info"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s phase"
})

L:SetTimerLocalization({
	TimerPhase			= "Next phase"
})

L:SetOptionLocalization({
	WarnPhase			= "Show warning which phase is incoming",
	TimerPhase			= "Show timer for next phase",
	RangeFrame			= "Show range frame (6) during blue phase",
	SetTextures			= "Automatically disable projected textures in dark phase\n(returns it to enabled upon leaving phase)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77699),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "red|r vial into the cauldron!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "blue|r vial into the cauldron!",
	YellGreen			= "green|r vial into the cauldron!",
	YellDark			= "dark|r magic into the cauldron!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	OnyTailSwipe			= "Tail Lash (Onyxia)",
	NefTailSwipe			= "Tail Lash (Nefarian)",
	OnyBreath				= "Breath (Onyxia)",
	NefBreath				= "Breath (Nefarian)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding			= "Nefarian lands",
	OnySwipeTimer			= "Tail Lash CD (Ony)",
	NefSwipeTimer			= "Tail Lash CD (Nef)",
	OnyBreathTimer			= "Breath CD (Ony)",
	NefBreathTimer			= "Breath CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe			= "Show warning for Onyxia's $spell:77827",
	NefTailSwipe			= "Show warning for Nefarian's $spell:77827",
	OnyBreath				= "Show warning for Onyxia's $spell:77826",
	NefBreath				= "Show warning for Nefarian's $spell:77826",
	specWarnCinderMove		= "Show special warning to move away when you are affected by\n $spell:79339 (5s before explosion)",
	warnShadowblazeSoon		= "Show pre-warning countdown for $spell:81031 (5s before)\n(Only after timer has been synced to first yell to ensure accuracy)",
	specWarnShadowblazeSoon	= "Show pre-special warning for $spell:81031\n(5s prewarn at first, 1s prewarn after first yell sync to ensure accuracy)",
	timerNefLanding			= "Show timer for when Nefarian lands",
	OnySwipeTimer			= "Show timer for Onyxia's $spell:77827 cooldown",
	NefSwipeTimer			= "Show timer for Nefarian's $spell:77827 cooldown",
	OnyBreathTimer			= "Show timer for Onyxia's $spell:77826 cooldown",
	NefBreathTimer			= "Show timer for Nefarian's $spell:77826 cooldown",
	InfoFrame				= "Show info frame for $journal:3284",
	SetWater				= "Automatically disable water collision on pull\n(returns it to enabled upon leaving combat)",
	TankArrow				= "Show DBM arrow for Animated Bone Warrior kiter\n(designed for one kiter strategy)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame				= "Show range frame (10) for $spell:79339\n(Shows everyone if you have debuff, only players with debuff if not)"
})

L:SetMiscLocalization({
	NefAoe					= "The air crackles with electricity!",
	YellPhase2				= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	YellPhase3				= "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",
	YellShadowBlaze			= "Flesh turns to ash!",
	ShadowBlazeExact		= "Shadowblaze Spark in %ds",
	ShadowBlazeEstimate		= "Shadowblaze Spark soon (~5s)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Blackwing Descent Trash"
})
