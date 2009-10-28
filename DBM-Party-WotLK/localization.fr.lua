if GetLocale() ~= "frFR" then return end

local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s cooldown"
local spellSoon			= "%s bientôt"
local optionWarning		= "Activer l'annonce: \"%s\" "
local optionPreWarning	= "Activer la pré-annonce: \"%s\" "
local optionSpecWarning	= "Activer l'avertissement spécial: \"%s\" "
local optionTimerCD		= "Afficher le timer pour le cooldown pour: \"%s\" "
local optionTimerDur	= "Afficher le timer de durée pour: \"%s\" "
local optionTimerCast	= "Afficher le timer pour le cast de: \"%s\" "


--------------------------------
-- Ahn'Kahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prince Taldaram"
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
	name = "Ancien Nadox"
})

L:SetWarningLocalization({
	WarningPlague	= debuff
})

L:SetTimerLocalization({
	TimerPlague		= debuff,
	TimerPlagueCD	= spellCD
})

L:SetOptionLocalization({
	WarningPlague	= optionWarning:format(GetSpellInfo(56130)),
	TimerPlague		= optionTimerDur:format(GetSpellInfo(56130)),
	TimerPlagueCD	= optionTimerCD:format(GetSpellInfo(56130))
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Cherchelombre"
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
	name = "Héraut Volazj"
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
	name = "Krik'thir le Gardien de porte"
})

L:SetWarningLocalization({
	WarningCurse	= spell
})

L:SetTimerLocalization({
	TimerCurse		= spell
})

L:SetOptionLocalization({
	WarningCurse 	= optionWarning:format(GetSpellInfo(52592)),
	TimerCurse		= optionTimerDur:format(GetSpellInfo(52592))
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


-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Groupe)"
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
	name = "Grancrochet"
})

L:SetWarningLocalization({
	WarningChains	= debuff
})

L:SetTimerLocalization({
	TimerChains		= debuff,
	TimerChainsCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(52696)),
	TimerChains		= optionTimerDur:format(GetSpellInfo(52696)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(52696))
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm le Façonneur de chair"
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
	TimerCurse		= optionTimerDur:format(GetSpellInfo(58845))
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chronoseigneur Epoch"
})

L:SetWarningLocalization({
	WarningTime		= spell,
	WarningCurse	= debuff
})

L:SetTimerLocalization({
	TimerTimeCD		= spellCD,
	TimerCurse		= debuff
})

L:SetOptionLocalization({
	WarningTime		= optionWarning:format("Arrêt du temps/Warp"),	-- requires translation
	WarningCurse	= optionWarning:format(GetSpellInfo(52772)),
	TimerTimeCD		= optionTimerCD:format("Arrêt du temps/Warp"),	-- translate
	TimerCurse		= optionTimerDur:format(GetSpellInfo(52772))
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
	TimerSleep		= debuff,
	TimerSleepCD	= spellCD
})

L:SetOptionLocalization({
	WarningSleep	= optionWarning:format(GetSpellInfo(52721)),
	TimerSleep		= optionTimerDur:format(GetSpellInfo(52721)),
	TimerSleepCD	= optionTimerCD:format(GetSpellInfo(52721))
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Vagues de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow	= "Vague %d: %s",
})

L:SetTimerLocalization({
	TimerWaveIn		= 	"Prochaine vague (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("New Wave"),
	TimerWaveIn		= "Montre le timer \"Prochaine vague\" (vague 6 seulement)",
})


L:SetMiscLocalization({
	Meathook	= "Grancrochet",
	Salramm		= "Salramm le Façonneur de chair",
	Devouring	= "Goule dévorante",
	Enraged		= "Goule enragée",
	Necro		= "Nécromancien",
	Friend		= "Démon des cryptes",
	Tomb		= "Traqueur des tombes",
	Abom		= "Assemblage recousu",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s et %d %s",
	Wave3		= "%d %s, %d %s et %d %s",
	Wave4		= "%d %s, %d %s, %d %s et %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Vagues du Fléau = %d/10"
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Trollétripe"
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
	name = "Novos l'Invocateur"
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
	name = "Roi Dred"
})

L:SetWarningLocalization({
	WarningFear		= spell,
	WarningBite		= debuff,
	WarningSlash	= spell
})

L:SetTimerLocalization({
	TimerFear		= spellCD,
	TimerSlash		= debuff,
	TimerSlashCD	= spellCD
})

L:SetOptionLocalization({
	WarningSlash	= optionWarning:format("Entaille transperçante/mutilante"), 	-- needs translation
	WarningFear		= optionWarning:format(GetSpellInfo(22686)),
	WarningBite		= optionWarning:format(GetSpellInfo(48920)),
	TimerFear		= optionTimerCD:format(GetSpellInfo(22686)),
	TimerSlash		= optionTimerDur:format("Entaille transperçante/mutilante"), 	-- needs translation
	TimerSlashCD	= optionTimerCD:format("Entaille transperçante/mutilante") 	-- needs translation
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Le prophète Tharon'ja"
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
	name = "Colosse drakkari"
})

L:SetWarningLocalization({
	warningElemental	= "Phase Elémentaire",
	WarningStone		= "Phase Colosse"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Activer l'annonce de la phase Elémentaire",
	WarningStone		= "Activer l'annonce de la phase Colosse"
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
	name = "Eck le Féroce"
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
	name = "Général Bjarngrim"
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
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Loken"
})

L:SetWarningLocalization({
	WarningNova		= spell
})

L:SetTimerLocalization({
	TimerNovaCD		= spellCD
})

L:SetOptionLocalization({
	WarningNova		= optionWarning:format(GetSpellInfo(52960)),
	TimerNovaCD		= optionTimerCD:format(GetSpellInfo(52960))
})


--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Damoiselle de peine"
})

L:SetWarningLocalization({
	WarningWoe	= debuff,
	WarningSorrow	= spell,
	WarningStorm	= spell
})

L:SetTimerLocalization({
	TimerWoe		= debuff,
	TimerSorrow		= spell,
	TimerSorrowCD	= spellCD,
	TimerStormCD	= spellCD
})

L:SetOptionLocalization({
	WarningWoe		= optionWarning:format(GetSpellInfo(50761)),
	WarningSorrow	= optionWarning:format(GetSpellInfo(50760)),
	WarningStorm	= optionWarning:format(GetSpellInfo(50752)),
	TimerWoe		= optionTimerDur:format(GetSpellInfo(50761)),
	TimerSorrow		= optionTimerDur:format(GetSpellInfo(50760)),
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
	name = "Sjonnir le Sculptefer"
})

L:SetWarningLocalization({
	WarningCharge	= debuff,
	WarningRing		= spell
})

L:SetTimerLocalization({
	TimerCharge		= debuff,
	TimerChargeCD	= spellCD,
	TimerRingCD		= spellCD
})

L:SetOptionLocalization({
	WarningCharge	= optionWarning:format(GetSpellInfo(50834)),
	WarningRing		= optionWarning:format(GetSpellInfo(50840)),
	TimerCharge		= optionTimerDur:format(GetSpellInfo(50834)),
	TimerChargeCD	= optionTimerCD:format(GetSpellInfo(50834)),
	TimerRingCD		= optionTimerCD:format(GetSpellInfo(50840))
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Tribunal des ages"
})

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Phase #")
})

L:SetMiscLocalization({
	Pull	= "Time to get some answers! Let's get this show on the road!",
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
	name = "Ormorok le Sculpte-arbre"
})

L:SetWarningLocalization({
	WarningSpikes		= spell,
	WarningReflection	= spell,
	WarningFrenzy		= spell,
	WarningAdd			= spell
})

L:SetTimerLocalization({
	TimerReflection		= spell,
	TimerReflectionCD	= spellCD
})

L:SetOptionLocalization({
	WarningSpikes		= optionWarning:format(GetSpellInfo(47958)),
	WarningReflection	= optionWarning:format(GetSpellInfo(47981)),
	WarningFrenzy		= optionWarning:format(GetSpellInfo(48017)),
	WarningAdd			= optionWarning:format(GetSpellInfo(61564)),
	TimerReflection		= optionTimerDur:format(GetSpellInfo(47981)),
	TiemrReflectionCD	= optionTimerCD:format(GetSpellInfo(47981))
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Grand magus Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Dédoublement imminent",
	WarningSplitNow		= "Dédoublement",
	WarningMerge		= "Rassemblement"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Dédoublement"),
	WarningSplitNow		= optionWarning:format("Dédoublement"),
	WarningMerge		= optionWarning:format("Rassemblement")
})

L:SetMiscLocalization({
	SplitTrigger1 	= "Il y en aura assez pour tout le monde.",
	SplitTrigger2 	= "Vous allez être trop bien servis !",
	MergeTrigger 	= "Et maintenant finissons le travail !"
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
	WarningNova		= spell
})

L:SetTimerLocalization({
	TimerChains		= debuff,
	TimerNova		= spell,
	TimerChainsCD	= spellCD,
	TimerNovaCD		= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(50997)),
	WarningNova		= optionWarning:format(GetSpellInfo(48179)),
	WarningEnrage	= optionWarning:format(GetSpellInfo(8599)),
	TimerChains		= optionTimerDur:format(GetSpellInfo(50997)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(50997)),
	TimerNova		= optionTimerDur:format(GetSpellInfo(48179)),
	TimerNovaCD		= optionTimerCD:format(GetSpellInfo(48179))
})


---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commandant Rudebarbe"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
	WarningFear 		= spell,
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
	TimerFearCD			= spellCD,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningFear			= optionWarning:format(GetSpellInfo(19134)),
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(38619)),
	TimerFearCD			= optionTimerCD:format(GetSpellInfo(19134)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(38619))
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = " Drakos l'Interrogateur"
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
	name = "Seigneur-mage Urom"
})

L:SetWarningLocalization({
	WarningTimeBomb 	= debuff,
	WarningExplosion 	= spell
})

L:SetTimerLocalization({
	TimerTimeBomb 		= debuff,
	TimerExplosion 		= spell
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
	name = "Varos Arpentenuée"
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
	name = "Gardien-tellurique Eregos"
})

L:SetWarningLocalization({
	WarningShift	= spell,
	WarningEnrage	= spell,
	WarningShiftEnd	= "Changement de plan terminé"		-- translate
})

L:SetTimerLocalization({
	TimerShift	= spell,
	TimerEnrage	= spell
})

L:SetOptionLocalization({
	WarningShift	= optionWarning:format(GetSpellInfo(51162)),
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." terminé"), 	-- translate the word 'ending'
	WarningEnrage	= optionWarning:format(GetSpellInfo(51170)),
	TimerShift		= optionTimerDur:format(GetSpellInfo(51162)),
	TimerEnrage		= optionTimerDur:format(GetSpellInfo(51170))
})



------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Prince Keleseth"
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
	name = "Constructeur & Contrôleur"
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
	name = "Ingvar le Pilleur"
})

L:SetWarningLocalization({
	WarningSmash			= spell,
	WarningGrowl			= spell,
	WarningWoeStrike		= debuff,
	SpecialWarningSpelllock = "Renvoi des sorts !!"
})

L:SetTimerLocalization({
	TimerSmash				= spell,
	TimerWoeStrike			= debuff
})

L:SetOptionLocalization({
	WarningSmash			= optionWarning:format(GetSpellInfo(42723)),
	WarningGrowl			= optionWarning:format(GetSpellInfo(42708)),
	WarningWoeStrike		= optionWarning:format(GetSpellInfo(42730)),
	TimerSmash				= optionTimerCast:format(GetSpellInfo(42723)),
	TimerWoeStrike			= optionTimerDur:format(GetSpellInfo(42730)),
	SpecialWarningSpelllock	= "Montre une alerte spéciale pour spell lock"
})


----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi le Brutal"
})

L:SetWarningLocalization({
	WarningWhirlwind	= spell,
	WarningPoison		= debuff
})

L:SetTimerLocalization({
	TimerPoison			= debuff,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(59332)),
	WarningPoison		= optionWarning:format(GetSpellInfo(59331)),
	TimerPoison			= optionTimerDur:format(GetSpellInfo(59331)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(59332))
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Roi Ymiron"
})

L:SetWarningLocalization({
	WarningBane		= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane		= optionWarning:format(GetSpellInfo(48294))
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tristetombe"
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
	name = "Gortok Pâle-sabot"
})

L:SetWarningLocalization({
	WarningImpale	= debuff
})

L:SetTimerLocalization({
	TimerImpale		= debuff
})

L:SetOptionLocalization({
	WarningImpale	= optionWarning:format(GetSpellInfo(48261)),
	TimerImpale		= optionTimerDur:format(GetSpellInfo(48261))
})


---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cyanigosa"
})

L:SetWarningLocalization({
	WarningVacuum		= spell,
	WarningBlizzard		= spell,
	WarningMana			= debuff
})

L:SetTimerLocalization({
	TimerVacuumCD		= spellCD,
	TimerMana			= debuff
})

L:SetOptionLocalization({
	WarningVacuum		= optionWarning:format(GetSpellInfo(58694)),
	WarningBlizzard		= optionWarning:format(GetSpellInfo(58693)),
	WarningMana			= optionWarning:format(GetSpellInfo(59374)),
	TimerMana			= optionTimerDur:format(GetSpellInfo(59374)),
	TimerVacuumCD		= optionTimerCD:format(GetSpellInfo(58694))
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
	name = "Ichoron"
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
	WarningLink			= debuff
})

L:SetTimerLocalization({
	TimerLink			= debuff,
	TimerLinkCD			= spellCD
})

L:SetOptionLocalization({
	WarningLink			= optionWarning:format(GetSpellInfo(54396)),
	TimerLink			= optionTimerDur:format(GetSpellInfo(54396)),
	TimerLinkCD			= optionTimerCD:format(GetSpellInfo(54396))
})


------------
-- Xevoss --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevoss"
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
	name = "Zuramat l'Oblitérateur"
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
	name = "Timer des portails"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Portail imminent",
	WarningPortalNow	= "Portail #%d",
	WarningBossNow		= "Arrivé d'un boss"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portail #%d" ,
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Portail"),
	WarningPortalSoon		= optionPreWarning:format("Portail imminent"),
	WarningBossNow			= optionWarning:format("Arrivé d'un boss"),
	TimerPortalIn			= "Afficher le timer des portails",
	ShowAllPortalWarnings	= "Activer les annonces pour toutes les vagues"
})


L:SetMiscLocalization({
	yell1 = "Gardes, nous partons ! Ces aventuriers vont se charger de la suite ! Allez, en route !",
})


---------------------
-- Trial of the Champion --
---------------------
-------------------
-- The Black Knight --
-------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Le Chevalier noir"
})

L:SetWarningLocalization({
	specWarnDesecration		= "Violation ! Bougez !",
	warnExplode				= "Séide goule incante explosion ! Bougez !"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Montre une alerte spéciale quand vous prenez des dégâts venant de la Violation",
	warnExplode				= "Montre une alerte quand une Séide goule incante explosion sur elle-même",
	SetIconOnMarkedTarget	= "Met une icône sur la cible de la mort"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Non ! Pas encore... un échec..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetWarningLocalization({
	specWarnHaste		= "Hâte sur >%s< ! Dispell Maintenant !",
	specWarnPoison		= "Poison ! Bougez !"
})

L:SetOptionLocalization({
	specWarnHaste		= "Montre une alerte spéciale quand le mage gagne la hâte (pour Dispell/Voler)",
	specWarnPoison		= "Montre une alerte spéciale quand vous subissez des dégâts provenant de la Bouteille de poison"
})

L:SetMiscLocalization({
	YellCombatEnd		= "Joli combat ! Votre prochain défi vient directement des rangs de la Croisade. L'épreuve sera de vous mesurer à l'incroyable vituosité de ses cavaliers."
})

-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Confesseur d'argent Paletress"
})

L:SetWarningLocalization({
	specwarnRenew			= "Paletress incante une rénovation sur >%s<. Dispell Maintenant !"
})

L:SetOptionLocalization({
	specwarnRenew			= "Montre une alerte spéciale pour la cible de la rénovation (pour Dispell/Voler)"
})

L:SetMiscLocalization({
--	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric le Pur"
})

L:SetWarningLocalization({
	specwarnHammerofJustice	= "Marteau de la justice sur >%s<. Dispell Maintenant !",
	specwarnRadiance		= "Radiance. Retournez vous !"
})

L:SetOptionLocalization({
	specwarnHammerofJustice	= "Montre une alerte spéciale pour le Marteau de la justice (pour Dispell)",
	specwarnRadiance		= "Montre une alerte spéciale pour Radiance.",
	SetIconOnHammerTarget	= "Met une icône sur la cible du Marteau du vertueux"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Grâce ! Je me rends. Excellent travail. Puis-je me débiner, maintenant ?"
})

---------------------
--  World Events  --
-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Navrebière"
})

L:SetWarningLocalization({
	warnBarrel			= "Tonneau sur >%s<", 
--	specwarnDaughters	= "Daughter Spawned!",
	specwarnDisarm		= "Désarmement. Bougez !",
	specWarnBrew		= "Débarrassez-vous de la bière avant qu'elle ne vous en lance une autre !",
	specWarnBrewStun	= "Vous avez reçu un coup sur la tête. La prochaine fois, videz votre verre !"
})

L:SetOptionLocalization({
	warnBarrel			= "Annonce la cible du Tonneau.",
--	specwarnDaughters	= "Announce Spawns of Ursula/Ilsa",
	DisarmWarning		= "Montre une alerte spéciale pour le désarmement",
	specWarnBrew		= "Montre une alerte spéciale pour la Sombrebière de la vierge",
	specWarnBrewStun	= "Montre une alerte spéciale pour l'Etourdir de la vierge bierrière",
	PlaySoundOnDisarm	= "Joue un son pour le désarmement",
	YellOnBarrel		= "Crie quand vous avez un Tonneau sur vous"
})

L:SetMiscLocalization({
	YellBarrel			= "Tonneau sur moi !"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Cavalier sans tête"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Arrivée des Citrouilles vibrantes !",
	specWarnHorsemanHead		= "Tapez la Tête du Cavalier"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Montre une alerte pour l'arrivée des Citrouilles vibrantes",
	specWarnHorsemanHead		= "Montre une alerte spéciale pour l'arrivée de la Tête du Cavalier"
})

L:SetMiscLocalization({
	HorsemanHead				= "Viens donc ici , sombre abruti !",  -- Attention, espace avant la virgule
	HorsemanSoldiers			= "Levez-vous, mes recrues ! Au combat sans surseoir ! Au chevalier déchu, donnez enfin victoire !",
	SayCombatEnd				= "Je la connais trop bien, cette fin importune. Que faut-il au destin pour changer ma fortune ?"
})

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick"
})

L:SetWarningLocalization({
	warnPursuit				= "Pursuit in 5 seconds",
	specWarnToxic			= "Déchets toxiques ! Bougez !",
	specWarnPursuit			= "Vous êtes poursuivi ! Courrez !"
})

L:SetOptionLocalization({
	warnPursuit				= "Montre une alerte lorsque la Poursuite est pour bientôt",
	specWarnToxic			= "Montre une alerte spéciale lorsque vous prenez des dégâts des Déchets toxiques",
	specWarnPursuit			= "Montre une alerte spéciale lorsque vous êtes poursuivi"
--	SetIconOnPursuitTarget	= "Met une icône sur la cible de la Poursuite"
})

L:SetMiscLocalization({
	IckPursuit				= "%s is chasing you!"
})
-------------------
-- Forgemaster Garfrost --
-------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Maître-forge Gargivre"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Rocher de Saronite ! Ligne de Vue maintenant !",
	specWarnSaroniteRock		= "Lancer de Saronite sur vous ! Bougez !",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Montre une alerte for Saronite Rock (to clear Permafrost)",
	specWarnSaroniteRock		= "Montre une alerte spéciale lorsque le Lancer de Saronite est sur vous",
	specWarnPermafrost			= "Montre une alerte spéciale when Permafrost stacks get to high (value not set in stone)"
--	SetIconOnSaroniteRockTarget	= "Met une icône sur la cible du Rocher de Saronite"
})

L:SetMiscLocalization({
	SaroniteRockThrow			= "%s hurls a massive saronite boulder at you!"
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Seigneur du Fléau Tyrannus"
})

L:SetWarningLocalization({
	specTyrannusEngaged			= "Seigneur du Fléau Tyrannus descend. Préparez-vous !",
	specWarnIcyBlast			= "Icy Blast! Bougez !",
	specWarnHoarfrost			= "Hoarfrost on you!",
	specWarnHoarfrostNear		= "Hoarfrost near to you! Bougez !"
})

L:SetOptionLocalization({
	specWarnIcyBlast			= "Montre une alerte spéciale when you take damage from Icy Blast",
	specWarnHoarfrost			= "Montre une alerte spéciale when Hoarfrost on you",
	specWarnHoarfrostNear		= "Montre une alerte spéciale when Hoarfrost near you",
	SetIconOnHoarfrostTarget	= "Met une icône sur la cible Hoarfrost target"
})

L:SetMiscLocalization({
	TyrannusYell				= "Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "^%%s gazes at (%S+) and readies an icy attack!"
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
	specwarnSoulstorm		= "Tempête d'âme ! Allez au centre !"
})

L:SetOptionLocalization({
	specwarnSoulstorm		= "Montre une alerte spéciale lorsque Tempête d'âme est lancé (pour aller au centre)"
})

L:SetMiscLocalization({
--	YellPull				= "De nouvelles âmes pour alimenter le moteur !"
--	YellCombatEnd			= "Mon âme vous appartient, maître."
})

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Dévoreur d'âmes"
})

L:SetWarningLocalization({
	specwarnMirroredSoul		= "Âme réfléchie ! Stop DPS !"
})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "Montre une alerte spéciale pour arrêter le DPS lorsque vous êtes la cible d'Âme réfléchie"
})
