-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2017/03/18

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

L:SetOptionLocalization({
	InfoFrameBehavior	= "在战斗中显示信息窗",
	TimeRelease			= "显示被时间释放影响的玩家",
	TimeBomb			= "显示被时间炸弹影响的玩家"
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
	warnSlamSoon		= "桥将在%d秒后断裂"
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
	warnStarLow				= "球血量低"
})

L:SetOptionLocalization({
	warnStarLow				= "特殊警报：当坍缩之星血量低时(~25%)"
})

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


L:SetTimerLocalization({
	timerFastTimeBubble		= "红罩子 (加速-%d)",
	timerSlowTimeBubble		= "蓝罩子 (减速-%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "计时条：$spell:209166 的红罩子",
	timerSlowTimeBubble		= "计时条：$spell:209165 的蓝罩子"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "让时间的浪潮碾碎你们！",
	noCLEU4EchoOrbs			= "你们会发现，时间极不稳定。",
	prePullRP				= "我早就预见了你们的到来，命运指引你们来到此地。为了阻止军团，你们想背水一战。"
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "该让这个恶魔猎手的灵魂回到躯体中……防止燃烧军团之主占据它了！",
	prePullRP			= "啊我们的英雄到了，如此执着，如此自性但这种傲慢只会毁了你们！"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"暗夜要塞小怪"
})
