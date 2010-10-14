if GetLocale() ~= "frFR" then return end

local L

----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon"
})

L:SetWarningLocalization({
	WarningShards	= "Eclats de pierre sur >%s<",
	WarningGrab		= "Archavon a Empalé >%s<"
})

L:SetTimerLocalization({
	TimerShards 	= "Eclats de pierre: %s"
})

L:SetMiscLocalization({
	TankSwitch		 = "%%s lunges for (%S+)!"
})

L:SetOptionLocalization({
	TimerShards 	= "Montre le timer pour les Eclats de pierre",
	WarningShards 	= "Montre les alertes pour les Eclats de pierre",
	WarningGrab 	= "Montre l'alerte pour le tank qui a été empalé"
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
	warnNova 			= "Alerte pour la Nova de foudre",
	warnOverCharge		= "Surcharger"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Explosion de Surcharge"
}

L:SetOptionLocalization{
	specWarnNova 		= ("Montre une alerte spéciale pour |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Nova de foudre"),
	warnNova 			= ("Montre une alerte pour |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Nova de foudre"),
	warnOverCharge 		= ("Montre une alerte pour |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "Surcharge explosive"),
	timerMobOvercharge	= "Montre le timer pour le séide surchargé (debuff empilable)",
	RangeFrame			= "Montre la fenêtre de portée"
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon"
}

L:SetWarningLocalization{
	SpecWarnCinder		= "Vous êtes sur une Braise enflammée ! BOUGEZ !"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SpecWarnCinder		= "Montre une alerte spéciale quand vous êtes dans les Braises enflammées",
	PlaySoundOnCinder	= "Joue un son quand vous êtes dans les Braises enflammées",
}

L:SetMiscLocalization{
	Meteor				= "%s lance Poings météoriques !"
}