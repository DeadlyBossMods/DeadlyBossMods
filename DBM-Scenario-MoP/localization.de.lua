if GetLocale() ~= "deDE" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "Bräu fertig (ca.)"
}

L:SetOptionLocalization{
	timerEvent			= "Zeige ungefähre Zeit bis das Brauen abgeschlossen ist"
}

L:SetMiscLocalization{
	BrewStart			= "Der Sturm bricht los! Macht Euch fertig.",
	BrewFinish			= "Ihr habt's geschafft! Schaffen wir das Bräu ins Kloster...",
	BorokhulaPull		= "Letzte Chance, ihr schleimigen, züngelnden Kriecher!",
	BorokhulaAdds		= "ruft Verstärkung!"
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "Your Alliance is WEAK!"--translate (trigger)
}

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "Zan'vess will never fall!"--translate (trigger)
}

-----------------------
-- Brewmoon Festival --
-----------------------
L= DBM:GetModLocalization("d539")

L:SetTimerLocalization{
	timerBossCD		= "%s kommt"
}

L:SetOptionLocalization{
	timerBossCD		= "Zeige Zeit bis zum Erscheinen des nächsten Bosses"
}

L:SetMiscLocalization{
	RatEngage	= "Das ist die Höhlenmutter! Passt auf",
	BeginAttack	= "Wir müssen die Dorfbewohner verteidigen!",
	Yeti		= "Kriegsyeti der Bataari",
	Qobi		= "Kriegshetzer Qobi"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

L:SetWarningLocalization{
	WarnAchFiveAlive	= "Erfolg \"Nummer 5 lebt!\" fehlgeschlagen!"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "Zeige Warnung bei Fehlschlag des Erfolgs \"Nummer 5 lebt!\""
}

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

L:SetMiscLocalization{
	Stage2	= "Nun, dieser Ort gibt eine genauso gute Braustätte ab wie jeder andere."
}

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization{
	specWarnLostSouls		= "Verirrte Seelen!",
	specWarnEnslavePitLord	= "Grubenlord - Jetzt versklaven!"
}

L:SetTimerLocalization{
	timerCombatStarts		= "Kampfbeginn",
	timerLostSoulsCD		= "Verirrte Seelen CD"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "Zeige Spezialwarnung, wenn Verirrte Seelen erscheinen",
	specWarnEnslavePitLord	= "Zeige Spezialwarnung zum Dämonenversklaven, wenn der Grubenlord erscheint/freikommt",
	timerCombatStarts		= "Zeige Zeit bis Kampfbeginn",
	timerLostSoulsCD		= "Zeige Zeit bis nächste Verirrte Seelen erscheinen"
}

L:SetMiscLocalization{
	LostSouls				= "Stellt Euch den Seelen, die Ihr in die Verdammnis schicken wolltet!"--needs to be verified (wowhead-captured translation)
}
