-- Mini Dragon(projecteurs@gmail.com)
-- Blizzard Entertainment
-- Last update: May 12 2015, 08:10 UTC@14943

if GetLocale() ~= "zhCN" then return end
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
	NoDebuff	= "无%s"
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
	Third				= "第三"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization{
	warnStarLow				= "等离子球" --is low
}

L:SetOptionLocalization{
	warnStarLow				= "特殊警报：当堕落之星血量低时(~15%)"
}

L:SetMiscLocalization({
	RadarMessage			= "目前请使用雷达来找一个没有debuff的队友，并用HUD来防止碰到debuffs。我们会拿出更多的黑科技。"
})


------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetOptionLocalization{
	FilterOtherSigns		= "过滤掉与你无关的星座点名喊叫"
}

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SuramarTrash")

L:SetGeneralLocalization({
	name =	"暗夜要塞小怪"
})
