local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s cooldown"			-- translate
local spellSoon			= "%s soon"			-- translate
local optionWarning		= "Show warning for \"%s\""		-- translate
local optionPreWarning	= "Show pre-warning for \"%s\""	-- translate
local optionSpecWarning	= "Show special warning for \"%s\""	-- translate
local optionTimerCD		= "Show timer for \"%s\" cooldown"	-- translate
local optionTimerDur	= "Show timer for \"%s\" duration"	-- translate
local optionTimerCast	= "Show timer for \"%s\" cast"	-- translate


----------------------------------
--  Ahn’Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
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


-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Elder Nadox"
})

L:SetWarningLocalization({
	WarningPlague	= debuff
})

L:SetTimerLocalization({
	TimerPlague		= debuff
})

L:SetOptionLocalization({
	WarningPlague	= optionWarning:format(GetSpellInfo(56130)),
	TimerPlague		= optionTimerDur:format(GetSpellInfo(56130))
})


---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Shadowseeker"
})

L:SetWarningLocalization({
	WarningThundershock		= spell,
	WarningCycloneStrike	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock		= optionWarning:format(GetSpellInfo(56926)),
	WarningCycloneStrike	= optionWarning:format(GetSpellInfo(60030))
})


---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Herald Volazj"
})

L:SetWarningLocalization({
	WarningInsanity	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningInsanity	= optionWarning:format(GetSpellInfo(57496))
})


----------------
--  Amanitar  --
----------------
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


-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir the Gatewatcher"
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


----------------
--  Hadronox  --
----------------
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
	name = "Anub'arak (Party)"
})

L:SetWarningLocalization({
	WarningPound	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPound	= optionWarning:format(GetSpellInfo(53472)),
})


---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Meathook"
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


--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm the Fleshcrafter"
})

L:SetWarningLocalization({
	WarningCurse	= debuff,
	WarningSteal	= debuff,
	WarningGhoul	= spell
})

L:SetTimerLocalization({
	TimerGhoulCD	= spellCD,
	TimerCurse		= debuff
})

L:SetOptionLocalization({
	WarningCurse	= optionWarning:format(GetSpellInfo(58845)),
	WarningSteal	= optionWarning:format(GetSpellInfo(52709)),
	WarningGhoul	= optionWarning:format(GetSpellInfo(52451)),
	TimerGhoulCD	= optionTimerCD:format(GetSpellInfo(52451)),
	TimerCurse		= optionTimerDur:format(GetSpellInfo(58845))
})


-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chrono-Lord Epoch"
})

L:SetWarningLocalization({
	WarningTime		= spell,
	WarningCurse	= debuff
})

L:SetTimerLocalization({
	TimerTimeCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningTime		= optionWarning:format("Time Stop/Warp"),	-- requires translation
	WarningCurse	= optionWarning:format(GetSpellInfo(52772)),
	TimerTimeCD		= optionTimerCD:format("Time Stop/Warp"),	-- translate
	TimerCurse		= optionTimerDur:format(GetSpellInfo(52772))
})


-----------------
--  Mal'Ganis  --
-----------------
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

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Stratholme Waves"
})

L:SetWarningLocalization({
	WarningWaveNow	= "Wave %d: %s spawned",
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"Next Wave (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("New Wave"),
	TimerWaveIn		= "Show \"Next Wave\" timer (wave 6 only)",
})


L:SetMiscLocalization({
	Meathook	= "Meathook",
	Salramm		= "Salramm the Fleshcrafter",
	Devouring	= "Devouring Ghoul",
	Enraged		= "Enraged Ghoul",
	Necro		= "Necromancer",
	Friend		= "Crypt Friend",
	Tomb		= "Tomb Stalker",
	Abom		= "Patchwork Construct",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Scourge Wave = %d/10"
})


------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Trollgore"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos the Summoner"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "King Dred"
})

L:SetWarningLocalization({
	WarningFear		= spell,
	WarningBite		= debuff,
	WarningSlash	= spell
})

L:SetTimerLocalization({
	TimerFearCD		= spellCD,
	TimerSlash		= debuff,
	TimerSlashCD	= spellCD
})

L:SetOptionLocalization({
	WarningSlash	= optionWarning:format("Mangling/Piercing Slash"), 	-- needs translation
	WarningFear		= optionWarning:format(GetSpellInfo(22686)),
	WarningBite		= optionWarning:format(GetSpellInfo(48920)),
	TimerFearCD		= optionTimerCD:format(GetSpellInfo(22686)),
	TimerSlash		= optionTimerDur:format("Mangling/Piercing Slash"), -- needs translation
	TimerSlashCD	= optionTimerCD:format("Mangling/Piercing Slash") 	-- needs translation
})


-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "The Prophet Tharon'ja"
})

L:SetWarningLocalization({
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCloud	= optionWarning:format(GetSpellInfo(49548))
})


---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
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


---------------
--  Moorabi  --
---------------
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


-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Drakkari Colossus"
})

L:SetWarningLocalization({
	WarningElemental	= "Elemental Phase",		-- translate :)
	WarningStone		= "Colossus Phase"		-- translate :)
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Show warning for Elemental Phase",	-- translate ;)
	WarningStone		= "Show warning for Colossus Phase"		-- translate :)
})


-----------------
--  Gal'darah  --
-----------------
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

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Eck the Ferocious"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
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


-------------
--  Ionar  --
-------------
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


---------------
--  Volkhan  --
---------------
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


--------------
--  Kronus  --
--------------
L = DBM:GetModLocalization("Kronus")

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
	WarningNova	= optionWarning:format(GetSpellInfo(52960)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(52960))
})


----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Maiden of Grief"
})

L:SetWarningLocalization({
	WarningWoe		= debuff,
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


------------------
--  Krystallus  --
------------------
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


------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir the Ironshaper"
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


--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Escort Event"
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

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
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


-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok the Tree-Shaper"
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
	TimerReflectionCD	= optionTimerCD:format(GetSpellInfo(47981))
})


----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Grand Magus Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon",		-- translate
	WarningSplitNow		= "Split",		-- translate
	WarningMerge		= "Merge"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Split"),	-- translate
	WarningSplitNow		= optionWarning:format("Split"),	-- translate
	WarningMerge		= optionWarning:format("Merge"),	-- translate
})

L:SetMiscLocalization({
	SplitTrigger1	= "There's plenty of me to go around.",		-- translate
	SplitTrigger2	= "I'll give you more than you can handle.",	-- translate
	MergeTrigger	= "Now to finish the job!"				-- translate
})


-------------------
--  Keristrasza  --
-------------------
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


-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commander Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commander Stoutbeard"
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


------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos the Interrogator"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Mage-Lord Urom"
})

L:SetWarningLocalization({
	WarningTimeBomb		= debuff,
	WarningExplosion	= spell
})

L:SetTimerLocalization({
	TimerTimeBomb	= debuff,
	TimerExplosion	= spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou 	= optionSpecWarning:format(GetSpellInfo(51121))
})


--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Cloudstrider"
})

L:SetWarningLocalization({
	WarningAmplify	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningAmplify	= optionWarning:format(GetSpellInfo(51054))
})


---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Ley-Guardian Eregos"
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
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." ending"), 	-- translate the word 'ending'
	WarningEnrage	= optionWarning:format(GetSpellInfo(51170)),
	TimerShift		= optionTimerDur:format(GetSpellInfo(51162)),
	TimerEnrage		= optionTimerDur:format(GetSpellInfo(51170))
})



--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
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


--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Skarvald & Dalronn"
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


----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar the Plunderer"
})

L:SetWarningLocalization({
	WarningSmash			= spell,
	WarningGrowl			= spell,
	WarningWoeStrike		= debuff,
	SpecialWarningSpelllock = "Spell lock - Stop casting"  -- translate
})

L:SetTimerLocalization({
	TimerSmash		= spell,
	TimerWoeStrike	= debuff
})

L:SetOptionLocalization({
	WarningSmash			= optionWarning:format(GetSpellInfo(42723)),
	WarningGrowl			= optionWarning:format(GetSpellInfo(42708)),
	WarningWoeStrike		= optionWarning:format(GetSpellInfo(42730)),
	TimerSmash				= optionTimerCast:format(GetSpellInfo(42723)),
	TimerWoeStrike			= optionTimerDur:format(GetSpellInfo(42730)),
	SpecialWarningSpellock	= "Show special warning for spell lock"
})


------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi the Ruthless"
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

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "King Ymiron"
})

L:SetWarningLocalization({
	WarningBane	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= optionWarning:format(GetSpellInfo(48294))
})


-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Sorrowgrave"
})

L:SetWarningLocalization({
	WarningSword	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSword	= optionWarning:format(GetSpellInfo(48276))
})


-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Palehoof"
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


-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cyanigosa"
})

L:SetWarningLocalization({
	WarningVacuum	= spell,
	WarningBlizzard	= spell,
	WarningMana		= debuff
})

L:SetTimerLocalization({
	TimerVacuumCD	= spellCD,
	TimerMana		= debuff
})

L:SetOptionLocalization({
	WarningVacuum	= optionWarning:format(GetSpellInfo(58694)),
	WarningBlizzard	= optionWarning:format(GetSpellInfo(58693)),
	WarningMana		= optionWarning:format(GetSpellInfo(59374)),
	TimerMana		= optionTimerDur:format(GetSpellInfo(59374)),
	TimerVacuumCD	= optionTimerCD:format(GetSpellInfo(58694))
})


--------------
--  Erekem  --
--------------
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


---------------
--  Ichoron  --
---------------
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


-----------------
--  Lavanthor  --
-----------------
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


--------------
--  Moragg  --
--------------
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


--------------
--  Xevozz  --
--------------
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


-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat the Obliterator"
})

L:SetWarningLocalization({
	WarningVoidShift			= debuff,
	WarningVoidShifted			= debuff,
	WarningShroudOfDarkness		= spell,
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
	TimerVoidShift		= debuff,
	TimerVoidShifted	= debuff
})

L:SetOptionLocalization({
	WarningVoidShift			= optionWarning:format(GetSpellInfo(59743)),
	WarningVoidShifted			= optionWarning:format(GetSpellInfo(59343)),
	WarningShroudOfDarkness		= optionWarning:format(GetSpellInfo(59745)),
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(59343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745)),
	TimerVoidShift				= optionTimerDur:format(GetSpellInfo(59743)),
	TimerVoidShifted			= optionTimerDur:format(GetSpellInfo(59343))
})


---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Portal Timers"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New portal soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("New portal"),
	WarningPortalSoon		= optionPreWarning:format("New portal"),
	WarningBossNow			= optionWarning:format("Boss incoming"),
	TimerPortalIn			= "Show \"Portal: #\" timer",
	ShowAllPortalWarnings	= "Show warnings for all waves"
})


L:SetMiscLocalization({
	yell1		= "Prison guards, we are leaving! These adventurers are taking over! Go go go!",
	WavePortal	= "Portals Opened: (%d+)/18"
})


-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "The Black Knight"
})

L:SetWarningLocalization({
	specWarnDesecration		= "Desecration - Move away",
	warnExplode				= "Ghoul Minion is casting Explode - Move away"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Show special warning when you take damage from Desecration",
	warnExplode				= "Show warning when Ghoul Minion is about to explode",
	SetIconOnMarkedTarget	= "Set icon on Marked For Death target"
})

L:SetMiscLocalization({
	YellCombatEnd			= "My congratulations, champions. Through trials both planned and unexpected, you have triumphed."	-- can also be "No! I must not fail... again ..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetWarningLocalization({
	specWarnHaste			= "Haste on >%s< - Dispel now",
	specWarnPoison			= "Poison - Move away",
})

L:SetOptionLocalization({
	specWarnHaste			= "Show special warning when Mage gains Haste (to dispel/steal)",
	specWarnPoison			= "Show special warning when you take damage from Vial of Poison"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Argent Confessor Paletress"
})

L:SetWarningLocalization({
specwarnRenew				= "Confessor casts renew on >%s< - Dispel now"
})

L:SetOptionLocalization({
specwarnRenew				= "Show special warning for Renew target (to dispel/steal)"
})

L:SetMiscLocalization({
--	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric the Pure"
})

L:SetWarningLocalization({
	specwarnHammerofJustice		= "Hammer of Justice on >%s< - Dispel now",
	specwarnRadiance			= "Radiance - Look away"
})

L:SetOptionLocalization({
	specwarnHammerofJustice		= "Show special warning for Hammer of Justice (to dispel)",
	specwarnRadiance			= "Show special warning for Radiance",
	SetIconOnHammerTarget		= "Set icon on Hammer of Justice target"
})

L:SetMiscLocalization({
--	YellCombatEnd				= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

--------------------
--  World Events  --
----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Direbrew"
})

L:SetWarningLocalization({
	warnBarrel				= "Barrel on >%s<", 
--	specwarnDaughters		= "Daughter Spawned!",
	specwarnDisarm			= "Disarm - Move away",
	specWarnBrew			= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun		= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	warnBarrel				= "Announce Barrel target",
--	specwarnDaughters		= "Announce Spawns of Ursula/Ilsa",
	DisarmWarning			= "Show special warning for Disarm",
	specWarnBrew			= "Show special warning for Dark Brewmaiden's Brew",
	specWarnBrewStun		= "Show special warning for Dark Brewmaiden's Stun",
	PlaySoundOnDisarm		= "Play sound on Disarm",
	YellOnBarrel			= "Yell on Barrel"
})

L:SetMiscLocalization({
	YellBarrel				= "Barrel on me!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Headless Horseman"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Pulsing Pumpkin spawning",
	specWarnHorsemanHead		= "Head spawned - Switch to the head"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Show warning for Pulsing Pumpkin spawn",
	specWarnHorsemanHead		= "Show special warning for Head of the Horseman spawn"
})

L:SetMiscLocalization({
	HorsemanHead				= "Get over here, you idiot!",
	HorsemanSoldiers			= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!",
	SayCombatEnd				= "This end have I reached before.  What new adventure lies in store?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick and Krick"
})

L:SetWarningLocalization({
	warnPursuit			= "Pursuit in 5 seconds",
	specWarnToxic		= "Toxic Waste - Move away",
	specWarnPursuit		= "You are being pursued - Run away"
})

L:SetOptionLocalization({
	warnPursuit			= "Show pre-warning for pursue",
	specWarnToxic		= "Show special warning when you take damage from Toxic Waste",
	specWarnPursuit		= "Show special warning when you are being pursued"
--	SetIconOnPursuitTarget	= "Set icon on Pursuit target"
})

L:SetMiscLocalization({
	IckPursuit			= "%s is chasing you!"
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Forgemaster Garfrost"
})

L:SetWarningLocalization({
	warnSaroniteRock		= "Saronite Rock - Line of sight now",
	specWarnSaroniteRock	= "Saronite Throw on you - Move",
	specWarnPermafrost		= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Show warning for Saronite Rock (to clear Permafrost)",
	specWarnSaroniteRock		= "Show special warning when you are affected by Saronite Throw",
	specWarnPermafrost			= "Show special warning when Permafrost stacks get too high (value not set in stone)"
--	SetIconOnSaroniteRockTarget	= "Set icon on Saronite Rock target"
})

L:SetMiscLocalization({
	SaroniteRockThrow		= "%s hurls a massive saronite boulder at you!"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Scourgelord Tyrannus"
})

L:SetWarningLocalization({
	specTyrannusEngaged			= "Scourgelord Tyrannus is coming down - Get ready",
	specWarnIcyBlast			= "Icy Blast - Move away",
	specWarnHoarfrost			= "Hoarfrost on you",
	specWarnHoarfrostNear		= "Hoarfrost near you - Move"
})

L:SetOptionLocalization({
	specWarnIcyBlast			= "Show special warning when you take damage from Icy Blast",
	specWarnHoarfrost			= "Show special warning when you are affected by Hoarfrost",
	specWarnHoarfrostNear		= "Show special warning for Hoarfrost near you",
	SetIconOnHoarfrostTarget	= "Set icon on Hoarfrost target"
})

L:SetMiscLocalization({
	TyrannusYell		= "Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget		= "^%%s gazes at (%S+) and readies an icy attack!"
})
----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Bronjahm"
})

L:SetWarningLocalization({
	specwarnSoulstorm		= "Soulstorm - Move in"
})

L:SetOptionLocalization({
	specwarnSoulstorm		= "Show special warning when Soulstorm is cast (to move in)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Devourer of Souls"
})

L:SetWarningLocalization({
	specwarnMirroredSoul		= "Stop DPS"
})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "Show special warning to stop DPS on Mirrored Soul"
})
