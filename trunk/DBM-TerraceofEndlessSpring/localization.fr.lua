-- Last update: 01/07/2013 (07/01/2013 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Rotation : Groupe %s",
	specWarnYourGroup	= "C'est votre groupe - Rotation !"
})


L:SetOptionLocalization({
	warnGroupOrder		= "Annoncer une rotation de groupe pour $spell:118191<br/>(À l'heure actuelle ne supporte que le raid 25 | 5,2,2,2, etc...)",
	specWarnYourGroup	= "Alerte spécial quand votre groupe doit faire rotation pour $spell:118191<br/>(Raid 25 seulement)",
	RangeFrame			= "Afficher le cadre de distance (8m) pour $spell:111850<br/>(Affiche tout le monde si vous avez le debuff, sinon ceux avec le debuff)"
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Je vous remercie étrangers. J'ai été libéré."
}
 

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s est fini"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Délai capacité spécial (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Alerte quand $spell:123244 est fini",
	timerSpecialCD			= "Délai avant la prochaine capacité spécial", -- revoir
	SetIconOnProtector		= "Mettre un icone sur les $journal:6224<br/>(Pas fiable si il y a des assistants(promot))",
	RangeFrame				= "Afficher le cadre de distance (3m) pour $spell:123121<br/>(Affiche tout le monde pendant $spell:123244, sinon, ne montre que les Tank)",
	GWHealthFrame			= "Afficher le cadre de la vie restante avant que $spell:123461 soit fini<br/>(Nécessite que le cadre de vie des Boss sois activé)"
})

L:SetMiscLocalization{
	Victory	= "Je... ah... oh ! J'ai... ? Tout était... si... embrouillé."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "Allez de l'autre côté !",
	MoveWarningRight			= "Allez vers la droite !",
	MoveWarningBack				= "Allez à la position précédente !",
	specWarnBreathOfFearSoon	= "Souffle de peur bientôt - Allez dans le mur !"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Capacité spéciale suivante",
	timerSpoHudCD				= "Délai Peur / Geysérit",
	timerSpoStrCD				= "Délai Geysérit / Frappe",
	timerHudStrCD				= "Délai Peur / Frappe"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "Alerte spécial préventive pour $spell:119414 si vous n'avez pas le buff $spell:117964"
})

L:SetOptionLocalization({
	RangeFrame					= "Afficher le cadre de distance (2m) pour $spell:119519",
	MoveWarningForward			= "Alerte spécial pour aller de l'autre côté quand $spell:120047 est lancé",
	MoveWarningRight			= "Alerte spécial pour aller à droite quand $spell:120047 est lancé",
	MoveWarningBack				= "Alerte spécial pour aller à la position précédente quand <br/>$spell:120047 est fini",
	timerSpecialAbilityCD		= "Délai pour la prochaine fois que la capacité spéciale est lancé",
	timerSpoHudCD				= "Délai pour le prochain lancé de $spell:120629 ou $spell:120519",
	timerSpoStrCD				= "Délai pour le prochain lancé de $spell:120519 ou $spell:120672",
	timerHudStrCD				= "Délai pour le prochain lancé de $spell:120629 ou $spell:120672"
})
