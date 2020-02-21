local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"Circles in 3s"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "Za'qul tears open the pathway to Delirium Realm!",
	Tear	= "Tear"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Adds Berserk"
}

L:SetOptionLocalization({
	SortDesc 				= "Sort $spell:298569 Infoframe by highest debuff stack (instead of lowest).",
	ShowTimeNotStacks		= "Show time remaining on $spell:298569 Infoframe instead of stack count.",
	timerStageThreeBerserk	= "Show timer for when the Stage 3 adds go Berserk"
})

L:SetMiscLocalization({
	SoakOrb 			= "Soak Orb",
	AvoidOrb 			= "Avoid Orb",
	GroupUp 			= "Group Up",
	Spread 				= "Spread",
	Move				= "Keep Moving",
	DontMove 			= "Stop Moving",
	--For Yells
	HelpSoakMove		= "{rt3}HELP SOAK MOVE{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}HELP SOAK STAY{rt6}",--Blue Square
	HelpSoak			= "{rt3}HELP SOAK{rt3}",--Purple Diamond
	HelpMove			= "{rt4}HELP MOVE{rt4}",--Green Triangle
	HelpStay			= "{rt7}HELP STAY{rt7}",--Red X
	SoloSoak 			= "SOLO SOAK",
	Solo 				= "SOLO",
	--Not currently used Yells
	SoloMoving			= "SOLO MOVE",
	SoloStay			= "SOLO STAY",
	SoloSoakMove		= "SOLO SOAK MOVE",
	SoloSoakStay		= "SOLO SOAK STAY"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Eternal Palace Trash"
})

