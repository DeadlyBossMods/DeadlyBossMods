if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

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
L = DBM:GetModLocalization("EyeoftheStorm")

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
	WarningGrab	= "Archavon agarró >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Enrage"
})

L:SetMiscLocalization({
	TankSwitch	 = "%%s se abalanza sobre (%S+)!"
})

L:SetOptionLocalization({
	WarningGrab 	= "Mostrar aviso para cambiar tank",
	ArchavonEnrage	= "Mostrar tiempo para $spell:26662"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Sobrecarga",
	EmalonEnrage		= "Enrage"
}

L:SetOptionLocalization{
	NovaSound			= "Reproducir sonido en $spell:65279",
	timerMobOvercharge	= "Mostrar tiempo para que un Mob se haga grande.",
	EmalonEnrage		= "Mostrar tiempo para $spell:26662",
	RangeFrame			= "Mostrar distancia"
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon"
}

L:SetWarningLocalization{
	BurningFury		= "Burning Fury >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Enrage"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "Reproducir sonido si estas en Ceniza flamigera",
	BurningFury			= "Mostrar aviso para $spell:66721",
	KoralonEnrage		= "Mostrar tiempo para $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "%s castea Meteorito!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon"
}

L:SetWarningLocalization{
	Frostbite	= "Frostbite en >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Enrage"
}

L:SetOptionLocalization{
	Frostbite	= "Mostrar aviso para $spell:72098",
}

L:SetMiscLocalization{
	ToravonEnrage	= "Mostrar tiempo para enrage"
}

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Isla de la Conquista"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine ready!",
	WarnSiegeEngineSoon	= "Siege Engine in ~10 sec"
})

L:SetTimerLocalization({
	TimerStart		= "¡La batalla va comenzar!", 
	TimerPOI		= "%s",
	TimerSiegeEngine	= "Siege Engine ready"
})

L:SetOptionLocalization({
	TimerStart		= "Mostrar tiempo para que comienze la Batalla.", 
	TimerPOI		= "Mostrar tiempo para las Capturas",
	TimerSiegeEngine	= "Show timer for Siege Engine construction",
	WarnSiegeEngine		= "Show warning when Siege Engine is ready",
	WarnSiegeEngineSoon	= "Show warning when Siege Engine is almost ready"
})

L:SetMiscLocalization({
	ZoneName		= "Isla de la Conquista",
	BgStart60		= "La batalla comenzará en 60 segundos.",
	BgStart30		= "La batalla comenzará en 30 segundos.",
	BgStart15		= "La batalla comenzará en 15 segundos.",
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

