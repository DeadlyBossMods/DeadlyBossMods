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
L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

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
	ShowHighestFirst	 =	"Sortiere Infofenster nach dem höchsten Stapel von \"Anhaltende Infektion\" (statt dem niedrigsten Stapel)"
})

---------------
-- Mythrax the Unraveler --
---------------
L= DBM:GetModLocalization(2194)

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
	timerAddIncoming		= "Zeit bis erscheinende Adds angreifbar sind anzeigen"
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

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Trash von Uldir"
})
