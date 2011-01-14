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
	PingCharge	= "Pingt die Minimap, wenn General Umbriss dich anstürmt"
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
	ValionaYell	= "Drache, du wirst tun, was ich sage! Fang mich!",	-- Yell when Valiona is incoming
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
	name = "Siamat"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

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
	WarnMortalWound	= "%s auf >%s< (%d)"		-- Mortal Wound on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(93675, GetSpellInfo(93675) or "unknown")
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetWarningLocalization({
	WarnEmerge	= "Auftauchen",
	WarnSubmerge	= "Untertauchen"
})

L:SetTimerLocalization({
	TimerEmerge	= "Auftauchen",
	TimerSubmerge	= "Untertauchen"
})

L:SetOptionLocalization({
	WarnEmerge	= "Zeige Warnung für Auftauchen",
	WarnSubmerge	= "eige Warnung für Untertauchen",
	TimerEmerge	= "Zeige Timer für Auftauchen",
	TimerSubmerge	= "Zeige Timer für Untertauchen"
})

L:SetGeneralLocalization({
	name = "Corborus"
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
	specWarnCrystalStorm		= "Kristallsturm - Geh in Deckung"
})

L:SetOptionLocalization({
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