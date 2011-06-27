if GetLocale() ~= "frFR" then return end
local L

---------------
-- Alysrazor --
---------------
--L= DBM:GetModLocalization(194)
L = DBM:GetModLocalization("Alysrazor")

L:SetGeneralLocalization({
	name = "Alysrazor"
})

L:SetWarningLocalization({
	WarnPhase		= "Phase %d"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Hatch Eggs"
})

L:SetOptionLocalization({
	WarnPhase		= "Show a warning for each phase change",
	TimerPhaseChange	= "Show a timer till next phase",
	TimerHatchEggs		= "Show a timer till next eggs are hatched",
	InfoFrame		= "Show info frame for Blazing Power"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellPhase2		= "These skies are MINE!",
	PowerLevel		= "Blazing Power"
})

-------------------
-- Lord Rhyolith --
-------------------
--L= DBM:GetModLocalization(192)
L = DBM:GetModLocalization("Rhyolith")

L:SetGeneralLocalization({
	name = "Lord Rhyolith"
})

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
--L= DBM:GetModLocalization(192)
L = DBM:GetModLocalization("Bethtilac")

L:SetGeneralLocalization({
	name = "Beth'tilac"
})

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
--L= DBM:GetModLocalization(195)
L = DBM:GetModLocalization("Shannox")

L:SetGeneralLocalization({
	name = "Shannox"
})

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
--L= DBM:GetModLocalization(196)
L = DBM:GetModLocalization("Baleroc")

L:SetGeneralLocalization({
	name = "Baleroc"
})

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
--L= DBM:GetModLocalization(197)
L = DBM:GetModLocalization("FandralStaghelm")

L:SetGeneralLocalization({
	name = "Majordomo Fandral Staghelm"
})

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
--L= DBM:GetModLocalization(198)
L = DBM:GetModLocalization("Ragnaros-Cata")

L:SetGeneralLocalization({
	name = "Ragnaros' End"--Temp name, i'm sure blizz will give it a unique name like they did with "Nefarian's End" being officlal name of encounter
})

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