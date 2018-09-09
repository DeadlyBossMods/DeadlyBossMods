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
	timerCallofCrawgCD		= "Next Crawg Pool (%s)",
	timerCallofHexerCD 		= "Next Hexer Pool (%s)",
	timerCallofCrusherCD	= "Next Crusher Pool (%s)",
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Show timer for when Crawg pools begin to form",
	timerCallofHexerCD 		= "Show timer for when Hexer pools begin to form",
	timerCallofCrusherCD	= "Show timer for when Crusher pools begin to form",
	timerAddIncoming		= "Show timer for when incoming add is attackable",
	TauntBehavior			= "Set taunt behavior for tank swaps",
	TwoHardThreeEasy		= "Swap at 2 stacks on heroic/mythic, 3 stacks on other difficulties",--Default
	TwoAlways				= "Always swap at 2 stacks regardless of difficulty",
	ThreeAlways				= "Always swap at 3 stacks regardless of difficulty"
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

L:SetWarningLocalization({
	warnMatrixFail		= "Power Matrix dropped"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Show warning when Power Matrix is dropped."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Current Matrix:",--Mythic
	NextMatrix			=	"Next Matrix:",--Mythic
	CurrentMatrixLong	=	"Current Matrix (%s):",--Non Mythic
	NextMatrixLong		=	"Next Matrix (%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Uldir Trash"
})
