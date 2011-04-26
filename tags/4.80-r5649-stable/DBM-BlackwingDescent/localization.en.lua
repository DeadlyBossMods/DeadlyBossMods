local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmaw"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Blazing Bone Construct Soon (~4s)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Show pre-special warning for $spell:92190 (~4s)",
	RangeFrame		= "Show range frame in Phase 2 (5)"
})

L:SetMiscLocalization({
	Slump			= "%s slumps forward, exposing his pincers!",
	HeadExposed		= "%s becomes impaled on the spike, exposing his head!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Omnotron Defense System"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Change Target to %s!",
	specWarnGenerator			= "Power Generator - Move %s!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Arcane Blowback",
	timerShadowConductorCast	= "Shadow Conductor",
	timerNefAblity				= "Ability Buff CD",
	timerArcaneLockout			= "Annihilator Lockout"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Show timer for $spell:92048 cast",
	timerArcaneBlowbackCast		= "Show timer for $spell:91879 cast",
	timerArcaneLockout			= "Show timer for $spell:91542 spell lockout",
	timerNefAblity				= "Show timer for heroic ability buff cooldown",
	SpecWarnActivated			= "Show special warning when new boss activated",
	specWarnGenerator			= "Show special warning when a boss gains $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Set icon on last activated boss"
})

L:SetMiscLocalization({
	Magmatron					= "Magmatron",
	Electron					= "Electron",
	Toxitron					= "Toxitron",
	Arcanotron					= "Arcanotron",
	YellTargetLock				= "Encasing Shadows! Away from me!"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase			= "%s phase",
	WarnRemainingAdds	= "%d aberrations remaining"
})

L:SetTimerLocalization({
	TimerPhase			= "Next phase"
})

L:SetOptionLocalization({
	WarnPhase			= "Show warning which phase is incoming",
	WarnRemainingAdds	= "Show warning how many aberrations remain",
	TimerPhase			= "Show timer for next phase",
	RangeFrame			= "Show range frame (6) during blue phase",
	SetTextures			= "Automatically disable projected textures in dark phase\n(returns it to enabled upon leaving phase)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "red|r vial into the cauldron!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "blue|r vial into the cauldron!",
	YellGreen			= "green|r vial into the cauldron!",
	YellDark			= "dark|r magic into the cauldron!",
	Red					= "Red",
	Blue				= "Blue",
	Green				= "Green",
	Dark				= "Dark"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (6)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Show info frame for health (<10k hp)"
})

L:SetMiscLocalization({
	HealthInfo	= "Health Info"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase			= "Airphase",
	WarnGroundphase			= "Groundphase",
	WarnShieldsLeft			= "Ancient Dwarven Shield used - %d left",
	warnAddSoon				= "Obnoxious Fiend summoned",
	specWarnAddTargetable	= "%s is targetable"
})

L:SetTimerLocalization({
	TimerAirphase			= "Next Airphase",
	TimerGroundphase		= "Next Groundphase"
})

L:SetOptionLocalization({
	WarnAirphase			= "Show warning when Atramedes lifts off",
	WarnGroundphase			= "Show warning when Atramedes lands",
	WarnShieldsLeft			= "Show warning when a Ancient Dwarven Shield gets used",
	warnAddSoon				= "Show warning when Nefarian summons adds",
	specWarnAddTargetable	= "Show special warning when adds are targetable",
	TimerAirphase			= "Show timer for next airphase",
	TimerGroundphase		= "Show timer for next groundphase",
	InfoFrame				= "Show info frame for sound levels",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancient Dwarven Shield",
	Soundlevel				= "Sound Level",
	YellPestered			= "Obnoxious Fiend on me!",--npc 49740
	NefAdd					= "Atramedes, the heroes are right THERE!",
	Airphase				= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Nefarian's End"	-- No conflict with BWL version (probably also why blizzard calls the encounter "Nefarian's End"
})

L:SetWarningLocalization({
	OnyTailSwipe			= "Tail Lash (Onyxia)",
	NefTailSwipe			= "Tail Lash (Nefarian)",
	OnyBreath				= "Breath (Onyxia)",
	NefBreath				= "Breath (Nefarian)",
	specWarnShadowblazeSoon	= "Shadowblaze Soon (~5s)"
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
	OnyBreath				= "Show warning for Onyxia's $spell:94124",
	NefBreath				= "Show warning for Nefarian's $spell:94124",
	specWarnShadowblazeSoon	= "Show pre-special warning for $spell:94085 (~5s)",
	timerNefLanding			= "Show timer for when Nefarian lands",
	OnySwipeTimer			= "Show timer for Onyxia's $spell:77827 cooldown",
	NefSwipeTimer			= "Show timer for Nefarian's $spell:77827 cooldown",
	OnyBreathTimer			= "Show timer for Onyxia's $spell:94124 cooldown",
	NefBreathTimer			= "Show timer for Nefarian's $spell:94124 cooldown",
	InfoFrame				= "Show info frame for Onyxia's Electric Charge",
	SetWater				= "Automatically disable water collision on pull\n(returns it to enabled upon leaving combat)",
	TankArrow				= "Show DBM arrow for Animated Bone Warrior kiter\n(designed for one kiter strategy)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame				= "Show range frame (10) for $spell:79339\n(Shows everyone if you have debuff, only players with icons if not)"
})

L:SetMiscLocalization({
	NefAoe					= "The air crackles with electricity!",
	YellPhase2				= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	YellPhase3				= "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",
	Nefarian				= "Nefarian",
	Onyxia					= "Onyxia",
	Charge					= "Electric Charge"
})

--------------
--  Blackwing Descent Trash  --
--------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Blackwing Descent Trash"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})