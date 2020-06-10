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
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Chute has opened - Adds Soon"
})

L:SetTimerLocalization({
	chuteTimer		= "Next Chute (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "Show pre warning for when chutes open and start spawning adds",
	chuteTimer		= "Show timer for when Chutes open"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Orb (%s) Lands"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Show timer for when Orb of Corruption Lands",
	EarlyTankSwap	 =	"Show tank swap warning immediately after Shatter, instead of waiting for 2nd Void Lash"
})

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
	ShowHighestFirst3	 =	"Sort Lingering Infection Infoframe by highest debuff stack (instead of lowest). Only applies if not set to party only.",
	ShowOnlyParty		 =	"Show Lingering Infection only for your party. This option always sorts the frame by party order.",
	SetIconsRegardless	 =	"Set icons regardless of whether or not a BW user has assist (Advanced)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM's has passed icon marking to a promoted BW user in raid to avoid icon conflicts. Make sure they have marking enabled, or demote them to enable DBM marking, or enable the override option in Vectis options"
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
	timerCallofCrawgCD		= "Next Crawg Pool (%s)",
	timerCallofHexerCD 		= "Next Hexer Pool (%s)",
	timerCallofCrusherCD	= "Next Crusher Pool (%s)",
	timerAddIncoming		= DBM_CORE_L.INCOMING
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
