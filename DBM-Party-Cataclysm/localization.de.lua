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
	WarnAdd		= "Add frei"
})

L:SetOptionLocalization({
	WarnAdd		= "Warne wenn ein Add den $spell:75608 Buff verliert"
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
	TimerSuperheated	= "Zeige Timer für die Dauer von $spell:75846"
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
	name = "Admiral Knurreißer"
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
	name = "Vanessa VanCleef"
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
	name = "General Umbriss"
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
	ValionaYell	= "Drache, du wirst tun, was ich sage! Fang mich!",
	Add			= "%s Summons an", --translate
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
	Brann		= "Alles klar, auf geht's! Ich gebe nur noch die letzte Eingangssequenz in den Türmechanismus ein... und..."
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
	specWarnPhase2Soon	= "Zeige Spezialwarnung für Phase 2 bald (5 Sekunden)",
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
	BossHealthAdds	= "Zeige die Gesundheit der Adds"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Flamme des Himmels",
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
	RangeFrame	= "Zeige Abstandsfenster(5)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"		-- he is fightable after Lockmaw :o
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
	TimerAdds		= "Zeige Timer für Adds"
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
	specWarnCoagulant	= "Grüne Mischung - Lauf!",	-- Green light
	specWarnRedMix		= "Rote Mischung - Bleib stehen!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Show special warnings for Red/Green movement queues"
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
	WarnEmerge	= "Auftauchen",
	WarnSubmerge	= "Untertauchen"
})

L:SetTimerLocalization({
	TimerEmerge	= "Nächstes Auftauchen",
	TimerSubmerge	= "Nächstes Untertauchen"
})

L:SetOptionLocalization({
	WarnEmerge	= "Zeige Warnung für Auftauchen",
	WarnSubmerge	= "eige Warnung für Untertauchen",
	TimerEmerge	= "Zeige Timer für Auftauchen",
	TimerSubmerge	= "Zeige Timer für Untertauchen",
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
	specWarnCrystalStorm		= "Kristallsturm - Geh in Deckung"
})

L:SetOptionLocalization({
	WarnAirphase			= "Zeige Warnung, wenn Plattenhaut abhebt",
	WarnGroundphase			= "Zeige Warnung, wenn Plattenhaut landet",
	TimerAirphase			= "Zeige Timer für die nächste Luftphase",
	TimerGroundphase		= "Zeige Timer für die nächste Bodenphase",

	specWarnCrystalStorm		= "Zeige Spezialwarnung für $spell:92265"
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
	WarnNormal		= "Normale Form",
	WarnNormalSoon	= "Normale Form in 5 Sek"
}

L:SetTimerLocalization{
	TimerBear		= "Bärform",
	TimerNormal		= "Normale Form"
}

L:SetOptionLocalization{
	WarnBear		= "Zeige Warnung für Bärform",
	WarnBearSoon	= "Zeige Vorwarnung für Bärform",
	WarnNormal		= "Zeige Warnung für Normalform",
	WarnNormalSoon	= "Zeige Vorwarnung für Normalform",
	TimerBear		= "Zeige Timer für Bärform",
	TimerNormal		= "Zeige Timer für Normalform"
}

L:SetMiscLocalization{
	YellBear 	= "Ihr provoziert die Bestie, jetzt werdet ihr sie kennenlernen!",
	YellNormal	= "Macht Platz für Nalorakk!"
}

--------------
-- Akil'zon --
--------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Akil'zon (Adler)"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame	= "Zeige Abstandsfenster (10m)"
}

L:SetMiscLocalization{
}

--------------
-- Jan'alai --
--------------
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
	YellBomb	= "Jetzt sollt ihr brennen!",
	YellAdds	= "Wo is' meine Brut? Was ist mit den Eiern?"
}

-------------
-- Halazzi --
-------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Halazzi (Lynx)"
}

L:SetWarningLocalization{
	WarnSpirit	= "Geist Phase",
	WarnNormal	= "Normale Phase"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnSpirit	= "Zeige Warnung für Geistphase",
	WarnNormal	= "Zeige Warnung für normale Phase"
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

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Zeige Timer für $spell:43501"
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
	name = "Hohepriesterin Venoxis" --check
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
-- Zanzil --
------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Blutfürst Mandokir" --check
}

L:SetWarningLocalization{
	WarnRevive		= "Geisterwiederbelebung - %d verbleiben",
	SpecWarnOhgan	= "Ohgan wiederbelebt! Angreifen!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnRevive		= "Verkünde wieviele Geisterwiederbelebungen verbleiben",
	SpecWarnOhgan	= "Zeige Warnung, wenn Ohgan wiederbelebt wird"
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
	name = "Hohepriesterin Kilnara" --check
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
	name = "Jin'do the Godbreaker" --translate
}

L:SetWarningLocalization{
	WarnBarrierDown	= "Hakkar's Chains Barrier Down - %d/3 left" --translate
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Announce when Hakkar's Chains barrier down" --translate
}

L:SetMiscLocalization{
	Kill			= "Oh no, Hakkar's spirit is free!" -- translate (temporarily)
}