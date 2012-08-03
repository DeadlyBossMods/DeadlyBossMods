if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetWarningLocalization({
	SpecWarnActivated			= "Cambia el objetivo a %s!",
	specWarnGenerator			= "¡Generador de poder! ¡Mueve a %s!"
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "Conductor de las Sombras",
	timerArcaneLockout			= "Aniquilador Silenciado",
	timerArcaneBlowbackCast		= "Retorno Arcano",
	timerNefAblity				= "CD de Bufo de Habilidad"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Mostrar tiempo para lanzamiento de $spell:92053",
	timerArcaneLockout			= "Mostrar tiempo de silenciamiento de hechizo de $spell:79710",
	timerArcaneBlowbackCast		= "Mostrar tiempo para lanzamiento de $spell:91879",
	timerNefAblity				= "Mostrar tiempo de CoolDown de las habilidades de bufos en heroico",
	SpecWarnActivated			= "Mostrar aviso especial cuando se activa un nuevo boss",
	specWarnGenerator			= "Mostrar aviso especial cuando un boss gana $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Poner un icono en el último boss activado"
})

L:SetMiscLocalization({
	YellTargetLock		= "¡Sombras atrapantes! ¡Apartaos de mi!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "Ensamblaje osario llameante pronto (~4s)",
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Mostrar pre-aviso especial para $spell:92154 (~4s)",
	RangeFrame		= "Mostrar distancia en Fase 2 (5 yardas)"
})

L:SetMiscLocalization({
	Slump			= "¡%s cae hacia delante y deja expuestas sus tenazas!",
	HeadExposed		= "¡%s acaba empalado en el pincho y deja expuesta la cabeza!",
	YellPhase2		= "¡Inconcebible! ¡Existe la posibilidad de que venzáis a mi gusano de lava! Quizás yo pueda... desequilibrar la balanza."
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetOptionLocalization({
	InfoFrame			= "Mostrar información de los niveles de sonido",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	NefAdd					= "¡Atramedes, los héroes están justo AHÍ!",
	Airphase		= "¡Sí, corred! Con cada paso, vuestros corazones se aceleran. El latido, fuerte y clamoroso... Casi ensordecedor. ¡No podéis escapar!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	RangeFrame		= "Mostrar distancia (6 yardas)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame	= "Mostrar información sobre la vida (<10k vida)"
})

L:SetMiscLocalization({
	HealthInfo	= "Información de vida"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase		= "Fase %s"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar aviso de la fase que viene",
	TimerPhase		= "Mostrar tiempo para la siguiente fase",	
	RangeFrame		= "Mostrar distancia (6 yardas) durante la fase azul",
	SetTextures			= "Desactivar las texturas proyectadas automáticamente en fase oscura\n(se reactivan al cambiar de fase)",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77699),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed			= "rojo|r a la caldera!",
	YellBlue		= "azul|r a la caldera!",
	YellGreen		= "verde|r a la caldera!",
	YellDark		= "oscura|r en el caldero!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	OnyTailSwipe		= "Latigazo de cola (Onyxia)",
	NefTailSwipe		= "Latigazo de cola (Nefarian)",
	OnyBreath			= "Aliento (Onyxia)",
	NefBreath			= "Aliento (Nefarian)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding		= "Nefarian aterriza",
	OnySwipeTimer		= "Latigazo de cola CD (Ony)",
	NefSwipeTimer		= "Latigazo de cola CD (Nef)",
	OnyBreathTimer		= "Aliento CD (Ony)",
	NefBreathTimer		= "Aliento CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Mostrar aviso para el $spell:77827 de Onyxia",
	NefTailSwipe		= "Mostrar aviso para el $spell:77827 de Nefarian",
	OnyBreath			= "Mostrar aviso para el $spell:77826 de Onyxia",
	NefBreath			= "Mostrar aviso para el $spell:77826 de Nefarian",	
	specWarnCinderMove		= "Mostrar aviso especial para moverte si te afecta\n $spell:79339 (5s antes de la explosión)",	
	warnShadowblazeSoon		= "Mostrar pre-aviso de cuenta atrás para $spell:81031 (5s before)\n(Solo después que el contador se haya sincronizado para asegurar precisión)",
	specWarnShadowblazeSoon	= "Mostrar pre-aviso especial para $spell:81031 (~5s)",
	timerNefLanding		= "Mostrar tiempo para que Nefarian aterrice",
	OnySwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Onyxia",
	NefSwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Nefarian",
	OnyBreathTimer		= "Mostrar tiempo de cooldown de $spell:77826 de Onyxia",
	NefBreathTimer		= "Mostrar tiempo de cooldown de $spell:77826 de Nefarian",
	InfoFrame			= "Mostrar información sobre la carga eléctrica de Onyxia",
	SetWater			= "Desactivar la colisión con el agua automáticamente al pullear\n(se reactiva al abandonar el combate)",
	TankArrow			= "Mostrar flecha para el kiteador de Guerrero Hueso animado\n(diseñado para estrategia de kiteo)",--npc 41918
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame			= "Mostrar distancia (10 yardas) cuando tengas $spell:79339"
})

L:SetMiscLocalization({
	NefAoe			= "¡El aire crepita cargado de electricidad!",
	YellPhase2		= "¡Os maldigo, mortales! ¡Ese cruel menosprecio por las posesiones de uno debe ser castigado con fuerza extrema!",
	YellPhase3		= "He intentado ser un buen anfitrión, pero ¡no morís! Es hora de dejarnos de tonterías y simplemente... ¡MATAROS A TODOS!",
	YellShadowBlaze	= "¡Mirad cómo la llama de las sombras da vida a sus huesos! ¡Luchan a mis órdenes!",
	ShadowBlazeExact	= "hispa de Fuegoarbusto en %ds",
	ShadowBlazeEstimate	= "Llamarada de las Sombras pronto (~5s)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Pulls de Descenso de Alanegra"
})