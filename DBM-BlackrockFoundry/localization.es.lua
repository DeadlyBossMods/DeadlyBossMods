if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------
-- Gruul --
-----------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "Patrón de agrupamiento para Tajo infernal",
	ThreeGroup			= "3 grupos, 1 acumulación",
	TwoGroup			= "2 grupos, 2 acumulaciones" 
})

----------------
-- Tragamenas --
----------------
L= DBM:GetModLocalization(1202)

L:SetOptionLocalization({
	InterruptBehavior	= "Patrón de interrupciones para avisos especiales",
	Smart				= "Avisos en función del número de trombas",
	Fixed				= "Avisos siempre en secuencia de 5 ó 3 trombas (aunque no coincida con las usadas)"
})

---------------------------
-- El Horno de Fundición --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "Reguladores de calor restantes: %d",
	warnBlastFrequency		= "Frecuencia de Reventar aumentada: aprox. cada %d s",
	specWarnTwoVolatileFire	= "¡Doble Fuego volátil en ti!"
})

L:SetOptionLocalization({
	warnRegulators			= "Anunciar el número de reguladores de calor restantes",
	warnBlastFrequency		= "Anunciar cada vez que aumente la frecuencia de $spell:155209",
	specWarnTwoVolatileFire	= "Mostrar aviso especial cuando te afecten dos $spell:176121 a la vez",
	InfoFrame				= "Mostrar marco de información para $spell:155192 y $spell:155196",
	VFYellType2				= "Gritos para Fuego volátil (dificultad mítica)",
	Countdown				= "Cuenta atrás hasta que expire",
	Apply					= "Solo al aplicarse"
})

L:SetMiscLocalization({
	heatRegulator		= "Regulador de calor",
	Regulator			= "Regulador %d",--Can't use above, too long for infoframe
	bombNeeded			= "%d bomba(s)"
})

------------------------
-- Hans'gar y Franzok --
------------------------
L= DBM:GetModLocalization(1155)

L:SetTimerLocalization({
	timerStamperDodge			= DBM_CORE_AUTO_TIMER_TEXTS.nextcount:format((GetSpellInfo(160582)))
})

L:SetOptionLocalization({
	timerStamperDodge			= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format(160582)
})

--------------------------
-- Dominallamas Ka'graz --
--------------------------
L= DBM:GetModLocalization(1123)

-----------
--Kromog --
-----------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s está compartiendo su configuración de posiciones de Exorsus Raid Tools para las runas. Tu posición es: %s."
})

---------------------------------
-- Señor de las bestias Darmac --
---------------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operador Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "Separación de banda en 10 s"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "Mostrar aviso especial 10 s antes de la separación de banda",
	InfoFrameSpeed		= "Marco de información de trenes",
	Immediately			= "Mostrar en cuanto se abran las puertas",
	Delayed				= "Mostrar en cuanto se vaya el tren anterior",
	HudMapUseIcons		= "Usar iconos de banda para el indicador en pantalla en lugar de círculos verdes",
	TrainVoiceAnnounce	= "Alertas de voz para los trenes",
	LanesOnly			= "Solo anunciar vías",
	MovementsOnly		= "Solo anunciar movimientos (dificultad mítica)",
	LanesandMovements	= "Anunciar vías y movimientos (dificultad mítica)"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "Vía",
	oneTrain		= "1 vía aleatoria: Tren",
	oneRandom		= "en 1 vía aleatoria",
	threeTrains		= "3 vías aleatorias: Tren",
	threeRandom		= "en 3 vías aleatorias",
	helperMessage	= "Este encuentro se puede simplificar en gran medida con el addon 'Thogar Assist' o paquetes de voces de DBM diseñados para anunciar trenes, todos disponibles en Curse."
})

-----------------------------
-- Las Doncellas de Hierro --
-----------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "¡Volved a tierra!"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Mostrar aviso especial cuando los jugadores del barco puedan volver a salvo a tierra",
	filterBladeDash3	= "Ocultar aviso especial para $spell:155794 al estar afectado por $spell:170395",
	filterBloodRitual3	= "Ocultar aviso especial para $spell:158078 al estar afectado por $spell:170405"
})

L:SetMiscLocalization({
	shipMessage		= "se prepara para controlar el cañón principal de El Acorator!",
	EarlyBladeDash	= "Demasiado lentos."
})

----------------
-- Puño Negro --
----------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "Posición para marcado: %s",
	specWarnSlagPosition	= "Posición para bomba: %s"
})

L:SetOptionLocalization({
	PositionsAllPhases	= "Asignar posiciones para $spell:156096 mediante gritos en todas las fases (en lugar de solo en la fase 3)",
	InfoFrame			= "Mostrar marco de información para $spell:155992 y $spell:156530"
})

L:SetMiscLocalization({
	customMFDSay	= "Marcado %s en %s",
	customSlagSay	= "Bomba %s on %s"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
