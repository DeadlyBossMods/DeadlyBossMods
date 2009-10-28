if GetLocale() ~= "esES" then return end

local L

local spell		= "%s"				
local debuff		= "%s: >%s<"			
local spellCD		= "%s CD"			-- translate
local spellSoon		= "%s Pronto"			-- translate
local optionWarning	= "Mostrar cuadno haga \"%s\" "		-- translate
local optionPreWarning	= "Mostrar pre-aviso de \"%s\" "	-- translate
local optionSpecWarning	= "Mostrar aviso especial de \"%s\" "	-- translate
local optionTimerCD	= "Mostrar barra de CD de \"%s\" "	-- translate
local optionTimerDur	= "Mostrar duracion de \"%s\" "	-- translate
local optionTimerCast	= "Mostrar tiempo de casteo \"%s\" "	-- translate


--------------------------------
-- Ahn�Kahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Príncipe Taldaram"
})

L:SetWarningLocalization({
	WarningFlame		= spell,
	WarningEmbrace		= debuff
})

L:SetTimerLocalization({
	TimerEmbrace		= debuff,
	TimerFlameCD		= spellCD
})

L:SetOptionLocalization({
	WarningFlame		= optionWarning:format(GetSpellInfo(55931)),
	WarningEmbrace		= optionWarning:format(GetSpellInfo(55959)),
	TimerEmbrace		= optionTimerDur:format(GetSpellInfo(55959)),
	TimerFlameCD		= optionTimerCD:format(GetSpellInfo(55931))
})


-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Ancestro Nadox"
})

L:SetWarningLocalization({
	WarningPlague	= debuff
})

L:SetTimerLocalization({
	TimerPlague	= debuff
})

L:SetOptionLocalization({
	WarningPlague	= optionWarning:format(GetSpellInfo(56130)),
	TimerPlague	= optionTimerDur:format(GetSpellInfo(56130))
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Buscasombras"
})

L:SetWarningLocalization({
	WarningThundershock	= spell,
	WarningCycloneStrike	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock	= optionWarning:format(GetSpellInfo(56926)),
	WarningCycloneStrike	= optionWarning:format(GetSpellInfo(60030))
})


-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Heraldo Volazj"
})

L:SetWarningLocalization({
	WarningInsanity	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningInsanity	= optionWarning:format(GetSpellInfo(57496))
})


--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

L:SetWarningLocalization({
	WarningMini	= spell
})

L:SetTimerLocalization({
	TimerMiniCD	= spellCD
})

L:SetOptionLocalization({
	WarningMini	= optionWarning:format(GetSpellInfo(57055)),
	TimerMiniCD	= optionTimerCD:format(GetSpellInfo(57055))
})


-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir el vigía de ..."
})

L:SetWarningLocalization({
	WarningCurse	= spell
})

L:SetTimerLocalization({
	TimerCurseCD	= spellCD
})

L:SetOptionLocalization({
	WarningCurse 	= optionWarning:format(GetSpellInfo(52592)),
	TimerCurseCD	= optionTimerCD:format(GetSpellInfo(52592))
})


--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

L:SetWarningLocalization({
	WarningLeech	= spell,
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningLeech	= optionWarning:format(GetSpellInfo(53030)),
	WarningCloud	= optionWarning:format(GetSpellInfo(53400))
})


---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak H"
})

L:SetWarningLocalization({
	WarningPound	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPound	= optionWarning:format(GetSpellInfo(53472)),
})


--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Gancho"
})

L:SetWarningLocalization({
	WarningChains	= debuff
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerChainsCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(52696)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(52696)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(52696))
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "El Modelador de carne"
})

L:SetWarningLocalization({
	WarningCurse	= debuff,
	WarningSteal	= debuff,
	WarningGhoul	= spell
})

L:SetTimerLocalization({
	TimerGhoulCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningCurse	= optionWarning:format(GetSpellInfo(58845)),
	WarningSteal	= optionWarning:format(GetSpellInfo(52709)),
	WarningGhoul	= optionWarning:format(GetSpellInfo(52451)),
	TimerGhoulCD	= optionTimerCD:format(GetSpellInfo(52451)),
	TimerCurse	= optionTimerDur:format(GetSpellInfo(58845))
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Cronolord Época"
})

L:SetWarningLocalization({
	WarningTime	= spell,
	WarningCurse	= debuff
})

L:SetTimerLocalization({
	TimerTimeCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningTime	= optionWarning:format(GetSpellInfo(58848)),	-- requires translation
	WarningCurse	= optionWarning:format(GetSpellInfo(52772)),
	TimerTimeCD	= optionTimerCD:format(GetSpellInfo(58848)),	-- translate
	TimerCurse	= optionTimerDur:format(GetSpellInfo(52772))
})


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetWarningLocalization({
	WarningSleep	= debuff
})

L:SetTimerLocalization({
	TimerSleep	= debuff,
	TimerSleepCD	= spellCD
})

L:SetOptionLocalization({
	WarningSleep	= optionWarning:format(GetSpellInfo(52721)),
	TimerSleep	= optionTimerDur:format(GetSpellInfo(52721)),
	TimerSleepCD	= optionTimerCD:format(GetSpellInfo(52721))
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Oleadas de CoT4"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Oleada %d: %s empieza",
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"Siguiente oleada (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("Nueva oleada"),
	TimerWaveIn		= "Mostrar la \"Siguiente oleada\" ",
})


L:SetMiscLocalization({
	Meathook	= "Gancho",
	Salramm		= "Salramm el Modelador de carne",
	Devouring	= "Necrófago devorador",
	Enraged		= "Necrófago iracundo",
	Necro		= "Nigromante oscuro",
	Friend		= "Maligno de cripta",
	Tomb		= "Acechador de tumbas",
	Abom		= "Ensamblaje de retazos",
	Acolyte		= "Acólito",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Oleada de la Plaga = %d/10"
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Cuernotrol"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos el Invocador"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Rey Dred"
})

L:SetWarningLocalization({
	WarningFear	= spell,
	WarningBite	= debuff,
	WarningSlash	= spell
})

L:SetTimerLocalization({
	TimerFearCD	= spellCD,
	TimerSlash	= debuff,
	TimerSlashCD	= spellCD
})

L:SetOptionLocalization({
	WarningSlash	= optionWarning:format("Mangling/Piercing Slash"), 	-- needs translation
	WarningFear	= optionWarning:format(GetSpellInfo(22686)),
	WarningBite	= optionWarning:format(GetSpellInfo(48920)),
	TimerFearCD	= optionTimerCD:format(GetSpellInfo(22686)),
	TimerSlash	= optionTimerDur:format("Mangling/Piercing Slash"), 	-- needs translation
	TimerSlashCD	= optionTimerCD:format("Mangling/Piercing Slash") 	-- needs translation
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "El profeta Tharon'ja"
})

L:SetWarningLocalization({
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCloud	= optionWarning:format(GetSpellInfo(49548))
})


--------------
-- Gun'Drak --
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Slad'ran"
})

L:SetWarningLocalization({
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(55081)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(55081))
})


-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

L:SetWarningLocalization({
	WarningTransform	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningTransform	= optionWarning:format(GetSpellInfo(55098))
})


-----------------------
-- Drakkari Colossus --		
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Coloso Drakkari"
})

L:SetWarningLocalization({
	WarningElemental	= "Fase Elemental",		-- translate :)
	WarningStone		= "Fase Coloso"		-- translate :)
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Activar/Desactivar fase Elemental",	-- translate ;)
	WarningStone		= "Activar/Desactivar fase Coloso"		-- translate :)
})


---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Gal'darah"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- Eck the Ferocious --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Eck el Feroz"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------------
-- Halls of Lightning --
------------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "General Bjarngrim"
})

L:SetWarningLocalization({
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(52027))
})


-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

L:SetWarningLocalization({
	WarningOverload	= debuff,
	WarningSplit	= spell
})

L:SetTimerLocalization({
	TimerOverload	= debuff
})

L:SetOptionLocalization({
	WarningOverload = optionWarning:format(GetSpellInfo(52658)),
	WarningSplit	= optionWarning:format(GetSpellInfo(52770)),
	TimerOverload	= optionTimerDur:format(GetSpellInfo(52658))
})


-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "Volkhan"
})

L:SetWarningLocalization({
	WarningStomp 	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp 	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD 	= optionTimerCD:format(GetSpellInfo(52237))
})


------------
-- Kronus --
------------
L = DBM:GetModLocalization("Loken")

L:SetGeneralLocalization({
	name = "Loken"
})

L:SetWarningLocalization({
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(59835)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(59835))
})


--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Doncella de Pena"
})

L:SetWarningLocalization({
	WarningWoe	= debuff,
	WarningSorrow	= spell,
	WarningStorm	= spell
})

L:SetTimerLocalization({
	TimerWoe	= debuff,
	TimerSorrow	= spell,
	TimerSorrowCD	= spellCD,
	TimerStormCD	= spellCD
})

L:SetOptionLocalization({
	WarningWoe	= optionWarning:format(GetSpellInfo(50761)),
	WarningSorrow	= optionWarning:format(GetSpellInfo(50760)),
	WarningStorm	= optionWarning:format(GetSpellInfo(50752)),
	TimerWoe	= optionTimerDur:format(GetSpellInfo(50761)),
	TimerSorrow	= optionTimerDur:format(GetSpellInfo(50760)),
	TimerSorrowCD	= optionTimerCD:format(GetSpellInfo(50760)),
	TimerStormCD	= optionTimerCD:format(GetSpellInfo(50752)),
})


----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "Krystallus"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})


----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir el Afilador"
})

L:SetWarningLocalization({
	WarningCharge	= debuff,
	WarningRing	= spell
})

L:SetTimerLocalization({
	TimerCharge	= debuff,
	TimerChargeCD	= spellCD,
	TimerRingCD	= spellCD
})

L:SetOptionLocalization({
	WarningCharge	= optionWarning:format(GetSpellInfo(50834)),
	WarningRing	= optionWarning:format(GetSpellInfo(50840)),
	TimerCharge	= optionTimerDur:format(GetSpellInfo(50834)),
	TimerChargeCD	= optionTimerCD:format(GetSpellInfo(50834)),
	TimerRingCD	= optionTimerCD:format(GetSpellInfo(50840))
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Salvar a Brann"
})

L:SetWarningLocalization({
	WarningPhase	= "Fase %d"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Phase #")
})

L:SetMiscLocalization({
	Pull		= "Time to get some answers! Let's get this show on the road!",
	Phase1	= "xxx anti error xxx",
	Phase2	= "xxx anti error xxx",
	Phase3	= "xxx anti error xxx"
})

---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Anomalus"
})

L:SetWarningLocalization({
	WarningRiftSoon		= spellSoon,
	WarningRiftNow		= spell,
})

L:SetOptionLocalization({
	WarningRiftSoon		= optionPreWarning:format(GetSpellInfo(47743)),
	WarningRiftNow		= optionWarning:format(GetSpellInfo(47743))
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok el Cortador de árboles"
})

L:SetWarningLocalization({
	WarningSpikes		= spell,
	WarningReflection	= spell,
	WarningFrenzy		= spell,
	WarningAdd		= spell
})

L:SetTimerLocalization({
	TimerReflection		= spell,
	TimerReflectionCD	= spellCD
})

L:SetOptionLocalization({
	WarningSpikes		= optionWarning:format(GetSpellInfo(47958)),
	WarningReflection	= optionWarning:format(GetSpellInfo(47981)),
	WarningFrenzy		= optionWarning:format(GetSpellInfo(48017)),
	WarningAdd		= optionWarning:format(GetSpellInfo(61564)),
	TimerReflection		= optionTimerDur:format(GetSpellInfo(47981)),
	TimerReflectionCD	= optionTimerCD:format(GetSpellInfo(47981))
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Gran maga Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Dividir pronto",		-- translate
	WarningSplitNow		= "Se divide",		-- translate
	WarningMerge		= "Se une"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Dividir pronto"),	-- translate
	WarningSplitNow		= optionWarning:format("Se divide"),	-- translate
	WarningMerge		= optionWarning:format("Se une"),	-- translate
})

L:SetMiscLocalization({
	SplitTrigger1 = "'Tendréis más de lo que podéis soportar!",		-- translate
	SplitTrigger2 = "¡Tendréis más de lo que podéis soportar!",	-- translate
	MergeTrigger = "Ahora, ¡a terminar el trabajo!"				-- translate
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

L:SetWarningLocalization({
	WarningChains 	= debuff,
	WarningEnrage	= spell,
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerNova	= spell,
	TimerChainsCD	= spellCD,
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(50997)),
	WarningNova	= optionWarning:format(GetSpellInfo(48179)),
	WarningEnrage	= optionWarning:format(GetSpellInfo(8599)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(50997)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(50997)),
	TimerNova	= optionTimerDur:format(GetSpellInfo(48179)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(48179))
})


---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Comandante Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Comandante Barbarrecia"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
	WarningFear 		= spell,
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
	TimerFearCD		= spellCD,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningFear		= optionWarning:format(GetSpellInfo(19134)),
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(38619)),
	TimerFearCD		= optionTimerCD:format(GetSpellInfo(19134)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(38619))
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos el Interrogador"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Señor de la Magia Urom"
})

L:SetWarningLocalization({
	WarningTimeBomb = debuff,
	WarningExplosion = spell
})

L:SetTimerLocalization({
	TimerTimeBomb = debuff,
	TimerExplosion = spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou 	= optionSpecWarning:format(GetSpellInfo(51121))
})


------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Zancanubes"
})

L:SetWarningLocalization({
	WarningAmplify	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningAmplify	= optionWarning:format(GetSpellInfo(51054))
})


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Guardián-Ley Eregos"
})

L:SetWarningLocalization({
	WarningShift	= spell,
	WarningEnrage	= spell,
	WarningShiftEnd	= "Planar Shift ending"		-- translate
})

L:SetTimerLocalization({
	TimerShift	= spell,
	TimerEnrage	= spell
})

L:SetOptionLocalization({
	WarningShift	= optionWarning:format(GetSpellInfo(51162)),
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." termina"), 	-- translate the word 'ending'
	WarningEnrage	= optionWarning:format(GetSpellInfo(51170)),
	TimerShift	= optionTimerDur:format(GetSpellInfo(51162)),
	TimerEnrage	= optionTimerDur:format(GetSpellInfo(51170))
})



------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Príncipe Keleseth"
})

L:SetWarningLocalization({
	WarningTomb	= debuff
})

L:SetTimerLocalization({
	TimerTomb	= debuff
})

L:SetOptionLocalization({
	WarningTomb	= optionWarning:format(GetSpellInfo(48400)),
	TimerTomb	= optionTimerDur:format(GetSpellInfo(48400))
})


------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Constructor & Controlador"
})

L:SetWarningLocalization({
	WarningEnfeeble		= debuff,
	WarningSummon		= spell
})

L:SetTimerLocalization({
	TimerEnfeeble		= debuff
})

L:SetOptionLocalization({
	WarningEnfeeble		= optionWarning:format(GetSpellInfo(43650)),
	WarningSummon		= optionWarning:format(GetSpellInfo(52611)),
	TimerEnfeeble		= optionTimerDur:format(GetSpellInfo(43650))
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar el Desvalijador"
})

L:SetWarningLocalization({
	WarningSmash			= spell,
	WarningGrowl			= spell,
	WarningWoeStrike		= debuff,
	SpecialWarningSpelllock 	= "Bloqueo de hechizos - para de lanzar!"  -- translate
})

L:SetTimerLocalization({
	TimerSmash	= spell,
	TimerWoeStrike	= debuff
})

L:SetOptionLocalization({
	WarningSmash		= optionWarning:format(GetSpellInfo(42723)),
	WarningGrowl		= optionWarning:format(GetSpellInfo(42708)),
	WarningWoeStrike	= optionWarning:format(GetSpellInfo(42730)),
	TimerSmash		= optionTimerCast:format(GetSpellInfo(42723)),
	TimerWoeStrike		= optionTimerDur:format(GetSpellInfo(42730))
})


----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi el Despiadado"
})

L:SetWarningLocalization({
	WarningWhirlwind	= spell,
	WarningPoison		= debuff
})

L:SetTimerLocalization({
	TimerPoison		= debuff,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(59332)),
	WarningPoison		= optionWarning:format(GetSpellInfo(59331)),
	TimerPoison		= optionTimerDur:format(GetSpellInfo(59331)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(59332))
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Rey Ymiron"
})

L:SetWarningLocalization({
	WarningBane	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= optionWarning:format(GetSpellInfo(48294))
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tumbapena"
})

L:SetWarningLocalization({
	WarningSword	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSword	= optionWarning:format(GetSpellInfo(48276))
})


---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Pezuña Pálida"
})

L:SetWarningLocalization({
	WarningImpale	= debuff
})

L:SetTimerLocalization({
	TimerImpale	= debuff
})

L:SetOptionLocalization({
	WarningImpale	= optionWarning:format(GetSpellInfo(48261)),
	TimerImpale	= optionTimerDur:format(GetSpellInfo(48261))
})


---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cianigosa"
})

L:SetWarningLocalization({
	WarningVacuum	= spell,
	WarningBlizzard	= spell,
	WarningMana	= debuff
})

L:SetTimerLocalization({
	TimerVacuumCD	= spellCD,
	TimerMana	= debuff
})

L:SetOptionLocalization({
	WarningVacuum	= optionWarning:format(GetSpellInfo(58694)),
	WarningBlizzard	= optionWarning:format(GetSpellInfo(58693)),
	WarningMana	= optionWarning:format(GetSpellInfo(59374)),
	TimerMana	= optionTimerDur:format(GetSpellInfo(59374)),
	TimerVacuumCD	= optionTimerCD:format(GetSpellInfo(58694))
})


------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

L:SetWarningLocalization({
	WarningES	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningES	= optionWarning:format(GetSpellInfo(54479))
})


-------------
-- Ichoron --
-------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Ícoron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Lavanthor"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Moragg"
})

L:SetWarningLocalization({
	WarningLink	= debuff
})

L:SetTimerLocalization({
	TimerLink	= debuff,
	TimerLinkCD	= spellCD
})

L:SetOptionLocalization({
	WarningLink	= optionWarning:format(GetSpellInfo(54396)),
	TimerLink	= optionTimerDur:format(GetSpellInfo(54396)),
	TimerLinkCD	= optionTimerCD:format(GetSpellInfo(54396))
})


------------
-- Xevoss --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevozz"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------------
-- Zuramat the Obliterator --
-----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat el Obliterador"
})

L:SetWarningLocalization({
	WarningVoidShift			= debuff,
	WarningVoidShifted			= debuff,
	WarningShroudOfDarkness		= spell,
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
	TimerVoidShift			= debuff,
	TimerVoidShifted		= debuff
})

L:SetOptionLocalization({
	WarningVoidShift			= optionWarning:format(GetSpellInfo(54343)),
	WarningVoidShifted			= optionWarning:format(GetSpellInfo(59343)),
	WarningShroudOfDarkness		= optionWarning:format(GetSpellInfo(59745)),
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745)),
	TimerVoidShift				= optionTimerDur:format(GetSpellInfo(59743)),
	TimerVoidShifted			= optionTimerDur:format(GetSpellInfo(59343))
})


-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Timpo de Portales"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Preparate para el portal",
	WarningPortalNow	= "Portal Nº%d abierto",
	WarningBossNow		= "Ahora toca boss"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal Nº%d en" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Nuevo portal"),
	WarningPortalSoon		= optionPreWarning:format("Nuevo portal"),
	WarningBossNow			= optionWarning:format("Toca boss"),
	TimerPortalIn			= "Activar/Desactivar tiempo para \"Portal: Nº\" ",
	ShowAllPortalWarnings		= "Activar/Desactivar aviso para todos los portales"
})


L:SetMiscLocalization({
	yell1 = "¡Guardias de la prisión, nos largamos! ¡Esos aventureros están dominando el cotarro! ¡Vamos, vamos!",
	WavePortal		= "Portales abiertos: (%d+)/18"
})


---------------------
-- Trial of the Champion --
---------------------
-------------------
-- The Black Knight --
-------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "El Caballero Negro"
})

L:SetWarningLocalization({
	specWarnDesecration		= "Profanación! Alejate!",
	warnExplode		= "Explosión de necrófago. Alejate!"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Aviso especial si te hace daño la Profanacion",
	warnExplode		= "Avisar cuando un Necrofago vaya a explotar."
})


-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetWarningLocalization({
	specWarnHaste		= ">%s< tiene celeridad. Robalo o dispelea!",
	warnPoison		= "El picaro ha echado la botella de veneno",
	specWarnPoison		= "Veneno! Alejate!",
	warnHealingWave		= "El chaman castea Ola de sanacion. Interrumpe!",
})

L:SetOptionLocalization({
	warnHealingWave		= "Mostrar aviso cuando el chaman castee ola de sanacion.",
	specWarnHaste		= "Mostrar aviso especial cuando el mago tenga celeridad ( para robar o dispelear )",
	warnPoison		= "Mostrar aviso cuando el picaro lanze botella de veneno",
	specWarnPoison		= "Mostrar aviso especial si recibes daño del veneno"
})


-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Confesora Argenta"
})

L:SetWarningLocalization({
    warnRenew       = "Renovar",
	specwarnRenew		= "Confesora argenta castea renovar a >%s<. Dispelea Ya!",
	warnReflectiveShield		= "Confesora argenta tiene escudo reflectante"
})

L:SetOptionLocalization({
	warnRenew		= "Mostrar aviso cuando la Confesora argenta castee renovar",
	specwarnRenew		= "Mostrar aviso especial cuando la Confesora argenta tenga renovar para (robar o cortar)",
	warnReflectiveShield		= "Mostrar aviso cuando la Confesora argenta tenga el Escudo refelctante"
})


-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric el Puro"
})

L:SetWarningLocalization({
	warnHammerofRighteous		= "Eadric castea Martillo del honrado!",
	specwarnHammerofJustice		= "Martillo de Justicia en >%s<. Dispelea ya!",
	specwarnRadiance		= "Radiancia. Date la vuelta!"
})

L:SetOptionLocalization({
	warnHammerofRighteous		= "Mostrar aviso cuando Eadric castee martillo del honrado",
	specwarnHammerofJustice		= "Mostrar aviso especial para martillo de justicia ( para dispelear )",
	specwarnRadiance		= "Mostrar aviso especial para Radiancia."
})


---------------------
-- Holiday --
---------------------
-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Cerveza Temible"
})

L:SetWarningLocalization({
	warnBarrel	= "Barril en >%s<", 
--	specwarnDaughters		= "Ha salido la hija!",
	specwarnDisarm		= "Desarmar. Alejate!",
	specWarnBrew		= "Matar a la hija antes de que lanze otra cerveza!",
	specWarnBrewStun		= "SUGERENCIA: Bebe la cerveza si te ha lanzado!"
})

L:SetOptionLocalization({
	warnBarrel		= "Anunciar el objetivo del barril.",
--	specwarnDaughters		= "Anunciar salida de Urusla/Ilsa",
	specwarnDisarm		= "Mostrar aviso especial para Desarmar",
	specWarnBrew		= "Mostrar aviso especial para Dark Brewmaiden's Brew",
	specWarnBrewStun		= "Mostrar aviso especial para Dark Brewmaiden's Stun",
	PlaySoundOnDisarm	= "Sonido para Desarmar",
	YellOnBarrel	= "Avisar si tienes el Barril"
})

L:SetMiscLocalization{
	YellBarrel		= "Tengo el Barril!"
}