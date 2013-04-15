if GetLocale() ~= "deDE" then return end
local L

--------------------------------
-- A Brewing Storm --
--------------------------------
L= DBM:GetModLocalization("d517")

L:SetGeneralLocalization{
	name = "Ein Sturm braut sich zusammen"
}

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

--------------------------------
-- Crypt of Forgotten Kings --
--------------------------------
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
