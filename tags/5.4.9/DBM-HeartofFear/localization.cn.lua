-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/26/2013

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s：%s (%s)",
	warnEcho			= "回响出现",
	warnEchoDown		= "回响被击败",
	specwarnAttenuation	= "%s：%s (%s)",
	specwarnPlatform	= "换平台"
})

L:SetOptionLocalization({
	warnEcho			= "警报：回响出现",
	warnEchoDown		= "警报：回响被击败",
	specwarnPlatform	= "特殊警报：改变平台",
	ArrowOnAttenuation	= "DBM箭头：在$spell:127834阶段指示移动方向"
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
	RangeFrame			= "距离监视（10码）：$spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "远离紫圈！"
})


L:SetOptionLocalization({
	specwarnUnder	= "特殊警报：当你在首领身体下方时",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).."（仅英雄难度）"
})

L:SetMiscLocalization({
	UnderHim	= "在它下方",
	Phase2		= "巨型盔甲开始碎裂了"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetMiscLocalization({
	Reinforcements		= "风领主梅尔加拉克调遣援兵了！"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s：>%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1：打断/减益目标，2：打断自己，3：回复生命/意志，4：离开构造体",
	warnAmberExplosion			= "%s 正在施放 %s",
	warnAmberExplosionAM		= "琥珀畸怪正在施放琥珀爆炸 - 快打断！",--personal warning.
	warnInterruptsAvailable		= "可打断 %s: >%s<",
	warnWillPower				= "当前意志：%s",
	specwarnWillPower			= "意志低下！- 还剩5秒",
	specwarnAmberExplosionYou	= "打断%s！",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s：打断 %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s：打断 %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize			= "动摇意志（%2$d）：%1$s",
	timerAmberExplosionAMCD		= "爆炸冷却：琥珀畸怪"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "当变为变异构造体时显示技能及其作用",
	warnAmberExplosion			= "警报：$spell:122398正在施放，并警报来源",
	warnAmberExplosionAM		= "个人警报：打断琥珀畸怪的$spell:122398",
	warnInterruptsAvailable		= "警报：可使用$spell:122402打断琥珀打击的成员",
	warnWillPower				= "警报：当前意志剩余80、50、30、10以及4点时",
	specwarnWillPower			= "特殊警报：在变异构造体中意志低下时",
	specwarnAmberExplosionYou	= "特殊警报：打断自己的$spell:122398",
	specwarnAmberExplosionAM	= "特殊警报：打断琥珀畸怪的$spell:122402",
	specwarnAmberExplosionOther	= "特殊警报：打断变异构造体的$spell:122398",
	timerAmberExplosionAMCD		= "计时条：琥珀畸怪的下一次$spell:122402",
	InfoFrame					= "信息框：意志值",
	FixNameplates				= "在变为变异构造体后自动关闭影响战斗的姓名板<br/>（战斗结束后会自动恢复原始设置）"
})

L:SetMiscLocalization({
	WillPower					= "意志"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "琥珀陷阱：%d/5"
})

L:SetOptionLocalization({
	warnAmberTrap		= "警报：$spell:125826的生成，并提示进度", -- maybe bad translation.
	InfoFrame			= "信息框：受$spell:125390效果影响的玩家",
	RangeFrame			= "距离监视（5码）：$spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "凝视",
	YellPhase3			= "别找借口了，女皇！消灭这些傻瓜，否则我会亲手杀了你！"
})