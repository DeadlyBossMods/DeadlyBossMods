if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Rompemundos garothi --
-------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------------
-- Canes manáfagos de Sargeras --
---------------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Secuenciar los temporizadores en función al último lanzamiento de cada habilidad en lugar del siguiente para reducir el desajuste de temporizadores a cambio de una leve pérdida de precisión (uno o dos segundos de margen de error)"
})

------------------------
-- Alto Mando antoran --
------------------------
L= DBM:GetModLocalization(1997)

----------------------------------
-- Eonar, la Patrona de la Vida --
----------------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"Ofuscador (%s)",
	timerDestructor 	=	"Destructor (%s)",
	timerPurifier 		=	"Purificador (%s)",
	timerBats	 		=	"Murciélagos (%s)"
})

L:SetOptionLocalization({
	timerObfuscator		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
	Obfuscators =	"Ofuscador",
	Destructors =	"Destructor",
	Purifiers 	=	"Purificador",
	Bats 		=	"Murciélagos",
	EonarHealth	= 	"Salud de Eonar",
	EonarPower	= 	"Energía de Eonar",
	NextLoc		=	"Siguiente:"
})

---------------------------------
-- Vigilante de portal Hasabel --
---------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Mostrar todos los avisos independientemente de tu plataforma actual"
})

--Xoroth = "¡Admirad Xoroth, un mundo de calor infernal y huesos calcinados!",
--Rancora = "¡Contemplad Rancora, un horizonte de pozas infectas y muerte por doquier!",
--Nathreza = "Nathreza... Antaño un mundo de magia y conocimiento, ahora un escabroso lugar del que nadie puede escapar."

--------------------------------
-- Imonar el Cazador de Almas --
--------------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe =		"¡Disipadme!"
})

----------------
-- Kin'garoth --
----------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Mostrar marco de información con una vista general del combate",
	UseAddTime = "Mostrar temporizadores de la fase de despligue durante la fase de construcción"
})

-----------------
-- Varimathras --
-----------------
L= DBM:GetModLocalization(1983)

------------------------
-- Aquelarre shivarra --
------------------------
L= DBM:GetModLocalization(1986)

L:SetOptionLocalization({
	SetLighting				= "Bajar automáticamente la calidad de iluminación a bajo al iniciar el combate (se restaurará a su configuración anterior al terminar el combate; no funciona en Mac)"
})

L:SetTimerLocalization({
	timerBossIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerBossIncoming	= "Mostrar temporizador para el siguiente cambio de jefe",
	TauntBehavior		= "Patrón de avisos para el cambio de tanque",
	TwoMythicThreeNon	= "Cambiar a dos acumulaciones en mítico, tres en otras dificultades",--Default
	TwoAlways			= "Cambiar a dos acumulaciones en todas las dificultades",
	ThreeAlways			= "Cambiar a tres acumulaciones en todas las dificultades"
})

--------------
-- Aggramar --
--------------
L= DBM:GetModLocalization(1984)

L:SetMiscLocalization({
	Foe			=	"Doma",
	Rend		=	"Desgarro",
	Tempest 	=	"Tempestad",
	Current		=	"Actual:"
})

--------------------------
-- Argus el Aniquilador --
--------------------------
L= DBM:GetModLocalization(2031)

L:SetMiscLocalization({
	SeaText =		"{rt6} Celeridad/Versatilidad",
	SkyText =		"{rt5} Crítico/Maestría"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
