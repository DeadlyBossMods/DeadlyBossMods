local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Blazing Talon Initiate (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Next Eggs",
	timerNextInitiate	= "Next Initiate (%s)",
	TimerCombatStart	= "Combat starts"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for start of combat",
	WarnPhase			= "Show a warning for each phase change",
	WarnNewInitiate		= "Show a warning for new Blazing Talon Initiate",
	timerNextInitiate	= "Show a timer for next Blazing Talon Initiate",
	TimerPhaseChange	= "Show a timer till next phase",
	TimerHatchEggs		= "Show a timer till next eggs are hatched",
	InfoFrame			= "Show info frame for Molten Feather"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellInitiate1	= "We call upon you, Firelord!",
	YellInitiate2	= "Behold His power!",
	YellInitiate3	= "Let the unbelievers perish in fire!",
	YellInitiate4	= "Witness the majesty of flame!",
	YellPhase2		= "These skies are MINE!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Fiery Lava Worms erupt from the ground!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "Molten Feathers",
	East			= "East",
	West			= "West",
	Both			= "Both"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	yellPhase2			= "Eons I have slept undisturbed... Now this... Creatures of flesh, now you will BURN!"
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
	TimerDrone		= "Show timer for next $journal:2773",
	RangeFrame				= "Show range frame (10)",
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
	Riplimb		= "Riplimb",
	Rageface	= "Rageface"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	timerShards			= "Next %s (%%d)",
	timerStrike			= "Next %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Next blade"
})

L:SetOptionLocalization({
	warnStrike			= "Show warnings for Decimation/Inferno Strike",
	timerShards			= "Show timer for next $spell:99259",
	timerStrike			= "Show timer for next Decimation/Inferno Strike",
	TimerBladeActive	= "Show a duration timer for the active Blade",
	TimerBladeNext		= "Show a next timer for Decimation/Inferno Blade",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "Show DBM Arrow when you are affected by $spell:99516 ",
	InfoFrame			= "Show info frame for Vital Spark stacks"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." stacks"
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
	warnSplittingBlow		= "%s in %s",--Spellname in Location
	warnEngulfingFlame		= "%s in %s",--Spellname in Location
	WarnRemainingAdds		= "%d Sons of Flame remaining"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Transition ends"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "Show warning for $spell:100877",
	warnEngulfingFlame	= "Show warning for $spell:99171",
	WarnRemainingAdds	= "Show warning for how many Sons of Flame remain",
	TimerPhaseSons		= "Show a duration timer for the \"Sons of Flame phase\"",
	RangeFrame			= "Show range frame",
	InfoFrame			= "Show info frame for $spell:99849 targets",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "East",
	West				= "West",
	Middle				= "Middle",
	North				= "Melee",
	South				= "Back",
	MeteorTargets		= "ZOMG Meteors!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Enough! I will finish this.",--More reliable then adds method.
	TransitionEnded2	= "Sulfuras will be your end.",
	TransitionEnded3	= "Fall to your knees, mortals!  This ends now.",
	Defeat				= "Too soon! ... You have come too soon...",
	Phase4				= "Too soon..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Firelands Trash"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TrashRangeFrame	= "Show range frame (10) for $spell:100012"
})

L:SetMiscLocalization({

})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "Transition ends"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Show a timer for the phase transition"
})

L:SetMiscLocalization({
	StaffEvent			= "The Branch of Nordrassil reacts violently to %S+ touch!",--Reg expression pull match
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"
})