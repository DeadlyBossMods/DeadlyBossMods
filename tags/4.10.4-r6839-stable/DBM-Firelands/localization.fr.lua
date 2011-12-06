if GetLocale() ~= "frFR" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

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
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	PowerLevel		= "Blazing Power"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	RangeFrameSeeds				= "Show range frame (12) for $spell:98450",
	RangeFrameCat				= "Show range frame (10) for $spell:98374",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
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
	East				= "East",
	West				= "West",
	Middle				= "Middle",
	North				= "Melee",
	South				= "Back",
	MeteorTargets		= "ZOMG Meteors!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Assez ! Je vais en finir.",
	TransitionEnded2	= "Sulfuras sera votre fin.",
	TransitionEnded3	= "À genoux, mortels !",
	Defeat				= "Too soon! ... You have come too soon...",--Translate
	Phase4				= "Trop tôt..."
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "Thyrinar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})