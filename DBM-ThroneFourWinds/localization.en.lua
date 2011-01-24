local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Conclave of Wind"
})

L:SetWarningLocalization({
	warnSpecial			= "Hurricane/Zephyr/Sleet Storm Active",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Special Abilities Active!"
})

L:SetTimerLocalization({
	timerSpecial			= "Special Abilities CD",
	timerSpecialActive		= "Special Abilities Active"
})

L:SetMiscLocalization({
	gatherstrength			= "%s begins to gather strength"
})

L:SetOptionLocalization({
	warnSpecial			= "Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Show special warning when special abilities are cast",
	timerSpecial		= "Show timer for special abilities cooldown",
	timerSpecialActive	= "Show timer for special abilities duration"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
	WarnFeedback	= "%s on >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd			= "Stormling add spawned"
})

L:SetTimerLocalization({
	TimerFeedback 	= "Feedback (%d)",
	TimerAddCD		= "Next add"
})

L:SetOptionLocalization({
	WarnFeedback	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "unknown"),
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Show timer for $spell:87904 duration",
	WarnAdd			= "Show warning when Stormling add spawns",
	TimerAddCD		= "Show timer for new add"
})

L:SetMiscLocalization({
	summonSquall	=	"Storms! I summon you to my side!",
--	phase2		=	"Your futile persistance angers me!",--Not used, Acid rain is, but just in case there is reliability issues with that, localize this anyways.
	phase3		=	"Enough! I will no longer be contained!"
})

