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
	RangeFrame	= "Show range frame (10) for $spell:104601\n(Heroic difficulty)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "Oozes incoming: %s",
	specWarnOozes	= "Oozes incoming!",
})

L:SetTimerLocalization({
	timerOozesCD		= "Next Oozes",
	timerOozesActive	= "Oozes Attackable"
})

L:SetOptionLocalization({
	warnOozes			= "Show warning for Oozes spawning",
	specWarnOozes		= "Show special warning for Oozes spawning",
	timerOozesCD		= "Show timer for next Oozes spawn",
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
	RangeFrame				= "Show range frame (3) for $spell:105269",
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
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion Lands"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for Ultraxion RP"
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
	TimerSapper			= "Next Twilight Sapper"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for start of combat",
	TimerSapper			= "Show timer for next Twilight Sapper spawn"--npc=56923
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
	Pull		= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff	= "No %s",
	PlasmaTarget	= "Searing Plasma: %s",
	DRoll		= "about to roll"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Blistering Tentacles - Switch"--Msg too long? maybe just "Blistering Tentacles!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Show special warning when Blistering Tentacles spawn (and Alexstrasza is not active)"--http://ptr.wowhead.com/npc=56188
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART.",
	Kill				= "We are one step closer. The unknowable, transcendent power of the Emerald Dream I now give unto the Dragon Soul."
})
