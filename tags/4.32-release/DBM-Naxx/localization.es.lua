if GetLocale() ~= "esES" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Enjambre de Langostas!",
	WarningLocustSoon	= "Enjambre de Langostas en 15 seg",
	WarningLocustNow	= "Enjambre de Langostas!",
	WarningLocustFaded	= "Enjambre de Langostas desapareció"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Enjambre de Langostas", 
	TimerLocustFade = "Enjambre de Langostas dura"
})

L:SetOptionLocalization({
	SpecialLocust		= "Mostrar aviso especial para Enjambre de Langostas",
	WarningLocustSoon	= "Mostrar pre-aviso para Enjambre de Langostas",
	WarningLocustNow	= "Mostrar aviso para Enjambre de Langostas",
	WarningLocustFaded	= "Mostrar aviso para cunado Enjambre de Langostas desaparece",
	TimerLocustIn		= "Mostrar tiempo para Enjambre de Langostas", 
	TimerLocustFade 	= "Mostrar tiempo para cuando Enjambre de Langostas desaparece"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Gran Viuda Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "Abrazo de la viuda activo",
	WarningEmbraceExpire	= "Abrazo de la viuda temina en 5 seg",
	WarningEmbraceExpired	= "Abrazo de la viuda ha terminado",
	WarningEnrageSoon		= "Enrage pronto",
	WarningEnrageNow		= "Enrage!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "Abrazo de la viuda activo",
	TimerEnrage		= "Enrage",
})

L:SetOptionLocalization({
	TimerEmbrace			= "Mostrar tiempo para Abrazo de la viuda",
	WarningEmbraceActive	= "Mostrar aviso para Abrazo de la viuda",
	WarningEmbraceExpire	= "Mostrar aviso para cuando acabe en 5 seg Abrazo de la viuda",
	WarningEmbraceExpired	= "Mostrar aviso cuando Abrazo de la viuda acabe"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningWebWrap		= "Trampa arácnida: >%s<",
	WarningWebSpraySoon	= "Pulverizador de telaraña en 5 seg",
	WarningWebSprayNow	= "Pulverizador de telaraña!",
	WarningSpidersSoon	= "Arañas en 5 seg",
	WarningSpidersNow	= "Las arañas salieron!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Pulverizador de telaraña",
	TimerSpider		= "Arañas"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Anunciar quien esta en Trampa arácnida",
	WarningWebSpraySoon	= "Mostrar pre-aviso para Pulverizador de telaraña (Web Spray)",
	WarningWebSprayNow	= "Mostrar aviso para Pulverizador de telaraña (Web Spray)",
	WarningSpidersSoon	= "Mostrar pre-aviso para las Arañas",
	WarningSpidersNow	= "Mostrar aviso para las Arañas",
	TimerWebSpray		= "Mostrar tiempo para Pulverizador de telaraña (Web Spray)",
	TimerSpider			= "Mostrar tiempo para las Arañas"
})

L:SetMiscLocalization({
	YellWebWrap			= "¡Estoy en capullo!¡Ayuda!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth el Pesteador"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "¡Teletransportado!",
	WarningTeleportSoon	= "Teletransporte en 20 seg",
	WarningCurse		= "¡Maldición!"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teletransporte",
	TimerTeleportBack	= "Teletransporte vuelve"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Mostrar aviso cuando se Teletransporte",
	WarningTeleportSoon		= "Mostrar aviso antes de que se Teletransporte",
	WarningCurse			= "Mostrar aviso para las Maldiciones",
	TimerTeleport			= "Mostrar tiempo de Teletransporte",
	TimerTeleportBack		= "Mostrar cuando va volver a Teletransportarse"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan el Impuro"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "¡Teletransportado!",
	WarningTeleportSoon	= "Teletransporte en %d seg",
})

L:SetTimerLocalization({
	TimerTeleport		= "Treletransporte",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Mostrar aviso cuando se Teletransporte",
	WarningTeleportSoon		= "Mostrar aviso antes de Teletransportarse",
	WarningCurse			= "Mostrar aviso para las Maldiciones",
	TimerTeleport			= "Mostrar tiempo para Teletransporte",
	TimerTeleportBack		= "Mostrar tiempo cuando va volver a Teletransportarse"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "¡Espora!",
	WarningSporeSoon	= "Espora en 5 seg",
	WarningDoomNow		= "Fatalidad inevitable #%d",
	WarningHealSoon		= "Curar en 3 segundos",
	WarningHealNow		= "¡Curar Ahora!"
})

L:SetTimerLocalization({
	TimerDoom			= "Fatalidad inevitable #%d",
	TimerSpore			= "Siguiente espora",
	TimerAura			= "Aura Necrótica"
})

L:SetOptionLocalization({
	WarningSporeNow		= "Mostrar aviso para Esporas",
	WarningSporeSoon	= "Mostrar pre-aviso para Esporas",
	WarningDoomNow		= "Mostrar aviso apra Fatalidad inevitable ( Doom )",
	WarningHealSoon		= "Mostrar pre-aviso para \"Curar en 3 segudos\" ",
	WarningHealNow		= "Mostrar aviso para \"Curar Ahora\" ",
	TimerDoom			= "Mostrar tiempo para Fatalidad Inevitable",
	TimerSpore			= "Mostrar tiempo para Esporas",
	TimerAura			= "Mostrar tiempo para Aura Necrotica"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Remendejo"
})

L:SetOptionLocalization({
	WarningHateful = "Avisar por chat de raid los Golpes de Odio (necesitas ser ayudante o lider para eso)"
})

L:SetMiscLocalization({
	yell1 = "¡Remendejo quiere jugar!",
	yell2 = "¡Remendejo es la encarnación de Kel'Thuzad de la guerra!",
	HatefulStrike = "Golpe de Odio --> %s [%s]"
})


-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

L:SetOptionLocalization({
	WarningInjection		= "Mostrar aviso para Inyección mutante",
	SpecialWarningInjection	= "Mostrar aviso especial si te afecta Inyección mutante"
})

L:SetWarningLocalization({
	WarningInjection		= "Inyección mutante: >%s<",
	SpecialWarningInjection	= "Inyección mutante en ti!"
})

L:SetTimerLocalization({
})


-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

L:SetOptionLocalization({
	WarningDecimateNow	= "Mostrar aviso para Diezmar ( Decimate )",
	WarningDecimateSoon	= "Mostrar pre-aviso para Diezmar ( Decimate )",
	TimerDecimate		= "Mostrar tiempo para Diezmar ( Decimate )"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "Diezmar!",
	WarningDecimateSoon	= "Diezmar en 10 seg"
})

L:SetTimerLocalization({
	TimerDecimate		= "Diezmar cd"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell	= "¡Stalagg aplasta!",
	Emote	= "%s se sobrecarga!", -- ?
	Emote2	= "¡Espiral Tesla se sobrecarga!", -- ?
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "negativo",
	Charge2 = "positivo",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "Mostrar aviso para cambio de polaridad",
	WarningChargeChanged	= "Mostrar aviso especial si tu polaridad cambia",
	WarningChargeNotChanged	= "Mostrar avsio especial si tu polaridad no cambia",
	TimerShiftCast			= "Mostrar tiempo para cambio de polaridad",
	TimerNextShift			= "Mostrar cd de cambio de polaridad",
	ArrowsEnabled			= "Mostrar flechas (estrategia normal \"2 campos\" )",
	ArrowsRightLeft			= "Mostrar flechas derecha/izquierda para la estrategia de  \"4 campos\" (mostrar flecha izquierda si te cambia la polaridad, derecha si no)",
	ArrowsInverse			= "Estrategia inversa \"4 campos\" (mostrar flecha derecha si cambia la polaridad, izquierda si no)",
	WarningThrow			= "Mostrar aviso para Cambio-Tank",
	WarningThrowSoon		= "Mostrar pre-aviso para Cambio-Tank",
	TimerThrow				= "Mostrar tiempo para Cambio-Tank"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "Polaridad cambia en 3 seg!",
	WarningChargeChanged	= "Polaridad ha cambiado %s",
	WarningChargeNotChanged	= "Polaridad no ha cambiado",
	WarningThrow			= "Cambio-Tank!",
	WarningThrowSoon		= "Cambio-Tank en 3 seg"
})

L:SetTimerLocalization({
	TimerShiftCast			= "Cambio de Polaridad",
	TimerNextShift			= "Siguiente cambio",
	TimerThrow				= "Cambio-Tank"
})

L:SetOptionCatLocalization({
	Arrows	= "Flechas",
})


-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Instructor Razuvious"
})

L:SetMiscLocalization({
	Yell1 = "Show them no mercy!",
	Yell2 = "¡El tiempo de practivar ha pasado! ¡Quiero ver lo que habéis aprendido!",
	Yell3 = "Do as I taught you!",
	Yell4 = "Sweep the leg... Do you have a problem with that?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "Mostrar aviso para Grito perturbador",
	WarningShoutSoon		= "Mostrar pre-aviso para Grito perturbador",
	TimerShout				= "Mostrar tiempo para Grito perturbador",
	WarningShieldWallSoon	= "Mostrar aviso para Barrera de huesos",
	TimerShieldWall			= "Mostrar tiempo para Barrera de huesos",
	TimerTaunt				= "Mostrar tiempo para Provocar"
})

L:SetWarningLocalization({
	WarningShoutNow			= "Grito perturbador!",
	WarningShoutSoon		= "Grito perturbador en 5 seg",
	WarningShieldWallSoon	= "Barrera de huesos expira en 5 seg"
})

L:SetTimerLocalization({
	TimerShout			= "Grito perturbadort",
	TimerTaunt			= "Provocar",
	TimerShieldWall		= "Barrera de huesos"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik el Cosechador"
})

L:SetOptionLocalization({
	TimerWave			= "Mostrar tiempo de Oleadas",
	TimerPhase2			= "Mostrar tiempo para Fase 2",
	WarningWaveSoon		= "Mostrar pre-aviso para Oleadas",
	WarningWaveSpawned	= "Mostrar aviso para Oleadas",
	WarningRiderDown	= "Mostrar aviso cuando un Jinete muere",
	WarningKnightDown	= "Mostrar aviso cuando un Caballero muere",
	WarningPhase2		= "Mostrar aviso para Fase 2"
})

L:SetTimerLocalization({
	TimerWave	= "Oleada #%d",
	TimerPhase2	= "Fase 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Oleada %d: %s en 3 seg",
	WarningWaveSpawned	= "Oleada %d: %s empezó",
	WarningRiderDown	= "Jinete muerto",
	WarningKnightDown	= "Caballero muerto",
	WarningPhase2		= "Fase 2"
})

L:SetMiscLocalization({
	yell			= "Foolishly you have sought your own demise.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s y %d %s",
	WarningWave3	= "%d %s, %d %s y %d %s",
	Trainee			= "Alumnos",
	Knight			= "Caballeros",
	Rider			= "Jinetes",
--	Trainee			= "|4Trainee:Trainees;",
--	Knight			= "|4Knight:Knights;",
--	Rider			= "|4Rider:Riders;",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Los Cuatro Jinetes"
})

L:SetOptionLocalization({
	TimerMark					= "Mostrar tiempo de Marcas",
	WarningMarkSoon				= "Mostrar pre-aviso de Marcas",
	WarningMarkNow				= "Mostrar aviso de Marcas",
	SpecialWarningMarkOnPlayer	= "Mostrar aviso especial si llevas 4 marcas"
})

L:SetTimerLocalization({
	TimerMark = "Marca %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Marca %d en 3 seg",
	WarningMarkNow				= "Marca %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz	= "Señor feudal Korth'azz",
	Rivendare	= "Barón Osahendido",
	Blaumeux	= "Lady Blaumeux",
	Zeliek		= "Sir Zeliek",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "Mostrar aviso de Draenaje de Vida",
	WarningDrainLifeSoon	= "Mostrar pre-aviso de Draenaje de Vida",
	WarningAirPhaseSoon		= "Mostrar pre-aviso de Fase en el Aire",
	WarningAirPhaseNow		= "Mostrar aviso de Fase en el Aire",
	WarningLanded			= "Mostrar aviso de Fase en el Suelo",
	TimerDrainLifeCD		= "Mostrar tiempo para Draenaje de Vida",
	TimerAir				= "Mostrar tiempo para Fase en el Aire",
	TimerLanding			= "Mostrar tiempo para Fase en el Suelo",
	TimerIceBlast			= "Mostrar tiempo para Respira Hondo",
	WarningDeepBreath		= "Mostrar aviso especial para Respira Hondo"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s respira hondo.",
	WarningYellIceblock	= "¡Soy bloque de hielo!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Draenaje de Vida!",
	WarningDrainLifeSoon	= "Draenaje de Vida pronto",
	WarningAirPhaseSoon		= "Fase Aerea en 10 seg",
	WarningAirPhaseNow		= "Fase Aerea",
	WarningLanded			= "Sapphiron aterrizo",
	WarningDeepBreath		= "Respira hondo!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Draenaje de Vida CD",
	TimerAir				= "Fase Aerea",
	TimerLanding			= "Aterriza en",
	TimerIceBlast			= "Respira Hondo"	
})

------------------
--  Kel'thuzad  --
------------------


L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	TimerPhase2			= "Mostrar tiempo para Fase 2",
	WarningBlastTargets	= "Mostrar aviso para Explosión de Escarcha",
	WarningPhase2		= "Mostrar aviso para Fase 2",
	WarningFissure		= "Mostrar aviso para Fisura de las Sombras",
	WarningMana			= "Mostrar aviso para Detonar Mana",
	WarningChainsTargets= "Mostrar aviso para Cadenas de Kel'Thuzad"
})

L:SetMiscLocalization({
	Yell = "¡Esbirros, sirvientes, soldados de la fría oscuridad! ¡Obedeced la llamada de Kel'Thuzad!"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "Explosión de Escarcha: >%s<",
	WarningPhase2		= "Fase 2",
	WarningFissure		= "Fisura de las Sombras",
	WarningMana			= "Detonar Mana: >%s<",
	WarningChainsTargets= "Cadenas de Kel'Thuzad: >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "Fase 2"
})



