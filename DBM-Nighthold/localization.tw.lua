if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

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

L:SetOptionLocalization({
	HUDSeekerLines		= "為覓腐蟲群顯示HUD線條"
})

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
	warnStarLow				= "為電漿球血量變低時(25%)顯示特別警告"
})

L:SetMiscLocalization({
	RadarMessage			= "使用雷達找到無減益的夥伴加上HUD去閃避減益。未來希望能加強此功能並提供更多選項。"
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)



L:SetOptionLocalization({
	ShowCustomNPAuraTexture	= "如果你中了星之記號則在名條上顯示自訂的綠/紅圖示材質而不是星之記號減益",
	FilterOtherSigns		= "過濾與你無關的星之記號點名。"
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "加快區域(%d)",
	timerSlowTimeBubble		= "遲緩區域(%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "為$spell:209166區域顯示計時器",
	timerSlowTimeBubble		= "為$spell:209165區域顯示計時器"
})

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
