-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 8/26/2011

if GetLocale() ~= "zhCN" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
--L = DBM:GetModLocalization(154)
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "风之议会"
})

L:SetWarningLocalization({
	warnSpecial			= "飓风/微风/暴雨",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "特殊技能启动！",
	warnSpecialSoon		= "特殊技能10秒后启动！"
})

L:SetTimerLocalization({
	timerSpecial		= "特殊技能冷却",
	timerSpecialActive	= "特殊技能"
})

L:SetOptionLocalization({
	warnSpecial			= "警报：飓风/微风/暴雨",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "特殊警报：特殊技能的施放",
	timerSpecial		= "计时条：特殊技能冷却时间",
	timerSpecialActive	= "计时条：特殊技能持续时间",
	warnSpecialSoon		= "提前警报：特殊技能即将施放（10秒前）",
	OnlyWarnforMyTarget	= "只显示当前或焦点目标首领的警报和计时条（隐藏其他首领。包括拉怪）"
})

L:SetMiscLocalization({
	gatherstrength	= "gather shtrenth", -- die
	Anshal			= "安舍尔",
	Nezir			= "尼希尔",
	Rohash			= "洛哈西"
})

---------------
--  Al'Akir  --
---------------
--L = DBM:GetModLocalization(155)
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "奥拉基尔"
})

L:SetWarningLocalization({
	WarnAdd			= "风暴火花即将刷新"
})

L:SetTimerLocalization({
	TimerFeedback 	= "回馈（%d）",
	TimerAddCD		= "下一个风暴火花"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "计时条：$spell:87904持续时间",
	WarnAdd			= "警报：风暴火花出现",
	TimerAddCD		= "计时条：下一个风暴花火出现",
	RangeFrame		= "当你中了$spell:89668时显示距离监视器（20码）"
})

L:SetMiscLocalization({
	summonAdd		=	"暴风啊！到我的身边来！",
	phase3			=	"Enough! I will no longer be contained!"
})
