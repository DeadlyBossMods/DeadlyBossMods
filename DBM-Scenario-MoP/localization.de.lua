if GetLocale() ~= "deDE" then return end
local L

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

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "Erfolg \"Nummer 5 lebt!\" fehlgeschlagen!"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "Zeige Warnung bei Fehlschlag des Erfolgs \"Nummer 5 lebt!\""
})

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

L:SetWarningLocalization({
	specWarnLostSouls		= "Verirrte Seelen!",
	specWarnEnslavePitLord	= "Grubenlord - Jetzt versklaven!"
})

L:SetTimerLocalization({
	timerLostSoulsCD		= "Verirrte Seelen CD"
})

L:SetOptionLocalization({
	specWarnLostSouls		= "Zeige Spezialwarnung, wenn Verirrte Seelen erscheinen",
	specWarnEnslavePitLord	= "Zeige Spezialwarnung zum Dämonenversklaven, wenn der Grubenlord erscheint/freikommt",
	timerLostSoulsCD		= "Zeige Zeit bis nächste Verirrte Seelen erscheinen"
})

L:SetMiscLocalization({
	LostSouls				= "Stellt Euch den Seelen, die Ihr in die Verdammnis schicken wolltet!"--needs to be verified (wowhead-captured translation)
})
