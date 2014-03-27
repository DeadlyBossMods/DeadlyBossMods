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
	warnGroupOrder		= "Announce group rotation for $spell:118191<br/>(Currently only supports 25 man 5,2,2,2, etc... strat)",
	specWarnYourGroup	= "Show special warning when it's your group's turn for $spell:118191<br/>(25 man only)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(Shows everyone if you have debuff, only players with debuff if not)",
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
	warnHideOver			= "%s has ended"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Special CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Show warning when $spell:123244 has ended",
	timerSpecialCD			= "Show timer for special ability CD",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(Shows everyone during Hide, otherwise, only shows tanks)",
	GWHealthFrame			= "Show remaining health frame for $spell:123461 fades<br/>(Requires boss health frame enabled)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory	= "I... ah... oh! Did I...? Was I...? It was... so... cloudy."--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
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
	warnBreathOnPlatform		= "Show $spell:119414 warning when you are on platform<br/>(not recommended, for raid leader)",
	specWarnBreathOfFearSoon	= "Show pre-special warning for $spell:119414 if you not have a $spell:117964 buff",
	specWarnMovement			= "Show special warning to move when $spell:120047 is being fired<br/>(Click to copy link <a href=\"http://mysticalos.com/terraceofendlesssprings.jpg\">|cff3588ffhttp://mysticalos.com/terraceofendlesssprings.jpg|r</a>)",
	timerSpecialAbility			= "Show timer for when next special ability will be cast",
	RangeFrame					= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(2, 119519),
	SetIconOnHuddle				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})
