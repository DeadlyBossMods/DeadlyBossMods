if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "階段 %d",
	WarnNewInitiate		= "熾炎爪擊啟動 (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "階段 %d",
	TimerHatchEggs		= "熔岩蛋孵化",
	timerNextInitiate	= "下次熾炎爪擊啟動",
        TimerCombatStart	= "戰鬥開始"
})

L:SetOptionLocalization({
        TimerCombatStart	= "為戰鬥開始顯示時間",
	WarnPhase			= "為每次轉換階段顯示警告",
	WarnNewInitiate		= "為新的熾炎爪擊啟動顯示警告",
	timerNextInitiate	= "為下一次熾炎爪擊啟動顯示計時器",
	TimerPhaseChange	= "為下次階段轉換顯示計時器",
	TimerHatchEggs		= "為下次熔岩蛋孵化顯示計時器",
	InfoFrame			= "在資訊框架顯示熔岩之力"
})

L:SetMiscLocalization({
	YellPull		= "我現在有新的主人了，凡人!",
	YellInitiate1	= "我們呼喚你，炎魔!",
	YellInitiate2	= "看看他的力量!",
	YellInitiate3	= "把不信者全都燒死!",
	YellInitiate4	= "見證壯麗的火焰。",
	YellPhase2		= "這片天空屬於我。",
        FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
        LavaWorms		= "熾炎熔岩蟲從地上鑽了出來!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "熔岩之力"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "元素怪出現"
})

L:SetTimerLocalization({
	TimerElementals		= "下一次召喚元素怪"
})

L:SetOptionLocalization({
	WarnElementals		= "當元素怪出現時顯示警告",
	TimerElementals		= "為下一次元素怪出現顯示警告"
})

L:SetMiscLocalization({
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "下一次 燼網紡織者",
	TimerSpiderlings	= "下一次 燼網小蜘蛛",
	TimerDrone		= "下一次 燼網雄蛛"
})

L:SetOptionLocalization({
	TimerSpinners		= "為下一次$journal:2770出現顯示計時器",
	TimerSpiderlings	= "為下一次$journal:2778出現顯示計時器",
	TimerDrone		= "為下一次$journal:2773出現顯示計時器",
	RangeFrame				= "顯示距離框(10碼)",
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "小蜘蛛從牠們的巢穴中被驚動了!"
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
	Riplimb		= "裂軀",
	Rageface	= "怒面"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "下一次 強化刀刃"
})

L:SetOptionLocalization({
	TimerBladeActive	= "為當前強化的刀刃顯示持續時間計時器",
	TimerBladeNext		= "為下一次強化刀刃顯示計時器",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
        SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "當你中了$spell:99516時顯示DBM箭頭",
	InfoFrame		= "顯示活力火花堆疊訊息框"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." 堆疊"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrameSeeds				= "為$spell:98450顯示距離框(12碼)",
	RangeFrameCat				= "為$spell:98374顯示距離框(10碼)",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnSplittingBlow		= "%s 在 %s 身上",--Spellname in Location
	warnEngulfingFlame		= "%s 在 %s 身上"--Spellname in Location
})

L:SetTimerLocalization({
	TimerPhaseSons		= "烈焰之子階段結束"
})

L:SetOptionLocalization({
        warnSplittingBlow	= "為$spell:100877顯示警告",
	warnEngulfingFlame	= "為$spell:99171顯示警告",
	TimerPhaseSons		= "為\"烈焰之子階段\"顯示持續時間計時器",
	RangeFrame		= "顯示距離監視框",
        InfoFrame		= "為$spell:99849顯示目標資訊框架",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "東邊",
	West				= "西邊",
	Middle				= "中央",
	North				= "近戰區",
	South				= "後面",
        MeteorTargets		= "我的天阿 隕石!",--Keep rollin' rollin' rollin' rollin'.
	transitionended		= "夠了!我將結束這一切。"--The adds detection doesn't always work right for some reason. May have to switch to this so translate it in case of switch.
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "火源之界小怪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "為$spell:100012顯示距離框(10碼)",
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "沃坎努斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "轉換階段結束"
})

L:SetOptionLocalization({
	timerStaffTransition	= "為轉換階段顯示時間"
})

L:SetMiscLocalization({
	StaffEvent			= "The Branch of Nordrassil reacts violently",--Partial, not sure if pull detection will work with partials yet :\
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"
})
