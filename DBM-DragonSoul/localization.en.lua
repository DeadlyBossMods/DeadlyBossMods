local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	SpecwarnVortexAfter	= "Hide behind pillars!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecwarnVortexAfter	= "Show a special warning when $spell:110047 ends"
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
	specWarnManaVoid= "Mana Void - Switch"
})

L:SetTimerLocalization({
	timerOozesCD	= "Next Oozes"
})

L:SetOptionLocalization({
	warnOozes			= "Show warning for Oozes spawning",
	specWarnOozes		= "Show special warning for Oozes spawning",
	specWarnManaVoid	= "Show a special warning when $spell:105530 spawns",
	timerOozesCD		= "Show timer for next Oozes spawn"
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
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
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
	TimerCombatStart	= "Combat starts"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for start of combat"
})

L:SetMiscLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
