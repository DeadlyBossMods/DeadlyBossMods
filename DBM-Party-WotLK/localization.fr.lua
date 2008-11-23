if GetLocale() ~= "frFR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

--------------------------------
-- Ahn’Kahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prince Taldaram"
})

L:SetWarningLocalization({
	WarningFlame		= "Sphère de flamme",
	WarningEmbrace		= "Étreinte du Vampire: >%s<"
})

L:SetTimerLocalization({
	TimerEmbrace		= "Étreinte du Vampire: %s"
})

L:SetOptionLocalization({
	WarningFlame		= "Afficher Sphère de flamme alerte",
	WarningEmbrace		= "Afficher Étreinte du Vampire alerte",
	TimerEmbrace		= "Afficher Étreinte du Vampire durée timer"
})


-----------------
-- Elder Nadox --
-----------------
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


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Cherchelombre"
})

L:SetWarningLocalization({
	WarningThundershock	= "Thundershock",
	WarningPhase2Soon	= "Phase 2 Bientot",
	WarningPhase2Now	= "Phase 2"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock	= "Afficher Thundershock alerte",
	WarningPhase2Soon	= "Afficher Phase 2 pre-alerte",
	WarningPhase2Now	= "Afficher Phase 2 alerte (NYI)"
})

L:SetMiscLocalization({
	emote			= ""
})


-------------------
-- Herald Volazj --
-------------------
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


-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir the Gatewatcher"
})

L:SetWarningLocalization({
	WarningCurse	= "Malédiction de fatigue: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCurse = "Afficher Malédiction de fatigue alerte"
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
	name = "Anub'arak"
})

L:SetWarningLocalization({
	WarningBurrowSoon	= "Submerge bientot",
	WarningBurrowNow	= "Submerge",
	WarningEmerge		= "Émerge"
})

L:SetTimerLocalization({
	TimerEmerge		= "Émerge",
})

L:SetOptionLocalization({
	WarningBurrowSoon	= "Afficher Submerge pre-alerte",
	WarningBurrowNow	= "Afficher Submerge alerte (NYI)",
	WarningEmerge		= "Afficher Émerge alerte (NYI)",
	TimerEmerge		= "Afficher Émerge timer (NYI)"
})


--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Meathook"
})

L:SetWarningLocalization({
	WarningChains		= "Constricting Chains: >%s<"
})

L:SetTimerLocalization({
	TimerChains		= "Constricting Chains: %s"
})

L:SetOptionLocalization({
	WarningChains		= "Afficher Constricting Chains alerte",
	TimerChains		= "Afficher Constricting Chains timer",
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
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


-----------------------
-- Chrono-Lord Epoch --
-----------------------
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


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetWarningLocalization({
	WarningSleep		= "Dormir: >%s<"
})

L:SetTimerLocalization({
	TimerSleep		= "Dormir: %s"
})

L:SetOptionLocalization({
	WarningSleep		= "Afficher Dormir alerte",
	TimerSleep		= "Afficher Dormir durée timer"
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
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
	name = "The Prophet Tharon'ja"
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
	name = "Colosse Drakkari"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningOverload	= "Static Overload: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningOverload = "Afficher Static Overload alerte"
})


-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "Volkhan"
})

L:SetWarningLocalization({
	WarningStomp = "Shattering Stomp"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningStomp = "Afficher Shattering Stomp alerte"
})


------------
-- Kronus --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Kronus"
})

L:SetWarningLocalization({
	WarningNova	= "Lightning Nova"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningNova	= "Afficher Lightning Nova alerte"
})


--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Maiden of Grief"
})

L:SetWarningLocalization({
	WarningWoe	= "Pillar of Woe: >%s<",
	WarningSorrow	= "Shock of Sorrow",
	WarningStorm	= "Storm of Grief",
})

L:SetTimerLocalization({
	TimerWoe	= "Pillar of Woe: %s",
	TimerSorrow	= "Shock of Sorrow",
})

L:SetOptionLocalization({
	WarningWoe	= "Afficher Pillar of Woe alerte",
	WarningSorrow	= "Afficher Shock of Sorrow alerte",
	WarningStorm	= "Afficher Storm of Grief alerte",
	TimerWoe	= "Afficher Pillar of Woe duration timer",
	TimerSorrow	= "Afficher Shock of Sorrow duration timer",
})


----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "Krystallus"
})

L:SetWarningLocalization({
	WarningShatter	= "Shatter soon!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShatter	= "Afficher Shatter prealerte"
})


----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir the Ironshaper"
})

L:SetWarningLocalization({
	WarningCharge	= "Static Charge: >%s<",
	WarningRing	= "Lightning Ring"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCharge	= "Afficher Static Charge alerte",
	WarningRing	= "Afficher Lightning Ring alerte"
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Escort Event"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningRiftSoon	= "Rift Soon",
	WarningRiftNow	= "Rift Opened!",
})

L:SetOptionLocalization({
	WarningRiftSoon		= "Afficher Rift Opened pre-alerte",
	WarningRiftNow		= "Afficher Rift Opened alerte"
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok the Tree-Shaper"
})

L:SetWarningLocalization({
	WarningSpikes		= "Crystal Spikes",
	WarningReflection	= "Spell Reflection",
	WarningFrenzy		= "Frenzy",
})

L:SetTimerLocalization({
	TimerReflection		= "Spell Reflection",
})

L:SetOptionLocalization({
	WarningSpikes		= "Afficher Crystal Spikes alerte",
	WarningReflection	= "Afficher Spell Reflection alerte",
	WarningFrenzy		= "Afficher Frenzy alerte",
	TimerReflection		= "Afficher Spell Reflection duration timer",
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Grand Magus Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Splitting Soon",
	WarningSplitNow		= "Split",
	WarningMerge		= "Merge"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Afficher split pre-alerte",
	WarningSplitNow		= "Afficher split alerte",
	WarningMerge		= "Afficher merge alerte",
})

L:SetMiscLocalization({
	SplitTrigger1 = "There's plenty of me to go around.",
	SplitTrigger2 = "I'll give you more than you can handle.",
	MergeTrigger = "Now to finish the job!"
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

L:SetWarningLocalization({
	WarningChains 	= "Crystal Chains: >%s<",
	WarningEnrage	= "Enrage",
})

L:SetTimerLocalization({
	TimerChains	= "Crystal Chains: %s",
})

L:SetOptionLocalization({
	WarningChains	= "Afficher Crystal Chains alerte",
	WarningEnrage	= "Afficher Enrage alerte",
	TimerChains	= "Afficher Crystal Chains duration timer",
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
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

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Mage-Lord Urom"
})

L:SetWarningLocalization({
	WarningTimeBomb = "Time Bomb",
	WarningExplosion = "Arcane Explosion",
})

L:SetTimerLocalization({
	TimerTimeBomb = "Time Bomb: %s",
	TimerExplosion = "Arcane Explosion",
})

L:SetOptionLocalization({
	WarningTimeBomb = "Afficher Time Bomb alerte",
	WarningExplosion = "Afficher Arcane Explosion alerte",
	TimerTimeBomb = "Afficher Time Bomb timer",
	TimerExplosion = "Afficher Arcane Explosion timer",
	SpecWarnBombYou = "Afficher a special alerte if you are the bomb",
})


------------------------
-- Varos Cloudstrider --
------------------------
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


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Ley-Guardian Eregos"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningTomb	= "Frost Tomb: >%s<",
})

L:SetTimerLocalization({
	TimerTomb	= "Frost Tomb: %s",
})

L:SetOptionLocalization({
	WarningTomb	= "Afficher Frost Tomb alerte",
	TimerTomb	= "Afficher Frost Tomb duration timer",
})


------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Constructor & Controller"
})

L:SetWarningLocalization({
	WarningEnfeeble		= "Debilitate: >%s<",
})

L:SetTimerLocalization({
	TimerEnfeeble		= "Debilitate: %s",
})

L:SetOptionLocalization({
	WarningEnfeeble		= "Afficher Debilitate alerte",
	TimerEnfeeble		= "Afficher Debilitate duration timer",
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar the Plunderer"
})

L:SetWarningLocalization({
	WarningSmash			= "%s",
	WarningGrowl			= "%s",
	WarningWoeStrike		= "Woe Strike: >%s<",
	SpecialWarningSpelllock = "Spell-lock - stop casting!"
})

L:SetTimerLocalization({
	TimerSmash	= "%s",
	TimerWoeStrike	= "Woe Strike: %s"
})

L:SetOptionLocalization({
	WarningSmash		= "Afficher Dark Smash alerte",
	WarningGrowl		= "Afficher Growl alerte",
	WarningWoeStrike	= "Afficher Woe Stike alerte",
	TimerSmash			= "Afficher Dark Smash cast timer",
	TimerWoeStrike		= "Afficher Woe Strike timer",
})


----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi the Ruthless"
})

L:SetWarningLocalization({
	WarningWhirlwind	= "Whirlwind"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= "Afficher Whirlwind alerte"
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "King Ymirion"
})

L:SetWarningLocalization({
	WarningBane	= "Bane"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= "Afficher Bane alerte"
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
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


---------------------
-- Gortok Palehoof --
---------------------
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	name = "Zuramat the Obliterator"
})

L:SetWarningLocalization({
	WarningVoidShift		= "Void Shift: >%s<",
	WarningVoidShifted		= "%s is fighting spawns",
	WarningShroudOfDarkness		= "Shroud of Darkness - stop dps",
	SpecialWarningVoidShifted 	= "You are Void Shifted!",
	SpecialShroudofDarkness 	= "Darkness - Stop DPS",
})

L:SetTimerLocalization({
	TimerVoidShift			= "Void Shift: %s",
	TimerVoidShifted		= "Void Shifted: %s",
})

L:SetOptionLocalization({
	WarningVoidShift			= "Announce Void Shift dot",
	WarningVoidShifted			= "Announce Void Shifted players",
	WarningShroudOfDarkness		= "Announce Shroud of Darkness",
	SpecialWarningVoidShifted	= "Special Warnung when you are Void Shifted",
	SpecialShroudofDarkness		= "Special Warnung on Shroud of Darkness",
	TimerVoidShift				= "Afficher timer for Void Shift dot",
	TimerVoidShifted			= "Afficher timer for Void Shifted players",
})


-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Portal Timers"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New Portal Soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= "Afficher New Portal alerte",
	WarningPortalSoon		= "Afficher New Portal pre-alerte",
	WarningBossNow			= "Afficher Boss alerte",
	TimerPortalIn			= "Afficher \"Portal: #\" timer",
	AfficherAllPortalWarnings	= "Afficher alertes for all waves"
})


L:SetMiscLocalization({
	yell1 = "Prison guards, we are leaving! These adventurers are taking over! Go go go!",
})
