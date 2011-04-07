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
	specWarnSpecial		= "Special Abilities Active!",
	warnSpecialSoon		= "Special Abilities in 10 seconds!"
})

L:SetTimerLocalization({
	timerSpecial		= "Special Abilities CD",
	timerSpecialActive	= "Special Abilities Active"
})

L:SetOptionLocalization({
	warnSpecial			= "Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Show special warning when special abilities are cast",
	timerSpecial		= "Show timer for special abilities cooldown",
	timerSpecialActive	= "Show timer for special abilities duration",
	warnSpecialSoon		= "Show pre-warning 10 seconds before special abilities",
	OnlyWarnforMyTarget	= "Only show warnings/timers for current & focus targets\n(Hides the rest. THIS INCLUDES PULL)"
})

L:SetMiscLocalization({
	gatherstrength	= "begins to gather strength",
	Anshal			= "Anshal",
	Nezir			= "Nezir",
	Rohash			= "Rohash"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
	WarnAdd			= "Stormling add incoming"
})

L:SetTimerLocalization({
	TimerFeedback 	= "Feedback (%d)",
	TimerAddCD		= "Next add"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Show timer for $spell:87904 duration",
	WarnAdd			= "Show warning when Stormling add spawns",
	TimerAddCD		= "Show timer for new add"
})

L:SetMiscLocalization({
	summonSquall	=	"Storms! I summon you to my side!",
	phase3		=	"Enough! I will no longer be contained!"
})
