if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Kanonendonner"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Hau-den-Gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Es wurden %d von insgesamt %d erreichbaren Punkten erzielt.",
	warnGameOverNoQuest	= "Spielende. Es waren insgesamt %d Punkte erreichbar.",
	warnGnoll			= "Gnoll erschienen",
	warnHogger			= "Hogger erschienen",
	specWarnHogger		= "Hogger erschienen!"
})

L:SetOptionLocalization({
	warnGameOver	= "Verkünde nach dem Spielende die insgesamt erreichbaren Punkte",
	warnGnoll		= "Zeige Warnung, wenn ein Gnoll erscheint",
	warnHogger		= "Zeige Warnung, wenn ein Hogger erscheint",
	specWarnHogger	= "Spezialwarnung, wenn ein Hogger erscheint"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Schießbude"
})

L:SetOptionLocalization({
	SetBubbles			= "Automatische Deaktivierung der 'Sprechblasen' während $spell:101871<br/>(wird nach dem Spielende auf die vorherige Einstellung zurückgesetzt)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Panzergeneral"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Dunkelmond-Kaninchen"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Mondfang"
})

L:SetWarningLocalization({
	specWarnCallPack		= "Rudelruf - Lauf mehr als 40 Meter von Mondfang weg!",
	specWarnMoonfangCurse	= "Mondfangs Fluch - Lauf mehr als 10 Meter von Mondfang weg!"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Pflanzen gegen Zombies"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Anzahl erschienener Zombies seit letzter Riesiger Welle: %d",
	specWarnWave	= "Riesige Welle!"
})

L:SetTimerLocalization{
	timerWave		= "Nächste Riesige Welle"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Verkünde die Anzahl der erschienenen Zombies zwischen jeder Riesigen Welle",
	specWarnWave	= "Spezialwarnung, wenn eine Riesige Welle beginnt",
	timerWave		= "Zeige Zeit bis nächste Riesige Welle"
})

L:SetMiscLocalization({
	MassiveWave		= "Eine riesige Zombiewelle nähert sich!" --needs to be verified (video-captured translation)
})
