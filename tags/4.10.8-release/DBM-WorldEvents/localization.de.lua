if GetLocale() ~= "deDE" then return end
local L

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Apotheker-Trio"
})

L:SetWarningLocalization({
})

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

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune ist abgetaucht",
	Emerged			= "Ahune ist aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Abtauchen",
	EmergeTimer		= "Auftauchen",
	TimerCombat		= "Kampfbeginn"
}

L:SetOptionLocalization({
	Submerged		= "Zeige Warnung, wenn Ahune abtaucht",
	Emerged			= "Zeige Warnung, wenn Ahune auftaucht",
	specWarnAttack	= "Zeige Spezialwarnung, wenn Ahune verwundbar wird",
	SubmergTimer	= "Zeige Zeit bis Abtauchen",
	EmergeTimer		= "Zeige Zeit bis Auftauchen",
	TimerCombat		= "Zeige Zeit bis Kampfbeginn",
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Düsterbräu"
})

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir noch eins zuwirft!",
	specWarnBrewStun	= "TIPP: Du hast eine Kopfnuss kassiert, trink das Bier beim nächsten Mal!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Zeige Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Zeige Spezialwarnung für $spell:47340",
	YellOnBarrel		= "Schreie bei $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel			= "Stecke im Fass!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Der kopflose Reiter"
})

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

L:SetWarningLocalization({
})

L:SetTimerLocalization{
}

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})