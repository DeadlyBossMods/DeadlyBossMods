if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	NoDebuff	= "無%s"
})

---------------------------
-- Chronomatic Anomaly --
---------------------------
L= DBM:GetModLocalization(1725)

---------------------------
-- Trilliax --
---------------------------
L= DBM:GetModLocalization(1731)

------------------
-- Spellblade Aluriel --
------------------
L= DBM:GetModLocalization(1751)

------------------
-- Tichondrius --
------------------
L= DBM:GetModLocalization(1762)

L:SetMiscLocalization({
	First				= "第一",
	Second				= "第二",
	Third				= "第三",
	Adds1				= "手下們！都進來！",
	Adds2				= "讓這些笨蛋見識真正的戰鬥！"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "橋梁將在%d秒後砸毀"
})

L:SetMiscLocalization({
	MoveLeft			= "向左移動",
	MoveRight			= "向右移動"
})

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "電漿球低血量"
})

L:SetOptionLocalization({
	warnStarLow				= "為電漿球血量變低時(15%)顯示特別警告"
})

L:SetMiscLocalization({
	RadarMessage			= "使用雷達找到無減益的夥伴加上HUD去閃避減益。未來希望能加強此功能並提供更多選項。"
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowNeutralColor		= "為沒有星之記號的玩家顯示HUB的白圈，直到所有記號被清除。",
	FilterOtherSigns		= "過濾與你無關的星之記號點名。"
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetMiscLocalization({
	noCLEU4EchoRings		= "時間的浪潮會粉碎你！",
	noCLEU4EchoOrbs			= "你會發現時光有時很不穩定。"
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"暗夜堡小怪"
})
