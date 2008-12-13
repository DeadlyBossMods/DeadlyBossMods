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
	WarningTenebron		= "Tenebron incoming",
	WarningShadron		= "Shadron incoming",
	WarningVesperon		= "Vesperon incoming",
})

L:SetTimerLocalization({
	TimerWall	= "Fire Wall cooldown",
	TimerTenebron	= "Tenebron incoming",
	TimerShadron	= "Shadron incoming",
	TimerVesperon	= "Vesperon incoming"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Play sound for \"Fire Wall\"",
	AnnounceFails		= "Post Player fails for FireWall and Void to Raid Chat",

	TimerWall		= "Show a Timer for \"Fire Wall\"",
	TimerTenebron		= "Show a Timer for Tenebron",
	TimerShadron		= "Show a Timer for Shadron",
	TimerVesperon		= "Show a Timer for Vesperon",

	WarningFireWall		= "Show \"Fire Wall\" Special-warning",
	WarningTenebron		= "Show Tenebron Spawn Timer",
	WarningShadron		= "Show Shadron Spawn Timer",
	WarningVesperon		= "Show Vesperon Spawn Timer",

	WarningTenebronPortal	= "Show Portal Special-Warning for Tenebron Portals",
	WarningShadronPortal	= "Show Portal Special-Warning for Shadron Portals",
	WarningVesperonPortal	= "Show Portal Special-Warning for Vesperon Portals",
})

L:SetMiscLocalization({
	Wall		= "The lava surrounding %s churns!",
	Portal		= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron	= "Shadron",
	NameVesperon	= "Vesperon"
	--[[ not in use 
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})


