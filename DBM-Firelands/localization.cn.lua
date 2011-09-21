-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 9/21/2011

if GetLocale() ~= "zhCN" then return end

local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "下一波织网蛛",
	TimerSpiderlings	= "下一波幼蛛",
	TimerDrone			= "下一波工虫"
})

L:SetOptionLocalization({
	TimerSpinners		= "计时条：下一波$journal:2770",
	TimerSpiderlings	= "计时条：下一波$journal:2778",
	TimerDrone			= "计时条：下一波$journal:2773",
	RangeFrame			= "距离监视器（10码）",
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
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
	yellPhase2			= "Eons I have slept undisturbed... Now this... Creatures of flesh, now you will BURN!"
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
	YellPull		= "I serve a new master now, mortals!",
	Initiate		= "炽炎之爪新兵",--http://www.wowhead.com/npc=53896
	YellPhase2		= "These skies are MINE!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Fiery Lava Worms erupt from the ground!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "熔火之羽",
	East			= "东",
	West			= "西",
	Both			= "Both"
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
	TimerBladeActive	= "%s",
	TimerBladeNext		= "下一次贝尔洛克之剑"
})

L:SetOptionLocalization({
	TimerBladeActive	= "计时条：当前贝尔洛克之剑的持续时间",
	TimerBladeNext		= "计时条：下一次贝尔洛克之剑",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "DBM箭头：当你受到$spell:99516影响时",
	InfoFrame		= "信息框：活力火花堆叠层数"
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
	RangeFrameSeeds				= "距离监视器（12码）：$spell:98450",
	RangeFrameCat				= "距离监视器（10码）：$spell:98374",
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
	WarnRemainingAdds		= "剩余%d个烈焰之子",
	warnAggro				= "获得仇恨：熔岩元素",
	warnNoAggro				= "未获仇恨：熔岩元素"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "阶段转换"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "警报：$spell:100877",
	warnEngulfingFlame	= "警报：$spell:99171",
	WarnRemainingAdds	= "警报：烈焰之子剩余数量",
	warnSeedsLand		= "警报与计时条：$spell:98520落地位置，而非施法警报",
	ElementalAggroWarn	= "警报：是否获得熔岩元素的仇恨",
	TimerPhaseSons		= "计时条：烈焰之子阶段持续时间",
	RangeFrame			= "距离监视器",
	InfoHealthFrame		= "信息框：生命值少于9万的团员的列表",
	InfoFrame			= "信息框：$spell:99849的目标",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "场景东部",
	West				= "场景西部",
	Middle				= "场景中部",
	North				= "近战范围",
	South				= "场景后方",
	HealthInfo			= "生命值少于9万",
	MeteorTargets		= "ZOMG Meteors!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Enough! I will finish this.",--More reliable then adds method.
	TransitionEnded2	= "Sulfuras will be your end.",
	TransitionEnded3	= "Fall to your knees, mortals!  This ends now.",
	Defeat				= "Too soon! ... You have come too soon...",
	Phase4				= "Too soon..."
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
	TrashRangeFrame	= "距离监视器（10码）：$spell:100012"
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus"
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
	StaffEvent			= "The Branch of Nordrassil reacts violently to %S+ touch!",--Reg expression pull match
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"
})