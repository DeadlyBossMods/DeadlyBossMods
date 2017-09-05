-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2017/08/29

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"忽略玩家的平台位置显示所有警告"
})

L:SetMiscLocalization({
	Xoroth = "看，克索诺斯，一个地狱火与枯骨的世界！",
	Rancora = "看，拉恩科纳，这片布满溃烂之池、死亡横行的地方！",
	Nathreza = "纳斯雷萨……它曾是魔法与知识的世界，现在却成了无法逃离的扭曲之地。" 
}) --offical

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"为战斗总览显示信息窗"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

--L:SetTimerLocalization({
--	timerBossIncoming		= DBM_INCOMING
--})

L:SetOptionLocalization({
	timerBossIncoming		= "为下一次Boss交换显示计时条"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"安托鲁斯小怪"
})