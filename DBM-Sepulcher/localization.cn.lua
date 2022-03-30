--Mini Dragon <流浪者酒馆-Brilla@金色平原> 20220330

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Solitary Guardian -- 孤生护卫
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle -- 道茜歌妮，堕落先知
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox -- 圣物匠赛·墨克斯
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon -- 万神殿原型
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "设置仪式的图标行为 (团长覆盖全团)",
	SetOne					= "与种子/午夜猎手不同 (无冲突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "与种子/午夜猎手配对 (如果种子与仪式同时出现则冲突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "与种子/午夜猎手配对 (不冲突，但需要团队成员安装特殊扩展图标来看见他们) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "死亡之触",
	Dispel			= "驱散",
	ExtendReset		= "你的仪式图标下拉选项已被重置，因为不再用了"
})

---------------------------
--  Lihuvim, Principal Architect -- 首席建筑师利胡威姆
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener -- 司垢莱克斯，无穷噬灭者
---------------------------
--L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~坦克组合技 (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "显示坦克组合技的冷却时间"
})

---------------------------
--  Halondrus the Reclaimer -- 回收者黑伦度斯
---------------------------
--L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "微尘"
})

---------------------------
--  Anduin Wrynn -- 安度因·乌瑞恩
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "设置渎神（光明与黑暗）的模组行为。队长设置覆盖全队。",
	Auto				= "点你提示，自动分配相反标记玩家，聊天说话符号提示该配对",
	Generic				= "点你提示，不分配相反标记玩家，聊天说话只符号提示光明或者黑暗的buff",--Default
	None				= "点你提示，不分配，没有聊天说话"
})

---------------------------
--  Lords of Dread -- 恐惧魔王
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon -- 莱葛隆
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer -- 典狱长
---------------------------
--L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "治疗艾泽拉斯 (%s)",
	warnDispel			= "驱散 (%s)"
})

L:SetTimerLocalization{
	timerPits			= "坑洞开启",
	timerHealAzeroth	= "治疗艾泽拉斯 (%s)",
	timerDispels		= "驱散 (%s)"
}

L:SetOptionLocalization({
	timerPits			= "计时器：楼层坑洞暴露时，你可以跳入。",
	warnHealAzeroth		= "警告：在史诗难度下，提示你何时治疗艾泽拉斯（基于Echo的策略）。",
	warnDispel			= "警告：在实施难度下，提示你何时驱散死亡宣判（基于Echo的策略）。",
	timerHealAzeroth	= "计时器：在史诗难度下，提示你何时治疗艾泽拉斯（基于Echo的策略）。",
	timerDispels		= "计时器：在实施难度下，提示你何时驱散死亡宣判（基于Echo的策略）。"
})

L:SetMiscLocalization({
	Pylon				= "晶塔",
	AzerothSoak			= "艾泽拉斯分摊伤害"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"初诞者圣墓小怪"
})
