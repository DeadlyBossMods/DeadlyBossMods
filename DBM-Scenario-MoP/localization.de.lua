if GetLocale() ~= "deDE" then return end
local L

--------------------------------
-- A Brewing Storm --
--------------------------------

L= DBM:GetModLocalization("BrewingStorm")

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

L= DBM:GetModLocalization("CryptofKings")

L:SetGeneralLocalization{
	name = "Krypta der Vergessenen Könige"
}

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Theramores Sturz"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "Arena der Auslöschung"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "Löwenlandung"
else
	landfall = "Herrschaftsfeste"
end

L:SetGeneralLocalization{
	name = landfall
}

L:SetWarningLocalization{
	WarnAchFiveAlive	= "Erfolg \"Nummer 5 lebt!\" fehlgeschlagen!"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "Zeige Warnung bei Fehlschlag des Erfolgs \"Nummer 5 lebt!\""
}

--------------------------------
-- Troves of the Thunder King --
--------------------------------

L= DBM:GetModLocalization("Troves")

L:SetGeneralLocalization{
	name = "Zitadelle des Donnerkönigs"
}

------------------------
-- Warlock Green Fire --
------------------------

L= DBM:GetModLocalization("GreenFire")

L:SetGeneralLocalization{
	name = "Jagd auf die Schwarze Ernte"
}

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
