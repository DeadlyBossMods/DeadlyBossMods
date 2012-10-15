-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 10/13/2012

if GetLocale() ~= "zhCN" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s: 7秒后可施放",
	specWarnBreakJasperChains	= "扯断红玉锁链！"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "特殊警报：过载预警",
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
	WarnPhase	= "警报：阶段转换"
})

L:SetMiscLocalization({
	Fire		= "Oh exalted one! Through me you shall melt flesh from bone!",
	Arcane		= "Oh sage of the ages! Instill to me your arcane wisdom!",
	Nature		= "Oh great spirit! Grant me the power of the earth!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
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

L:SetOptionLocalization({
	RangeFrame			= "距离监视（8码）"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "注意脚下！"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "注意脚下！"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "特殊警报：平台消失预警",
	timerDespawnFloor			= "计时条：平台消失"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "信息框：受$spell:116525效果影响的玩家"
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})

