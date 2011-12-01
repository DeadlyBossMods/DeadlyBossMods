-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 11/28/2011

if GetLocale() ~= "zhCN" then return end

local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	SpecwarnVortexAfter	= "快躲到碎片后！"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecwarnVortexAfter	= "特殊警报：$spell:110047结束"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "距离监视器（10码）：应对$spell:104601（英雄难度）"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "血球即将出现：%s",
	specWarnOozes	= "血球即将出现！",
	specWarnManaVoid= "法力虚空 - 转换目标"
})

L:SetTimerLocalization({
	timerOozesCD	= "下一次血球"
})

L:SetOptionLocalization({
	warnOozes			= "警报：召唤血球",
	specWarnOozes		= "特殊警报：召唤血球",
	specWarnManaVoid	= "特殊警报：$spell:105530出现",
	timerOozesCD		= "计时条：下一次血球"
})

L:SetMiscLocalization({
	Black			= "|cFF424242黑色|r",
	Purple			= "|cFF9932CD紫色|r",
	Red				= "|cFFFF0404红色|r",
	Green			= "|cFF088A08绿色|r",
	Blue			= "|cFF0080FF蓝色|r",
	Yellow			= "|cFFFFA901黄色|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s - 8秒后施放"
})

L:SetTimerLocalization({
	TimerSpecial			= "第一次特殊技能"
})

L:SetOptionLocalization({
	TimerSpecial			= "计时条：第一次特殊技能施放",
	RangeFrame				= "距离监视器（3码）：应对$spell:105269",
	AnnounceFrostTombIcons	= "向团队频道通报$spell:104451目标的团队标记（需要团队领袖权限）",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
})

L:SetMiscLocalization({
	TombIconSet				= "寒冰之墓标记{rt%d} -> %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "战斗即将开始"
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗即将开始"
})

L:SetMiscLocalization({
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "战斗即将开始",
	TimerSapper			= "下一次暮光弹幕"
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗即将开始",
	TimerSapper			= "计时条：下一次暮光弹幕"--npc=56923
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Get Secured!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "特殊警报：当你没有$spell:109454效果时",
	InfoFrame				= "信息框：没有$spell:109454效果的玩家",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459)
})

L:SetMiscLocalization({
	NoDebuff	= "没有%s",
	DRoll		= "about to roll"--Not a single transcriptor log for this fight from anyone, just bad chat logs that have more looting then actual boss encounters. This emote needs to be confirmed/fixed if it's wrong.
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "灼疮触须 - 转换目标"--Msg too long? maybe just "Blistering Tentacles!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "特殊警报：阿莱克斯塔萨没有激活的情况下灼疮触须出现"--http://ptr.wowhead.com/npc=56188
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})
