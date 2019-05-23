if GetLocale() ~= "koKR" then return end
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
--  The Hatchery --
---------------------------
L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"3초 후 동그라미"
})

---------------------------
-- Herald of N'zoth --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Tear =	"눈물"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetMiscLocalization({
	SoakOrb =	"구슬 맞기",
	AvoidOrb =	"구슬 피하기",
	GroupUp =	"뭉치기",
	Spread =	"산개",
	Move	 =	"계속 이동",
	DontMove =	"이동 중지"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"영원한 궁전 일반몹"
})
