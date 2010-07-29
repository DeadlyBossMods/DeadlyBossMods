local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron incoming",
	WarningShadron			= "Shadron incoming",
	WarningVesperon			= "Vesperon incoming",
	WarningFireWall			= "Fire Wall",
	WarningVesperonPortal	= "Vesperon's portal",
	WarningTenebronPortal	= "Tenebron's portal",
	WarningShadronPortal	= "Shadron's portal"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron arrives",
	TimerShadron	= "Shadron arrives",
	TimerVesperon	= "Vesperon arrives"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Play sound on Fire Wall",
	AnnounceFails			= "Post player fails for Fire Wall and Shadow Fissure to raid chat\n(requires announce to be enabled and leader/promoted status)",
	TimerTenebron			= "Show timer for Tenebron's arrival",
	TimerShadron			= "Show timer for Shadron's arrival",
	TimerVesperon			= "Show timer for Vesperon's arrival",
	WarningFireWall			= "Show special warning for Fire Wall",
	WarningTenebron			= "Announce Tenebron incoming",
	WarningShadron			= "Announce Shadron incoming",
	WarningVesperon			= "Announce Vesperon incoming",
	WarningTenebronPortal	= "Show special warning for Tenebron's portal",
	WarningShadronPortal	= "Show special warning for Shadron's portal",
	WarningVesperonPortal	= "Show special warning for Vesperon's portal"
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Fire Wall: %s",
	VoidZoneOn		= "Shadow Fissure: %s",
	VoidZones		= "Shadow Fissure fails (this try): %s",
	FireWalls		= "Fire Wall fails (this try): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus the Warborn"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show pre-warning for Split",
	RangeFrame			= "Show range frame (12 yards)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Ragefire"
})

L:SetWarningLocalization({
	SpecialWarningTranq		= "Enrage - Tranq now"
})

L:SetOptionLocalization({
	SpecialWarningTranq		= "Show special warning for $spell:78722 (to tranq)",
	RangeFrame				= "Show range frame (10 yards)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

L:SetMiscLocalization{
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "New adds",
	warnCleaveArmor	= "%s on >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "New adds"
})

L:SetOptionLocalization({
	WarnAdds		= "Announce new adds",
	TimerAdds		= "Show timer for new adds",
	warnCleaveArmor	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(74367, GetSpellInfo(74367) or "unknown")
})

L:SetMiscLocalization({
	SummonMinions	= "Turn them to ash, minions!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion the Twilight Destroyer"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "Phase 2 soon",
	WarnPhase3Soon		= "Phase 3 soon",
	TwilightCutterCast	= "Casting Twilight Cutter: 5 sec"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~79%)",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 (at ~54%)",
	TwilightCutterCast		= "Show warning when $spell:77844 is being cast",
	AnnounceAlternatePhase	= "Show warnings/timers for phase you aren't in as well",
	SoundOnConsumption		= "Play sound on $spell:74562 or $spell:74792",--We use localized text for these functions
	SetIconOnConsumption	= "Set icons on $spell:74562 or $spell:74792 targets",--So we can use single functions for both versions of spell.
	YellOnConsumption		= "Yell on $spell:74562 or $spell:74792",
	WhisperOnConsumption	= "Send whisper to $spell:74562 or $spell:74792\ntargets"
})

L:SetMiscLocalization({
	NormalHalion			= "Physical Halion",
	TwilightHalion			= "Twilight Halion",
	MeteorCast				= "The heavens burn!",
	Phase2					= "You will find only suffering within the realm of twilight! Enter if you dare!",
	Phase3					= "I am the light and the darkness! Cower, mortals, before the herald of Deathwing!",
	twilightcutter			= "The orbiting spheres pulse with dark energy!",
	YellCombustion			= "Combustion on me!",
	WhisperCombustion		= "Combustion on you! Run to the wall!",
	YellConsumption			= "Consumption on me!",
	WhisperConsumption		= "Consumption on you! Run to the wall!",
	Kill					= "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"
})