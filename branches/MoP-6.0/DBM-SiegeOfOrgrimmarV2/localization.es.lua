if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "¡Ah, lo habéis logrado! Las aguas vuelven a ser puras."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	warnCalamity		= "%s",
	specWarnCalamity	= "%s",
	specWarnMeasures	= "¡Medidas desesperadas pronto (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "Muy bien, crearé un campo para mantener aislada vuestra corrupción."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Mostrar icono en fragmento corrupto"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "Torre abierta",
	warnTowerGrunt		= "Adds defendiendo la torre"
})

L:SetTimerLocalization({
	timerTowerCD		= "Siguiente torre",
	timerTowerGruntCD	= "Siguientes adds defendiendo la torre"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Anunciar cuando se abre una torre",
	warnTowerGrunt		= "Anunciar cuando aparecen nuevos adds defendiendo la torre",
	timerTowerCD		= "Mostrar temporizador para el siguiente asalto a la torre",
	timerTowerGruntCD	= "Mostrar temporizador para los siguientes adds defendiendo la torre"
})

L:SetMiscLocalization({
	wasteOfTime		= "¡Bien hecho! ¡Grupos de desembarco, formad! ¡Infantería, al frente!",--Alliance Version
	wasteOfTime2	= "Well done. The first brigade has made landfall.",--Horde Version, TODO needs translation
	Pull		= "Clan Faucedraco, ¡recuperad los muelles y empujadlos al mar! ¡Por Grito Infernal! ¡Por la Horda auténtica!",
	newForces1	= "¡Ya vienen!",--Jaina's line, alliance
	newForces1H	= "Bring her down quick so i can wrap my fingers around her neck.",--Sylva's line, horde, TODO needs translation
	newForces2	= "¡Faucedraco, avanzad!",
	newForces3	= "¡Por Grito Infernal!",
	newForces4	= "¡Siguiente escuadrón, adelante!",
	tower		= "¡La puerta de la torre"--The door barring the South/North Tower has been breached!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Prisión en %s se desvanece (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Actitud defensiva en %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Mostrar cuenta atrás de pre-aviso para $spell:143593 (5s antes)"
})

L:SetMiscLocalization({
	newForces1					= "¡Guerreros, paso ligero!",
	newForces2					= "¡Defended la puerta",
	newForces3					= "¡Reunid a las tropas!",
	newForces4					= "¡Kor'kron, conmigo!",
	newForces5					= "¡Siguiente escuadrón, al frente!",
	allForces					= "Atención, Korkron: ¡matadlos!",
	nextAdds					= "Siguientes Adds: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "¿Estamos grabando? ¿Sí? Vale. Iniciando módulo de control goblin-titán. Atrás.",
	Module1			= "El módulo 1 está listo para el reinicio del sistema.",
	Victory			= "El módulo 2 está listo para el reinicio del sistema."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Mostrar radar de rango dinámico (10)<br/>(Se muestra cuando llegas a umbral de Frenesí)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "La cadena de montaje empieza a sacar armas sin terminar.",
	newShredder	= "¡Una trituradora automática se acerca!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Eres vulnerable a %s - ¡Evítalo!",
	specWarnMoreParasites			= "Hacen falta más parásitos - ¡NO mitigues actívamente!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Mostrar aviso especial cuando eres vulnerable a un Dechado",
	specWarnMoreParasites			= "Mostrar aviso especial cuando se necesiten más parásitos"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "One", --TODO need translation
	two					= "Two", --TODO need translation
	three				= "Three", --TODO need translation
	four				= "Four", --TODO need translation
	five				= "Five", --TODO need translation
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510  --TODO need translation
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109  --TODO need translation
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216  --TODO need translation
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024  --TODO need translation
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808  --TODO need translation
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232  --TODO need translation
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232  --TODO need translation
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305  --TODO need translation
	KarozFlavor			= "You won't be leaping anymore!",---Does not have quest, http://ptr.wowhead.com/npc=65303  --TODO need translation
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178  --TODO need translation
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508  --TODO need translation
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar radar dinámico de rango (8)<br/>(Muestra cuando alcanzas el umbral de $spell:147126)",
	InfoFrame			= "Mostrar cuadro de información para personajes sin reducción de daño durante las interfases",
	yellMaliceFading	= "Gritar cuando $spell:147209 esté apunto de disiparse"
})

L:SetMiscLocalization({
	NoReduce			= "Sin reducción de daño",
	MaliceFadeYell		= "Malicia disipándose en %s (%d)"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Entre-Jefes del Asedio de Orgrimmar"
})
