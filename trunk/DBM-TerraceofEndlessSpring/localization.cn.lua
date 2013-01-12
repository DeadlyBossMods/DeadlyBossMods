-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/4/2013

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（8码）：$spell:111850\n当你受到效果影响时会显示其他所有没有受到效果影响的队友",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "谢谢你，陌生人。我自由了。"
}


-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s 结束",
	warnHideProgress		= "命中：%s，伤害：%s，时间：%s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "特殊能力冷却（%d）"
})

L:SetOptionLocalization({
	warnHideOver			= "特殊警报：$spell:123244效果结束时",
	warnHideProgress		= "警报：$spell:123244阶段的战斗统计",
	timerSpecialCD			= "计时条：特殊能力冷却",
	SetIconOnProtector		= "为$journal:6224的目标添加团队标记",
	RangeFrame				= "距离监视（3码）：应对$spell:123121\n（隐藏阶段时显示所有人，其余时仅显示坦克位置）",
	GWHealthFrame			= "生命值监视：移除$spell:123461还需要的伤害"
})


L:SetMiscLocalization{
	Victory	= "我……啊……噢！我……？眼睛……好……模糊。"--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "穿过金莲之影",
	MoveWarningRight			= "向右",
	MoveWarningBack				= "返回原位",
	specWarnBreathOfFearSoon	= "即将恐惧吐息 - 快到光墙内！"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "下一次特殊能力",
	timerSpoHudCD				= "畏惧/水涌冷却",
	timerSpoStrCD				= "水涌/打击冷却",
	timerHudStrCD				= "畏惧/打击冷却"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "特殊警报：当没有$spell:117964效果需要躲避$spell:119414时",
})

L:SetOptionLocalization({
	RangeFrame					= "距离监视（2码）：应对$spell:119519",
	MoveWarningForward			= "特殊警报：被$spell:120047命中需要穿过金莲之影",
	MoveWarningRight			= "特殊警报：被$spell:120047命中需要向右移动",
	MoveWarningBack				= "特殊警报：$spell:120047阶段结束需要返回原位",
	timerSpecialAbilityCD		= "计时条：下一次特殊能力",
	timerSpoHudCD				= "计时条：下一次可能的$spell:120629或$spell:120519",
	timerSpoStrCD				= "计时条：下一次可能的$spell:120519或$spell:120672",
	timerHudStrCD				= "计时条：下一次可能的$spell:120629或$spell:120672"
})