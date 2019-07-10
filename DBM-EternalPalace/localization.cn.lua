-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2019/05/29

if GetLocale() ~= "zhCN" then return end
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
	Circles =	"Circles in 3s"
})

---------------------------
-- Herald of N'zoth --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Tear =	"撕裂"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetMiscLocalization({
	SoakOrb =	"吸收球",
	AvoidOrb =	"躲开球",
	GroupUp =	"集合",
	Spread =	"分散",
	Move	 =	"保持移动",
	DontMove =	"停止移动"
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"永恒王宫小怪"
})
