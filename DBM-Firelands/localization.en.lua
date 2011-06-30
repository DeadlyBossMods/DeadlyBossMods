local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Blazing Talon Initiate (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Hatch Eggs",
	timerNextInitiate	= "Next Initiate"
})

L:SetOptionLocalization({
	WarnPhase			= "Show a warning for each phase change",
	WarnNewInitiate		= "Show a warning for new Blazing Talon Initiate",
	timerNextInitiate	= "Show a timer for next Blazing Talon Initiate",
	TimerPhaseChange	= "Show a timer till next phase",
	TimerHatchEggs		= "Show a timer till next eggs are hatched",
	InfoFrame			= "Show info frame for Blazing Power"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellInitiate1	= "We call upon you, Firelord!",
	YellInitiate2	= "Behold His power!",
	YellInitiate3	= "Let the unbelievers perish in fire!",
	YellInitiate4	= "Witness the majesty of flame!",
	YellPhase2		= "These skies are MINE!",
	PowerLevel		= "Blazing Power"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "Elementals spawning"
})

L:SetTimerLocalization({
	TimerElementals		= "Next elementals"
})

L:SetOptionLocalization({
	WarnElementals		= "Show a warning when elementals are spawning",
	TimerElementals		= "Show a timer for next elementals spawning"
})

L:SetMiscLocalization({
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Next Spinners",
	TimerSpiderlings	= "Next Spiderlings",
	TimerDrone		= "Next Drone"
})

L:SetOptionLocalization({
	TimerSpinners		= "Show timer for next $journal:2770",
	TimerSpiderlings	= "Show timer for next $journal:2778",
	TimerDrone		= "Show timer for next $journal:2773"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Next blade"
})

L:SetOptionLocalization({
	TimerBladeActive	= "Show a duration timer for the active blade",
	TimerBladeNext		= "Show a next timer for blade",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "Show DBM Arrow when you are affected by $spell:99516 "
})

L:SetMiscLocalization({
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Sons phase ends"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "Show a duration timer for the \"Sons of Flame phase\"",
	RangeFrame		= "Show range frame"
})

L:SetMiscLocalization({
})