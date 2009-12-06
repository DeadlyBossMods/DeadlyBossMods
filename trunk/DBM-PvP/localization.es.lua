if GetLocale() ~= "esES" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Opciones"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Mostrar colores de clases en la Tabla de Estadísticas.",
	ShowInviteTimer	= "Mostrar tiempo restante para entrar en batalla.",
	AutoSpirit	= "Liberar espíritu automaticamente"
})

L:SetMiscLocalization({
	ArenaInvite	= "Mostrar tiempo para la Arena"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arena"
})

L:SetTimerLocalization({
	TimerStart	= "¡La arena va a Comenzar!",
	TimerShadow	= "Visión de las Sombras"
})

L:SetOptionLocalization({
	TimerStart	= "Mostrar tiempo para que la Arena empieze.",
	TimerShadow 	= "Mostrar tiempo para que salga Visión de las Sombras."
})

L:SetMiscLocalization({
    Start60     = "¡Un minuto hasta que comience la batalla en la arena!",
	Start45     = "¡Cuarenta y cinco segundos hasta que comience la batalla en la arena!",
	Start30		= "¡Treinta segundos hasta que comience la batalla en arena!",
	Start15		= "¡Quince segundos hasta que comience la batalla en arena!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Valle de Alterac"
})

L:SetTimerLocalization({
	TimerStart		= "La batalla comezara en", 
	TimerTower		= "%s",
	TimerGY			= "%s",
})

L:SetMiscLocalization({
	BgStart60		= "1 minuto para que dé comienzo la batalla por el Valle de Alterac.",
	BgStart30		= "30 segundos para que dé comienzo la batalla por el Valle de Alterac.",
	ZoneName		= "Valle de Alterac",
})

L:SetOptionLocalization({
	TimerStart		= "Mostrar tiempo para que comienze la Batalla.",
	TimerTower		= "Mostrar tiempo para conquistar las Torres.",
	TimerGY			= "Mostrar tiempo para conquistar los Cementerios.",
	AutoTurnIn		= "Completar automaticamente las misiones de entregar piezas."
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Cuenca de Arathi"
})

L:SetMiscLocalization({
	BgStart60		= "La batalla por la Cuenca de Arathi comenzará en 1 minuto.",
	BgStart30		= "La Batalla por la Cuenca de Arathi comenzará en 30 segundos.",
	ZoneName 		= "Cuenca de Arathi",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "La Alianza",
	Horde 			= "La Horda",
	WinBarText 		= "%s ganara en",
	BasesToWin 		= "Bases necesarias para ganar: %d",
	Flag 			= "Bandera"
})

L:SetTimerLocalization({
	TimerStart 		= "¡La batalla va Comenzar!", 
	TimerCap 		= "%s",
})

L:SetOptionLocalization({
	TimerStart  		= "Mostrar tiempo para que comienze la Batalla.",
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerCap 		= "Mostrar tiempo que tarda en conquistar Banderas.",
	ShowAbEstimatedPoints	= "Mostrar recursos estimados a ganar.",
	ShowAbBasesToWin	= "Mostrar bases para ganar."
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "Ojo de la Tormenta"
})

L:SetMiscLocalization({
	BgStart60		= "¡La batalla comienza en un minuto!",
	BgStart30		= "¡La batalla comienza en treinta segundos!",
	ZoneName		= "Ojo de la Tormenta",
	ScoreExpr		= "(%d+)/1600",
	Alliance 		= "La Alianza",
	Horde 			= "La Horda",
	WinBarText 		= "%s ganara en",
	FlagReset 		= "La bandera se ha restablecido.",
	FlagTaken 		= "¡ (.+) ha tomado la bandera!",
	FlagCaptured 		= "¡La .+ ha%w+ ha capturado la bandera!",
	FlagDropped 		= "¡Ha caído la bandera!",

})

L:SetTimerLocalization({
	TimerStart 		= "¡La batalla va a Comenzar!", 
	TimerFlag 		= "Bandera Restablecida",
})

L:SetOptionLocalization({
	TimerStart  		= "Mostrar tiempo para que comienze la Batalla.",
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerFlag 		= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowPointFrame 		= "Ver puntos que dara la bandera.",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Garganta Grito de Guerra"
})

L:SetMiscLocalization({
	BgStart60 			= "La batalla por la Garganta Grito de Guerra comenzará en 1 minuto.",
	BgStart30 			= "La batalla por la Garganta Grito de Guerra comenzará en 30 segundos. ¡Preparaos!",
	ZoneName 			= "Garganta Grito de Guerra",
	Alliance 			= "Alianza",
	Horde 				= "Horda",	
	InfoErrorText 			= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp 			= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured 		= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn 			= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance 			= "Banderas capturadas por la Alianza: ",
	FlagHorde			= "Banderas capturadas por la Horda: ",
	FlagBase			= "Base",
})

L:SetTimerLocalization({
	TimerStart 			= "La batalla va comenzar", 
	TimerFlag 			= "La bandera se resetea en",
})

L:SetOptionLocalization({
	TimerStart  			= "Mostrar tiempo para que comienze la Batalla.",
	TimerWin 			= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerFlag			= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowFlagCarrier			= "Mostrar por donde va la bandera",
	ShowFlagCarrierErrorNote 	= "Mostrar error de por donde va la bandera",
})



----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon el Vigía de piedra"
})

L:SetWarningLocalization({
	WarningShards	= "Fragmentos de roca en >%s<",
	WarningGrab	= "Archavon agarró >%s<"
})

L:SetTimerLocalization({
	TimerShards 	= "Fragmentos de roca: %s"
})

L:SetMiscLocalization({
	TankSwitch	 = "%%s se abalanza sobre (%S+)!"
})

L:SetOptionLocalization({
	TimerShards 	= "Mostrar tiempo para fragmentos de roca",
	WarningShards 	= "Mostrar aviso para fragmentos de roca",
	WarningGrab 	= "Mostrar aviso para cambiar tank"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon"
}

L:SetWarningLocalization{
	specWarnNova		= "Nova de relámpagos",
	warnNova 		= "Nova de relámpagos",
	warnOverCharge		= "Sobrecarga"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Sobrecarga"
}

L:SetOptionLocalization{
	specWarnNova 		= ("Mostrar aviso especial para |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Nova de relámpagos"),
	warnNova 		= ("Mostrar aviso para |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Nova de relámpagos"),
	warnOverCharge 		= ("Mostrar aviso para |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "Sobrecarga"),
	timerMobOvercharge	= "Mostrar tiempo para que un Mob se haga grande."
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon"
}

L:SetWarningLocalization{
	SpecWarnCinder	= "Estas en Ceniza flamígera! Corre!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SpecWarnCinder		= "Mostrar aviso especial cuando estas en Ceniza flamigera",
	PlaySoundOnCinder	= "Reproducir sonido si estas en Ceniza flamigera",
}

L:SetMiscLocalization{
	Meteor	= "%s castea Meteorito!"
}


------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleOfConquest")

L:SetGeneralLocalization({
	name = "Isla de la Conquista"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerStart		= "¡La batalla va comenzar!", 
	TimerPOI		= "%s",
})

L:SetOptionLocalization({
	TimerStart		= "Mostrar tiempo para que comienze la Batalla.", 
	TimerPOI		= "Mostrar tiempo para las Capturas",
})

L:SetMiscLocalization({
	ZoneName		= "Isla de la Conquista",
	BgStart60		= "La batalla comenzará en 60 segundos.",
	BgStart30		= "La batalla comenzará en 30 segundos.",
	BgStart15		= "La batalla comenzará en 15 segundos.",
})




