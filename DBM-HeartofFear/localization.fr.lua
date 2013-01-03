-- Last update: 01/03/2013 (03/01/2013 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s sur %s (%s)",
	specwarnAttenuation	= "%s sur %s (%s)",
	specwarnPlatform	= "Changement de plateforme"
})

L:SetOptionLocalization({
	warnAttenuation		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(127834, GetSpellInfo(127834)),
	specwarnAttenuation	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(127834, GetSpellInfo(127834)),
	specwarnPlatform	= "Alerte indiquant quand le Boss change de platforme",
	ArrowOnAttenuation	= "Afficher la flêche DBM pendant $spell:127834 \npour indiquer dans quelle direction bouger",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "s'envole vers l'une de ses plateformes !",
	Defeat				= "Nous ne nous laisserons pas aller au désespoir du vide. Si Sa volonté est de nous faire périr, il en sera ainsi.",
	Left				= "Gauche",
	Right				= "Droite"
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Afficher la flêche DBM quand quelqu'un est touché par $spell:122949",
	RangeFrame			= "Afficher le cadre de distance (8m) pour $spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "Sortez du cercle violet !"
})

L:SetOptionLocalization({
	specwarnUnder	= "Alerte spécial quand vous êtes sous le Boss",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).." (Difficulté héroïque seulement)",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "sous lui", -- Pas sûr.
	Phase2		= "commence à se fendiller !"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Le seigneur du Vent Mel'jarak appelle des renforts !"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s sur >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrompt/debuff la cible, 2: Vous faites une pause, 3: Regen Vie/Volonté, 4: Sortir du véhicule",
	warnAmberExplosion			= ">%s< lance %s",-- à vérifier.
	warnInterruptsAvailable		= "Interruption disponible pour %s: >%s<",
	warnWillPower				= "Volonté actuelle: %s",
	specwarnWillPower			= "Volonté faible ! - 5s restante",
	specwarnAmberExplosionYou	= "Interrompez VOTRE %s !",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrompt %s !",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrompt %s !"--Mutated Construct
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "Explosion CD: Monstruosité"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784, GetSpellInfo(122784)),
	warnReshapeLifeTutor		= "Voir l'aperçu des compétences de l'Assemblage muté",
	warnAmberExplosion			= "Alerte (avec la source)\nquand $spell:122398 est incanté",
	warnInterruptsAvailable		= "Annoncer qui a Frappe d'ambre disponible pour interrompre \n $spell:122402",
	warnWillPower				= "Annonce la Volonté actuelle à 75, 50, 25, 10, et 5.",
	specwarnWillPower			= "Alerte spéciale quand la Volonté est faible dans l'Assemblage muté",
	specwarnAmberExplosionYou	= "Alerte spéciale pour interrompre\nvotre propre $spell:122398",
	specwarnAmberExplosionAM	= "Alerte spéciale pour interrompre\n$spell:122402 de la Monstruosité d’ambre",
	specwarnAmberExplosionOther	= "Alerte spéciale pour interrompre le\n$spell:122398 de l'Assemblage muté",-- à vérifier
	timerAmberExplosionAMCD		= "Afficher le temps avant la prochaine \n$spell:122402 de la Monstruosité d'ambre",
	InfoFrame					= "Afficher le cadre d'information de la Volonté des joueurs",
	FixNameplates				= "Désactiver les barres d'info quand vous êtes en Assemblage muté\n(Restaure les paramètres en quittant le combat)"
})

L:SetMiscLocalization({
	WillPower					= "Volonté"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Progression du Piège d'ambre: (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Alerte préventive (avec progression)\nquand $spell:125826 est créé", -- maybe bad translation.
	InfoFrame			= "Afficher le cadre d'informations pour les joueurs touché par $spell:125390",
	RangeFrame			= "Afficher le cadre de distance (5m) pour $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixer",
	YellPhase3			= "Assez de vos excuses, impératrice ! Éliminez ces crétins ou je vous achève moi-même !"
})
