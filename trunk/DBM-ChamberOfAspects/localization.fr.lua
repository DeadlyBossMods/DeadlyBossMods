if GetLocale() ~= "frFR" then return end

local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Obscuron"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Ténébron"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vespéron"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Ténébron Arrive",
	WarningShadron			= "Obscuron Arrive",
	WarningVesperon			= "Vespéron Arrive",
	WarningVesperonPortal	= "Portail de Vespéron",
	WarningTenebronPortal	= "Portail de Ténébron",
	WarningShadronPortal	= "Portail d'Obscuron",
})

L:SetTimerLocalization({
	TimerTenebron	= "Ténébron Arrive",
	TimerShadron	= "Obscuron Arrive",
	TimerVesperon	= "Vespéron Arrive"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Joue un sons pour les Vague de Flammes",
	AnnounceFails		= "Ecris dans le chatt les joueurs qui n'ont pas éviter les zones noir / Vague de Flammes (requires announce enabled and promoted/leader status)",

	TimerWall		= "Montre le timer pour les Vague de Flammes",
	TimerTenebron		= "Montre le timer pour Ténébron",
	TimerShadron		= "Montre le timer pour Obscuron",
	TimerVesperon		= "Montre le timer pour Vespéron",

	WarningFireWall		= "Montre une alerte spécial pour les Vague de Flammes",
	WarningTenebron		= "Montre le timer avant que Ténébron arrive",
	WarningShadron		= "Montre le timer avant qu'Obscuron arrive",
	WarningVesperon		= "Montre le timer avant que Vespéron arrive",

	WarningTenebronPortal	= "Montre une alerte spécial pour les portails de Ténébron",
	WarningShadronPortal	= "Montre une alerte spécial pour les portails d'Obscuron",
	WarningVesperonPortal	= "Montre une alerte spécial pour les portails de Vespéron",
})

L:SetMiscLocalization({
	Portal			= "%s Commance a incanter un portail!",
	NameTenebron	= "Ténébron",
	NameShadron		= "Obscuron",
	NameVesperon	= "Vespéron",
	VoidZoneOn		= "Void Zone: %s",
	VoidZones		= "Void Zone raté (Ce try): %s",
	--[[ not in use; don't translate.
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})


