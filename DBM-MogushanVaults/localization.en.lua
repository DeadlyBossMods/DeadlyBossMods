local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s soon!", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "Break Jasper Chains!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Show special warning before overload", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "Show special warning when it is safe to break $spell:130395",
	ArrowOnJasperChains			= "Show DBM Arrow when you are affected by $spell:130395",
	InfoFrame					= "Show info frame for boss power, player petrification, and which boss is casting petrification"
})

L:SetMiscLocalization({
	Overload	= "%s is about to Overload!"
})

------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Phase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Announce Phase transition",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " during arcane phase",
	SetIconOnWS	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116784),
	SetIconOnAR	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116417)
})

L:SetMiscLocalization({
	Fire		= "Oh exalted one! Through me you shall melt flesh from bone!",
	Arcane		= "Oh sage of the ages! Instill to me your arcane wisdom!",
	Nature		= "Oh great spirit! Grant me the power of the earth!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "It be dyin' time, now!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Shield of Darkness in %ds"
})

L:SetTimerLocalization({
	timerUSRevive		= "Undying Shadow Reform",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Show pre-warning countdown for $spell:117697 (5s before)",
	timerUSRevive		= "Show timer for $spell:117506 reform",
	timerRainOfArrowsCD = DBM_CORE_AUTO_TIMER_OPTIONS.cd:format(118122),
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8")
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Floor despawn in 6s!"
})

L:SetTimerLocalization({
	timerDespawnFloor		= "Floor despawns"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Show special warning before floor vanishes",
	timerDespawnFloor		= "show timer for when floor vanishes",
	SetIconOnDestabilized	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132222),
	SetIconOnCreature		= "Set icons on $journal:6193"
})

------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Show info frame for players affected by $spell:116525",
	CountOutCombo	= "Count out $journal:5673 casts\nNOTE: This currently only has female voice option.",
	ArrowOnCombo	= "Show DBM Arrow during $journal:5673\nNOTE: This assumes tank is in front of boss and anyone else is behind."
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})
