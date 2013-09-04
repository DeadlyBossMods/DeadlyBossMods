if GetLocale() ~= "deDE" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Omen"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Hummel wird aktiv",
	BaxterActive		= "Baxter wird aktiv",
	FryeActive			= "Frye wird aktiv"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Zeit bis Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Abtauchen",
	EmergeTimer		= "Auftauchen",
	TimerCombat		= "Kampfbeginn"
}

L:SetOptionLocalization({
	Emerged			= "Zeige Warnung, wenn Ahune auftaucht",
	specWarnAttack	= "Spezialwarnung, wenn Ahune verwundbar wird",
	SubmergTimer	= "Zeige Zeit bis Abtauchen",
	EmergeTimer		= "Zeige Zeit bis Auftauchen",
	TimerCombat		= "Zeige Zeit bis Kampfbeginn"
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir noch eins zuwirft!",
	specWarnBrewStun	= "TIPP: Du hast eine Kopfnuss kassiert, trink das Bier beim nächsten Mal!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Spezialwarnung für $spell:47340",
	YellOnBarrel		= "Schreie bei $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel			= "Stecke im Fass!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsierende Kürbisse erscheinen",
	warnHorsemanHead		= "Kopf des Reiters aktiv"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Kampfbeginn"
}

L:SetOptionLocalization({
	WarnPhase				= "Zeige Warnung für jeden Phasenwechsel",
	TimerCombatStart		= "Zeige Zeit bis Kampfbeginn",
	warnHorsemanSoldiers	= "Zeige Warnung, wenn Pulsierende Kürbnisse erscheinen",
	warnHorsemanHead		= "Zeige Warnung, wenn Kopf des Reiters erscheint"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Erhebe dich, Reiter,...",
	HorsemanSoldiers		= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Der monströse Griesgram"
})

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
