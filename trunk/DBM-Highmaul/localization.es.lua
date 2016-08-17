if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Kargath Garrafilada --
-------------------------
L= DBM:GetModLocalization(1128)

L:SetTimerLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_TEXTS.next:format((GetSpellInfo(177776)))
})

L:SetOptionLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_OPTIONS.next:format(177776),
	countdownSweeper		= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(177776)
})

------------------
-- El Carnicero --
------------------
L= DBM:GetModLocalization(971)

------------
-- Tectus --
------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "¡ALZAOS, MONTAÑAS!"
})

------------------
-- Frondaespora --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "Patrón de reinicio del contador de Descomposición",
	Two					= "Cada dos lanzamientos",
	Three				= "Cada tres lanzamientos",
	Four				= "Cada cuatro lanzamientos"
})

---------------------
-- Gemelos ogrones --
---------------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Reproducir sonido de cuenta atrás para los tiempos de reutilización de Femos",
	PolSpecial		= "Reproducir sonido de cuenta atrás para los tiempos de reutilización de Pol",
	PhemosSpecialVoice	= "Reproducir alertas de voz del paquete de voces seleccionado para las facultades de Femos",
	PolSpecialVoice		= "Reproducir alertas de voz del paquete de voces seleccionado para las facultades de Pol"
})

-------------
-- Ko'ragh --
-------------
L= DBM:GetModLocalization(1153)


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "Expulsar magia: Vil expirando en 5 s - ¡vuelve a tu posición inicial!"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "Mostrar aviso especial para volver al punto de inicio cuando $spell:172895 esté a punto de expirar"
})

L:SetMiscLocalization({
	supressionTarget1	= "¡Os aplastaré!",
	supressionTarget2	= "¡Silencio!",
	supressionTarget3	= "¡Callad!",
	supressionTarget4	= "¡Os partiré en dos!"
})

-----------------------
-- Imperador Mar'gok --
-----------------------
L= DBM:GetModLocalization(1197)

L:SetTimerLocalization({
	timerNightTwistedCD		= "Siguientes fieles"
})

L:SetOptionLocalization({
	GazeYellType		= "Gritos para Mirada del abismo",
	Countdown			= "Cuenta atrás hasta que expire",
	Stacks				= "Con cada acumulación",
	timerNightTwistedCD	= "Mostrar temporizador para los siguientes Fieles alterados por las sombras",
})

L:SetMiscLocalization({
	BrandedYell			= "Marca (%d) %d m",
	GazeYell			= "Mirada expirando en %d",
	GazeYell2			= "Mirada (%d) en %s",
	PlayerDebuffs		= "Más cercano para Visión"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
