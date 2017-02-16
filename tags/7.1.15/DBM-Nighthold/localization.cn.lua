-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: Feb 06 2017, 02:56 UTC@15833

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
	Third				= "第三",
	Adds1				= "我的部下们！进来！", 
	Adds2				= "让这些僭越者看看应该怎么战斗！"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "桥将在%ds秒后断裂"
})

L:SetMiscLocalization({
	MoveLeft			= "向左走",
	MoveRight			= "向右走"
})

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "离子球生命值低"
})

L:SetOptionLocalization({
	warnStarLow				= "特殊警报：当坍缩之星血量低时(~25%)" --offical
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

L:SetMiscLocalization({
	noCLEU4EchoRings		= "让时间的浪潮碾碎你们！",
	noCLEU4EchoOrbs			= "你们会发现，时间极不稳定。"
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
	name =	"暗夜要塞小怪"
})
