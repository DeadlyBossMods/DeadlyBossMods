-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/4/2012

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "换平台"
})

L:SetOptionLocalization({
	specwarnPlatform	= "特殊警报：改变平台",
	ArrowOnAttenuation	= "DBM箭头：在$spell:127834阶段指示移动方向",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "%s朝他其中一个平台飞去了！",
	Defeat				= "我们不会向黑暗虚空的绝望屈服。如果女皇要我们去死，我们便照做。"
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "DBM箭头：当有人受到$spell:122949影响时",
	RangeFrame			= "距离监视（8码）：$spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "远离紫圈！"
})


L:SetOptionLocalization({
	specwarnUnder	= "特殊警报：当你在首领身体下方时",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "在它下方"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "风领主梅尔加拉克调遣援兵了！"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLifeTutor		= "1：打断/减益目标，2：打断自己，3：回复生命/意志，4：离开构造体",
	warnAmberExplosion			= "%s 正在施放 %s",
	warnInterruptsAvailable		= "可打断 %s: >%s<",
	specwarnWillPower			= "意志低下！",
	specwarnAmberExplosionYou	= "打断%s！",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s：打断 %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s：打断 %s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "下一次%s: %s"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "当变为变异构造体时显示技能及其作用",
	warnAmberExplosion			= "警报：$spell:122398正在施放，并警报来源",
	warnInterruptsAvailable		= "警报：可使用$spell:122402打断琥珀打击的成员",
	specwarnWillPower			= "特殊警报：在畸形体中意志低下时",
	specwarnAmberExplosionYou	= "特殊警报：打断自己的$spell:122398",
	specwarnAmberExplosionAM	= "特殊警报：打断琥珀畸怪的$spell:122402",
	specwarnAmberExplosionOther	= "特殊警报：打断畸形体的$spell:122398",
	timerAmberExplosionAMCD		= "计时条：琥珀畸怪的下一次$spell:122402",
	InfoFrame					= "信息框：意志值",
	FixNameplates				= "在战斗开始后自动关闭影响战斗的姓名面板\n（战斗结束后会自动恢复原始设置）"
})

L:SetMiscLocalization({
	WillPower					= "意志"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "琥珀陷阱：%d/5",
})

L:SetOptionLocalization({
	warnAmberTrap		= "警报：$spell:125826的生成，并提示进度", -- maybe bad translation.
	InfoFrame			= "信息框：受$spell:125390效果影响的玩家",
	RangeFrame			= "距离监视（5码）：$spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "凝视",
	YellPhase3			= "别找借口了，女皇！消灭这些傻瓜，否则我会亲手杀了你！"

})