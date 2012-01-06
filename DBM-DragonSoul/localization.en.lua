local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom mimicks %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Show warnings for Kohcrom mimicking abilities.",
	KohcromCD		= "Show timers for Kohcrom's next ability mimick.",
	RangeFrame		= "Show range frame (5) for achievement."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShadowYell			= "Yell when you are affected by $spell:104600\n(Heroic difficulty only)",
	CustomRangeFrame	= "Range Frame options (Heroic only)",
	Never				= "Disabled",
	Normal				= "Normal Range Frame",
	DynamicPhase2		= "Phase2 Debuff Filtering",
	DynamicAlways		= "Always Debuff Filtering"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "Oozes Attackable"
})

L:SetOptionLocalization({
	timerOozesActive	= "Show timer for when Oozes become attackable",
	RangeFrame			= "Show range frame (4) for $spell:104898\n(Normal+ difficulty)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242black|r",
	Purple			= "|cFF9932CDpurple|r",
	Red				= "|cFFFF0404red|r",
	Green			= "|cFF088A08green|r",
	Blue			= "|cFF0080FFblue|r",
	Yellow			= "|cFFFFA901yellow|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s in 8 sec"
})

L:SetTimerLocalization({
	TimerSpecial			= "First Special"
})

L:SetOptionLocalization({
	TimerSpecial			= "Show timer for first special ability cast",
	RangeFrame				= "Show range frame: (3) for $spell:105269, (10) for $journal:4327",
	AnnounceFrostTombIcons	= "Announce icons for $spell:104451 targets to raid chat\n(requires raid leader)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})

L:SetMiscLocalization({
	TombIconSet				= "Frost Beacon icon {rt%d} set on %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%%d) in 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",--spellname from mod
	TimerCombatStart	= "Ultraxion Active",
	timerRaidCDs		= "%s CD: %s"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerDrakes			= "Show timer for when Twilight Assaulters $spell:109904",
	TimerCombatStart	= "Show timer for Ultraxion RP",
	ResetHoTCounter		= "Restart Hour of Twilight counter",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Never",
	Reset3				= "Reset in sets of 3/2 (heroic/normal)",
	Reset3Always		= "Always Reset in sets of 3",
	SpecWarnHoTN		= "Special warn 5s before Hour of Twilight (3 set only)",
	One					= "1 (ie 1 4 7)",
	Two					= "2 (ie 2 5)",
	Three				= "3 (ie 3 6)",
	ShowRaidCDs			= "Show timers for Raid cooldowns",
	ShowRaidCDsSelf		= "But only show timers for yours\n(requires Raid cooldowns enabled)"
})

L:SetMiscLocalization({
	Trash				= "It is good to see you again, Alexstrasza. I have been busy in my absence.",
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Combat starts",
	TimerAdd			= "Next Elites"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for start of combat",
	TimerAdd			= "Show timer for next Twilight Elites spawn"
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Get Secured!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Show special warning when you are missing $spell:109454 debuff",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Show info frame for players without $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Show boss health with a health bar for $spell:105479"
})

L:SetMiscLocalization({
	Pull			= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff		= "No %s",
	PlasmaTarget	= "Searing Plasma: %s",
	DRoll			= "about to roll",
	DLevels			= "levels out"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Blistering Tentacles - Switch",--Msg too long? maybe just "Blistering Tentacles!"
	SpecWarnCongealing	= "Congealing Blood - Switch"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Show special warning when Blistering Tentacles spawn (and Alexstrasza is not active)",--http://ptr.wowhead.com/npc=56188
	SpecWarnCongealing	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(109089),
	RangeFrame			= "Show dynamic range frame based on player debuff status for\n$spell:108649 on Heroic difficulty",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})
