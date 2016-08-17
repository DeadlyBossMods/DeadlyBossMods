if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

----------------------------------
--  Invasiones de la ciudadela  --
----------------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Invasiones de la ciudadela"
})

L:SetWarningLocalization({
	specWarnRylak	= "Rylak",
	specWarnWorker	= "Trabajador aterrorizado",
	specWarnSpy		= "Espía",
	specWarnBuilding= "Están atacando un edificio"
})

L:SetOptionLocalization({
	specWarnRylak	= "Mostrar aviso especial cuando se aproxime un rylak",
	specWarnWorker	= "Mostrar aviso especial cuando haya un obrero aterrorizado al descubierto",
	specWarnSpy		= "Mostrar aviso especial cuando entre un espía",
	specWarnBuilding= "Mostrar aviso especial cuando estén atacando un edificio"
})

L:SetMiscLocalization({
	--General
	preCombat			= "¡A las armas! ¡A vuestros puestos!",--Common in all yells, rest varies based on invasion
	preCombat2			= "Hay un hedor que inunda el aire. Demonios...",--Shadow Council doesn't follow format of others :\
	rylakSpawn			= "¡El fragor de la batalla atrae a un rylak!",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "¡Un trabajador aterrorizado se ha quedado al descubierto!",
	sneakySpy			= "ha aprovechado el caos para entrar!",--Shortened to cut out "horde/alliance"
	buildingAttack		= "¡Están atacando un edificio!",--Your Salvage Yard is under attack!
	--Ogre
	GorianwarCaller		= "¡Un clamaguerras goriano se une a la batalla para subir la moral!",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "¡Están invocando a un elemental de fuego salvaje en la puerta principal!",--Maybe combined "add" special warning most adds?
	--Iron Horde
	Assassin			= "¡Un asesino está dando caza a tus guardias!"--Maybe combined "add" special warning most adds?
})

-----------------
--  Aniquilón  --
-----------------
L = DBM:GetModLocalization("Annihilon")

L:SetGeneralLocalization({
	name = "Aniquilón"
})

--------------
--  Teluur  --
--------------
L = DBM:GetModLocalization("Teluur")

L:SetGeneralLocalization({
	name = "Teluur"
})

----------------------
--  Lady Ajadermis  --
----------------------
L = DBM:GetModLocalization("LadyFleshsear")

L:SetGeneralLocalization({
	name = "Lady Ajadermis"
})

--------------------------
--  Comandante Dro'gan  --
--------------------------
L = DBM:GetModLocalization("Drogan")

L:SetGeneralLocalization({
	name = "Comandante Dro'gan"
})

--------------------------------------
--  Señor de los magos Gogg'nathog  --
--------------------------------------
L = DBM:GetModLocalization("Goggnathog")

L:SetGeneralLocalization({
	name = "Señor de los magos Gogg'nathog"
})

------------
--  Gaur  --
------------
L = DBM:GetModLocalization("Gaur")

L:SetGeneralLocalization({
	name = "Gaur"
})
