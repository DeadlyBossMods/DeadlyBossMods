-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 11/04/2012

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "平台变化"
})

L:SetOptionLocalization({
	specwarnPlatform	= "特殊警报：改变平台",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s flies to one of his platforms!",
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
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

L:SetOptionLocalization({
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnAmberExplosion			= "%s 正在施放 %s",
	warnInterruptsAvailable		= "可打断 %s: %s",
	specwarnWillPower			= "意志低下！",
	specwarnAmberExplosionYou	= "打断%s！"--Struggle for Control interrupt.
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "下一次%s: %s"
}

L:SetOptionLocalization({
	warnAmberExplosion			= "警报：$spell:122398正在施放，并警报来源",
	warnInterruptsAvailable		= "警报：可使用$spell:122402打断琥珀打击的成员",
	specwarnWillPower			= "特殊警报：在畸形体中意志低下时",
	specwarnAmberExplosionYou	= "特殊警报：打断自己的$spell:122398",
	timerAmberExplosionAMCD		= "计时条：琥珀畸怪的下一次$spell:122402",
	InfoFrame					= "信息框：意志值（功能开发中）"
})

L:SetMiscLocalization({
	WillPower					= "意志"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame		= "信息框：受$spell:125390效果影响的玩家",
	RangeFrame		= "距离监视（5码）：$spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "凝视"
})
