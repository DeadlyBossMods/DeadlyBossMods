-- BNS (三皈依-暗影之月)
-- Blizzard Entertainment
-- Last update: 2019/07/15

if GetLocale() ~= "zhTW" then return end
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
	Circles =	"3秒後出圈"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "札奎爾撕開了一條通往狂亂領域的通道！",
	Tear =	"撕裂"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetOptionLocalization({
	SortDesc 			= "$spell:298569的資訊框架用最高減益層數排序 (取代最低的)。",
	ShowTimeNotStacks	= "$spell:298569的資訊框架顯示剩餘時間而非層數。"
})

L:SetMiscLocalization({
	SoakOrb   =	"吸收球",
	AvoidOrb  =	"躲開球",
	GroupUp  =	"集合",
	Spread     =	"分散",
	Move	   =	"保持移動",
	DontMove =	"停止移動",
	--For Yells,
	HelpSoakMove	= "{rt3}幫忙吸收移動{rt3}",--Purple Diamond
	HelpSoakStay	= "{rt6}幫忙吸收不動{rt6}",--Blue Square
	HelpSoak		    = "{rt3}幫忙吸收{rt3}",--Purple Diamond
	HelpMove		= "{rt4}幫忙移動{rt4}",--Green Triangle
	HelpStay		    = "{rt7}幫忙不動{rt7}",--Red X
	SoloSoak 		    = "單獨吸收",
	Solo 			    = "單獨",
	--Not currently used Yells
	SoloMoving		= "單獨移動",
	SoloStay		    = "單獨不動",
	SoloSoakMove	= "單獨吸收移動",
	SoloSoakStay	= "單獨吸收不動"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"永恆宮殿小怪"
})
