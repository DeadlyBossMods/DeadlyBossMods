if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Machacahuesos Rom'ogg"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "Corla, Heraldo del Crepúsculo"
})

L:SetWarningLocalization({
	WarnAdd		= "Se ha liberado un add"
})

L:SetOptionLocalization({
	WarnAdd		= "Avisar cuando un add pierde el bufo de $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Karsh Doblacero"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "Armadura sobrecalentada (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Mostrar tiempo de duracion de $spell:75846"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "Bella"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "Ascendiente Lord Obsidius"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "Poner un icono en el boss después de $spell:76200"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "Glubtok"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "Helix Rompengranajes"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "Siegaenemigos 5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "Almirante Rasgagruñido"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"Capitán\" Cocinitas"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "Vanessa VanCleef"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Vigorosa venganza VanCleef"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name = "General Umbriss"
})

L:SetOptionLocalization{
	PingBlitz	= "Marcar en el minimapa cuando el General Umbriss vaya a atacarte con Ataque relámpago"
}

L:SetMiscLocalization{
	Blitz		= "fija la mirada |cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Maestro de forja Throngus"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Drahga Quemasombras"
})

L:SetMiscLocalization{
	ValionaYell	= "¡Dragón, harás lo que te ordeno! ¡Cógeme!",
	Add			= "%s Invoca un",
	Valiona		= "Valiona"	
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "Erudax"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "Guardian del templo Anhuur"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "Terracundo Ptah"
})

L:SetMiscLocalization{
	Kill		= "Se... acabó... Ptah..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Anraphet"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Velocidad de la luz"
})

L:SetMiscLocalization({
	Brann		= "¡Bien, vamos! Tan solo me falta introducir la secuencia final en el mecanismo de la puerta... y..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "Isiset"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "División pronto"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Mostrar pre aviso para división"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "Ammunae"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "Setesh"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "Rajh"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "General Husam"
})

------------------------------------
-- Siamat, Lord of the South Wind --
-------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Siamat"
})

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Fase 2 en 5 segundos"
}

L:SetTimerLocalization({
	timerPhase2 	= "Empieza la Fase 2"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Mostrar aviso epecial para fase 2 en breve (5 segundos)",
	timerPhase2 	= "Mostrar tiempo para el inicio de la fase 2"
}


------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Sumo Profeta Barim"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Mostrar barra de vida de los adds"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Llamarada de los cielos",
	HarbringerDarkness	= "Presagista de oscuridad"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Cierrafauce"
})

L:SetOptionLocalization{
	RangeFrame	= "Mostrar distancia (6 yardas)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"
})

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "Barón Ashbury"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "Barón Filargenta"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "Comandante Vallefont"
})

L:SetTimerLocalization({
	TimerAdds		= "Siguientes Adds"
})

L:SetOptionLocalization{
	TimerAdds		= "Mostrar tiempo para adds"
}

L:SetMiscLocalization{
	YellAdds		= "¡Repeled a los intrusos!"
}

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Lord Walden"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "Mezcla verde. ¡Muévete!",	-- Green light
	specWarnRedMix		= "Mezcla roja. ¡No te muevas!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Mostrar aviso especial para mezclas rojas/verdes"
}


------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Lord Godfrey"
})

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}


---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "Corborus"
})

L:SetWarningLocalization({
	WarnEmerge	= "Emerge",
	WarnSubmerge	= "Se sumerge"
})

L:SetTimerLocalization({
	TimerEmerge	= "Siguiente Emerger",
	TimerSubmerge	= "Siguiente Sumergirse"
})

L:SetOptionLocalization({
	WarnEmerge	= "Mostrar aviso cuando emerge",
	WarnSubmerge	= "Mostrar aviso cuando se sumerge",
	TimerEmerge	= "Mostrar tiempo para que emerja",
	TimerSubmerge	= "Mostrar tiempo para que se sumerja",
	CrystalArrow	= "Mostrar una flecha cuando $spell:81634 esté cerca de ti",
	RangeFrame		= "Mostrar distancia (5 yardas)"

})



-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "Ozruk"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "Pielpétrea"
})

L:SetWarningLocalization({
	WarnAirphase			= "Fase aerea",
	WarnGroundphase			= "Fase en tierra",
	specWarnCrystalStorm		= "Tormenta de Cristales - Protégete"
})

L:SetTimerLocalization({
	TimerAirphase			= "Siguiente Fase aerea",
	TimerGroundphase		= "Siguiente Fase en tierra"
})

L:SetOptionLocalization({
	WarnAirphase			= "Mostrar aviso cuando Pielpétrea despega",
	WarnGroundphase			= "Mostrar aviso cuando Pielpétrea aterriza",
	TimerAirphase			= "Mostrar tiempo para siguiente Fase aerea",
	TimerGroundphase		= "Mostrar tiempo para siguiente Fase en tierra",
	specWarnCrystalStorm		= "Mostrar aviso especial para $spell:92265"
})


-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "Suma Sacerdotisa Azil"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "Gran visir Ertan"
})

L:SetMiscLocalization{
	Retract		= "¡%s retira su Escudo de ciclón!"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "Altarius"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "Asaad"
})

L:SetOptionLocalization({
	SpecWarnStaticCling	= "Mostrar aviso especial para $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "¡SALTA!"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "Lady Naz'jar"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "Comandante Ulthok"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "Erunak Hablapiedra"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "Ozumat"
})

----------------
--  Zul'Aman  --
----------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "Nalorakk"
}

L:SetWarningLocalization{
	WarnBear		= "Forma de oso",
	WarnBearSoon	= "Forma de oso en 5 seg",
	WarnNormal		= "Forma normal",
	WarnNormalSoon	= "Forma normal en 5 seg"
}

L:SetTimerLocalization{
	TimerBear		= "Oso",
	TimerNormal		= "Forma Normal"
}

L:SetOptionLocalization{
	WarnBear		= "Mostrar aviso para forma de Oso",
	WarnBearSoon	= "Mostrar pre-aviso para forma de Oso",
	WarnNormal		= "Mostrar aviso para forma de Normal",
	WarnNormalSoon	= "Mostrar preaviso para forma de Normal",
	TimerBear		= "Mostrar tiempo para forma de Oso",
	TimerNormal		= "Mostrar tiempo para forma Normal"
}

L:SetMiscLocalization{
	YellBear 	= "¡Si llamáis a la bestia, vais a recibir más de lo que esperáis!",--translate ?
	YellNormal	= "¡Dejad paso al Nalorakk!"--translate ?
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Akil'zon"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame	= "Mostrar distancia"
}

L:SetMiscLocalization{
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "Jan'alai"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "¡Ahora os quemaré!",--translate ?
	YellAdds	= "¿Dónde está mi criador? ¡A por los huevos!"--translate ?
}

-------------
-- Halazzi --
-------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Halazzi"
}

L:SetWarningLocalization{
	WarnSpirit	= "Fase de Espíritu",
	WarnNormal	= "Fase Normal"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnSpirit	= "Mostrar aviso para fase de Espíritu",
	WarnNormal	= "Mostrar aviso para fase Normal"
}

L:SetMiscLocalization{
	YellSpirit	= "Lucho con libertad de espíritu...",--translate ?
	YellNormal	= "¡Espíritu, vuelve a mí!"--translate ?
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "Señor aojador Malacrass"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Mostrar tiempo para $spell:43501"
}

L:SetMiscLocalization{
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "Daakara"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	SetIconOnThrow		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639)
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Sumo sacerdote Venoxis"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477)
}

L:SetMiscLocalization{
}

------------
-- Mandokir --
------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Señor Sangriento Mandokir"
}

L:SetWarningLocalization{
	WarnRevive		= "Revive un fantasma - %d restantes",
	SpecWarnOhgan	= "¡Ohgan ha resucitado! ¡Ataca ahora!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnRevive	= "Anunciar cuantas resurrecciones de fantasmas quedan",
	SpecWarnOhgan	= "Mostrar aviso cuando Ohgan es resucitado"
}

L:SetMiscLocalization{
	Ohgan		= "Ohgan"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "Zanzil"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "Suma Sacerdotisa Kilnara"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do the Godbreaker"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "Hakkar's Chains Barrier Down - %d/3 restantes"--translate
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Announce when Hakkar's Chains barrier down"--translate
}

L:SetMiscLocalization{
	Kill	= "Oh no, Hakkar's spirit is free!" --translate
}
