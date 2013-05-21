if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s pronto - ¡abandona el Agua conductiva!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Mostrar aviso especial si permaneces en $spell:138470\n(Aviso al comenzar $spell:137313 o si $spell:138732 expirará pronto)",
	RangeFrame			= "Mostrar radar de rango (8/4)"
})


--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Orbe de control disponible",
	specWarnOrbofControl	= "¡Orbe de crontrol disponible!"
})

L:SetTimerLocalization({
	timerDoor				= "Siguiente puerta tribal",
	timerAdds				= "Siguientes %s"
})

L:SetOptionLocalization({
	warnAdds				= "Anunciar cuando aparecen nuevos adds",
	warnOrbofControl		= "Anunciar cuando un $journal:7092 está disponible",
	specWarnOrbofControl	= "Mostrar aviso especial cuando un $journal:7092 está disponible",
	timerDoor				= "Mostrar temporizador para la siguiente fase de puerta tribal",
	timerAdds				= "Mostrar temporizador cuando aparecen nuevos adds",
	RangeFrame				= "Mostrar distancia (5) para $spell:136480"
})

L:SetMiscLocalization({
	newForces		= "salen en tropel desde",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "fija la vista"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed		= "%s en %s - cambio de objetivo"
})

L:SetOptionLocalization({
	PHealthFrame		= "Mostrar salud restante para que $spell:136442 desaparezca\n(Requiere barra de vida del boss)",
	RangeFrame			= "Mostrar radar de rango",
	AnnounceCooldowns	= "Mostrar cuenta de $spell:137166 (hasta 3) para uso de cooldowns de banda"
})



------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s usó >%s< (%d restantes)",
	specWarnCrystalShell	= "Obtén %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Mostrar aviso especial cuando te falta $spell:137633",
	InfoFrame				= "Mostrar cuadro de información para los jugadores sin $spell:137633",
	SetIconOnTurtles		= "Poner iconos en $journal:7129",
	ClearIconOnTurtles		= "Quitar iconos en $journal:7129 cuando les afecte $spell:133971",
	AnnounceCooldowns		= "Mostrar cuenta de $spell:134920 para el uso de cooldowns de banda"
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "Siguiente aliento"
})

L:SetOptionLocalization({
	timerBreaths			= "Mostrar temporizador para el siguiente aliento",
	AnnounceCooldowns		= "Contar Desenfrenos para el uso de cooldowns de banda",
	Never					= "Nunca",
	Every					= "Todos (consecutivos)",
	EveryTwo				= "Cada 2",
	EveryThree				= "Cada 3",
	EveryTwoExcludeDiff		= "Cada 2 (Excluyendo Difusión)",
	EveryThreeExcludeDiff	= "Cada 3 (Excluyendo Difusión)"
})

L:SetMiscLocalization({
	rampageEnds	= "La ira de Megaera amaina."
})
------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "Guardián del nido: %s",
	specWarnBigBirdSoon	= "Guardián del nido pronto: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nido (%d): %s"
})

L:SetOptionLocalization({
	RangeFrame			= "Mostrar radar de rango (10) para $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "huevos de uno de los nidos inferiores empiezan",
	eggsHatchU		= "huevos de uno de los nidos superiores empiezan",
	Upper			= "Arriba",
	Lower			= "Abajo",
	UpperAndLower	= "Arriba y Abajo",
	TrippleD		= "Triple (2xAbajo)",
	TrippleU		= "Triple (2xArriba)",
	SouthWest		= "SO",
	SouthEast		= "SE",
	NorthWest		= "NO",
	NorthEast		= "NE",
	West			= "O",
	Middle			= "C"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Luz - |cffff0000Roja|r : >%s<, |cff0000ffAzul|r : >%s<",
	warnBeamHeroic				= "Luz - |cffff0000Roja|r : >%s<, |cff0000ffAzul|r : >%s<, |cffffff00Amarilla|r : >%s<",
	warnAddsLeft				= "Bestias de niebla restantes: %d",
	specWarnBlueBeam			= "Luz azul en ti - No te muevas",
	specWarnFogRevealed			= "¡%s descubierto!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Anunciar objetivos de las luces",
	warnAddsLeft				= "Anunciar bestias de niebla restantes",
	specWarnFogRevealed			= "Mostrar aviso especial cuando se descubre una bestia de niebla",
	ArrowOnBeam					= "Mostrar flecha indicando la dirección en la que moverse durante $journal:6882",
	InfoFrame					= "Mostrar cuadro de información para acumulaciones de $spell:133795",
	SetParticle					= "Bajar densidad de partículas al comenzar el encuentro\n(Restaurar la configuración original al terminar)"
})

L:SetMiscLocalization({
	LifeYell		= "Drenaje de vida en %s (%d)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Mutaciones: %d/5 buenas, %d malas",
})

L:SetOptionLocalization({
	warnDebuffCount				= "Mostrar cuenta de debuffs cuando se absorbe un charco",
	RangeFrame					= "Mostrar radar de rango (5/2)",
	SetIconOnBigOoze			= "Poner icono en $journal:6969"
})


-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< y >%s< intercambiados"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Anunciar objetivos intercambiados por $spell:138618"
})

L:SetMiscLocalization({
	Pull		= "¡El orbe explota!"
})


--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s y %s escudados"
})

L:SetOptionLocalization({
	RangeFrame				= "Mostrar radar de rango dinámico (10)\n(Radar inteligente que muestra cuando hay demasiados jugadores cerca)",
	InfoFrame				= "Mostrar cuadro de información para jugadores con $spell:136193"
})


-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "Fase de noche",
	warnDay			= "Fase de día",
	warnDusk		= "Fase de crepúsculo"
})

L:SetTimerLocalization({
	timerDayCD		= "Siguiente fase de día",
	timerDuskCD		= "Siguiente fase de crepúsculo"
})

L:SetOptionLocalization({
	RangeFrame		= "Mostrar radar de rango (8)"
})

L:SetMiscLocalization({
	DuskPhase		= "¡Lu'lin! ¡Préstame tu fuerza!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Interfase pronto"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Mostrar aviso especial antes de cada interfase",
	RangeFrame					= "Mostrar radar de rango (8/6)",--For two different spells
	StaticShockArrow			= "Mostrar flecha cuando alguien está afectado por $spell:135695",
	OverchargeArrow				= "Mostrar flecha cuando alguien está afectado por $spell:136295"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)
