local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Rotate In: Group %s",
	specWarnYourGroup	= "Your Group - Rotate In!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Announce group rotation for $spell:118191\n(Currently only supports 25 man 5,2,2,2, etc... strat)",
	specWarnYourGroup	= "Show special warning when it's your group's turn for $spell:118191\n(25 man only)",
	RangeFrame			= "Show range frame (8) for $spell:111850\n(Shows everyone if you have debuff, only players with debuff if not)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetOptionLocalization({
	warnLightOfDay	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(123716)
})

L:SetMiscLocalization{
	Victory	= "I thank you, strangers. I have been freed."
}
 

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s has ended",
	warnHideProgress		= "Hits: %s. Damage: %s. Time: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Special CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Show warning when $spell:123244 has ended",
	warnHideProgress		= "Show statistics for $spell:123244 when it ends",
	timerSpecialCD			= "Show timer for special ability CD",
	SetIconOnProtector		= "Set icons on $journal:6224\n(Not Reliable if more than 1 person with assist enables)",
	RangeFrame				= "Show range frame (3) for $spell:123121\n(Shows everyone during Hide, otherwise, only shows tanks)",
	GWHealthFrame			= "Show remaining health frame for $spell:123461 fades\n(Requires boss health frame enabled)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory	= "I... ah... oh! Did I...? Was I...? It was... so... cloudy."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	warnWaterspout				= "%s (%d) : %s",
	warnHuddleInTerror			= "%s (%d) : %s",
	MoveForward					= "Move Through",
	MoveRight					= "Move Right",
	MoveBack					= "Move To Old Position",
	specWarnBreathOfFearSoon	= "Breath of Fear soon - MOVE into wall!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Next Special Ability",
	timerSpoHudCD				= "Fear / Waterspout CD",
	timerSpoStrCD				= "Waterspout / Strike CD",
	timerHudStrCD				= "Fear / Strike CD"
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	warnBreathOnPlatform		= "Show $spell:119414 warning when you are on platform\n(not recommanded, for raid leader)",
	specWarnBreathOfFearSoon	= "Show pre-special warning for $spell:119414 if you not have a $spell:117964 buff",
	specWarnMovement			= "Show special warning to move when $spell:120047 is being fired",
	warnWaterspout				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120519),
	warnHuddleInTerror			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120629),
	timerSpecialAbility			= "Show timer for when next special ability will be cast",
	RangeFrame					= "Show range frame (2) for $spell:119519",
	SetIconOnHuddle				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})
