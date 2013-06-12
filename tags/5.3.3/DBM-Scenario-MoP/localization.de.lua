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

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "Zan'vess will never fall!"--translate (trigger)
}

------------------------------
-- Battle on the High Seas ---
------------------------------
L= DBM:GetModLocalization("d652")

-----------------------
-- Blood in the Snow --
-----------------------
L= DBM:GetModLocalization("d646")

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

-----------------------
-- Dagger in the Dark --
-----------------------
L= DBM:GetModLocalization("d616")

L:SetTimerLocalization{
	timerAddsCD		= "Neue Adds"
}

L:SetOptionLocalization{
	timerAddsCD		= "Zeige Zeit bis ein Echsenlord neue Adds herbeiruft"
}

L:SetMiscLocalization{
	LizardLord		= "Diese Saurok bewachen die Höhle. Räumen wir sie aus'm Weg!"
}

----------------------------
-- Dark Heart of Pandaria --
----------------------------
L= DBM:GetModLocalization("d647")

L:SetMiscLocalization{
	summonElemental		= "Meine Diener, vernichtet diese Insekten!"
}

------------------------
-- Greenstone Village --
------------------------
L= DBM:GetModLocalization("d492")

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

----------------------------
-- The Secret of Ragefire --
----------------------------
L= DBM:GetModLocalization("d649")

L:SetMiscLocalization{
	XorenthPull		= "All lesser races are enemies of the true Horde!",--translate (trigger)
	ElagloPull		= "Fools! The true horde cannot be stopped by the likes of you."--translate (trigger)
}

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

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
	specWarnLostSouls		= "Spezialwarnung, wenn Verirrte Seelen erscheinen",
	specWarnEnslavePitLord	= "Spezialwarnung zum Dämonenversklaven, wenn der Grubenlord erscheint/freikommt",
	timerCombatStarts		= "Zeige Zeit bis Kampfbeginn",
	timerLostSoulsCD		= "Zeige Zeit bis nächste Verirrte Seelen erscheinen"
}

L:SetMiscLocalization{
	LostSouls				= "Stellt Euch den Seelen, die Ihr in die Verdammnis schicken wolltet!"--needs to be verified (wowhead-captured translation)
}
