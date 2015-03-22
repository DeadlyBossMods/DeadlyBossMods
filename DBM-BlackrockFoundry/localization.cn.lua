-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Mar 22, 2015@13396

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "特殊警报：吸收伤害的分组方式 (史诗模式)",
	ThreeGroup			= "3组1层换",
	TwoGroup			= "2组2层换" 
})

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

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s 向你指派了ExRT的符文的站立位置。你的位置: %s"
 })




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
	specWarnSplitSoon	= "特殊警报：当团队需要在10秒后分轨时",
	InfoFrameSpeed		= "设置显示下一班列车信息窗的时间",
	Immediately			= "当门打开时",
	Delayed				= "当列车出现时" 
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
	specWarnReturnBase	= "特殊警报：当上船的玩家可以安全地返回码头时",
	filterBladeDash2	= "当受到$spell:170395的影响时不显示$spell:155794的特殊警报",
	filterBloodRitual2	= "当受到$spell:170405的影响时不显示$spell:158078的特殊警报"
})

L:SetMiscLocalization({
	shipMessage		= "准备操纵无畏舰的主炮"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "死亡标记站位：%s",
	specWarnSlagPosition	= "炉渣炸弹站位：%s"
})

L:SetMiscLocalization({
	customMFDSay	= "%2$s 中了 死亡标记(%1$s)!",
	customSlagSay	= "%2$s 中了 炉渣炸弹(%1$s)!",
	left			= "左",
	middle			= "中",
	right			= "右"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"黑石铸造厂小怪"
})
