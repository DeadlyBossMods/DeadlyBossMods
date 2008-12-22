local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron incoming",
	WarningShadron			= "Shadron incoming",
	WarningVesperon			= "Vesperon incoming",
	WarningFireWall			= "Fire Wall!",
	WarningVesperonPortal	= "Vesperon's Portal!",
	WarningTenebronPortal	= "Tenebron's Portal!",
	WarningShadronPortal	= "Shadron's Portal!",
})

L:SetTimerLocalization({
	TimerWall	= "Fire Wall cooldown",
	TimerTenebron	= "Tenebron incoming",
	TimerShadron	= "Shadron incoming",
	TimerVesperon	= "Vesperon incoming"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Play sound for \"Fire Wall\"",
	AnnounceFails		= "Post player fails for Fire Wall and Void Zone to the raid chat (requires announce enabled and promoted/leader status)",

	TimerWall		= "Show a Timer for \"Fire Wall\"",
	TimerTenebron		= "Show a timer for Tenebron",
	TimerShadron		= "Show a timer for Shadron",
	TimerVesperon		= "Show a timer for Vesperon",

	WarningFireWall		= "Show \"Fire Wall\" special-warning",
	WarningTenebron		= "Show Tenebron spawn timer",
	WarningShadron		= "Show Shadron spawn timer",
	WarningVesperon		= "Show Vesperon spawn timer",

	WarningTenebronPortal	= "Show special-warning for Tenebron's portals",
	WarningShadronPortal	= "Show special-warning for Shadron's portals",
	WarningVesperonPortal	= "Show special-warning for Vesperon's portals",
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Fire wall: %s",
	VoidZoneOn		= "Void zone: %s",
	VoidZones		= "Void zone fails (this try): %s",
	FireWalls		= "Fire wall fails (this try): %s",
	--[[ not in use; don't translate.
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})


