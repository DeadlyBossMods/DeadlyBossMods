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
	WarnPhase	= "Anunciar transición de fase"
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
	RangeFrame			= "Mostrar distancia (8)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "It be dyin' time, now!"--translate
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar distancia (8)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "¡Cuidado!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "¡Cuidado!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "Mostrar aviso especial antes de que el suelo se desaparezca",
	timerDespawnFloor			= "Mostrar tiempo para que el suelo desaparezca"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Mostrar información de jugadores a los que les afecta $spell:116525"
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--translate
	Rage		= "The Emperor's Rage echoes through the hills.",--translate
	Strength	= "The Emperor's Strength appears in the alcoves!",--translate
	Courage		= "The Emperor's Courage appears in the alcoves!",--translate
	Boss		= "Two titanic constructs appear in the large alcoves!"--translate
})

