local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s castable in 7s!",
	specWarnBreakJasperChains	= "Break Jasper Chains!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Show special warning before overload",
	specWarnBreakJasperChains	= "Show special warning when it is safe to break $spell:130395",
	ArrowOnJasperChains			= "Show DBM Arrow when you are affected by $spell:130395 ",
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
	WarnPhase	= "Announce Phase transition"
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
	RangeFrame			= "Show range frame (8)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "It be dyin' time, now!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (8)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "Watch your step!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "Watch your step!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "Show special warning before floor vanishes",
	timerDespawnFloor			= "show timer for when floor vanishes"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Show info frame for players affected by $spell:116525"
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})

