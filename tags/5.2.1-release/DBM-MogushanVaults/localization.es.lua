if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "¡%s casteable en 7s!",
	specWarnBreakJasperChains	= "¡Rompe las cadenas de jade!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "Mostrar aviso especial antes de sobrecarga",
	specWarnBreakJasperChains	= "Mostrar un aviso especial cuando sea seguro romper break $spell:130395",
	ArrowOnJasperChains			= "Mostrar flecha cuando te afecten $spell:130395",
	InfoFrame					= "Mostrar información para poder del boss, petrificación de jugador y que boss está canalizando petrificación"
})

L:SetMiscLocalization({
	Overload	= "¡%s se empieza a sobrecargar!"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Fase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Anunciar transición de fase",
	RangeFrame	= "Mostrar distancia (6) durante la fase arcana"
})

L:SetMiscLocalization({
	Fire		= "¡Oh, exaltado! ¡Soy tu herramienta para desgarrar la carne de los huesos!",
	Arcane		= "¡Oh, sabio eterno! ¡Transmíteme tu sapiencia Arcana!",
	Nature		= "¡Oh, gran espíritu! ¡Otórgame el poder de la tierra!",
	Shadow		= "Great soul of champions past! Bear to me your shield!"--translate
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "¡Ya es hora de morir!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Escudo de la oscuridad en %ds"
})

L:SetOptionLocalization({
	DarknessSoon		= "Mostrar pre-aviso con contador para for $spell:117697 (5s antes)",
	RangeFrame			= "Mostrar distancia (8)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "¡Evacúen la Pista!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "¡Evacúen la Pista!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "Mostrar aviso especial antes de que el suelo se desaparezca",
	timerDespawnFloor			= "Mostrar tiempo para que el suelo desaparezca",
	SetIconOnCreature		= "Poner iconos en $journal:6193",
	SetIconOnDestabilized	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226)
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Mostrar información de jugadores a los que les afecta $spell:116525",
	ArrowOnCombo	= "Mostrar flecha durante $journal:5673\nNOTA: Esto asume que el tanque está delante del boss y todos los demás detrás."
})

L:SetMiscLocalization({
	Pull		= "¡La máquina vuelve a la vida! ¡Baja el nivel inferior!",
	Rage		= "La ira del Emperador resuena por las colinas.",
	Strength	= "¡La fuerza del Emperador aparece en la habitación!",
	Courage		= "¡El coraje del Emperador aparece en la habitación!",
	Boss		= "¡Aparecen dos construcciones titánicas en las enormes habitaciones!"
})

