-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 8/26/2011

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
	BlackoutShieldFrame		= "Show boss health with a health bar for $spell:92878",
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
	blizzHatesMe	= "我中了冰霜道标和闪电魔棒！清路！",--You're probably fucked, and gonna kill half your raid if this happens, but worth a try anyways :).
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
	WarnDragon			= "Twilight Whelp Spawned",
	WarnOrbSoon			= "Orbs in %d sec!",
	WarnEggWeaken		= "Twilight Carapace dissipated on Egg",
	SpecWarnOrbs		= "Orbs coming! Watch Out!",
	warnWrackJump		= "%s jumped to >%s<",
	warnAggro			= "Players with Aggro (Orbs candidates): >%s< ",
	SpecWarnAggroOnYou	= "You have Aggro! Watch Orbs!",
	SpecWarnEggWeaken	= "Twilight Carapace dissipated - Dps EGG Now!",
	SpecWarnEggShield	= "Twilight Capapace Regenerated!"
})

L:SetTimerLocalization({
	TimerDragon			= "Next Twilight Whelps",
	TimerEggWeakening	= "Twilight Carapace dissipates",
	TimerEggWeaken		= "Twilight Capapace Regeneration",
	TimerOrbs			= "Shadow Orbs CD"
})

L:SetOptionLocalization({
	WarnDragon			= "Show warning when Twilight Whelp Spawns",
	WarnOrbSoon			= "Show pre-warning for Orbs (Before 5s, Every 1s)\n(Expected warning. may not be accurate. Can be spammy.)",
	WarnEggWeaken		= "Show pre-warning for when $spell:87654 dissipates",
	warnWrackJump		= "Announce $spell:92955 jump targets",
	warnAggro			= "Announce players who have Aggro when Orbs spawn (Can be target of Orbs)",
	SpecWarnAggroOnYou	= "Show special warning if you have Aggro when Orbs spawn\n(Can be target of Orbs)",
	SpecWarnOrbs		= "Show special warning when Orbs spawn (Expected warning)",
	SpecWarnEggWeaken	= "Show special warning when $spell:87654 dissipates",
	SpecWarnEggShield	= "Show special warning when $spell:87654 regenerated",
	TimerDragon			= "Show timer for new Twilight Whelp",
	TimerEggWeakening	= "Show timer for when $spell:87654 dissipates",
	TimerEggWeaken		= "Show timer for $spell:87654 regeneration",
	TimerOrbs			= "Show timer for next Orbs (Expected timer. may not be accurate)",
	SetIconOnOrbs		= "Set icons on players who have Aggro when Orbs spawn\n(Can be target of Orbs)",
	OrbsCountdown		= "Play countdown sound for Orbs",
	InfoFrame			= "Show info frame for players who have aggro"
})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",
	YellEgg				= "You mistake this for weakness?  Fool!",
	HasAggro			= "Has Aggro"
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