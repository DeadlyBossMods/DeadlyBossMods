-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/4/2013

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "循环：小队Group %s",
	specWarnYourGroup	= "轮到你的小对了！"
})

L:SetOptionLocalization({
	warnGroupOrder		= "警报：针对$spell:118191的小队循环\n（当前仅支持25人模式的5/2/2/2战术）",
	specWarnYourGroup	= "特殊警报：当轮到你的小队需要应对$spell:118191时\n（仅25人模式）",
	RangeFrame			= "距离监视（8码）：$spell:111850\n当你受到效果影响时会显示其他所有没有受到效果影响的队友",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetOptionLocalization({
	warnLightOfDay	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(123716)
})

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
	SetIconOnProtector		= "为$journal:6224的目标添加团队标记\n（当有多名团队助理时该功能不可靠）",
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
	warnWaterspout				= "%s (%d) : %s",
	warnHuddleInTerror			= "%s (%d) : %s",
	MoveForward					= "穿过金莲之影",
	MoveRight					= "向右移动",
	MoveBack					= "返回原位",
	specWarnBreathOfFearSoon	= "即将恐惧吐息 - 快到光墙内！"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "下一次特殊能力",
	timerSpoHudCD				= "畏惧/水涌冷却",
	timerSpoStrCD				= "水涌/打击冷却",
	timerHudStrCD				= "畏惧/打击冷却"
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	warnBreathOnPlatform		= "警报：当你在平台时的$spell:119414\n（不推荐，为团长准备）",
	specWarnBreathOfFearSoon	= "特殊警报：当没有$spell:117964效果需要躲避$spell:119414时",
	specWarnMovement			= "特殊警报：$spell:120047时的移动",
	warnWaterspout				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120519),
	warnHuddleInTerror			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(120629),
	timerSpecialAbility			= "计时条：下一次特殊能力",
	RangeFrame					= "距离监视（2码）：应对$spell:119519",
	SetIconOnHuddle				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})