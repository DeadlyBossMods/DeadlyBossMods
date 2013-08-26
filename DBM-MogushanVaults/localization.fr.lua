-- Last update: 01/03/2013 (03/01/2013 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s bientôt !", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "Cassez les Chaînes de Jaspe !"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Alerte spéciale avant la surcharge",
	specWarnBreakJasperChains	= "Alerte spéciale quand il est sûr de casser $spell:130395",
	ArrowOnJasperChains			= "Voir la fleche DBM lorsque vous êtes affecté par $spell:130395",
	InfoFrame					= "Afficher le cadre d'information pour la puissance des boss, la pétrification des joueurs, et quand le boss lance la pétrification"
})

L:SetMiscLocalization({
	Overload	= "%s est sur le point de surcharger !"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Phase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Annoncer la transition de Phase",
	RangeFrame	= "Afficher le cadre de distance (6m) durant la phase d'arcane"
})

L:SetMiscLocalization({
	Fire		= "Ô être exalté ! Grâce à moi vous ferez fondre la chair et les os !",
	Arcane		= "Ô sagesse ancestrale ! Distille en moi ta sagesse arcanique !",
	Nature		= "Ô grand esprit ! Accorde-moi le pouvoir de la terre !",
	Shadow		= "Grandes âmes des champions du passé ! Confiez-moi votre bouclier !"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull		= "L'heure de mourir elle est arrivée maintenant !"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Bouclier des ténèbres sur %ds"
})

L:SetTimerLocalization({
	timerUSRevive		= "Ombres éternelles reconstitué",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Alerte préventive pour $spell:117697 (5s avant) ",
	timerUSRevive		= "Délai avec que $spell:117506 ne se reconstitue",
	RangeFrame			= "Afficher le cadre de distance (8m)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Le sol disparait dans 6sec!"
})

L:SetTimerLocalization({
	timerDespawnFloor		= "Sol disparu"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Alerte spéciale avant que le sol ne disparaisse",
	timerDespawnFloor		= "Afficher le temps avant que le sol disparaît"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Afficher le cadre d'informations pour les joueurs touché par $spell:116525",
	CountOutCombo	= "Comptez le nombre de $journal:5673 vocalement<br/>NOTE: Disponible qu'avec l'option de voix féminine.",
	ArrowOnCombo	= "Afficher la flêche DBM pendant $journal:5673<br/>NOTE: Cela suppose que le Tank est face au Boss <br/>et que personne d'autre n'est derrière."
})

L:SetMiscLocalization({
	Pull		= "La machine s'anime en bourdonnant ! Allez au niveau inférieur !",--Emote
	Rage		= "La rage de l'empereur se répercute dans les collines.",--Yell
	Strength	= "La Force de l'empereur apparaît dans les alcôves !",--Emote
	Courage		= "Le Courage de l'empereur apparaît dans les alcôves !",--Emote
	Boss		= "Deux assemblages titanesques apparaissent dans les grandes alcôves !"--Emote
})

