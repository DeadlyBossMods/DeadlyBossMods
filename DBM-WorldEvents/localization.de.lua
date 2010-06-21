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
	specWarnBrew		= "Get rid of the brew before she tosses you another one!",	--to be translated
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
	specWarnHorsemanHead	= "Wirbelwind - Wechsel auf den Kopf"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Zeige Warnung wenn Pulsierender Kürbnis erscheint",
	specWarnHorsemanHead	= "Zeige Spezialwarnung für Wirbelwind (ab der zweiten Kopfphase)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Get over here, you idiot!",	--to be translated
	HorsemanSoldiers	= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!",	--to be translated
	SayCombatEnd		= "This end have I reached before.  What new adventure lies in store?"	--to be translated
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