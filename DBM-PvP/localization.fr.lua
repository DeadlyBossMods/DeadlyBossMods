-- Last update: 12/20/2012 (20/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)
if GetLocale() ~= "frFR" then return end
local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Options générale"
})

L:SetTimerLocalization({
	TimerInvite		 = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Met le nom en couleur en fonction de la classe dans le tableau des scores",
	ShowInviteTimer	= "Affiche le temps restant pour rejoindre le Champ de bataille",
	AutoSpirit		= "Auto-rez à un Ange",
	HideBossEmoteFrame	= "Masquez les cadres d'émotes de boss de raid"
})

L:SetMiscLocalization({
	ArenaInvite		= "Invitation d'arène"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arenas"
})

L:SetTimerLocalization({
	TimerShadow	= "Vue de l'ombre"
})

L:SetOptionLocalization({
	TimerShadow = "Montre le timer de la Vue de l'ombre"
})

L:SetMiscLocalization({
	Start15		= "Quinze secondes avant le départ de l'arène !"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Vallée d'Alterac"
})

L:SetTimerLocalization({
	TimerTower		= "%s",
	TimerGY			= "%s",
})

L:SetOptionLocalization({
	TimerTower		= "Voir le timer des captures des tours",
	TimerGY			= "Voir le timer des captures des cimetières",
	AutoTurnIn		= "Fini automatiquement les quêtes dans la Vallée d'Alterac"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Bassin d'Arathi"
})

L:SetMiscLocalization({
	ScoreExpr 				= "(%d+)/1600",
	Alliance 				= "Alliance",
	Horde 					= "Horde",
	WinBarText 				= "%s Gagne",
	BasesToWin 				= "Bases pour gagner: %d",
	Flag 					= "Drapeau"
})

L:SetTimerLocalization({
	TimerCap 				= "%s",
})

L:SetOptionLocalization({
	TimerWin 				= "Montre le timer de la victoire",
	TimerCap 				= "Montre le timer de capture",
	ShowAbEstimatedPoints	= "Montre l'estimation de point pour gagner / perdre",
	ShowAbBasesToWin		= "Montre les bases à avoir pour gagner"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "L'Œil du cyclone"
})

L:SetMiscLocalization({
	ZoneName			= "L'Œil du cyclone",
	ScoreExpr			= "(%d+)/1600",
	Alliance 			= "Alliance",
	Horde 				= "Horde",
	WinBarText 			= "%s Gagne",
	FlagReset 			= "Le drapeau a été réinitialisé.",
	FlagTaken 			= "(.+) a pris le drapeau !",
	FlagCaptured 		= "La .+ ha%w+ s'est emparée du drapeau !",
	FlagDropped 		= "Le drapeau vient d'être laché !",

})

L:SetTimerLocalization({
	TimerFlag 			= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerWin 			= "Montre le timer de la victoire",
	TimerFlag 			= "Montre le timer du respawn du drapeau",
	ShowPointFrame 		= "Montre les porteurs des drapeaux et les points estimés",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Goulet des Chanteguerres"
})

L:SetMiscLocalization({
	BgStart60 					= "Début de la bataille pour le goulet des Chanteguerres dans 1 minute.",
	BgStart30 					= "Début de la bataille pour le goulet des Chanteguerres dans 30 secondes. Préparez-vous !",
	Alliance 					= "Alliance",
	Horde 						= "Horde",	
	InfoErrorText 				= "Le ciblage du drapeau est restoré lorsque vous êtes hors de combat.",
	ExprFlagPickUp 				= "Le Drapeau (%w+) a été pris par (.+) !",
	ExprFlagCaptured 			= "(.+) a capturé le drapeau (%w+) !",
	ExprFlagReturn 				= "Le Drapeau (%w+) a été renvoyé à la base par (.+) !",
	FlagAlliance 				= "Drapeau de l'alliance: ",
	FlagHorde					= "Drapeau de la horde: ",
	FlagBase					= "Base",
})

L:SetTimerLocalization({
	TimerStart 					= "Début de la bataille dans", 
	TimerFlag 					= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerStart  				= "Voir: Temps de départ du BG",
	TimerFlag 					= "Montre le timer du respawn du drapeau",
	ShowFlagCarrier				= "Montre le porteur du drapeau",
	ShowFlagCarrierErrorNote 	= "Montre un message d'erreur au porteur du drapeau lorsqu'il est en combat",
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Île des Conquérants"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Engins de Siège prêt!",
	WarnSiegeEngineSoon	= "Apparition des Engins de Siège dans ~10 sec"
})

L:SetTimerLocalization({
	TimerStart			= "Début de la bataille dans", 
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Engins de Siège prêt"
})

L:SetOptionLocalization({
	TimerStart			= "Voir: Temps de départ du BG", 
	TimerPOI			= "Montre le timer pour les captures",
	TimerSiegeEngine	= "Montre le timer de la construction des Engins de Siège",
	WarnSiegeEngine		= "Alerter lorsque l'Engin de Siège est prêt",
	WarnSiegeEngineSoon	= "Alerter lorsque l'Engin de Siège est presque prêt",
	ShowGatesHealth		= "Afficher la vie des portes endommagées (les valeurs peuvent être fausses après avoir rejoint un champ de bataille déjà en cours !))"
})

L:SetMiscLocalization({
	BgStart60				= "Début de la bataille dans 60 secondes.",
	BgStart30				= "Début de la bataille dans 30 secondes.",
	BgStart15				= "Début de la bataille dans 15 secondes.",
	GatesHealthFrame		= "Portes endommagées",
	SiegeEngine				= "Engin de Siège",
	GoblinStartAlliance	= "Regarder ces Bombes d'hydroglycérine ? Utilisez-les sur les portes alors que je répare l'engin de siège !",
	GoblinStartHorde		= "Je travaillerai sur l'engin de siège, regarde juste mon dos. Utilse ces  Bombes d'hydroglycérine sur les portes si tu en as besoin !",
	GoblinHalfwayAlliance	= "Je suis à mi-chemin! Gardez la Horde loin d'ici. Ils n'apprennent pas la lutte à l'ecole d'ingénieur !",
	GoblinHalfwayHorde	= "J'ai déjà fait mi-chemin ! Gardez l'Alliance loin - Combattre n'est pas dans mon contrat!",
	GoblinFinishedAlliance	= "Mon plus beau travail accompli jusqu'à présent! Cet engin de siège est prêt pour l'action !",
	GoblinFinishedHorde	= "L'engin de siège est prêt à rouler !",
	GoblinBrokenAlliance	= "C'est déjà cassé ?! Pas de soucis. Ce n'est rien que je ne puisse arranger.",
	GoblinBrokenHorde	= "C'est encore cassé ?! j'arrangerais ça... ne vous attendez pas a ce que la garantie couvre cela"
})


------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("TwinPeaks")

L:SetGeneralLocalization({
	name = "Pics-Jumeaux"
})

L:SetMiscLocalization({
	BgStart60 			= "Début de la bataille dans 60 secondes.",
	BgStart30 			= "Début de la bataille dans 30 secondes. Préparez vous!",
	ZoneName 			= "Pics-Jumeaux",
	Alliance 			= "Alliance",
	Horde 				= "Horde",	
	InfoErrorText		= "Le ciblage du drapeau est restoré lorsque vous êtes hors de combat.",
	ExprFlagPickUp		= "Le  Drapeau (%w+) a été pris par (.+) !",
	ExprFlagCaptured		= "(.+) a capturé le drapeau (%w+) !",
	ExprFlagReturn		= "Le Drapeau (%w+) a été renvoyé à la base par (.+) !",
	FlagAlliance			= "Drapeau Alliance: ",
	FlagHorde			= "Drapeau Horde: ",
	FlagBase			= "Base",
	Vulnerable1		= "Le porteur du drapeau est vulnérable aux attaques !",
	Vulnerable2		= "Le porteur du drapeau devient encore plus vulnérable aux attaques !"
})

L:SetTimerLocalization({
	TimerStart	= "Début de la bataille dans", 
	TimerFlag	= "Respawn du drapeau"
})

L:SetOptionLocalization({
	TimerStart  				= "Voir: Temps de départ du BG",
	TimerFlag 					= "Montre le timer du respawn du drapeau",
	ShowFlagCarrier				= "Montre le porteur du drapeau",
	ShowFlagCarrierErrorNote 	= "Montre un message d'erreur au porteur du drapeau lorsqu'il est en combat",

})


--------------------------
--  Battle for Gilneas  --
--------------------------
L = DBM:GetModLocalization("Gilneas")

L:SetGeneralLocalization({
	name = "Bataille de Gilnéas"
})

L:SetMiscLocalization({
	ScoreExpr 				= "(%d+)/2000",
	Alliance 				= "Alliance",
	Horde 					= "Horde",
	WinBarText 				= "%s Gagne",
	BasesToWin 				= "Bases pour gagner: %d",
	Flag 					= "Drapeau"
})

L:SetTimerLocalization({
	TimerCap 				= "%s",
})

L:SetOptionLocalization({
	TimerWin 				= "Montre le timer de la victoire",
	TimerCap 				= "Montre le timer de capture",
	ShowGilneasEstimatedPoints	= "Montre l'estimation de points pour gagner / perdre",
	ShowGilneasBasesToWin	= "Montre les bases à avoir pour gagner"
})
