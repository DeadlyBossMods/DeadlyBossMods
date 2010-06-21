if GetLocale() ~= "frFR" then return end

local L

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Navrebière"
})

L:SetWarningLocalization({
	warnBarrel			= "Tonneau sur >%s<", 
	specwarnDisarm		= "Désarmement. Bougez !",
	specWarnBrew		= "Débarrassez-vous de la bière avant qu'elle ne vous en lance une autre !",
	specWarnBrewStun	= "Vous avez reçu un coup sur la tête. La prochaine fois, videz votre verre !"
})

L:SetOptionLocalization({
	warnBarrel			= "Annonce la cible du Tonneau.",
	specwarnDisarm		= "Montre une alerte spéciale pour le désarmement",
	specWarnBrew		= "Montre une alerte spéciale pour la Sombrebière de la vierge",
	specWarnBrewStun	= "Montre une alerte spéciale pour l'Etourdir de la vierge bierrière",
	PlaySoundOnDisarm	= "Joue un son pour le désarmement",
	YellOnBarrel		= "Crie quand vous avez un Tonneau sur vous"
})

L:SetMiscLocalization({
	YellBarrel			= "Tonneau sur moi !"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Cavalier sans tête"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Arrivée des Citrouilles vibrantes !",
	specWarnHorsemanHead		= "Tapez la Tête du Cavalier"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Montre une alerte pour l'arrivée des Citrouilles vibrantes",
	specWarnHorsemanHead		= "Montre une alerte spéciale pour l'arrivée de la Tête du Cavalier"
})

L:SetMiscLocalization({
	HorsemanHead				= "Viens donc ici , sombre abruti !",  -- Attention, espace avant la virgule
	HorsemanSoldiers			= "Levez-vous, mes recrues ! Au combat sans surseoir ! Au chevalier déchu, donnez enfin victoire !",
	SayCombatEnd				= "Je la connais trop bien, cette fin importune. Que faut-il au destin pour changer ma fortune ?"
})