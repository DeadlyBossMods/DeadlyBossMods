if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

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
	WarningLocustFaded	= "Enjambre de Langostas desapareció"
})

L:SetOptionLocalization({
	SpecialLocust		= "Mostrar aviso especial para Enjambre de Langostas",
	WarningLocustFaded	= "Mostrar aviso para cunado Enjambre de Langostas desaparece",
	ArachnophobiaTimer	= "Mostrar tiempo para Aracnofobia (logro)"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobia"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Gran Viuda Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Abrazo de la viuda temina en 5 seg",
	WarningEmbraceExpired	= "Abrazo de la viuda ha terminado"
})

L:SetOptionLocalization({
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
	WarningSpidersSoon	= "Arañas en 5 seg",
	WarningSpidersNow	= "Las arañas salieron!"
})

L:SetTimerLocalization({
	TimerSpider		= "Arañas"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Mostrar pre-aviso para las Arañas",
	WarningSpidersNow	= "Mostrar aviso para las Arañas",
	TimerSpider			= "Mostrar tiempo para las Arañas"
})

L:SetMiscLocalization({
	YellWebWrap			= "¡Estoy en capullo!¡Ayuda!",
	ArachnophobiaTimer	= "Aracnofobia"
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
	WarningTeleportSoon	= "Teletransporte en 20 seg"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teletransporte",
	TimerTeleportBack	= "Teletransporte vuelve"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Mostrar aviso cuando se Teletransporte",
	WarningTeleportSoon		= "Mostrar aviso antes de que se Teletransporte",
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
	TimerTeleport			= "Mostrar tiempo para Teletransporte"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningHealSoon		= "Curar en 3 segundos",
	WarningHealNow		= "¡Curar Ahora!"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Mostrar pre-aviso para \"Curar en 3 segudos\" ",
	WarningHealNow		= "Mostrar aviso para \"Curar Ahora\" ",
	SporeDamageAlert	= "Enviar susurros y avisar a la banda de los jugadores que estén dañando esporas\n (necesita 'anunciar' activado y lider/ayudante)"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Remendejo"
})

L:SetOptionLocalization({
	WarningHateful = "Avisar por chat de banda los Golpes de Odio (necesitas ser ayudante o lider para eso)"
})

L:SetMiscLocalization({
	yell1 = "¡Remendejo quiere jugar!",
	yell2 = "¡Remendejo es la encarnación de guerra de Kel'Thuzad!",
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
	SpecialWarningInjection	= "Mostrar aviso especial si te afecta Inyección mutante",
	SetIconOnInjectionTarget	= "Poner iconos en los objetivos de Inyección mutante"
})

L:SetWarningLocalization({
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

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell	= "¡Stalagg aplasta!",
	Emote	= "¡%s se sobrecarga!",
	Emote2	= "¡Espiral Tesla se sobrecarga!",
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "negativo",
	Charge2 = "positivo",
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Mostrar aviso especial si tu polaridad cambia",
	WarningChargeNotChanged	= "Mostrar avsio especial si tu polaridad no cambia",
	ArrowsEnabled			= "Mostrar flechas (estrategia normal \"2 campos\" )",
	ArrowsRightLeft			= "Mostrar flechas derecha/izquierda para la estrategia de  \"4 campos\" (mostrar flecha izquierda si te cambia la polaridad, derecha si no)",
	ArrowsInverse			= "Estrategia inversa \"4 campos\" (mostrar flecha derecha si cambia la polaridad, izquierda si no)"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Polaridad ha cambiado %s",
	WarningChargeNotChanged	= "Polaridad no ha cambiado"
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
	Yell1 = "¡No tengáis piedad!",
	Yell2 = "¡El tiempo de practivar ha pasado! ¡Quiero ver lo que habéis aprendido!",
	Yell3 = "Do as I taught you!",--translate
	Yell4 = "Sweep the leg... Do you have a problem with that?"--translate
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Mostrar aviso para Barrera de huesos"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Barrera de huesos expira en 5 seg"
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
	WarningKnightDown	= "Mostrar aviso cuando un Caballero muere"
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
	yell			= "Foolishly you have sought your own demise.",--translate
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s y %d %s",
	WarningWave3	= "%d %s, %d %s y %d %s",
	Trainee			= "Alumnos",
	Knight			= "Caballeros",
	Rider			= "Jinetes"
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Los Cuatro Jinetes"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Mostrar pre-aviso de Marcas",
	WarningMarkNow				= "Mostrar aviso de Marcas",
	SpecialWarningMarkOnPlayer	= "Mostrar aviso especial si llevas 4 marcas"
})

L:SetTimerLocalization({
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
	WarningAirPhaseSoon		= "Mostrar pre-aviso de Fase en el Aire",
	WarningAirPhaseNow		= "Mostrar aviso de Fase en el Aire",
	WarningLanded			= "Mostrar aviso de Fase en el Suelo",
	TimerAir				= "Mostrar tiempo para Fase en el Aire",
	TimerLanding			= "Mostrar tiempo para Fase en el Suelo",
	TimerIceBlast			= "Mostrar tiempo para Respira Hondo",
	WarningDeepBreath		= "Mostrar aviso especial para Respira Hondo",
	WarningIceblock			= "Gritar en Bloque de hielo"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s respira hondo.",
	WarningYellIceblock	= "¡Soy bloque de hielo!"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "Fase Aerea en 10 seg",
	WarningAirPhaseNow		= "Fase Aerea",
	WarningLanded			= "Sapphiron aterrizo",
	WarningDeepBreath		= "Respira hondo!",
})

L:SetTimerLocalization({
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
	specwarnP2Soon	= "Mostrar aviso especial 10 segundos antes de que Kel'Thuzad salga",
	warnAddsSoon	= "Mostrar pre-aviso para Guardianes de Corona de Hielo",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(28410),
	SetIconOnManaBomb	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(27819),
	SetIconOnFrostTomb	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(27808),
	ShowRange		= "Mostrar distancia cuando empieze la fase 2"
})

L:SetMiscLocalization({
	Yell = "¡Esbirros, sirvientes, soldados de la fría oscuridad! ¡Obedeced la llamada de Kel'Thuzad!"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Kel'Thuzad sale en 10 segundos",
	warnAddsSoon	= "Guardianes de Corona de Hielo vienen pronto"
})

L:SetTimerLocalization({
	TimerPhase2			= "Fase 2"
})



