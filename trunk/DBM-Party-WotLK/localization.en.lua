local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s cooldown"			-- translate
local spellSoon			= "%s soon"			-- translate
local optionWarning		= "Show warning for %s"		-- translate
local optionPreWarning	= "Show pre-warning for %s"	-- translate
local optionSpecWarning	= "Show special warning for %s"	-- translate
local optionTimerCD		= "Show timer for %s cooldown"	-- translate
local optionTimerDur	= "Show timer for %s duration"	-- translate
local optionTimerCast	= "Show timer for %s cast"	-- translate


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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Elder Nadox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Shadowseeker"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Herald Volazj"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------
--  Amanitar  --
----------------
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------
--  Hadronox  --
----------------
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


-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Party)"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm the Fleshcrafter"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chrono-Lord Epoch"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------
--  Mal'Ganis  --
-----------------
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
	TimerWaveIn		= "Next wave (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("new wave"),
	TimerWaveIn		= "Show timer for next wave (wave 6 only)",
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "The Prophet Tharon'ja"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
--  Moorabi  --
---------------
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


-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Drakkari Colossus"
})

L:SetWarningLocalization({
	WarningElemental	= "Elemental phase",		-- translate :)
	WarningStone		= "Colossus phase"		-- translate :)
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Show warning for Elemental phase",	-- translate ;)
	WarningStone		= "Show warning for Colossus phase"		-- translate :)
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningPhase	= optionWarning:format("phase number")
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
})

L:SetOptionLocalization({
})


-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok the Tree-Shaper"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningSplitSoon	= "Show warning for split soon",	-- translate
	WarningSplitNow		= "Show warning for split",	-- translate
	WarningMerge		= "Show warning for Merge"	-- translate
})

L:SetMiscLocalization({
	SplitTrigger1		= "There's plenty of me to go around.",		-- translate
	SplitTrigger2		= "I'll give you more than you can handle.",	-- translate
	MergeTrigger		= "Now to finish the job!"				-- translate
})


-------------------
--  Keristrasza  --
-------------------
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningExplosion	= spell,
	SpecWarnBombYou 	= "Time Bomb on you"
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
	SpecWarnBombYou		= "Show special warning for Time Bomb on you"
})


--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Cloudstrider"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Ley-Guardian Eregos"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "Planar Shift ending"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." ending") 	-- translate the word 'ending'
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar the Plunderer"
})

L:SetWarningLocalization({
	SpecialWarningSpelllock = "Spell lock - Stop casting"  -- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningSpelllock	= "Show special warning for spell lock"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "King Ymiron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Sorrowgrave"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Palehoof"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------
--  Erekem  --
--------------
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
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
	WarningPortalNow		= optionWarning:format("new portal"),
	WarningPortalSoon		= optionPreWarning:format("new portal"),
	WarningBossNow			= optionWarning:format("boss incoming"),
	TimerPortalIn			= "Show timer for portal number",
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
	specwarnDisarm			= "Disarm - Move away",
	specWarnBrew			= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun		= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	warnBarrel				= "Announce Barrel target",
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
	specWarnHorsemanHead		= "Show special warning for Head of the Horseman spawn (2nd and later)"
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
	warnPursuit				= "Show pre-warning for pursue",
	specWarnToxic			= "Show special warning when you take damage from Toxic Waste",
	specWarnPursuit			= "Show special warning when you are being pursued"
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
