-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Nov 1 2016, 5:59 UTC@15435

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Nythendra --
---------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Il'gynoth, Heart of Corruption --
---------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	SetIconOnlyOnce2	= "当一个软泥爆炸以后, 关闭软泥图标提示",
	InfoFrameBehavior	= "设置在战斗过程中信息窗的内容",
	Fixates				= "显示被锁定的玩家",
	Adds				= "显示所有小怪计数"
})

---------------------------
-- Elerethe Renferal --
---------------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain		= ">%s< 和 >%s< 相连!",--Only this needs localizing
	specWarnWebofPain	= "你和 >%s< 相连!"--Only this needs localizing
})

---------------------------
-- Ursoc --
---------------------------
L= DBM:GetModLocalization(1667)

L:SetOptionLocalization({
	NoAutoSoaking2		= "关闭所有和专注凝视有关的吃冲击提示"
})

L:SetMiscLocalization({
	SoakersText		=	"吃冲击分配: %s"
})

---------------------------
-- Dragons of Nightmare --
---------------------------
L= DBM:GetModLocalization(1704)

------------------
-- Cenarius --
------------------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleYell			= UnitName("player") .. " 的附近有梦魇荆棘!",
	BrambleMessage		= "注意: 梦魇荆棘没有战斗记录无法被DBM检测. DBM目前使用的黑科技只能确保显示第一个点名的人. (换其他插件也不行)"
})

------------------
-- Xavius --
------------------
L= DBM:GetModLocalization(1726)

L:SetOptionLocalization({
	InfoFrameFilterDream	= "在信息窗中过滤到受到 $spell:206005 影响的玩家"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"翡翠梦魇小怪"
})
