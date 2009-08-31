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
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Met le nom en couleur en fonction de la classe dans le tableau des scores",
	ShowInviteTimer	= "Montre le temps d'acceptation des champs de bataille",
	AutoSpirit	= "Auto-rez a un Ange"
})

L:SetMiscLocalization({
	ArenaInvite	= "Invitation d'arène"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arène"
})

L:SetTimerLocalization({
	TimerStart	= "Le jeux commance dans",
	TimerShadow	= "Cristal d'ombre"
})

L:SetOptionLocalization({
	TimerStart	= "Voir le timer du début",
	TimerShadow 	= "Montre le timer pour le cristal d'ombre"
})

L:SetMiscLocalization({
	Start60		= "Une minute avant de début de l'arène!",
	Start30		= "Trente seconde avant de début de l'arène!",
	Start15		= "Quinze seconde avant de début de l'arène!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "Vallée d'Alterac"
})

L:SetTimerLocalization({
	TimerStart		= "Le jeux commance", 
	TimerTower		= "%s",
	TimerGY			= "%s",
})

L:SetMiscLocalization({
	BgStart60		= "1 minute avant le commancement de la bataille de la Vallée d'Alterac.",
	BgStart30		= "30 seconds avant le commancement de la bataille de la Vallée d'Alterac",
	ZoneName		= "Vallée d'Alterac",
})

L:SetOptionLocalization({
	TimerStart		= "Voir le timer du commancement",
	TimerTower		= "Voir le timer des capture des tours",
	TimerGY			= "Voir le timer des capture des cimetères",
	AutoTurnIn		= "Fini automatiquement les quètes dans la Vallée d'Alterac"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name = "Bassin d'Arathi"
})

L:SetMiscLocalization({
	BgStart60		= "La bataille pour le Bassin d'Arathi commance dans 1 minute.",
	BgStart30		= "La bataille pour le Bassin d'Arathi commance dans 30 secondes.",
	ZoneName 		= "Bassin d'Arathi",
	ScoreExpr 		= "(%d+)/2000",
	Alliance 		= "Alliance",
	Horde 			= "Horde",
	WinBarText 		= "%s Gagne",
	BasesToWin 		= "Bases pour gagner: %d",
	Flag 			= "Drapeau"
})

L:SetTimerLocalization({
	TimerStart 		= "Le jeux commance", 
	TimerCap 		= "%s",
})

L:SetOptionLocalization({
	TimerStart  		= "Montre le timer avant le début de la partie",
	TimerWin 		= "Montre le timer de la victoire",
	TimerCap 		= "Montre le timer de capture",
	ShowAbEstimatedPoints	= "Montre l'estimation de point pour gagner / perdre",
	ShowAbBasesToWin	= "Montre les base a avoir pour gagner"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "L'Œil du cyclone"
})

L:SetMiscLocalization({
	BgStart60		= "La bataille commance dans 1 minute!",
	BgStart30		= "La bataille commance dans 30 secondes!",
	ZoneName		= "L'Œil du cyclone",
	ScoreExpr		= "(%d+)/2000",
	Alliance 		= "Alliance",
	Horde 			= "Horde",
	WinBarText 		= "%s Gagne",
	FlagReset 		= "Le drapeau viens d'être reset a la base",
	FlagTaken 		= "(.+) a pris le drapeau",
	FlagCaptured 		= "The .+ ha%w+ a capturer le drapeau!",
	FlagDropped 		= "Le drapeau viens d'être lacher!",

})

L:SetTimerLocalization({
	TimerStart 		= "Le jeux commance", 
	TimerFlag 		= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerStart  		= "Montre le timer avant le début de la partie",
	TimerWin 		= "Montre le timer de la victoire",
	TimerFlag 		= "Montre le timer du respawn du drapeau",
	ShowPointFrame 		= "Montre les porteurs des drapeau et les points estimer",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name = "Goulet des Chanteguerres"
})

L:SetMiscLocalization({
	BgStart60 			= "La bataille du Goulet des Chanteguerres commance dans 1 minute.",
	BgStart30 			= "La bataille du Goulet des Chanteguerres commance dans 30 seconde - Préparez vous!",
	ZoneName 			= "Goulet des Chanteguerres",
	Alliance 			= "Alliance",
	Horde 				= "Horde",	
	InfoErrorText 			= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp 			= "Le (%w+) .lag a était pris par (.+)!",
	ExprFlagCaptured 		= "(.+) a capturer le (%w+) drapeau!",
	ExprFlagReturn 			= "Le (%w+) .lag a été renvoyer a la base par (.+)!",
	FlagAlliance 			= "Drapeau de l'alliance: ",
	FlagHorde			= "Drapeau de la horde: ",
	FlagBase			= "Base",
})

L:SetTimerLocalization({
	TimerStart 			= "Le jeux commance", 
	TimerFlag 			= "Respawn du drapeau",
})

L:SetOptionLocalization({
	TimerStart  		= "Montre le timer avant le début de la partie",
	TimerWin 		= "Montre le timer de la victoire",
	TimerFlag 		= "Montre le timer du respawn du drapeau",
	ShowFlagCarrier			= "Montre le porteur du drapeau",
	ShowFlagCarrierErrorNote 	= "Shows flag carrier error message when in combat",
})



----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon"
})

L:SetWarningLocalization({
	WarningShards	= "Eclats de pierre sur >%s<",
	WarningGrab	= "Archavon a Empaler >%s<"
})

L:SetTimerLocalization({
	TimerShards 	= "Eclats de pierre: %s"
})

L:SetMiscLocalization({
	TankSwitch	 = "%%s lunges for (%S+)!"
})

L:SetOptionLocalization({
	TimerShards 	= "Montre le timer pour les Eclats de pierre",
	WarningShards 	= "Montre les alertes pour les Eclats de pierre",
	WarningGrab 	= "Montre l'alerte pour le tank qui a été Empaler"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon le guetteur d’orage"
}

L:SetWarningLocalization{
	specWarnNova		= "Nova de foudre",
	warnNova 		= "Alerte pour la Nova de foudre",
	warnOverCharge		= "Surcharger"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Explosion de Surcharge"
}

L:SetOptionLocalization{
	specWarnNova 		= ("Show special warning for |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Lightning Nova"),
	warnNova 		= ("Show warning for |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Lightning Nova"),
	warnOverCharge 		= ("Show warning for |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "Overcharge"),
	timerMobOvercharge	= "Show Timer for Overchaged Mob (stacking debuff)"
}

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleOfConquest")

L:SetGeneralLocalization({
	name = "Île des Conquérants"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerStart		= "La partie commance", 
	TimerPOI		= "%s",
})

L:SetOptionLocalization({
	TimerStart		= "Montre le timer avant le début de la partie", 
	TimerPOI		= "Montre le timer pour les captures",
})

L:SetMiscLocalization({
	ZoneName		= "Île des Conquérants",
	BgStart60		= "La bataille commance dans 60 secondes.",
	BgStart30		= "La bataille commance dans 30 secondes.",
	BgStart15		= "La bataille commance dans 15 secondes.",
})



