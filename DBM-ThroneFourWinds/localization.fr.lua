if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/25/2011 (by Sasmira) 

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Conclave du Vent"
})

L:SetWarningLocalization({
	warnSpecial			= "Ouragan/Zéphyr/Tempête de grésil Actifs",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Abiletés Speciales Activées!"
})

L:SetTimerLocalization({
	timerSpecial			= "CD Abiletés Speciales",
	timerSpecialActive		= "Abiletés Speciales Actives"
})

L:SetMiscLocalization({
	gatherstrength			= "%s commence à rassembler ses forces à partir des autres Seigneurs du Vent !"
})

L:SetOptionLocalization({
	warnSpecial		= "Alerter lorsque Ouragan/Zéphyr/Tempête de grésil  sont cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Alerter lorsque les abiletés spéciales sont cast",
	timerSpecial		= "Afficher le timer des cooldown des abiletés spéciales",
	timerSpecialActive	= "Afficher le timer de la durée des abiletés spéciales"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
	WarnFeedback	= "%s sur >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd		= " Apparition : Tourmentin"
})

L:SetTimerLocalization({
	TimerFeedback 	= "Réaction (%d)",
	TimerAddCD	= "Prochaine apparition"
})

L:SetOptionLocalization({
	WarnFeedback	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "inconnu"),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Afficher le timer pour la durée de: $spell:87904",
	WarnAdd		= "Affiche une alerte lorsque les Tourmentins apparaissent",
	TimerAddCD	= "Affiche le timer de la prochaine apparition"
})

L:SetMiscLocalization({
	summonSquall	=	"Tempêtes! Je vous appelle à mes côtés!",
--	phase2		=		"Your futile persistance angers me!",--Not used, Acid rain is, but just in case there is reliability issues with that, localize this anyways.
	phase3		=	"Assez! Je ne veux plus être contenu!"
})