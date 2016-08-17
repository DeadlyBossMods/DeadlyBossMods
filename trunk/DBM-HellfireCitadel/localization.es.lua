if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------------------
-- Asalto a Fuego Infernal --
-----------------------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "Siguiente vehículo: %s",
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"Mostrar temporizador para el siguiente vehículo"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"¡Paso, que voy ardiendo!",--Blizzard seems to have disabled these
	AddsSpawn2		=	"¡Bomba va!",--Blizzard seems to have disabled these
	BossLeaving		=	"Volveré..."
})

-------------------------------------
-- Atracador de la Horda de Hierro --
-------------------------------------
L= DBM:GetModLocalization(1425)

------------------------------------
-- Alto Consejo de Fuego Infernal --
------------------------------------
L= DBM:GetModLocalization(1432)

L:SetWarningLocalization({
	reapDelayed =	"Segar tras Rostro de pesadilla"
})

L:SetOptionLocalization({
	reapDelayed =	DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon:format(184476)
})

-------------
-- Kormrok --
-------------
L= DBM:GetModLocalization(1392)

L:SetMiscLocalization({
	ExRTNotice		= "%s está compartiendo su configuración de posiciones de Exorsus Raid Tools. Tus posiciones son: Naranja: %s, Verde: %s, Púrpura: %s."
})

---------------------
-- Kilrogg Mortojo --
---------------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon		=	"¡Hermanos, cumplid vuestro destino!"
})

--------------
-- Sanguino --
--------------
L= DBM:GetModLocalization(1372)

L:SetTimerLocalization({
	SoDDPS2		= "Siguiente Sombra (%s)",
	SoDTank2	= "Siguiente Sombra (%s)",
	SoDHealer2	= "Siguiente Sombra (%s)"
})

L:SetOptionLocalization({
	SoDDPS2			= "Mostrar temporizador para la siguiente $spell:179864 que afecte a los DPS",
	SoDTank2		= "Mostrar temporizador para la siguiente $spell:179864 que afecte a los tanques",
	SoDHealer2		= "Mostrar temporizador para la siguiente $spell:179864 que afecte a los sanadores",
	ShowOnlyPlayer	= "Mostrar indicadores en pantalla para $spell:179909 solo si eres uno de los jugadores afectados"
})

--------------------------------
-- Señor de las Sombras Iskar --
--------------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"¡Pasa el Ojo de Anzu a %s!"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"Mostrar aviso especial cuando debas pasar el $spell:179202"
})

----------------------
-- Señor vil Zakuun --
----------------------
L= DBM:GetModLocalization(1391)

L:SetOptionLocalization({
	SeedsBehavior		= "Patrón de gritos de la banda (requiere líder)",
	Iconed				= "Estrella, Círculo, Diamante, Triángulo, Luna. Para marcadores del mundo.",--Default
	Numbered			= "1, 2, 3, 4, 5. Para posiciones numeradas.",
	DirectionLine		= "Izquierda, Medio izquierda, Medio, Medio derecha, Derecha. Para uso general.",
	FreeForAll			= "Libre. No asigna ninguna posición, pero avisa por gritos."
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Configuración de semillas establecida a %s para que coincida con la del líder de banda.",
	BWConfigMsg			= "El líder de banda está usando BigWigs. Configuración establecida automáticamente a 'numerada'."
})

----------------
-- Xhul'horac --
----------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "Patrón de avisos de cadenas. El temporizador se ajustará en función del patrón.",
	Cast				= "Solo al objetivo original cuando se inicie el lanzamiento",
	Applied				= "Solo a los objetivos afectados al terminar el lanzamiento",
	Both				= "Objetivo original al iniciarse el lanzamiento, y resto de objetivos cuando termine"
})

-------------------------
-- Socrethar el Eterno --
-------------------------
L= DBM:GetModLocalization(1427)

L:SetOptionLocalization({
	InterruptBehavior	= "Patrón de interrupciones de la banda (requiere líder)",
	Count3Resume		= "Rotación de 3 jugadores que se mantiene cuando desaparece la barrera",--Default
	Count3Reset			= "Rotación de 3 jugadores que se reinicia cuando desaparece la barrera",
	Count4Resume		= "Rotación de 4 jugadores que se mantiene cuando desaparece la barrera",
	Count4Reset			= "Rotación de 4 jugadores que se reinicia cuando desaparece la barrera"
})

--------------------
-- Tirana Velhari --
--------------------
L= DBM:GetModLocalization(1394)

---------------
-- Mannoroth --
---------------
L= DBM:GetModLocalization(1395)

L:SetOptionLocalization({
	CustomAssignWrath	= "Poner iconos de $spell:186348 según el rol de los jugadores (requiere líder; puede causar conflictos con BigWigs o versiones antiguas de DBM)"
})

L:SetMiscLocalization({
	felSpire		=	"comienza a potenciar la cumbre vil!"
})

----------------
-- Archimonde --
----------------
L= DBM:GetModLocalization(1438)

L:SetWarningLocalization({
	specWarnBreakShackle	= "Tormento encadenado - ¡Rompe el %s!"
})

L:SetOptionLocalization({
	specWarnBreakShackle	= "Mostrar aviso especial cuando te afecte $spell:184964. Este aviso asigna un orden para minimizar el daño sufrido.",
	ExtendWroughtHud3		= "Extender las líneas del indicador de $spell:185014 más allá del objetivo (puede reducir la precisión de la línea)",
	AlternateHudLine		= "Usar textura alternativa para las líneas del indicador en pantalla de $spell:185014",
	NamesWroughtHud			= "Mostrar nombres de jugadores en el indicador en pantalla de $spell:185014",
	FilterOtherPhase		= "Ocultar avisos de eventos que no ocurran en tu fase actual",
	MarkBehavior			= "Patrón de gritos de la banda para Marca de la Legión (requiere líder)",
	Numbered				= "Estrella, Círculo, Diamante, Triángulo. Para marcadores del mundo.",--Default
	LocSmallFront			= "Melé (Estrella/Círculo), Distancia (Diamante/Triángulo). Perj. cortos a melé.",
	LocSmallBack			= "Melé (Estrella/Círculo), Distancia (Diamante/Triángulo). Perj. cortos a distancia.",
	NoAssignment			= "Deshabilitar todos los avisos e indicadores para toda la banda.",
	overrideMarkOfLegion	= "Impedir que el líder de banda cambie tu patrón de Marca de la Legión (solo para expertos seguros de que su configuración no entrará en conflicto con la del líder)"
})

L:SetMiscLocalization({
	phase2point5		= "Contemplad las tropas de la Legión Ardiente y asumid lo fútil que es vuestra resistencia.",--3 seconds faster than CLEU, used as primary, slower CLEU secondary
	First				= "primero",
	Second				= "segundo",
	Third				= "tercero",
	Fourth				= "cuarto",--Just in case, not sure how many targets in 30 man raid
	Fifth				= "quinto"--Just in case, not sure how many targets in 30 man raid
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
