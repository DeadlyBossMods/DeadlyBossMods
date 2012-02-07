-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/1/2012

if GetLocale() ~= "zhCN" then return end

local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame			= "距离监视器（10码）"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "幼蛛从巢穴里爬出来了！"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "第%d阶段",
	WarnNewInitiate		= "炽炎之爪新兵（%s）"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "第%d阶段",
	TimerHatchEggs		= "下一波蛋",
	timerNextInitiate	= "下一个新兵（%s）",
	TimerCombatStart	= "战斗即将开始"
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗开始",
	WarnPhase			= "警报：每次阶段转换",
	WarnNewInitiate		= "警报：新的炽炎之爪新兵",
	timerNextInitiate	= "计时条：下一个炽炎之爪新兵",
	TimerPhaseChange	= "计时条：下一阶段",
	TimerHatchEggs		= "计时条：下一波蛋孵化",
	InfoFrame			= "信息框：熔火之羽"
})

L:SetMiscLocalization({
	YellPull		= "凡人们，我现在侍奉新的主人！",
	YellPhase2		= "天空，归我统治！",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "熔岩火虫从地下涌出来了！",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "熔火之羽",
	East			= "东",
	West			= "西",
	Both			= "两侧"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
	Riplimb		= "裂肢",
	Rageface	= "狂脸"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s（%d）"
})

L:SetTimerLocalization({
	timerStrike			= "下一次%s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "下一次贝尔洛克之剑"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "每3秒（25人）/2秒（10人）重置$spell:99259的倒数计时",
	warnStrike			= "警报：毁灭之刃或地狱火之刃",
	timerStrike			= "计时条：下一次毁灭之刃或地狱火之刃",
	TimerBladeActive	= "计时条：当前贝尔洛克之剑的持续时间",
	TimerBladeNext		= "计时条：下一次贝尔洛克之剑",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "DBM箭头：当你受到$spell:99516影响时",
	InfoFrame		= "信息框：活力火花堆叠层数",
	RangeFrame			= "距离监视器（5码）：应对$spell:99404"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).."堆叠"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerNextSpecial	= "下一次%s（%d）"
})

L:SetOptionLocalization({
	timerNextSpecial			= "计时条：下一次特殊技能",
	RangeFrameSeeds				= "距离监视器（12码）：应对$spell:98450",
	RangeFrameCat				= "距离监视器（10码）：应对$spell:98374",
	LeapArrow					= "DBM箭头：当$spell:98476在你附近时",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnSplittingBlow		= "%s在%s",--Spellname in Location
	warnEngulfingFlame		= "%s在%s",--Spellname in Location
	warnEmpoweredSulf		= "%s - 5秒后施放"--The spell has a 5 second channel, but tooltip doesn't reflect it so cannot auto localize
})

L:SetTimerLocalization({
	TimerPhaseSons		= "阶段转换"
})

L:SetOptionLocalization({
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow			= "警报：$spell:100877的位置",
	warnEngulfingFlame			= "警报：$spell:99171",
	WarnEngulfingFlameHeroic	= "警报：英雄模式下$spell:99171的位置",
	warnSeedsLand				= "警报与计时条：$spell:98520落地，而非施法警报",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100997, GetSpellInfo(100997)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons				= "计时条：烈焰之子阶段持续时间",
	RangeFrame					= "距离监视器",
	InfoHealthFrame				= "信息框：生命值少于10万的团员的列表",
	MeteorFrame					= "信息框：$spell:99849的目标",
	AggroFrame					= "信息框：没有获得熔岩元素仇恨的团员的列表",
	BlazingHeatIcons			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "场景东部",
	West				= "场景西部",
	Middle				= "场景中部",
	North				= "近战范围",
	South				= "场景后方",
	HealthInfo			= "生命值少于10万",
	HasNoAggro			= "未获仇恨",
	MeteorTargets		= "看！流星灰过来咯！",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "够了！我会亲自解决。",--More reliable then adds method.
	TransitionEnded2	= "萨弗拉斯将会是你的末日。",
	TransitionEnded3	= "跪下吧，凡人们！一切都结束了。",
	Defeat				= "太早了！……你们来得太早了……",
	Phase4				= "太早了……"
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "火焰之地小怪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TrashRangeFrame	= "距离监视器（10码）：应对$spell:100012"
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "沃卡纳斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "阶段转换"
})

L:SetOptionLocalization({
	timerStaffTransition	= "计时条：阶段转换"
})

L:SetMiscLocalization({
	StaffEvent			= "%S+的触摸令诺达希尔的分枝产生了强烈反应！",--Reg expression pull match
	StaffTrees			= "烈焰树人从地下涌出，来协助保护者了！",--Might add a spec warning for this later.
	StaffTransition		= "受折磨的保护者身上一直燃烧着的火焰熄灭了！"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "泰林纳尔"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})