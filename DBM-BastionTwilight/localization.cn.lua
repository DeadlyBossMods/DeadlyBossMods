-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 10/10/2011

if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
--L = DBM:GetModLocalization(156)
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"哈尔弗斯·碎龙者"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "显示已释放幼龙的生命值（需要开启首领生命值显示）"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
--L = DBM:GetModLocalization(157)
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"瓦里昂娜和瑟纳利昂"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "警报：$spell:86788时的$spell:92898",
	TwilightBlastArrow		= "DBM箭头：当有$spell:92898的目标在你附近时",
	RangeFrame				= "距离监视器（10码）",
	BlackoutShieldFrame		= "为$spell:92878显示首领血量条",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "深呼吸",
	BlackoutTarget			= "眩晕：%s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
--L = DBM:GetModLocalization(158)
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"升腾者议会"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s生命值低于30%% - 下一阶段即将开始",
	SpecWarnGrounded		= "快去接触融入大地",
	SpecWarnSearingWinds	= "快去接触旋风上抛"
})

L:SetTimerLocalization({
	timerTransition			= "阶段转换"
})

L:SetOptionLocalization({
	specWarnBossLow			= "特殊警报：首领生命值低于30%",
	SpecWarnGrounded		= "特殊警报：缺少$spell:83581效果（对应技能施放10秒前警报）",
	SpecWarnSearingWinds	= "特殊警报：缺少$spell:83500效果（对应技能施放10秒前警报）",
	timerTransition			= "计时条：阶段转换",
	RangeFrame				= "在需要时自动显示距离监视器",
	yellScrewed				= "当你同时受到$spell:83099和$spell:92307影响时大喊",
	InfoFrame				= "信息框：没有$spell:83581或$spell:83500效果的团员的列表",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "你脚下的地面发出不祥的“隆隆”声……",
	Thundershock	= "周围的空气因为充斥着强大的能量而发出“噼啪”声……",
	Switch			= "停止你的愚行！",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "令人印象深刻……",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Ignacious		= "伊格纳休斯",
	Feludius		= "费伦迪乌斯",
	Arion			= "艾里昂",
	Terrastra		= "泰拉斯卓",
	Monstrosity		= "源质畸体",
	Kill			= "这不可能……",
	blizzHatesMe	= "我中了冰霜道标和闪电魔棒！快让路！",--You're probably fucked, and gonna kill half your raid if this happens, but worth a try anyways :).
	WrongDebuff	= "没有 %s"
})

----------------
--  Cho'gall  --
----------------
--L = DBM:GetModLocalization(167)
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"古加尔"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	CorruptingCrashArrow	= "DBM箭头：当$spell:93178在你附近时",
	InfoFrame				= "信息框：$spell:81701",
	RangeFrame				= "为$spell:82235显示距离监视器（5码）",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "自动为黑暗造物添加团队标记"
})

L:SetMiscLocalization({
	Bloodlevel				= "腐蚀"
})

----------------
--  Sinestra  --
----------------
--L = DBM:GetModLocalization(168)
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"希奈丝特拉"
})

L:SetWarningLocalization({
	WarnDragon			= "暮光幼龙出现",
	WarnOrbSoon			= "暗影宝珠 %d秒后出现",
	WarnEggWeaken		= "龙蛋上的暮光龙鳞消失了",
	SpecWarnOrbs		= "暗影宝珠即将出现！小心！",
	warnWrackJump		= "%s跳到>%s<",
	warnAggro			= "拥有仇恨的团员（宝珠可能的目标）：>%s< ",
	SpecWarnAggroOnYou	= "获得仇恨！小心宝珠！",
	SpecWarnEggWeaken	= "暮光龙鳞消失 - 快打龙蛋！",
	SpecWarnEggShield	= "暮光龙鳞再生！"
})

L:SetTimerLocalization({
	TimerDragon			= "下一波暮光幼龙",
	TimerEggWeakening	= "暮光龙鳞消失",
	TimerEggWeaken		= "暮光龙鳞再生",
	TimerOrbs			= "暗影宝珠冷却"
})

L:SetOptionLocalization({
	WarnDragon			= "警报：暮光幼龙出现",
	WarnOrbSoon			= "提前警报：暗影宝珠（5秒前，每秒警报一次。不精确）",
	WarnOrbsSoon		= "提前警报：暗影宝珠（5秒前，每秒警报一次。不精确）",
	WarnEggWeaken		= "提前警报：$spell:87654消失",
	warnWrackJump		= "警报：$spell:92955跳跃的目标",
	WarnWrackCount5s	= "警报：当$spell:92955在某一团员身上持续了10、15和20秒时",
	warnAggro			= "警报：暗影宝珠刷新时拥有仇恨的团员（可能成为宝珠的目标）",
	SpecWarnAggroOnYou	= "特殊警报：当宝珠刷新时你获得仇恨（可能成为宝珠的目标）",
	SpecWarnOrbs		= "特殊警报：宝珠即将刷新（预计时间，不精确）",
	SpecWarnDispel		= "特殊警报：提醒驱散$spell:92955（在效果施放或跳跃后的特定时间警报）",
	SpecWarnEggWeaken	= "特殊警报：$spell:87654消失",
	SpecWarnEggShield	= "特殊警报：$spell:87654再生",
	TimerDragon			= "计时条：下一波暮光幼龙",
	TimerEggWeakening	= "计时条：$spell:87654消失",
	TimerEggWeaken		= "计时条：$spell:87654再生",
	TimerOrbs			= "计时条：暗影宝珠冷却时间",
	SetIconOnOrbs		= "在暗影宝珠刷新时自动为获得仇恨的团员添加团队标记\n（可能成为宝珠的目标）",
	OrbsCountdown		= "倒计时警报：暗影宝珠",
	InfoFrame			= "信息框：获得仇恨的团员的列表"
})

L:SetMiscLocalization({
	YellDragon			= "吃吧，孩子们！尽情享用他们肥美的躯壳吧！",
	YellEgg				= "你以为就这么简单？愚蠢！",
	HasAggro			= "获得仇恨"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"暮光堡垒小怪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})