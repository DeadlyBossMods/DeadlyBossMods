if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "Se ha liberado un add"
})

L:SetOptionLocalization({
	WarnAdd		= "Avisar cuando un add pierde el bufo de $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "Armadura sobrecalentada (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Mostrar tiempo de duracion de $spell:75846"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "Poner un icono en el boss después de $spell:76200"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "Vigorosa venganza VanCleef"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "Marcar en el minimapa cuando el General Umbriss vaya a atacarte con Ataque relámpago"
}

L:SetMiscLocalization{
	Blitz		= "fija la mirada |cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "¡Dragón, harás lo que te ordeno! ¡Cógeme!",
	Add			= "%s Invoca un"
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "Se... acabó... Ptah..."
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "Velocidad de la luz"
})

L:SetMiscLocalization({
	Brann		= "¡Bien, vamos! Tan solo me falta introducir la secuencia final en el mecanismo de la puerta... y..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "División pronto"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Mostrar pre aviso para división"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

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

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "Mostrar barra de vida de los adds"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

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

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

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
L= DBM:GetModLocalization(99)

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
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

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

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

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

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "¡%s retira su Escudo de ciclón!"
}

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

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
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

----------------
--  Zul'Aman  --
----------------
--  Akil'zon --
---------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame	= "Mostrar distancia",
	StormArrow	= "Mostrar flecha para $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

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
	TimerNormal		= "Mostrar tiempo para forma Normal",
	InfoFrame		= "Mostrar información para jugadores a los que les afecta $spell:42402"
}

L:SetMiscLocalization{
	YellBear 	= "¡Si llamáis a la beh'tia, vais a recibir más de lo que eh'peráis!",
	YellNormal	= "¡Dejad paso al Nalorakk!",
	PlayerDebuffs	= "Debuff de Oleada"
}

---------------
--  Jan'alai --
---------------
L= DBM:GetModLocalization(188)

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "¡Ahora os quemaré!",
	YellHatchAll= "Os mostraré la fuerza... con números.",
	YellAdds	= "¿Dónde está mi criador? ¡A por los huevos!"
}

--------------
--  Halazzi --
--------------
L= DBM:GetModLocalization(189)

L:SetWarningLocalization{
	WarnSpirit	= "Fase de Espíritu",
	WarnNormal	= "Fase Normal"
}

L:SetOptionLocalization{
	WarnSpirit	= "Mostrar aviso para fase de Espíritu",
	WarnNormal	= "Mostrar aviso para fase Normal"
}

L:SetMiscLocalization{
	YellSpirit	= "Lucho con libertad de espíritu...",
	YellNormal	= "¡Espíritu, vuelve a mí!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L= DBM:GetModLocalization(190)

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Mostrar tiempo para $spell:43501"
}

L:SetMiscLocalization{
	YellPull	= "Las sombras caerán sobre vosotros..."
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "Siguiente cambio de forma"
}

L:SetOptionLocalization{
	timerNextForm	= "Mostrar tiempo para los cambios de forma.",
	InfoFrame		= "Mostrar información para jugadores a los que les afecta $spell:42402",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Debuff de Oleada"
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "Mostrar una flecha cuando te afecte $spell:96477"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "%d fantasmas restantes",
	SpecWarnOhgan	= "¡Ohgan ha resucitado! ¡Ataca ahora!"
}

L:SetOptionLocalization{
	WarnRevive	= "Anunciar cuantas resurrecciones de fantasmas quedan",
	SpecWarnOhgan	= "Mostrar aviso cuando Ohgan es resucitado",
	SetIconOnOhgan	= "Poner un icono a Ohgan cuando resucite" 
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

L:SetWarningLocalization{
	SpecWarnToxic	= "Coge Tormento tóxico"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "Mostrar aviso especial cuando pierdas el debufo de $spell:96328",
	InfoFrame		= "Mostrar información de jugadores sin $spell:96328",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Sin Tormento tóxico"
}

----------------------------
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

L:SetWarningLocalization{
	WarnBarrierDown	= "Barrera de las cadenas de Hakkar eliminada - %d/3 restantes"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Anunciar cuando se elimine una barrera de cadenas",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill	= "Te has pasado de la raya, Jin'do. Juegas con poderes que van más allá de ti. ¿Acaso has olvidado quién soy? ¡¿Es que has olvidado lo que puedo hacer?!"
}

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Detonación de Bengala del Núcleo"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Mostrar tiempo para detonación de $spell:101927"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "No tenéis ni idea de lo que habéis hecho. Aman'Thul... Lo que... he... visto..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

L:SetMiscLocalization{
	Pull		= "¡Ningún mortal que se enfrente a mí saldrá con vida!"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetWarningLocalization{
	WarnAdds	= "Siguientes adds pronto"
}

L:SetTimerLocalization{
	TimerAdds	= "Siguientes adds"
}

L:SetOptionLocalization{
	WarnAdds	= "Anunciar cuando \"salgan\" nuevos adds",
	TimerAdds	= "Mostrar tiempo para que \"salgan\" nuevos adds"
}

L:SetMiscLocalization{
	Kill		= "Ya basta. Por mucho que me guste hacer de anfitriona, debo atender asuntos más urgentes."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetTimerLocalization{
	TimerTyrandeHelp	= "Tyrande necesita ayuda"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "Mostrar tiempo para que Tyrande necesite ayuda"
}

L:SetMiscLocalization{
	Kill		= "¡Malfurion... lo ha logrado! ¡El portal se desmorona!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L= DBM:GetModLocalization(322)

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate"
}

L:SetMiscLocalization{
	Event		= "¡Muéstrate!",
	Pull		= "Las fuerzas Crepusculares comienzan a aparecer en los bordes de los cañones."
}

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "... una vez liquidado eso, tú y ese rebaño de torpes amigos tuyos sois los siguientes en mi lista. ¡Mmm, creí que nunca llegarías!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate"
}

L:SetMiscLocalization{
	Event		= "Y ahora, chamán, me entregarás el Alma de dragón."
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "Akma'hat"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Garr (Cata)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Julak Fatalidad"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "Mobus"
}
