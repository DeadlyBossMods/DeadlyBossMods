if GetLocale() ~= "deDE" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "Add freigesetzt"
})

L:SetOptionLocalization({
	WarnAdd		= "Warne, wenn ein Add den $spell:75608 Buff verliert"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "Supererhitzte Rüstung (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Dauer von $spell:75846 anzeigen"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "Setze ein Zeichen auf den Boss nach $spell:76200 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "Spießrutenlauf"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "Pingt die Minimap, wenn General Umbriss dich anstürmt"
}

L:SetMiscLocalization{
	Blitz		= "richtet seine Augen auf |cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "Drache, Ihr werdet tun, was ich sage! Fangt mich!",
	Add			= "%s wirkt den Zauber"
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "Ptah... ist... nicht mehr..."
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "Schneller als das Licht"
})

L:SetMiscLocalization({
	Brann				= "Alles klar, auf geht's! Ich gebe nur noch die letzte Eingangssequenz in den Türmechanismus ein... und..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "Teilung bald"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Zeige Vorwarnung für Teilung"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

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

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "Zeige die Gesundheit der Adds in der Lebensanzeige"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

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

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

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
L= DBM:GetModLocalization(99)

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
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

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

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

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

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "%s zieht sein Wirbelsturmschild zurück!"
}

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

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
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

----------------
--  Zul'Aman  --
----------------
-- Akil'zon --
--------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Zeige Abstandsfenster (10m)",
	StormArrow	= "Zeige DBM-Pfeil für $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

--------------
-- Nalorakk --
--------------
L= DBM:GetModLocalization(187)

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
-- Jan'alai --
--------------
L= DBM:GetModLocalization(188)

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
L= DBM:GetModLocalization(189)

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
L= DBM:GetModLocalization(190)

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
L= DBM:GetModLocalization(191)

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
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "Zeige DBM-Pfeil, wenn du von $spell:96477 betroffen bist"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "%d Geister verbleiben",
	SpecWarnOhgan	= "Ohgan wiederbelebt! Angreifen!"
}

L:SetOptionLocalization{
	WarnRevive		= "Verkünde die Anzahl der verbleibenden Geisterwiederbelebungen",
	SpecWarnOhgan	= "Zeige Warnung, wenn Ohgan wiederbelebt wird",
	SetIconOnOhgan	= "Setze ein Zeichen auf Ohgan, wenn er wiederbelebt wird"
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

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
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

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

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Flammenkern detoniert"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Zeige Zeit bis $spell:101927 detoniert"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "Ihr wisst nicht, was Ihr getan habt. Aman'Thul... Was ich... gesehen... habe..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

L:SetMiscLocalization{
	Pull		= "Kein Sterblicher überlebt es, sich mir gegenüberzustellen!"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

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
L= DBM:GetModLocalization(292)

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
L= DBM:GetModLocalization(322)

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
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "... Das wäre erledigt. Jetzt seid Ihr und Eure tollpatschigen Freunde an der Reihe. Mmm, ich dachte schon, Ihr würdet nie kommen!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "Kampfbeginn"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn"
}

L:SetMiscLocalization{
	Event		= "Und nun, Schamane, werdet Ihr MIR die Drachenseele geben."
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
