if GetLocale() ~= "deDE" then return end

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
	Phase3	= "Za'qul reißt den Weg zum Reich des Deliriums auf!",
	Tear	= "Tear"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetMiscLocalization({
	SoakOrb 		=	"Soak Orb",
	AvoidOrb 		=	"Avoid Orb",
	GroupUp 		=	"Group Up",
	Spread 			=	"Spread",
	Move			=	"Keep Moving",
	DontMove 		=	"Stop Moving",
	--For Yells
	HelpSoakMove	= "{rt3}HELP SOAK MOVE{rt3}",--Purple Diamond
	HelpSoakStay	= "{rt6}HELP SOAK STAY{rt6}",--Blue Square
	HelpSoak		= "{rt3}HELP SOAK{rt3}",--Purple Diamond
	HelpMove		= "{rt4}HELP MOVE{rt4}",--Green Triangle
	HelpStay		= "{rt7}HELP STAY{rt7}",--Red X
	SoloSoak 		= "SOLO SOAK",
	Solo 			= "SOLO",
	--Not currently used Yells
	SoloMoving		= "SOLO MOVE",
	SoloStay		= "SOLO STAY",
	SoloSoakMove	= "SOLO SOAK MOVE",
	SoloSoakStay	= "SOLO SOAK STAY"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Eternal Palace Trash"
})

