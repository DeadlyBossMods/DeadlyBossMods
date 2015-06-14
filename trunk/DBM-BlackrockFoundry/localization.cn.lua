-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Jun 10, 2015@13867

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

L:SetOptionLocalization({
	InterruptBehavior	= "设置打断$spell:156879警告的方式",
	Smart				= "基于BOSS尖刺的层数",
	Fixed				= "永远3打断或5打断轮换"
})

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "温度调节器剩下:%d",
	warnBlastFrequency		= "冲击施法频率增加:大约每%d秒一次",
	specWarnTwoVolatileFire	= "你叠加了两层不稳定的火焰"
})

L:SetOptionLocalization({
	warnRegulators			= "显示剩余的温度调节器生命值",
	warnBlastFrequency		= "当$spell:155209施法频率增加时发出警告",
	specWarnTwoVolatileFire	= "特殊警报：当你受到两层$spell:176121的影响时",
	InfoFrame				= "为$spell:155192和$spell:155196显示信息框体",
	VFYellType2				= "设定$spell:176121的大喊方式 (史诗模式)",
	Countdown				= "倒数直到消失",
	Apply					= "只有中了的时候"
})

L:SetMiscLocalization({
	heatRegulator		= "温度调节器",
	Regulator			= "调节器 %d",
	bombNeeded			= "%d个炸弹"
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
	InfoFrameSpeed		= "设置何时在信息框体显示下一班列车的信息",
	Immediately			= "当门打开时",
	Delayed				= "当列车出现时",
	HudMapUseIcons		= "在HudMap中，使用团队标记代替绿圈",
	TrainVoiceAnnounce	= "设置语音报警下一班列车的信息类型",
	LanesOnly			= "仅包含轨道信息",
	MovementsOnly		= "仅包含走位信息 (史诗模式)",
	LanesandMovements	= "同时包含轨道信息和走位信息 (史诗模式)"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
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
	filterBladeDash3	= "当受到$spell:170395的影响时不显示$spell:155794的特殊警报",
	filterBloodRitual3	= "当受到$spell:170405的影响时不显示$spell:158078的特殊警报"
})

L:SetMiscLocalization({
	shipMessage		= "准备操纵无畏舰的主炮",
	EarlyBladeDash	= "太慢了！"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "死亡标记站位：%s",
	specWarnSlagPosition	= "炉渣炸弹站位：%s"
})

L:SetOptionLocalization({
	PositionsAllPhases	= "在所有阶段受到$spell:156096影响时喊话 (原来只在第三阶段喊。测试目的。)",
	InfoFrame			= " 为$spell:155992和$spell:156530显示信息框体"
})

L:SetMiscLocalization({
	customMFDSay	= "%2$s 中了 死亡标记(%1$s)!",
	customSlagSay	= "%2$s 中了 炉渣炸弹(%1$s)!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"黑石铸造厂小怪"
})
