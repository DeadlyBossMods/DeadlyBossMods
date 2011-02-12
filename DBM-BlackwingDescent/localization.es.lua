if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Faucemagma"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Ensamblaje osario llameante pronto (~4s)",
	WarnPhase2Soon	= "Fase 2 pronto"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "¡%s cae hacia delante y deja expuestas sus tenazas!",
	HeadExposed		= "¡%s acaba empalado en el pincho y deja expuesta la cabeza!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."--translate
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Mostrar pre-aviso especial para $spell:92190 (~4s)",
	WarnPhase2Soon	= "Mostrar pre-aviso para Fase 2",
	RangeFrame		= "Mostrar distancia en Fase 2 (5 yardas)"

})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Sistema de defensa de Omnotron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Retorno Arcano",
	timerShadowConductorCast	= "Conductor de las Sombras"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Mostrar tiempo para lanzamiento de $spell:92053",
	timerArcaneBlowbackCast	= "Mostrar tiempo para lanzamiento de $spell:91879",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "Fase %s",
	WarnRemainingAdds	= "%d aberraciones restantes"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase"
})

L:SetMiscLocalization({
	YellRed			= "rojo|r a la caldera!",
	YellBlue		= "azul|r a la caldera!",
	YellGreen		= "verde|r a la caldera!",
	YellDark		= "oscuro|r a la caldera!",--translate
	Red				= "Rojo",
	Blue			= "Azul",
	Green			= "Verde",
	Dark			= "Oscuro"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar aviso de la fase que viene",
	WarnRemainingAdds	= "Mostrar un aviso con las aberraciones restantes",
	TimerPhase		= "Mostrar tiempo para la siguiente fase",	
	RangeFrame		= "Mostrar distancia (6 yardas) durante la fase azul",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})


-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Fase 2 pronto",
	WarnBreak	= "%s en >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	HealthInfo	= "Información de vida"
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Mostrar un preaviso para la fase 2",
	RangeFrame		= "Mostrar distancia (6 yardas)",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame	= "Mostrar información sobre la vida (<10k vida)"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Fase aerea",
	WarnGroundphase		= "Fase en tierra",
	WarnShieldsLeft		= "Antiguo escudo enano usado - %d restantes"
})

L:SetTimerLocalization({
	TimerAirphase		= "Fase aerea",
	TimerGroundphase	= "Fase en tierra"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Antiguo escudo enano",
	Soundlevel				= "Nivel de sonido",
	Airphase		= "¡Sí, corred! Con cada paso, vuestros corazones se aceleran. El latido, fuerte y clamoroso... Casi ensordecedor. ¡No podéis escapar!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Mostrar aviso cuando Atramedes levanta el vuelo",
	WarnGroundphase		= "Mostrar aviso cuando Atramedes aterriza",
	WarnShieldsLeft		= "Mostrar aviso cuando Antiguo escudo enano sea usado",
	TimerAirphase		= "Mostrar tiempo para siguiente Fase aerea",
	TimerGroundphase	= "Mostrar tiempo para siguiente Fase en tierra",
	InfoFrame			= "Mostrar información de los niveles de sonido",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Latigazo de cola (Onyxia)",
	NefTailSwipe		= "Latigazo de cola (Nefarian)",
	OnyBreath			= "Aliento (Onyxia)",
	NefBreath			= "Aliento (Nefarian)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Latigazo de cola CD (Ony)",
	NefSwipeTimer		= "Latigazo de cola CD (Nef)",
	OnyBreathTimer		= "Aliento CD (Ony)",
	NefBreathTimer		= "Aliento CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Mostrar aviso para el $spell:77827 de Onyxia",
	NefTailSwipe		= "Mostrar aviso para el $spell:77827 de Nefarian",
	OnyBreath			= "Mostrar aviso para el $spell:94124 de Onyxia",
	NefBreath			= "Mostrar aviso para el $spell:94124 de Nefarian",
	OnySwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Onyxia",
	NefSwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Nefarian",
	OnyBreathTimer		= "Mostrar tiempo de cooldown de $spell:94124 de Onyxia",
	NefBreathTimer		= "Mostrar tiempo de cooldown de $spell:94124 de Nefarian",
	YellOnCinder		= "Gritar cuando tengas $spell:79339",
	RangeFrame			= "Mostrar distancia (10 yardas) cuando tengas $spell:79339",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe				= "¡El aire crepita cargado de electricidad!",
	YellPhase2		= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",--translate
	YellPhase3			= "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",--translate
	YellCinder			= "Explosive Cinders on me!"--translate
})