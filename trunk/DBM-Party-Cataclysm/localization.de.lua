if GetLocale() ~= "deDE" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Rom'ogg Knochenbrecher"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "Corla, Botin des Zwielichts"
})

L:SetWarningLocalization({
	WarnAdd		= "Add freigesetzt"
})

L:SetOptionLocalization({
	WarnAdd		= "Warne, wenn ein Add den $spell:75608 Buff verliert"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Karsh Stahlbieger"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "Supererhitzte Rüstung (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Dauer von $spell:75846 anzeigen"
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
	name = "Aszendentenfürst Obsidius"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "Setze ein Zeichen auf den Boss nach $spell:76200 "
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
	name = "Helix Ritzelbrecher"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "Feindschnitter 5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "Admiral Knurrreißer"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"Kapitän\" Krümel"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "Vanessa van Cleef"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Spießrutenlauf"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name 		= "General Umbriss"
})

L:SetOptionLocalization{
	PingBlitz	= "Pingt die Minimap, wenn General Umbriss dich anstürmt"
}

L:SetMiscLocalization{
	Blitz		= "richtet seine Augen auf |cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Schmiedemeister Throngus"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Drahga Schattenbrenner"
})

L:SetMiscLocalization{
	ValionaYell	= "Drache, Ihr werdet tun, was ich sage! Fangt mich!",
	Add			= "%s wirkt den Zauber",
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
	name = "Tempelwächter Anhuur"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "Erdwüter Ptah"
})

L:SetMiscLocalization{
	Kill		= "Ptah... ist... nicht mehr..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Anraphet"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Schneller als das Licht"
})

L:SetMiscLocalization({
	Brann				= "Alles klar, auf geht's! Ich gebe nur noch die letzte Eingangssequenz in den Türmechanismus ein... und..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "Isiset"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "Teilung bald"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Zeige Vorwarnung für Teilung"
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
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Siamat"
})

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Phase 2 in 5 Sekunden"
}

L:SetTimerLocalization({
	timerPhase2 		= "Phase 2 beginnt"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Zeige Spezialwarnung für baldige Phase 2 (5 Sekunden)",
	timerPhase2 		= "Zeige Timer für den Beginn von Phase 2"
}

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Hochprophet Barim"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Zeige die Gesundheit der Adds in der Lebensanzeige"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Flamme der Himmel",
	HarbringerDarkness	= "Bote der Dunkelheit"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Schnappschlund"
})

L:SetOptionLocalization{
	RangeFrame	= "Zeige Abstandsfenster (5m)"
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
	name = "Baron Ashbury"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "Baron Silberlein"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "Kommandant Grüntal"
})

L:SetTimerLocalization({
	TimerAdds		= "Nächste Adds"
})

L:SetOptionLocalization{
	TimerAdds		= "Zeige Zeit bis nächste Adds"
}

L:SetMiscLocalization{
	YellAdds		= "Schlagt die Eindringlinge zurück!"
}

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Lord Walden"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "Grüne Mischung - Lauf!",
	specWarnRedMix		= "Rote Mischung - Bleib stehen!"
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Zeige Spezialwarnungen für Bewegungen bei Rot/Grün"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Lord Godfrey"
})

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
	WarnEmerge		= "Auftauchen",
	WarnSubmerge	= "Abtauchen"
})

L:SetTimerLocalization({
	TimerEmerge		= "Nächstes Auftauchen",
	TimerSubmerge	= "Nächstes Abtauchen"
})

L:SetOptionLocalization({
	WarnEmerge		= "Zeige Warnung für Auftauchen",
	WarnSubmerge	= "Zeige Warnung für Abtauchen",
	TimerEmerge		= "Zeige Zeit bis Auftauchen",
	TimerSubmerge	= "Zeige Zeit bis Abtauchen",
	CrystalArrow	= "Zeige DBM-Pfeil, wenn $spell:81634 in deiner Nähe ist",
	RangeFrame		= "Zeige Abstandsfenster (5m)"
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
	name = "Plattenhaut"
})

L:SetWarningLocalization({
	WarnAirphase			= "Luftphase",
	WarnGroundphase			= "Bodenphase",
	specWarnCrystalStorm	= "Kristallsturm - Geh in Deckung"
})

L:SetTimerLocalization({
	TimerAirphase			= "Nächste Luftphase",
	TimerGroundphase		= "Nächste Bodenphase"
})

L:SetOptionLocalization({
	WarnAirphase			= "Zeige Warnung, wenn Plattenhaut abhebt",
	WarnGroundphase			= "Zeige Warnung, wenn Plattenhaut landet",
	TimerAirphase			= "Zeige Zeit bis nächste Luftphase",
	TimerGroundphase		= "Zeige Zeit bis nächste Bodenphase",
	specWarnCrystalStorm	= "Zeige Spezialwarnung für $spell:92265"
})

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "Hohepriesterin Azil"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "Großwesir Ertan"
})

L:SetMiscLocalization{
	Retract		= "%s zieht sein Wirbelsturmschild zurück!"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "Altairus"
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
	SpecWarnStaticCling	= "Zeige Spezialwarnung für $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "SPRING!"
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
	name = "Kommandant Ulthok"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "Erunak Steinsprecher"
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
-- Nalorakk --
--------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "Nalorakk (Bär)"
}

L:SetWarningLocalization{
	WarnBear		= "Bärform",
	WarnBearSoon	= "Bärform in 5 Sek",
	WarnNormal		= "Normalform",
	WarnNormalSoon	= "Normalform in 5 Sek"
}

L:SetTimerLocalization{
	TimerBear		= "Bärform",
	TimerNormal		= "Normalform"
}

L:SetOptionLocalization{
	WarnBear		= "Zeige Warnung für Bärform",
	WarnBearSoon	= "Zeige Vorwarnung für Bärform",
	WarnNormal		= "Zeige Warnung für Normalform",
	WarnNormalSoon	= "Zeige Vorwarnung für Normalform",
	TimerBear		= "Zeige Zeit bis Bärform",
	TimerNormal		= "Zeige Zeit bis Normalform",
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:42402 betroffen sind",
}

L:SetMiscLocalization{
	YellBear 		= "Ihr provoziert die Bestie, jetzt werdet ihr sie kennenlernen!",
	YellNormal		= "Macht Platz für Nalorakk!",
	PlayerDebuffs	= "Anstürmen Debuff"
}

--------------
-- Akil'zon --
--------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Akil'zon (Adler)"
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Zeige Abstandsfenster (10m)",
	StormArrow	= "Zeige DBM-Pfeil für $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

L:SetMiscLocalization{
}

--------------
-- Jan'alai --
--------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "Jan'alai (Drachenfalke)"
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "Jetzt sollt ihr brennen!",
	YellHatchAll= "Stärke... und zwar viel davon.",
	YellAdds	= "Wo is' meine Brut? Was ist mit den Eiern?"
}

-------------
-- Halazzi --
-------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Halazzi (Luchs)"
}

L:SetWarningLocalization{
	WarnSpirit	= "Geistphase",
	WarnNormal	= "Normalphase"
}

L:SetOptionLocalization{
	WarnSpirit	= "Zeige Warnung für Geistphase",
	WarnNormal	= "Zeige Warnung für Normalphase"
}

L:SetMiscLocalization{
	YellSpirit	= "Ich kämpfe mit wildem Geist...",
	YellNormal	= "Geist, zurück zu mir!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "Hexlord Malacrass"
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Dauer von $spell:43501 anzeigen"
}

L:SetMiscLocalization{
	YellPull	= "Der Schatten wird euch verschlingen..."
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "Daakara"
}

L:SetTimerLocalization{
	timerNextForm	= "Nächster Formwechsel"
}

L:SetOptionLocalization{
	timerNextForm	= "Zeige Zeit bis Formwechsel",
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:42402 betroffen sind",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Anstürmen Debuff"
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Hohepriester Venoxis"
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "Zeige DBM-Pfeil, wenn du von $spell:96477 betroffen bist"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Blutfürst Mandokir"
}

L:SetWarningLocalization{
	WarnRevive		= "%d Geister verbleiben",
	SpecWarnOhgan	= "Ohgan wiederbelebt! Angreifen!"
}

L:SetOptionLocalization{
	WarnRevive		= "Verkünde die Anzahl der verbleibenden Geisterwiederbelebungen",
	SpecWarnOhgan	= "Zeige Warnung, wenn Ohgan wiederbelebt wird",
	SetIconOnOhgan	= "Setze ein Zeichen auf Ohgan, wenn er wiederbelebt wird"
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
	SpecWarnToxic	= "Hole Toxische Qual"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "Zeige Spezialwarnung, wenn dir der $spell:96328 Buff fehlt",
	InfoFrame		= "Zeige Infofenster für Spieler, denen der $spell:96328 Buff fehlt",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Keine Toxische Qual"
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "Hohepriesterin Kilnara"
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do der Götterbrecher"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "Schild von Hakkars Ketten zerstört - %d/3 verbleibend"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Verkünde Zerstörung der Schilde von Hakkars Ketten",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill			= "Du hast deine Grenzen überschritten, Jin'do. Diese Macht kannst du nicht kontrollieren. Hast du vergessen, wer ich bin? Hast du vergessen, wozu ich fähig bin?!"
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
--L= DBM:GetModLocalization(603)

L = DBM:GetModLocalization("CoMGrilek")

L:SetGeneralLocalization{
	name = "Gri'lek"
}

L:SetMiscLocalization({
	pursuitEmote	= "%s jagt"
})

---------------
-- Hazza'rah --
---------------
--L= DBM:GetModLocalization(604)

L = DBM:GetModLocalization("CoMGHazzarah")

L:SetGeneralLocalization{
	name = "Hazza'rah"
}

--------------
-- Renataki --
--------------
--L= DBM:GetModLocalization(605)

L = DBM:GetModLocalization("CoMRenataki")

L:SetGeneralLocalization{
	name = "Renataki"
}

---------------
-- Wushoolay --
---------------
--L= DBM:GetModLocalization(606)

L = DBM:GetModLocalization("CoMWushoolay")

L:SetGeneralLocalization{
	name = "Wushoolay"
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
	name = "Garr (Cataclysm)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Julak-Doom"
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

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "Xariona"
}

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "Echo von Sylvanas"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "Echo von Tyrande"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "Echo von Jaina"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Flammenkern detoniert"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Zeige Zeit bis $spell:101927 detoniert"
}

L:SetMiscLocalization{
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "Echo von Baine"
}

--------------
-- Murozond --
--------------
L = DBM:GetModLocalization("Murozond")

L:SetGeneralLocalization{
	name = "Murozond"
}

L:SetMiscLocalization{
	Kill		= "Ihr wisst nicht, was Ihr getan habt. Aman'Thul... Was ich... gesehen... habe..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L = DBM:GetModLocalization("Perotharn")

L:SetGeneralLocalization{
	name = "Peroth'arn"
}

L:SetMiscLocalization{
	Pull		= "Kein Sterblicher überlebt es, sich mir gegenüberzustellen!"
}


-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "Königin Azshara"
}

L:SetWarningLocalization{
	WarnAdds	= "Neue Adds bald"
}

L:SetTimerLocalization{
	TimerAdds	= "Nächste Adds"
}

L:SetOptionLocalization{
	WarnAdds	= "Verkünde, wenn neue Adds \"erscheinen\"",
	TimerAdds	= "Zeige Zeit bis nächste Adds \"erscheinen\""
}

L:SetMiscLocalization{
	Kill		= "Genug. So gern ich auch Gastgeberin bin, muss ich mich doch um wichtigere Angelegenheiten kümmern."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "Mannoroth & Varo'then"
}

L:SetTimerLocalization{
	TimerTyrandeHelp	= "Tyrande braucht Hilfe"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "Zeige Zeit bis Tyrande Hilfe braucht"
}

L:SetMiscLocalization{
	Kill		= "Malfurion, er hat es geschafft! Das Portal bricht zusammen!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "Arcurion"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Kampfbeginn"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn"
}

L:SetMiscLocalization{
	Event		= "Zeigt Euch!",
	Pull		= "Streitkräfte des Schattenhammers tauchen an den Rändern der Schlucht auf."
}

----------------------
-- Asira Dawnslayer --
----------------------
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "Asira Dämmerschlächter"
}

L:SetMiscLocalization{
	Pull		= "... Das wäre erledigt. Jetzt seid Ihr und Eure tollpatschigen Freunde an der Reihe. Mmm, ich dachte schon, Ihr würdet nie kommen!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "Erzbischof Benedictus"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Kampfbeginn"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn"
}

L:SetMiscLocalization{
	Event		= "Und nun, Schamane, werdet Ihr MIR die Drachenseele geben."
}