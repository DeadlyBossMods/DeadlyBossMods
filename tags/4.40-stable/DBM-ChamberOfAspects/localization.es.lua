if GetLocale() ~= "esES" then return end

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
	WarningTenebron			= "Tenebron viene",
	WarningShadron			= "Shadron viene",
	WarningVesperon			= "Vesperon viene",
	WarningFireWall			= "Muro de Fuego!",
	WarningVesperonPortal	= "Portal de Vesperon!",
	WarningTenebronPortal	= "Portal de Tenebron!",
	WarningShadronPortal	= "Portal de Shadron!"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron viene",
	TimerShadron	= "Shadron  viene",
	TimerVesperon	= "Vesperon viene"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Reproducir sonido para \"Muro de Fuego\"",
	AnnounceFails		= "Spamear en la raid la gente que falle Muro de Fuego y Zona de Vacio (require ayudante/lider)",
	TimerTenebron		= "Mostrar tiempo para Tenebron",
	TimerShadron		= "Mostrar tiempo para Shadron",
	TimerVesperon		= "Mostrar tiempo para Vesperon",
	WarningFireWall		= "Mostrar aviso especial para \"Muro de Fuego\" ",
	WarningTenebron		= "Mostrar tiempo para que Tenebron venga",
	WarningShadron		= "Mostrar tiempo para que Shadron venga",
	WarningVesperon		= "Mostrar tiempo para que Vesperon venga",
	WarningTenebronPortal	= "Mostrar aviso especial para los portales de Tenebron",
	WarningShadronPortal	= "Mostrar aviso especial para los portales de Shadron",
	WarningVesperonPortal	= "Mostrar aviso especial para los portales de Vesperon"
})

L:SetMiscLocalization({
	Wall			= "¡La lava se arremolina alrededor de %s!",
	Portal			= "¡%s comienza a abrir Portales Crepusculares!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Muro de Fuego: %s",
	VoidZoneOn		= "Zona de vacio: %s",
	VoidZones		= "Zona de vacio fallos (est raid): %s",
	FireWalls		= "Muro de Fuego fallos (esta raid): %s"
})


