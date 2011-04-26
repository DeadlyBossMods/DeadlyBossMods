if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- PdC: Großchampions, Der Schwarze Ritter
-- HdR: Lichkönig-Event (Horde)

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Düsterbräu"
})

L:SetWarningLocalization({
	specWarnBrew		= "Get rid of the brew befüre she tosses you another one!",	--to be translated
	specWarnBrewStun	= "HINT: You were bonked, remember to drink the brew next time!"	--to be translated
})

L:SetOptionLocalization({
	specWarnBrew		= "Zeige Spezialwarnung für Bier der dunklen Schankmaid",
	specWarnBrewStun	= "Zeige Spezialwarnung für Betäubung der dunklen Schankmaid",
	YellOnBarrel		= "Schreie bei Fass"
})

L:SetMiscLocalization({
	YellBarrel	= "Fass auf mir!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Der kopflose Reiter"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "neuer Pulsierender Kürbis",
	warnHorsemanHead	= "Wirbelwind - Wechsel auf den Kopf"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Zeige Warnung wenn Pulsierender Kürbnis erscheint",
	warnHorsemanHead	= "Zeige Spezialwarnung für Wirbelwind (ab der zweiten Kopfphase)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Komm hierher, du Idiot!",
	HorsemanSoldiers	= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!",
	SayCombatEnd		= "Dieses Ende ist mir schon bekannt. Welch neue Abenteuer hat das Schicksal zur Hand?"
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
	HummelActive	= "Hummel wird aktiv",
	BaxterActive	= "Baxter wird aktiv",
	FryeActive		= "Frye wird aktiv"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Timer für wann die Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?"
})

-----------------------
--  Lord Ahune  --
-----------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Fürst Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune untergetaucht",
	Emerged			= "Ahune aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Untertauchen",
	EmergeTimer		= "Auftauchen",
	TimerCombat		= "Kampfbeginn"
}

L:SetOptionLocalization({
	Submerged		= "Zeige Warnung wenn Ahune untertaucht",
	Emerged			= "Zeige Warnung wenn Ahune auftaucht",
	specWarnAttack	= "Zeige Spezialwarnun wenn Ahune verwundbar wird",
	SubmergTimer	= "Zeige Timer für Untertauchen",
	EmergeTimer		= "Zeige Timer für Auftauchen",
	TimerCombat		= "Zeige Timer für Kampfbeginn",
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})