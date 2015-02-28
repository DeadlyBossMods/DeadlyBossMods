-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Feb 28, 2015@13161 

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators		= "温度调节器剩下%d个",
	warnBlastFrequency	= "冲击施法频率增加:大约每%d秒一次"
})

L:SetOptionLocalization({
	warnRegulators		= "显示剩余的温度调节器数量",
	warnBlastFrequency	= "当$spell:155209施法频率增加时发出警告",
	VFYellType			= "设定不稳定的火焰的大喊方式 (史诗模式)",
	Countdown			= "倒数直到消失",
	Apply				= "只有中了的时候"
})

L:SetMiscLocalization({
	heatRegulator		= "温度调节器"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz -- 
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	TorrentYell	= "%d秒后熔岩激流消失"
})

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "10秒后分轨"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "特殊警报：当团队需要在10秒后分轨时"
})

L:SetMiscLocalization({
	lane			= "轨道",
	oneTrain		= "随机单轨道快车",
	oneRandom		= "随机出现在一个轨道上",
	threeTrains		= "随机三轨道快车",
	threeRandom		= "随机出现在三个轨道上",
	helperMessage	= "建议使用第三方插件 'Thogar Assist' 索戈尔助手插件或DBM语音包来帮助你作战。这些都可以在Curse上找到。"
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "返回码头"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "特殊警报：当上船的玩家可以安全地返回码头时"
})

L:SetMiscLocalization({
	shipMessage		= "准备操纵无畏舰的主炮"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"黑石铸造厂小怪"
})
