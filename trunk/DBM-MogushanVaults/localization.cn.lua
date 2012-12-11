-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/12/2012

if GetLocale() ~= "zhCN" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s: 即将施放", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "扯断红玉锁链！"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "特殊警报：过载预警", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "特殊惊爆：可扯断$spell:130395",
	ArrowOnJasperChains			= "DBM箭头：当你受到$spell:130395效果影响时",
	InfoFrame					= "信息框：石像能量及激活情况"
})

L:SetMiscLocalization({
	Overload	= "%s即将过载！"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "第%d阶段"
})

L:SetOptionLocalization({
	WarnPhase	= "警报：阶段转换",
	RangeFrame	= "距离监视（6码）：应对奥术阶段"
})

L:SetMiscLocalization({
	Fire		= "噢，至高的神！借我之手融化他们的血肉吧！",
	Arcane		= "噢，上古的贤者！赐予我魔法的智慧吧！",
	Nature		= "噢，伟大的神灵！赐予我大地的力量！",
	Shadow		= "先烈的英灵！用你的盾保护我吧！"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（8码）",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "死亡时间到！"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "黑暗之盾：%d秒后施放"
})

L:SetOptionLocalization({
	DarknessSoon		= "预警：$spell:117697（提前5秒倒计时）",
	RangeFrame			= "距离监视（8码）"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "6秒后地板消失！"
})

L:SetTimerLocalization({
	timerDespawnFloor		= "地板消失"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "特殊警报：平台消失预警",
	timerDespawnFloor		= "计时条：平台消失",
	SetIconOnCreature		= "为$journal:6193的目标添加团队标记",
	SetIconOnDestabilized	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226)
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "信息框：受$spell:116525效果影响的玩家",
	ArrowOnCombo	= "DBM箭头：$journal:5673阶段\n注：该功能正常工作的前提是坦克在Boss面前而其他人在Boss身后。"
})

L:SetMiscLocalization({
	Pull		= "机器开始嗡嗡作响了！到下层去！",--Emote
	Rage		= "皇帝之怒响彻群山。",--Yell
	Strength	= "皇帝的力量出现在壁龛中！",--Emote
	Courage		= "皇帝的勇气出现在壁龛中！",--Emote
	Boss		= "两个巨型构造体出现在大型的壁龛中！"--Emote
})

