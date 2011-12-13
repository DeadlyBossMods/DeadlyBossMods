-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/14/2011

if GetLocale() ~= "zhCN" then return end

local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s：%s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "克卓莫模拟%s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "警报：克卓莫模拟技能",
	KohcromCD		= "计时条：下一次克卓莫模拟技能",
	RangeFrame		= "距离监视器（5码）：应对成就需求"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
	warnShadowGaze	= "%s：%s，来自%s，1.5秒后施放"--Spellname, possible target, source(target/focus) This is a temporary local and will be improved or made a generic after testing.
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnShadowGaze		= "警报（实验性）：$spell:104604（仅对当前或焦点目标有效）",--Spellname, possible target, source(target/focus) This is a temporary local and will be improved or made a generic after testing.
	RangeFrame			= "距离监视器（根据玩家状态动态变化）：应对$spell:104601（英雄难度）",
	NoFilterRangeFrame	= "取消距离监视器的动态监测，总是显示所有团员"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "血球即将出现：%s",
	specWarnOozes	= "血球即将出现！"
})

L:SetTimerLocalization({
	timerOozesCD		= "下一次软泥怪",
	timerOozesActive	= "软泥怪可攻击"
})

L:SetOptionLocalization({
	warnOozes			= "警报：召唤软泥怪",
	specWarnOozes		= "特殊警报：召唤软泥怪",
	timerOozesCD		= "计时条：下一次软泥怪",
	timerOozesActive	= "计时条：软泥怪可攻击",
	RangeFrame			= "距离监视器（4码）：应对$spell:104898（普通和英雄难度）"
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
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
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
	Trash				= "It is good to see you again, Alexstrasza. I have been busy in my absence.",
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
	TimerSapper			= "下一次暮光弹幕",
	TimerAdd			= "下一波暮光精英"
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗即将开始",
	TimerSapper			= "计时条：下一次暮光弹幕",--npc=56923
	TimerAdd			= "计时条：下一波暮光精英"
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
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "首领生命值信息框：应对$spell:105479"
})

L:SetMiscLocalization({
	Pull			= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff		= "没有%s",
	PlasmaTarget	= "灼热血浆：%s",
	DRoll			= "about to roll",
	DLevels			= "levels out"
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
