if GetLocale() ~= "deDE" then return end

local L

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
	specWarnBrew		= "Zeige Spezialwarnung für Bier der dunklen Schankmaid",
	specWarnBrewStun	= "Zeige Spezialwarnung für Betäubung der dunklen Schankmaid",
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
	warnHorsemanSoldiers	= "Pulsierender Kürbis erscheint",
	warnHorsemanHead		= "Wirbelwind - Wechsel auf den Kopf"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Kampfbeginn"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Zeige Zeit bis Kampfbeginn",
	warnHorsemanSoldiers	= "Zeige Warnung, wenn Pulsierender Kürbnis erscheint",
	warnHorsemanHead		= "Zeige Spezialwarnung für Wirbelwind (ab der zweiten Kopfphase)"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Erhebe dich, Reiter,...",
	HorsemanHead			= "Komm hierher, du Idiot!",
	HorsemanSoldiers		= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!",
	SayCombatEnd			= "Dieses Ende ist mir schon bekannt. Welch neue Abenteuer hat das Schicksal zur Hand?"
})

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

-----------------------
--  Lord Ahune  --
-----------------------
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