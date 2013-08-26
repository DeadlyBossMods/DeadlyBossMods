local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s on %s (%s)",
	warnEcho			= "Echo has spawned",
	warnEchoDown		= "Echo defeated",
	specwarnAttenuation	= "%s on %s (%s)",
	specwarnPlatform	= "Platform change"
})

L:SetOptionLocalization({
	warnAttenuation		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(127834),
	warnEcho			= "Announce when an Echo spawns",
	warnEchoDown		= "Announce when an Echo is defeated",
	specwarnAttenuation	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "Show special warning when boss changes platforms",
	ArrowOnAttenuation	= "Show DBM Arrow during $spell:127834 to indicate which direction to move",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "flies to one of his platforms!",
	Defeat				= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 123175)
})

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Move out of purple ring!"
})

L:SetOptionLocalization({
	warnCrush		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(122774),
	specwarnUnder	= "Show special warning when you are under boss",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).." (Heroic difficulty only)",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "under him",
	Phase2		= "armor plating begins to crack"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885),
	specWarnReinforcements	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6554")
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s on >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrupt/debuff target (use this on boss to build debuff stacks), 2: Interrupt yourself when casting Amber Explosion, 3: Restore Willpower when it's low (use primarily in phase 3), 4: Escape Vehicle (phase 1 & 2 only)",
	warnAmberExplosion			= ">%s< is casting %s",
	warnAmberExplosionAM		= "Amber Monstrosity is casting Amber Explosion - Interrupt Now!",--personal warning.
	warnInterruptsAvailable		= "Interupts available for %s: >%s<",
	warnWillPower				= "Current Will Power: %s",
	specwarnWillPower			= "Low Will Power! - Leave vehicle or consume a puddle",
	specwarnAmberExplosionYou	= "Interrupt YOUR %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize			= "Destabalize (%2$d) : %1$s",
	timerAmberExplosionAMCD		= "Explosion CD: Monstrosity"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "Display ability purpose rundown of Mutated Construct abilities",
	warnAmberExplosion			= "Show warning (with source) when $spell:122398 is cast",
	warnAmberExplosionAM		= "Show personal warning when Amber Montrosity's<br/> $spell:122398 is cast(for interrupt)",
	warnInterruptsAvailable		= "Announce who has Amber Strike interrupts available for<br/> $spell:122402",
	warnWillPower				= "Announce current will power at 80, 50, 30, 10, and 4.",
	specwarnWillPower			= "Show special warning when will power is low in construct",
	specwarnAmberExplosionYou	= "Show special warning to interrupt your own $spell:122398",
	specwarnAmberExplosionAM	= "Show special warning to interrupt Amber Montrosity's<br/> $spell:122402",
	specwarnAmberExplosionOther	= "Show special warning to interrupt loose Mutated Construct's<br/> $spell:122398",
	timerDestabalize			= DBM_CORE_AUTO_TIMER_OPTIONS.target:format(123059),
	timerAmberExplosionAMCD		= "Show timer for Amber Monstrosity's next $spell:122402",
	InfoFrame					= "Show info frame for players will power",
	FixNameplates				= "Automatically disable interfering nameplates while a construct<br/>(restores settings upon leaving combat)"
})

L:SetMiscLocalization({
	WillPower					= "Will Power"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Amber Trap progress: (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Show warning (with progress) when $spell:125826 is making", -- maybe bad translation.
	InfoFrame			= "Show info frame for players affected by $spell:125390",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 123735),
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097),
	HeartOfFearIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(123845)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixated",
	YellPhase3			= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name =	"Heart of Fear Trash"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949"
})
