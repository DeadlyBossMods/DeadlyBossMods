if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Opciones generales"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Mostrar colores de clases en la Tabla de Estadísticas.",
	ShowInviteTimer	= "Mostrar tiempo restante para entrar en batalla.",
	AutoSpirit	= "Liberar espíritu automaticamente",
	HideBossEmoteFrame	= "Ocultar el marco de chat del Boss"
})

L:SetMiscLocalization({
	ArenaInvite	= "Mostrar tiempo para la Arena"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arenas"
})

L:SetTimerLocalization({
	TimerShadow	= "Visión de las Sombras"
})

L:SetOptionLocalization({
	TimerShadow 	= "Mostrar tiempo para que salga Visión de las Sombras."
})

L:SetMiscLocalization({
	Start15		= "¡Quince segundos hasta que comience la batalla en arena!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("z30")

L:SetTimerLocalization({
	TimerTower		= "%s",
	TimerGY			= "%s"
})

L:SetOptionLocalization({
	TimerTower		= "Mostrar tiempo para conquistar las Torres.",
	TimerGY			= "Mostrar tiempo para conquistar los Cementerios.",
	AutoTurnIn		= "Completar automaticamente las misiones de entregar piezas."
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("z529")

L:SetMiscLocalization({
	ScoreExpr 		= "(%d+)/1600",
	WinBarText 		= "%s ganara en",
	BasesToWin 		= "Bases necesarias para ganar: %d",
	Flag 			= "Bandera"
})

L:SetTimerLocalization({
	TimerCap 		= "%s"
})

L:SetOptionLocalization({
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerCap 		= "Mostrar tiempo que tarda en conquistar Banderas.",
	ShowAbEstimatedPoints	= "Mostrar recursos estimados a ganar.",
	ShowAbBasesToWin	= "Mostrar bases para ganar."
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("z566")

L:SetMiscLocalization({
	ScoreExpr		= "(%d+)/1600",
	WinBarText 		= "%s ganara en",
	FlagReset 		= "La bandera se ha restablecido.",
	FlagTaken 		= "¡ (.+) ha tomado la bandera!",
	FlagCaptured 		= "¡La .+ ha%w+ ha capturado la bandera!",
	FlagDropped 		= "¡Ha caído la bandera!"

})

L:SetTimerLocalization({
	TimerFlag 		= "Bandera Restablecida"
})

L:SetOptionLocalization({
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerFlag 		= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowPointFrame 		= "Ver puntos que dara la bandera."
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("z489")

L:SetMiscLocalization({
	BgStart60 			= "La batalla comienza en 1 minuto.",
	BgStart30 			= "La batalla comienza en 30 segundos. ¡Preparaos!",
	InfoErrorText 			= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp 			= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured 		= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn 			= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance 			= "Banderas capturadas por la Alianza: ",
	FlagHorde			= "Banderas capturadas por la Horda: ",
	FlagBase			= "Base"
})

L:SetTimerLocalization({
	TimerStart 			= "La batalla va comenzar",
	TimerFlag 			= "La bandera se resetea en"
})

L:SetOptionLocalization({
	TimerStart  			= "Mostrar tiempo para que comienze la Batalla.",
	TimerFlag			= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowFlagCarrier			= "Mostrar por donde va la bandera",
	ShowFlagCarrierErrorNote 	= "Mostrar error de por donde va la bandera"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Máquina de asedio Lista!",
	WarnSiegeEngineSoon	= "Máquina de asedio en ~10 seg"
})

L:SetTimerLocalization({
	TimerPOI		= "%s",
	TimerSiegeEngine	= "Máquina de asedio Lista"
})

L:SetOptionLocalization({
	TimerPOI		= "Mostrar tiempo para las Capturas",
	TimerSiegeEngine	= "Mostrar tiempo para la construcción de Máquina de asedio",
	WarnSiegeEngine		= "Mostrar aviso cuando Máquina de asedio esté lista",
	WarnSiegeEngineSoon	= "Mostrar aviso cuando Máquina de asedio esté casi lista",
	ShowGatesHealth		= "Mostrar la vida de las puertas dañadas (Puede que muestre valores erréneos si te unes a una BG empezada!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Puertas dañadas",
	SiegeEngine				= "Máquina de asedio",
	GoblinStartAlliance		= "¿Ves esas bombas de seforio? Úsalas en las puertas mientras reparo la máquina de asedio.",
	GoblinStartHorde		= "Trabajaré en la máquina de asedio, solo cúbreme las espaldas. ¡Usa esas bombas de seforio en las puertas si las necesitas!",
	GoblinHalfwayAlliance	= "¡Estoy a medias! Mantén a la Horda alejada de aquí. ¡En la escuela de ingeniería no enseñan a luchar!",
	GoblinHalfwayHorde		= "¡Ya casi estoy! Mantén a la Alianza alejada... ¡Luchar no entra en mi contrato!",
	GoblinFinishedAlliance	= "¡Mi mejor obra! ¡Esta máquina de asedio está lista para la acción!",
	GoblinFinishedHorde		= "¡La máquina de asedio está lista para la acción!",
	GoblinBrokenAlliance	= "¿Ya está rota? No pasa nada. No es nada que no pueda arreglar.",
	GoblinBrokenHorde		= "¿Está estropeada otra vez? La arreglaré... pero no esperes que la garantía cubra esto."
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("z726")

L:SetMiscLocalization({
	BgStart60 			= "La batalla comienza en 1 minuto.",
	BgStart30 			= "La batalla comienza en 30 segundos. ¡Preparaos!",
	InfoErrorText		= "La función de targetear al portador de la bandera se restaurará cuando estés fuera de combate.",
	ExprFlagPickUp		= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured	= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn		= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance		= "Bandera de la Alianza: ",
	FlagHorde			= "Bandera de la Horda: ",
	FlagBase			= "Base",
	Vulnerable1		= "¡Los portadores de las banderas se han vuelto vulnerables a los ataques!",
	Vulnerable2		= "¡Los portadores de las banderas se han vuelto más vulnerables a los ataques!"
})

L:SetTimerLocalization({
	TimerStart	= "Empieza la batalla",
	TimerFlag	= "Reaparición de la bandera"
})

L:SetOptionLocalization({
	TimerStart					= "Mostrar tiempo de inicio",
	TimerFlag					= "Mostrar tiempo de reaparición de bandera",
	ShowFlagCarrier				= "Mostrar portador de la bandera",
	ShowFlagCarrierErrorNote	= "Mostrar mensaje de error del portador de la bandera en combate"
})

--------------------------
--  Battle for Gilneas  --
--------------------------
L = DBM:GetModLocalization("z761")

L:SetMiscLocalization({
	ScoreExpr 		= "(%d+)/2000",
	WinBarText 		= "%s ganara en",
	BasesToWin 		= "Bases necesarias para ganar: %d",
	Flag 			= "Bandera"
})

L:SetTimerLocalization({
	TimerCap 		= "%s"
})

L:SetOptionLocalization({
	TimerWin 			= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerCap 			= "Mostrar tiempo que tarda en conquistar Banderas.",
	ShowGilneasEstimatedPoints	= "Mostrar recursos estimados a ganar.",
	ShowGilneasBasesToWin		= "Mostrar bases para ganar."
})