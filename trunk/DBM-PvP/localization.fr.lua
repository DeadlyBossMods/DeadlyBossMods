if GetLocale() ~= "frFR" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Fonction générale des champs de bataille"
})

L:SetTimerLocalization({
	TimerInvite		 = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Met le nom en couleur en fonction de la classe dans le tableau des scores",
	ShowInviteTimer	= "Montre le temps d'acceptation des champs de bataille",
	AutoSpirit		= "Auto-rez à un Ange"
})

L:SetMiscLocalization({
	ArenaInvite		= "Invitation d'arène"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arène"
})

L:SetTimerLocalization({
	TimerStart	= "La bataille commence dans",
	TimerShadow	= "Cristal d'ombre"
})

L:SetOptionLocalization({
	TimerStart	= "Voir le timer du début",
	TimerShadow = "Montre le timer pour le cristal d'ombre"
})

L:SetMiscLocalization({
	Start60		= "Une minute avant de début de l'arène !",
	Start30		= "Trente secondes avant de début de l'arène !",
	Start15		= "Quinze secondes avant de début de l'arène !"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Vallée d'Alterac"
})

L:SetTimerLocalization({
	TimerStart		= "La bataille commence dans", 
	TimerTower		= "%s",
	TimerGY			= "%s",
})

L:SetMiscLocalization({
	BgStart60		= "La bataille pour la vallée d'Alterac commence dans 1 minute.",
	BgStart30		= "La bataille pour la vallée d'Alterac commence dans 30 secondes.",
	ZoneName		= "Vallée d'Alterac",
})

L:SetOptionLocalization({
	TimerStart		= "Voir le timer du commencement",
	TimerTower		= "Voir le timer des captures des tours",
	TimerGY			= "Voir le timer des captures des cimetères",
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
	BgStart60				= "La bataille pour le bassin d'Arathi commence dans 1 minute.",
	BgStart30				= "La bataille pour le bassin d'Arathi commence dans 30 secondes.",
	ZoneName 				= "Bassin d'Arathi",
	ScoreExpr 				= "(%d+)/1600",
	Alliance 				= "Alliance",
	Horde 					= "Horde",
	WinBarText 				= "%s Gagne",
	BasesToWin 				= "Bases pour gagner: %d",
	Flag 					= "Drapeau"
})

L:SetTimerLocalization({
	TimerStart 				= "La bataille commence dans", 
	TimerCap 				= "%s",
})

L:SetOptionLocalization({
	TimerStart  			= "Montre le timer avant le début de la partie",
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
	BgStart60			= "La bataille commence dans 1 minute !",
	BgStart30			= "La bataille commence dans 30 secondes !",
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
	TimerStart 			= "La bataille commence dans", 
	TimerFlag 			= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerStart  		= "Montre le timer avant le début de la partie",
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
	BgStart60 					= "La bataille pour le goulet des Chanteguerres commence dans 1 minute.",
	BgStart30 					= "La bataille pour le goulet des Chanteguerres commence dans 30 secondes. Préparez-vous !",
	ZoneName 					= "Goulet des Chanteguerres",
	Alliance 					= "Alliance",
	Horde 						= "Horde",	
	InfoErrorText 				= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp 				= "Le (%w+) .lag a été pris par (.+) !",
	ExprFlagCaptured 			= "(.+) a capturé le (%w+) drapeau!",
	ExprFlagReturn 				= "Le (%w+) .lag a été renvoyé à la base par (.+) !",
	FlagAlliance 				= "Drapeau de l'alliance: ",
	FlagHorde					= "Drapeau de la horde: ",
	FlagBase					= "Base",
})

L:SetTimerLocalization({
	TimerStart 					= "La bataille commence dans", 
	TimerFlag 					= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerStart  				= "Montre le timer avant le début de la partie",
	TimerWin 					= "Montre le timer de la victoire",
	TimerFlag 					= "Montre le timer du respawn du drapeau",
	ShowFlagCarrier				= "Montre le porteur du drapeau",
	ShowFlagCarrierErrorNote 	= "Shows flag carrier error message when in combat",
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Île des Conquérants"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine ready!",
	WarnSiegeEngineSoon	= "Siege Engine in ~10 sec"
})

L:SetTimerLocalization({
	TimerStart			= "La bataille commence dans", 
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Siege Engine ready"
})

L:SetOptionLocalization({
	TimerStart			= "Montre le timer avant le début de la partie", 
	TimerPOI			= "Montre le timer pour les captures",
	TimerSiegeEngine	= "Show a timer for Siege Engine building",
	WarnSiegeEngine		= "Warn when the Siege Engine is ready",
	WarnSiegeEngineSoon	= "Warn when the Siege Engine is almost ready"
})

L:SetMiscLocalization({
	ZoneName				= "Île des Conquérants",
	BgStart60				= "La bataille commance dans 60 secondes.",
	BgStart30				= "La bataille commance dans 30 secondes.",
	BgStart15				= "La bataille commance dans 15 secondes.",
	SiegeEngine				= "Siege Engine",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "I'll work on the siege engine, just watch my back.  Use those seaforium bombs on the gates if you need them!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

