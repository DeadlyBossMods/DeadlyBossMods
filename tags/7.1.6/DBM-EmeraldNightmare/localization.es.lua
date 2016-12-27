if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Nythendra --
---------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-----------------------------------------
-- Il'gynoth, Corazón de la Corrupción --
-----------------------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	InfoFrameBehavior	= "Información mostrada por el marco de información",
	Fixates				= "Jugadores afectados por Fijar",
	Adds				= "Cantidad de esbirros de cada tipo"
})

-----------------------
-- Elerethe Renferal --
-----------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain		= ">%s< vinculado a >%s<",
	specWarnWebofPain	= "Estás vinculado a >%s<"
})

L:SetOptionLocalization({
	WebConfiguration	= "Opciones del indicador en pantalla y flecha de Telaraña de dolor",
	Disabled			= "Deshabilitar",
	Arrow				= "Mostrar solo flecha tradicional si estás afectado",
	HudSelf				= "Mostrar línea indicadora solo si estás afectado",
	HudAll				= "Mostrar líneas indicadoras de todos los objetivos afectados"
})

L:SetMiscLocalization({
	MapMessage			= "Atención: este módulo hace uso de flechas e indicadores en pantalla, características que desaparecerán en el parche 7.1."
})

-----------
-- Ursoc --
-----------
L= DBM:GetModLocalization(1667)

L:SetOptionLocalization({
	NoAutoSoaking2		= "Deshabilitar todos los avisos, flechas e indicadores en pantalla para $spell:198006"
})

L:SetMiscLocalization({
	SoakersText		=	"Interceptores asignados: %s"
})

------------------------------
-- Dragones de la Pesadilla --
------------------------------
L= DBM:GetModLocalization(1704)

--------------
-- Cenarius --
--------------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleYell			= "¡Zarzas cerca de " .. UnitName("player") .. "!",
	BrambleMessage		= "Atención: DBM no puede detectar quién es el objetivo de las zarzas. Sin embargo, avisa del jugador en cuya posición comenzarán a aparecer las zarzas. Cenarius escoge a un jugador, crea zarzas a sus pies y entonces siguen a otro jugador distinto que no se puede identificar mediante addons."
})

------------
-- Xavius --
------------
L= DBM:GetModLocalization(1726)

L:SetOptionLocalization({
	InfoFrameFilterDream	= "Excluir jugadores afectados por $spell:206005 del marco de información"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
