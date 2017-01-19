-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: Jul 21 2015, 10:10 UTC@15067

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

L:SetWarningLocalization({
	warnStarLow				= "离子球" --is low, offical
})

L:SetOptionLocalization({
	warnStarLow				= "特殊警报：当坍缩之星血量低时(~15%)" --offical
})

L:SetMiscLocalization({
	RadarMessage			= "目前请使用雷达来找一个没有debuff的队友，并用HUD来防止碰到debuffs。我们会拿出更多的黑科技。"
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowNeutralColor		= "在HUD中为没有星座点名的玩家标记为白圈，直到所有星座消失。",
	FilterOtherSigns		= "过滤掉与你无关的星座点名喊叫。"
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"暗夜要塞小怪"
})
