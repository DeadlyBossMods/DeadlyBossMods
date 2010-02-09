if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- HdZ4: WaveCheck überprüfen
-- HdS: Brann-Eskorte
-- Nexus: Großmagistrix Telestra
-- Oculus: Magierlord Urom
-- Burg: Ingvar der Brandschatzer
-- Turm: Svala Grabesleid, Skadi der Skrupellose
-- VF: Portaltimer, Cyanigosa
-- PdC: Großchampions, Der Schwarze Ritter
-- Grube: Schmiedemeister Garfrost, Ick und Krick, Geißelfürst Tyrannus
-- HdR: Wellentimer, Lichkönig-Event

local L

local spell		= "%s"
local debuff		= "%s: >%s<"
local spellCD		= "Cooldown von %s"
local spellSoon		= "%s bald"
local optionWarning	= "Zeige Warnung für %s"
local optionPreWarning	= "Zeige Vorwarnung für %s"
local optionSpecWarning	= "Zeige Spezialwarnung für %s"
local optionTimerCD	= "Zeige Timer für Cooldown von %s"
local optionTimerDur	= "Zeige Timer für Dauer von %s"
local optionTimerCast	= "Zeige Timer für Zaubern von %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prinz Taldaram"
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
	name = "Urahne Nadox"
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
	name = "Jedoga Schattensucher"
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
	name = "Herold Volazj"
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
	name = "Krik'thir der Torwächter"
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
	name = "Anub'arak (Gruppe)"
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
	name = "Fleischhaken"
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
	name = "Salramm der Fleischformer"
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
	name = "Chronolord Epoch"
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

L:SetMiscLocalization({
	Outro	= "Eure Reise hat erst begonnen, junger Prinz. Sammelt Eure Streitmacht und folgt mir in das arktische Land Nordend. Dort werden wir unsere Rechnung begleichen. Dort wird sich Euer wahres Schicksal offenbaren."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Stratholme-Wellen"
})

L:SetWarningLocalization({
	WarningWaveNow = "Welle %d: %s erschienen"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Nächste Welle (6)",
	TimerRoleplay	= "Arthas-Rollenspiel"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("neue Welle"),
	TimerWaveIn		= "Zeige Timer für nächste Wellengruppe (nach dem Welle-5-Boss)",
	TimerRoleplay	= "Zeige Timer für das Eröffnungs-Rollenspiel"
})

L:SetMiscLocalization({
	Meathook	= "Fleischhaken",
	Salramm		= "Salramm der Fleischformer",
	Devouring	= "Verschlingender Ghul",
	Enraged		= "Aufgebrachter Ghul",
	Necro		= "Totenbeschwörer",
	Friend		= "Gruftbestie",
	Tomb		= "Grabschleicher",
	Abom		= "Flickwerkkonstrukt",
	Acolyte		= "Akolyt",
	Wave1		= "%d %s",
	Wave2		= "%d %s und %d %s",
	Wave3		= "%d %s, %d %s und %d %s",
	Wave4		= "%d %s, %d %s, %d %s und %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Angreiferwelle = %d/10",	-- does not work ... why?
	Roleplay	= "Wie schön, dass Ihr es geschafft habt, Uther.",
	Roleplay2	= "Alle sind bereit. Vergesst nicht, diese Leute sind alle infiziert und werden bald sterben. Wir müssen Stratholme säubern, um den Rest Lordaerons vor der Geißel zu schützen. Los jetzt."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Trollgrind"
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
	name = "Novos der Beschwörer"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "neuer Kristallwirker (%d übrig)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "neuer Kristallwirker"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Zeige Warnung wenn Kristallwirker erscheint",
	timerCrystalHandler	= "Zeige Timer für nächsten Kristallwirker"
})

L:SetMiscLocalization({
	HandlerEmote	= "%s ruft um Hilfe!"
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "König Dred"
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
	name = "Der Prophet Tharon'ja"
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
	name = "Koloss der Drakkari"
})

L:SetWarningLocalization({
	warningElemental	= "Elementarphase",
	WarningStone		= "Kolossphase"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Zeige Warnung für Elementarphase",
	WarningStone		= "Zeige Warnung für Kolossphase"	
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
	name = "Der wilde Eck"
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
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Volkhan"
})

L:SetWarningLocalization({
	WarningStomp	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD	= optionTimerCD:format(GetSpellInfo(52237))
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
	name = "Maid der Trauer"
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
	name = "Sjonnir der Eisenformer"
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
	name = "Brann-Eskorte"
})

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Zeit verbleibend"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Phasenwechsel"),
	timerEvent		= "Zeige Timer für Ereignisdauer"
})

L:SetMiscLocalization({
	Pull	= "Now keep an eye out! I'll have this licked in two shakes of a--",	-- to be translated
	Phase1	= "Security breach in progress. Analysis of historical archives transferred to lower-priority queue. Countermeasures engaged.",	-- to be translated
	Phase2	= "Threat index threshold exceeded.  Celestial archive aborted. Security level heightened.",	-- to be translated
	Phase3	= "Critical threat index. Void analysis diverted. Initiating sanitization protocol.",	-- to be translated
	Kill	= "Alert: security fail-safes deactivated. Beginning memory purge and... "	-- to be translated
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
	name = "Ormorok der Baumformer"
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
	name = "Großmagistrix Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Aufspaltung bald",	
	WarningSplitNow		= "Aufspaltung",		
	WarningMerge		= "Fusion"		
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Aufspaltung"),
	WarningSplitNow		= optionWarning:format("Aufspaltung"),	
	WarningMerge		= optionWarning:format("Fusion"),	
})

L:SetMiscLocalization({
	SplitTrigger1 = "There's plenty of me to go around.",		-- to be translated
	SplitTrigger2 = "I'll give you more than you can handle.",	-- to be translated
	MergeTrigger = "Now to finish the job!"				-- to be translated
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

local commander = "Unbekannt"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Kommandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Kommandant Starkbart"
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
	name = "Drakos der Befrager"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	MakeitCountTimer	= "Zeige Timer für Erfolg 'Jagt ihn!'"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Magierlord Urom"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "Poor blind fools!"	-- to be translated
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Wolkenwanderer"
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
	name = "Leywächter Eregos"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "Planarverschiebung endet"		
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." Ende")
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Prinz Keleseth"
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
	name = "Ingvar der Brandschatzer"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "No! I can do... better! I can..."	-- to be translated
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi der Skrupellose"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "What mongrels dare intrude here? Look alive, my brothers!  A feast for the one that brings me their heads!",	-- to be translated
	Phase2			= "You motherless knaves! Your corpses will make fine morsels for my new drake!"	-- to be translated
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "König Ymiron"
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
	name = "Svala Grabesleid"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerRoleplay		= "Svala Grabesleid aktiv"
})

L:SetOptionLocalization({
	timerRoleplay		= "Zeige Timer für Rollenspiel bevor Svala Grabesleid aktiv wird"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "My liege! I have done as you asked, and now beseech you for your blessing!"	-- to be translated
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Bleichhuf"
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
	TimerCombatStart		= "Kampf beginnt"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Zeige Timer für Kampfbeginn"
})

L:SetMiscLocalization({
	CyanArrived	= "A valiant defense, but this city must be razed. I will fulfill Malygos's wishes myself!"	-- to be translated
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
	name = "Zuramat der Vernichter"
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
	name = "Portaltimer"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Neues Portal bald",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal #%d", 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("neues Portal"),
	WarningPortalSoon		= optionPreWarning:format("neues Portal"),
	WarningBossNow			= optionWarning:format("neuen Boss"),
	TimerPortalIn			= "Zeige Timer für nächstes Portal (nach einem Boss)",
	ShowAllPortalTimers		= "Zeige Timer für alle Portale (ungenau)"
})

L:SetMiscLocalization({
	yell1		= "Prison guards, we are leaving! These adventurers are taking over! Go go go!",	-- to be translated
	Sealbroken	= "We've broken through the prison gate! The way into Dalaran is clear! Now we finally put an end to the Nexus War!",	-- to be translated
	WavePortal	= "Portale geöffnet: (%d+)/18"	-- to be checked
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Der Schwarze Ritter"
})

L:SetWarningLocalization({
	warnExplode			= "Ghul explodiert - Lauf"
})

L:SetOptionLocalization({
	warnExplode				= "Zeige Warnung wenn Ghuldiener kurz vor dem Explodieren ist",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	YellCombatEnd	= "My congratulations, champions. Through trials both planned and unexpected, you have triumphed."	-- can also be "No! I must not fail... again ..."	-- to be translated
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Großchampions"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."	-- to be translated
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Argentumbeichtpatin Blondlocke"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "Exzellente Arbeit!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric der Reine"
})

L:SetWarningLocalization({
	specwarnRadiance		= "Strahlen - schau weg"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Zeige Spezialwarnung für $spell:66935",
	SetIconOnHammerTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "Ich ergebe mich! Exzellente Arbeit. Darf ich jetzt wegrennen?"
})

--------------------
--  World Events  --
----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Düsterbräu"
})

L:SetWarningLocalization({
	specWarnBrew		= "Get rid of the brew before she tosses you another one!",	--to be translated
	specWarnBrewStun	= "HINT: You were bonked, remember to drink the brew next time!"	--to be translated
})

L:SetOptionLocalization({
	specWarnBrew		= "Zeige Spezialwarnung für Bier der dunklen Schankmaid",
	specWarnBrewStun	= "Zeige Spezialwarnung für Betäubung der dunklen Schankmaid",
	YellOnBarrel		= "Schreie bei Fass"
})

L:SetMiscLocalization({
	YellBarrel	= "Fass auf mir!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Der kopflose Reiter"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "neuer Pulsierender Kürbis",
	specWarnHorsemanHead	= "Wirbelwind - Wechsel auf den Kopf"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Zeige Warnung wenn Pulsierender Kürbnis erscheint",
	specWarnHorsemanHead	= "Zeige Spezialwarnung für Wirbelwind (ab der zweiten Kopfphase)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Get over here, you idiot!",	--to be translated
	HorsemanSoldiers	= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!",	--to be translated
	SayCombatEnd		= "This end have I reached before.  What new adventure lies in store?"	--to be translated
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Apotheker-Trio"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Hummel wird aktiv",
	BaxterActive	= "Baxter wird aktiv",
	FryeActive		= "Frye wird aktiv"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Timer für wann die Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick und Krick"
})

L:SetWarningLocalization({
	warnPursuit			= "Verfolgung auf >%s<",
	specWarnPursuit		= "Du wirst verfolgt - lauf"
})

L:SetOptionLocalization({
	warnPursuit				= "Verkünde Ziele von Verfolgung",
	specWarnPursuit			= "Zeige Spezialwarnung wenn du verfolgt wirst",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit	= "%s is chasing you!",	-- to be translated
	Barrage	= "%s begins rapidly conjuring explosive mines!"	-- to be translated
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Schmiedemeister Garfrost"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Saronitbrocken auf >%s<",
	specWarnSaroniteRock		= "Saronit werfen auf dich - Lauf",
	specWarnSaroniteRockNear	= "Saronit werfen in deine Nähe - Lauf",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Verkünde Ziele von $spell:70851",
	specWarnSaroniteRock		= "Zeige Spezialwarnung wenn du von $spell:70851 betroffen bist",
	specWarnSaroniteRockNear	= "Zeige Spezialwarnung wenn du in der Nähe des Ziels von $spell:70851 bist",
	specWarnPermafrost			= "Zeige Spezialwarnung wenn $spell:70336 zu hoch stapelt (11 Stapel)",
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s hurls a massive saronite boulder at you!"	-- to be translated
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Geißelfürst Tyrannus"
})

L:SetWarningLocalization({
	specWarnHoarfrost		= "Raureif auf dir",
	specWarnHoarfrostNear	= "Raureif in deiner Nähe - Lauf"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Kampf beginnt"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "Zeige Spezialwarnung wenn du von $spell:69246 betroffen bist",
	specWarnHoarfrostNear		= "Zeige Spezialwarnung für $spell:69246 in deiner Nähe",
	TimerCombatStart			= "Zeige Timer für Kampfbeginn",
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart	= "Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.",	-- to be translated
	HoarfrostTarget	= "The frostwyrm Rimefang gazes at (%S+) and readies an icy attack!",	-- to be translated
	YellCombatEnd	= "Impossible.... Rimefang.... warn...."	-- to be translated
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
	specwarnSoulstorm	= "Seelensturm - Lauf rein"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "Zeige Spezialwarnung wenn $spell:68872 gezaubert wird (zum Reinlaufen)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Verschlinger der Seelen"
})

L:SetWarningLocalization({
	specwarnMirroredSoul	= "Schadensstop",
	specwarnWailingSouls	= "Klagende Seelen - Lauf hinter den Boss"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Zeige Spezialwarnung für Schadensstop bei $spell:69051",
	specwarnWailingSouls	= "Zeige Spezialwarnung wenn $spell:68899 gezaubert wird",
	SetIconOnMirroredTarget	= "Setze Symbole auf Ziele von $spell:69051"
})


---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Wellentimer"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Neue Welle bald",
	WarnNewWave		= "%s kommt"
})

L:SetTimerLocalization({
	TimerNextWave	= "Neue Welle"
})

L:SetOptionLocalization({
	WarnNewWave			= "Zeige Warnung für neuen Boss",
	WarnNewWaveSoon		= "Zeige Vorwarnung für neue Welle (nach dem Welle-5-Boss)",
	ShowAllWaveWarnings	= "Zeige Warnungen für alle Wellen",
	TimerNextWave		= "Zeige Timer für nächste Wellengruppe (nach dem Welle-5-Boss)",
	ShowAllWaveTimers	= "Zeige Vorwarnung und Timer für alle Wellen (ungenau)"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Geisterwelle = (%d+)/10"	-- to be checked
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
	name = "Lichkönig-Event"
})

L:SetWarningLocalization({
	WarnWave1		= "6 Tobende Ghule, 1 Auferstandener Hexendoktor kommen",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "6 Tobende Ghule, 2 Auferstandene Hexendoktoren, 1 Schwerfällige Monstrosität kommen",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "6 Tobende Ghule, 2 Auferstandene Hexendoktoren, 2 Schwerfällige Monstrositäten kommen",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "12 Tobende Ghule, 4 Auferstandene Hexendoktoren, 3 Schwerfällige Monstrositäten kommen"--12 Ghoul, 3 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "Zeit zur Flucht"
})

L:SetOptionLocalization({
	ShowWaves	= "Zeige Warnung für Monsterwellen"
})

L:SetMiscLocalization({
	Ghoul			= "Tobender Ghul",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Schwerfällige Monstrosität",--creature id 37069
	WitchDoctor		= "Auferstandener Hexendoktor",--creature id 36941
	ACombatStart	= "He is too powerful. We must leave this place at once! My magic can hold him in place for only a short time. Come quickly, heroes!",	-- to be translated
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",	-- to be translated
	Wave1			= "There is no escape!",	-- to be translated
	Wave2			= "Succumb to the chill of the grave.",	-- to be translated
	Wave3			= "Another dead end.",	-- to be translated
	Wave4			= "How long can you fight it?",	-- to be translated
	YellCombatEnd	= "FIRE! FIRE!"	-- to be translated
})
