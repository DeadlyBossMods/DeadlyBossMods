-- Last update: 12/19/2012 (19/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "Afficher le cadre de distance (8m) pour $spell:111850\n(Affiche tout le monde si vous avez le debuff, sinon ceux avec le debuff)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
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
	warnHideOver			= "%s est fini",
	warnHideProgress		= "Touchés $spell:123244 : %s. Dommages $spell:123244 : %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Prochaine capacité spécial"
})

L:SetOptionLocalization({
	warnHideOver			= "Alerte quand $spell:123244 est fini",
	warnHideProgress		= "Alerte de progression de $spell:123244",
	timerSpecialCD			= "Afficher le temps avant que la prochaine capacité spécial ne sois lancé",
	SetIconOnGuard			= "Mettre un icone sur les $journal:6224",
	RangeFrame				= "Afficher le cadre de distance (3m) pour $spell:123121\n(Affiche tout le monde pendant $spell:123244, sinon, ne montre que les Tank)",
	GWHealthFrame			= "Afficher le cadre de la vie restante avant que $spell:123461 soit fini\n(Nécessite que le cadre de vie des Boss sois activé)"
})

L:SetMiscLocalization{
	Victory	= "Je... ah... oh ! J'ai... ? Tout était... si... embrouillé."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetOptionLocalization({
	RangeFrame			= "Afficher le cadre de distance (2m) pour $spell:119519"
})
