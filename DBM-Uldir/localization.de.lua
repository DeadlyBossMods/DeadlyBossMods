if GetLocale() ~= "deDE" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"hat Aggro"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Chute has opened - Adds Soon"--Translate
})

L:SetTimerLocalization({
	chuteTimer		= "Next Chute (%s)"--Translate
})

L:SetOptionLocalization({
	addsSoon		= "Show pre warning for when chutes open and start spawning adds",--Translate
	chuteTimer		= "Show timer for when Chutes open"--Translate
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Kugel (%s) landet"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Zeige Zeit bis Kugel der Verderbnis landet"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Disc accessed. C'thun data loading.",--translate (trigger)
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",--translate (trigger)
	CorruptedDisc =	"Disc accessed. Corrupted data loading."--translate (trigger)
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Sortiere Infofenster nach dem höchsten Stapel von \"Anhaltende Infektion\" (statt dem niedrigsten Stapel)",
	ShowOnlyParty		 =	"Zeige Anhaltende Infektion nur für deine Gruppe"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"Um Konfikte zu vermeiden, hat DBM das Setzen von Schlachtzugzeichen BW-Nutzern mit \"Assistent\"-Rechten überlassen. Stelle sicher, dass diese die Zeichensetzung aktiviert haben oder entziehe ihnen die \"Assistent\"-Rechte um die Zeichensetzung durch DBM zu aktivieren."
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Nächster Krogg (%s)",
	timerCallofHexerCD 		= "Nächster Hexer (%s)",
	timerCallofCrusherCD	= "Nächster Zermalmer (%s)"
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Zeige Zeit bis Krogg Pfützen entstehen",
	timerCallofHexerCD 		= "Zeige Zeit bis Hexer Pfützen entstehen",
	timerCallofCrusherCD	= "Zeige Zeit bis Zermalmer Pfützen entstehen",
	timerAddIncoming		= "Zeit bis erscheinende Adds angreifbar sind anzeigen",
	TauntBehavior			= "Setze Spottverhalten für Tankwechsel",
	TwoHardThreeEasy		= "Wechsel bei 2 Stacks (heroisch/mythisch) bzw. 3 Stacks (andere Schwierigkeitsgrade)",
	TwoAlways				= "Wechsel immer bei 2 Stacks (unabhängig vom Schwierigkeitsgrad)",
	ThreeAlways				= "Wechsel immer bei 3 Stacks (unabhängig vom Schwierigkeitsgrad)"
})

L:SetMiscLocalization({
	Crusher			=	"Zermalmer",
	Bloodhexer		=	"Hexer",
	Crawg			=	"Krogg"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Energiematrix fallen gelassen"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Zeige Warnung, wenn eine Energiematrix fallen gelassen wird"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Jetzige Matrix:",
	NextMatrix			=	"Nächste Matrix:",
	CurrentMatrixLong	=	"Jetzige Matrix (%s):",
	NextMatrixLong		=	"Nächste Matrix (%s):"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Trash von Uldir"
})
