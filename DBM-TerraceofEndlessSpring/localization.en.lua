local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (8) for $spell:111850\n(Shows everyone if you have debuff, only players with debuff if not)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "I thank you, strangers. I have been freed."
}
 

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s has ended",
	warnHideProgress		= "Hide Hits: %s. Hide Damage: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Next Special"
})

L:SetOptionLocalization({
	warnHideOver			= "Show warning when $spell:123244 has ended",
	warnHideProgress		= "Show warning debug for $spell:123244 progress",
	timerSpecialCD			= "Show timer for when next special ability will be cast",
	SetIconOnGuard			= "Set icons on $journal:6224",
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

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (2) for $spell:119519"
})
