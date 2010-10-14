if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

local spell		= "%s"				
local debuff		= "%s: >%s<"			
local spellCD		= "%s CD"
local spellSoon		= "%s Pronto"
local optionWarning	= "Mostrar cuadno haga %s "
local optionPreWarning	= "Mostrar pre-aviso de %s "
local optionSpecWarning	= "Mostrar aviso especial de %s "
local optionTimerCD	= "Mostrar barra de CD de %s "
local optionTimerDur	= "Mostrar duracion de %s "
local optionTimerCast	= "Mostrar tiempo de casteo %s "


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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Ancestro Nadox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Buscasombras"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Heraldo Volazj"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir el Vigía..."
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak H"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "El Modelador de carne"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Cronolord Época"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	Outro	= "Tu viaje acaba de comenzar, joven Príncipe. Reúne a tus tropas y ven a verme en las árticas tierras de Rasganorte. Allí ajustaremos cuentas. Allí es donde se desvelará tu verdadero destino."
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
	TimerRoleplay	= "Diálogo"
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("Nueva oleada"),
	TimerWaveIn		= "Mostrar tiempo para próximas oleadas (despues del boss de la 5a oleada)",
	TimerRoleplay	= "Mostrar tiempo de diálogo inicial"
})


L:SetMiscLocalization({
	Meathook	= "Gancho",
	Salramm		= "Salramm el Modelador de carne",
	Devouring	= "Necrófago devorador",
	Enraged		= "Necrófago iracundo",
	Necro		= "Nigromante oscuro",
	Fiend		= "Maligno de cripta",
	Stalker		= "Acechador de tumbas",
	Abom		= "Ensamblaje de retazos",
	Acolyte		= "Acólito",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Oleada de la Plaga = (%d+)/10",
	Roleplay	= "Me alegra que lo consiguieras, Uther.",
	Roleplay2	= "Parece que todo el mundo está listo. Recordad, esta gente está infectada por la peste y pronto morirá. Debemos purgar Stratholme para proteger de la Plaga lo que queda de Lordaeron. Vamos."
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
	WarnCrystalHandler	= "Sale un Manipulador de cristal (quedan %d)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Sale Manipulador de cristal"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Mostrar aviso cuando sale Manipulador de cristal",
	timerCrystalHandler	= "Mostrar tiempo para próximo Manipulador de cristal"
})

L:SetMiscLocalization({
	YellPull		= "¡El frío que sentís es el presagio de vuestro sino!",
	HandlerYell		= "¡Refuerza mis defensas! ¡Deprisa, maldito!!",
	Phase2			= "¡Seguro que ahora veis la inutilidad de todo ello!",
	YellKill		= "Vuestros esfuerzos... son en vano."
})


---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Rey Dred"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "El profeta Tharon'ja"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
-- Drakkari Colossus --		
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Coloso Drakkari"
})

L:SetWarningLocalization({
	WarningElemental	= "Fase Elemental",
	WarningStone		= "Fase Coloso"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Mostrar aviso para fase Elemental",
	WarningStone		= "Mostrar aviso para fase Coloso"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	timerEvent	= "Tiempo restante"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Fase numero"),
	timerEvent		= "Mostrar tiempo restante del evento"
})

L:SetMiscLocalization({
	Pull	= "¡Atentos! Tendré esto listo en un par de...",
	Phase1	= "Incumplimiento del código de seguridad en progreso. Análisis de los archivos históricos relegado a la cola de menor prioridad. Contramedidas activadas.",
	Phase2	= "Límite de índice de amenaza superado. Archivo celestial cancelado. Nivel de seguridad aumentado.",
	Phase3	= "Índice de amenaza crítico. Análisis del vacío desviado. Iniciando protocolo de higienización.",
	Kill	= "Alerta: sistema de seguridad desactivado. Comenzando purga de memoria y..."
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
})

L:SetOptionLocalization({
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok el Cortador de árboles"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Gran maga Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Dividir pronto",	
	WarningSplitNow		= "Se divide",
	WarningMerge		= "Se une"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Mostrar aviso para Dividir pronto",
	WarningSplitNow		= "Mostrar aviso para División",
	WarningMerge		= "Mostrar aviso para Unión"
})

L:SetMiscLocalization({
	SplitTrigger1 = "¡Tendréis más de lo que podéis soportar!",
	SplitTrigger2 = "¡Tendréis más de lo que podéis soportar!",
	MergeTrigger = "Ahora, ¡a terminar el trabajo!"
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	MakeitCountTimer	= "Mostrar tiempo para 'Haz que cuente' (logro)"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
})


--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Señor de la Magia Urom"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "¡Pobres necios ciegos!"
})

------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Zancanubes"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Guardián-Ley Eregos"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "Cambio de plano terminando"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." termina")
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar el Desvalijador"
})

L:SetWarningLocalization({

})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡No! Puedo hacerlo... ¡mejor! Puedo..."
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "¿Qué chuchos son los que se atreven a irrumpir aquí? ¡Adelante, hermanos! ¡Un festín para quien me traiga sus cabezas!",
	Phase2			= "¡Bastardos malnacidos! ¡Vuestros cadáveres serán un buen bocado para mis nuevos dracos!"
	---YellCombatEnd	= "¡ARGH! ¿ Y llamas ataque... a eso? Te voy a enseñar... aghhh..."
})


------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Rey Ymiron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tumbapena"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerRoleplay		= "Svala Sorrowgrave ataca"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar tiempo de diálogo antes de que Svala ataque"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "¡Mi señor! He hecho lo que pedisteis, ¡y ahora suplico vuestra bendición!"
})


---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Pezuña Pálida"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart		= "Inicio del combate"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Mostrar tiempo para inicio del combate"
})

L:SetMiscLocalization({
	CyanArrived	= "Una defensa valiente, pero esta ciudad debe ser arrasada. ¡Yo misma cumpliré los deseos de Malygos!"
})

------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
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
	TimerPortalIn			= "Mostrar tiempo para siguiente portal (después de boss)",
	ShowAllPortalTimers		= "Mostrar tiempo para todos los portales (poco acurado)"
})


L:SetMiscLocalization({
	Sealbroken	= "¡Hemos atravesado la puerta de la prisión! ¡El camino hacia Dalaran está despejado! ¡Por fin hemos puesto punto y final a la guerra de El Nexo!",
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
	warnExplode		= "Explosión de necrófago. Alejate!"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Mostrar tiempo para el inicio del combate",
	warnExplode		= "Avisar cuando un Necrofago vaya a explotar.",
	AchievementCheck		= "Anunciar fallo del logro 'Podría ser peor' al grupo",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull			= "Bien hecho. Hoy has demostrado algo...",
	AchievementFailed	= ">> LOGRO FALLADO: %s ha sido alcanzado por Explosión de necrófago <<",
	YellCombatEnd	= "¡No! No debo fallar... otra vez..."
})


-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Bien luchado! Vuestro próximo reto llega de entre las filas de la propia Cruzada. Se os pondrá a prueba contra su considerable destreza."
})


-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Confesora Argenta"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Un trabajo excelente!"
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric el Puro"
})

L:SetWarningLocalization({
	specwarnRadiance		= "Radiancia. Date la vuelta!"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Mostrar aviso especial para $spell:66935",
	SetIconOnHammerTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Me rindo! Lo admito. Un trabajo excelente. ¿Puedo escaparme ya?"
})

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Agh i Puagh"
})

L:SetWarningLocalization({
	warnPursuit				= "Persiguiendo a >%s<",
	specWarnPursuit			= "Estas siendo perseguido! Corre!"
})

L:SetOptionLocalization({
	warnPursuit				= "Anunciar objetivos perseguidos",
	specWarnPursuit			= "Mostrar aviso especial cuando seas perseguido",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit				= "¡%s te atrapa!",
	Barrage					= "¡%s comienza a invocar minas explosivas!",
})
-------------------
-- Forgemaster Garfrost --
-------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Maestro de forja Gargelus"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Roca de Saronita en >%s<",
	specWarnSaroniteRock		= "Te lanzan saronita! Muévete!",
	specWarnSaroniteRockNear	= "Lanzan saronita cerca tuyo! Muévete!",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Mostrar los objetivos de $spell:70851",
	specWarnSaroniteRock		= "Mostrar aviso especial cuando seas objetivo de\n $spell:70851",
	specWarnSaroniteRockNear	= "Mostrar aviso especial cuando estés cerca del objetivo de\n $spell:70851",
	specWarnPermafrost			= "Mostrar aviso cuando tengas mucha $spell:70336 acumulada",
	AchievementCheck			= "Anunciar avisos del logro 'Solo once campanadas' en el chat de grupo",
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
	SaroniteRockThrow			= "¡%s te lanza un pedrusco de saronita enorme!",
	AchievementWarning	= "Aviso: %s tiene %d marcas de Escarcha permanente",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Escarcha permanente <<"
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Señor de la Plaga Tyrannus"
})

L:SetWarningLocalization({
	specWarnHoarfrost			= "¡Triza de Escarcha en ti!",
	specWarnHoarfrostNear		= "¡Triza de Escarcha cerca de ti! Muévete!"
})

L:SetTimerLocalization{
	TimerCombatStart			= "Empieza el combate"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "Mostrar una alerta especial cuando estés afectado por $spell:69246",
	specWarnHoarfrostNear		= "Mostrar una alerta especial cuando $spell:69246 esté cerca de ti",
	TimerCombatStart			= "Mostrar cuenta atras para el inicio del combate",
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart					= "¡Ay! Valientes aventureros, vuestra intromisión ha llegado a su fin. ¿Oís el ruido de huesos y acero acercándose por ese túnel? Es el sonido de vuestra inminente muerte.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "¡La vermis de escarcha Dientrefrío mira a (%S+) y prepara un helado ataque!",
	YellCombatEnd				= "Imposible... Dientefrío... Avisa..."
})
---------------------
-- Forge of Souls --
---------------------
-- Bronjahm --
-------------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Bronjahm"
})

L:SetWarningLocalization({
	specwarnSoulstorm		= "Tormenta de almas! Todos al centro!"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "Mostrar un aviso especial cuando $spell:68872 es casteada"
})

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Devoraalmas"
})

L:SetWarningLocalization({
	specwarnMirroredSoul	= "Alma reflejada! Parad DPS!",
	specwarnWailingSouls	= "Almas gemebundas! Atrás!"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Mostrar una alerta especial para parar el daño en $spell:69051",
	specwarnWailingSouls	= "Mostrar aviso especial cuando $spell:68899 es casteado",
	SetIconOnMirroredTarget	= "Poner iconos en los objetivos de $spell:69051"
})

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Tiempo de oleadas"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Nueva oleada pronto",
	WarnNewWave		= "%s viene"
})

L:SetTimerLocalization({
	TimerNextWave	= "Siguiente oleada"
})

L:SetOptionLocalization({
	WarnNewWave			= "Mostrar aviso cuando llega una oleada",
	WarnNewWaveSoon		= "Mostrar pre-aviso para nueva oleada(después del 1r boss)",
	ShowAllWaveWarnings	= "Mostrar pre-aviso para todas las oleadas",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Mostrar tiempo para nuevo grupo de oleadas (después del 1r boss)",
	ShowAllWaveTimers	= "Mostrar tiempo para todas las oleadas (poco acurado)"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Oleada de espiritus = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Falric"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Marwyn"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Evento del Rey Exanime"
})

L:SetWarningLocalization({
	WarnWave1		= "6 Necrófagos enfurecidos, 1 Médico brujo resucitado vienen",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "6 Necrófagos enfurecidos, 2 Médicos brujos resucitados, 1 Abominación torpe vienen",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "6 Necrófagos enfurecidos, 2 Médicos brujos resucitados, 2 Abominaciónes torpes vienen",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "12 Necrófagos enfurecidos, 4 Médicos brujos resucitados, 3 Abominaciónes torpes"--12 Ghoul, 3 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "Tiempo para escapar"
})

L:SetOptionLocalization({
	ShowWaves	= "Mostrar avisos para las oleadas que vienen"
})

L:SetMiscLocalization({
	Ghoul			= "Necrófago enfurecido",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Abominación torpe",--creature id 37069
	WitchDoctor		= "Médico brujo resucitado",--creature id 36941
	ACombatStart	= "Es demasiado poderoso. ¡Debemos abandonar este lugar ahora mismo! Mi magia podrá inmovilizarlo brevemente. ¡Vamos rápido, héroes!",
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",
	Wave1			= "¡No hay escapatoria!",
	Wave2			= "Sucumbid al frío de la tumba.",
	Wave3			= "Otro final sin salida.",
	Wave4			= "¿Cuánto vais a aguantar?",
	YellCombatEnd	= "¡FUEGO! ¡FUEGO!"
})