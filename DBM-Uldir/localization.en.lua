local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"Has Aggro"
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
	CThunDisc	 =	"Disc accessed. C'thun data loading.",
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",
	CorruptedDisc =	"Disc accessed. Corrupted data loading."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst	 =	"Sort Lingering Infection Infoframe by highest debuff stack (instead of lowest)"
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
	timerCallofCrawgCD		= "Next Crawg (%s)",
	timerCallofHexerCD 		= "Next Hexer (%s)",
	timerCallofCrusherCD	= "Next Crusher (%s)",
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej18541"),
	timerCallofHexerCD 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej18540"),
	timerCallofCrusherCD	= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej18539"),
	timerAddIncoming		= "Show timer for when incoming add is attackable"
})

L:SetMiscLocalization({
	Crusher			=	"Crusher",
	Bloodhexer		=	"Hexer",
	Crawg			=	"Crawg"
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
	name =	"Uldir Trash"
})
