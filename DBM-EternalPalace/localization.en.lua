local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
L= DBM:GetModLocalization(2354)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Orgozoa --
---------------------------
L= DBM:GetModLocalization(2351)

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

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Eternal Palace Trash"
})

L:SetMiscLocalization({
	SoakOrb =	"Soak Orb",
	AvoidOrb =	"Avoid Orb",
	GroupUp =	"Group Up",
	Spread =	"Spread",
	Move	 =	"Keep Moving",
	DontMove =	"Stop Moving",
	--For Yells, not yet used, localize anyways.
	Soaking =	"{rt3}Soaking{rt3}",--Diamond for arcane orbs
	Stacking =	"Stacking",
	Solo =		"Solo",
	Marching =	"{rt4}Marching{rt4}",--Green Triangle
	Staying =	"{rt7}Staying{rt7}"--Red X
})
