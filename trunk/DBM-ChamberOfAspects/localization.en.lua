local L

---------------
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
	WarningShadronPortal	= "Shadron's portal",
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron incoming",
	TimerShadron	= "Shadron incoming",
	TimerVesperon	= "Vesperon incoming"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Play sound on \"Fire Wall\"",
	AnnounceFails		= "Post player fails for Fire Wall and Void Zone to raid chat (requires announce to be enabled and leader/promoted status)",

	TimerTenebron		= "Show timer for Tenebron's arrival",
	TimerShadron		= "Show timer for Shadron's arrival",
	TimerVesperon		= "Show timer for Vesperon's arrival",

	WarningFireWall		= "Show special warning for \"Fire Wall\"",
	WarningTenebron		= "Show warning for Tenebron incoming",
	WarningShadron		= "Show warning for Shadron incoming",
	WarningVesperon		= "Show warning for Vesperon incoming",

	WarningTenebronPortal	= "Show special warning for Tenebron's portal",
	WarningShadronPortal	= "Show special warning for Shadron's portal",
	WarningVesperonPortal	= "Show special warning for Vesperon's portal",
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Fire Wall: %s",
	VoidZoneOn		= "Void Zone: %s",
	VoidZones		= "Void Zone fails (this try): %s",
	FireWalls		= "Fire Wall fails (this try): %s",
})


