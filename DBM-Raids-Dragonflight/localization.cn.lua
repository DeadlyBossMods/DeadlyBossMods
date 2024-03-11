--Mini Dragon <流浪者酒馆-Brilla@金色平原(The Golden Plains-CN)> 20240115
--Blizzard Entertainment

if GetLocale() ~= "zhCN" then return end
local L

----<<<<化身巨龙牢窟>>>>----
---------------------------
--  Eranog -- 艾拉诺格
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros -- 泰洛斯
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council -- 原始议会
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath -- 瑟娜尔丝，冰冷之息
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended -- 晋升者达瑟雅
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem -- 库洛格-恐怖图腾
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "攻击阶段 (%s)",
	timerAvoidCD = "防御阶段 (%s)",
	timerUltimateCD = "终极阶段 (%s)",
	timerAddEnrageCD = "狂暴 (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "显示攻击阶段的 $spell:382563, $spell:373678, $spell:391055, $spell:373487 的计时器",
	timerAvoidCD = "显示防御阶段的 $spell:373329, $spell:391019, $spell:395893, $spell:390920 的计时器",
	timerUltimateCD = "显示终极阶段的 $spell:374022, $spell:372456, $spell:374691, $spell:374215 的计时器",
	timerAddEnrageCD = "显示狂暴（M难度）"
})

L:SetMiscLocalization({
	Fire	= "烈焰",
	Frost	= "冰霜",
	Earth	= "大地",
	Storm	= "风暴"
})

---------------------------
--  Broodkeeper Diurna -- 巢穴守护者迪乌尔娜
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff		= "巨杖",
	eStaff	= "强化巨杖"
})

---------------------------
--  Raszageth the Storm-Eater -- 莱萨杰丝，噬雷之龙
---------------------------
L= DBM:GetModLocalization(2499)

L:SetOptionLocalization({
	SetBreathToBait = "根据诱饵时间而不是施法时间调整转阶段的吐息计时器（警报仍会在吐息施放时触发）"
})

L:SetMiscLocalization({
	negative = "负电荷",
	positive = "正电荷",
	BreathEmote	= "莱萨杰丝深吸了一口气……"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"化身巨龙牢窟小怪"
})

---------------------------
--  Kazzara -- 卡扎拉
---------------------------
--L= DBM:GetModLocalization(2522)

---------------------------
--  The Amalgamation Chamber --融合体密室
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "在1阶段中动态扫描与每个Boss的距离，并自动隐藏大于43码的部分警告和计时条"
})

---------------------------
--  The Forgotten Experiments --被遗忘的实验体
---------------------------
L= DBM:GetModLocalization(2530)

L:SetMiscLocalization({
	SafeClear		= "安全清除"
})

---------------------------
--  Assault of the Zaqali --扎卡利突袭
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "大怪 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "计时条：显示下一波爬上来的的猎人或者卫士"
})

L:SetMiscLocalization({
	northWall		= "指挥官爬上了北部城垒！",
	southWall		= "指挥官爬上了南部城垒！"
})

---------------------------
--  Rashok --莱修克
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "设置换坦行为",
	OnlyIfDanger		= "只在其他坦克将要被unsafe hit时才提示换坦嘲讽",
	MinMaxSoak			= "在一次连续攻击或者其他坦克将要被unsafe hit时提示换坦嘲讽",
	DoubleSoak			= "在一次连续攻击之后或者其他坦克将要被unsafe hit时提示换坦嘲讽"--Default
})

L:SetMiscLocalization({
	pool		= "{rt%d}岩浆池 %d",--<icon> Pool 1,2,3
	soakpool	= "踩岩浆池"
})

---------------------------
--  The Vigilant Steward, Zskarn --兹斯卡恩
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --玛格莫莱克斯
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}岩浆池 %d",--<icon> Pool 1,2,3
	soakpool	= "踩岩浆池"
})

---------------------------
--  Echo of Neltharion --奈萨里奥的回响
---------------------------
L= DBM:GetModLocalization(2523)

L:SetMiscLocalization({
	WallBreaker	= "破墙点我"
})

---------------------------
--  Scalecommander Sarkareth --鳞长萨卡雷斯
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "设置信息窗的层数跟踪行为",
	OblivionOnly			= "只显示湮灭的层数 (1，2，3阶段)",--Default
	HowlOnly				= "只显示压迫怒嚎的层数 (第1阶段，其他时间关闭)",
	Hybrid					= "在第1阶段显示压迫怒嚎的层数，在2和3阶段显示湮灭的层数"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"亚贝鲁斯小怪"
})

----<<<<阿梅达希尔，梦境之愿>>>>----
---------------------------
--  Gnarlroot --瘤根
---------------------------
--L= DBM:GetModLocalization(2564)

---------------------------
--  Igira the Cruel --残虐者艾姬拉
---------------------------
--L= DBM:GetModLocalization(2554)

---------------------------
--  Volcoross --沃尔科罗斯
---------------------------
L= DBM:GetModLocalization(2557)

L:SetMiscLocalization({
	DebuffSoaks			= "Debuff被吸收(%s)"--Might be common localized later
})

---------------------------
--  Council of Dreams --梦境议会
---------------------------
L= DBM:GetModLocalization(2555)

L:SetMiscLocalization({
	Ducks		= "变鸭子 (%s)"
})

---------------------------
--  Larodar, Keeper of the Flame --拉罗达尔，烈焰守护者
---------------------------
L= DBM:GetModLocalization(2553)

L:SetMiscLocalization({
	currentHealth		= "%d%%",
	currentHealthIcon	= "{rt%d}%d%%",
	Roots				= "树根 (%s)",
	HealAbsorb			= "治疗被吸收 (%s)"--Might be common localized later
})

---------------------------
--  Nymue, Weaver of the Cycle --尼穆威，轮回编织者
---------------------------
L= DBM:GetModLocalization(2556)

L:SetMiscLocalization({
	Threads			= "丝线 (%s)"
})

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --丁达尔·迅贤，烈焰预言者
---------------------------
L= DBM:GetModLocalization(2565)

L:SetMiscLocalization({
	TreeForm			= "树人形态",
	MoonkinForm			= "枭兽形态",
	Feathers			= "羽毛"
})

---------------------------
--  Fyrakk the Blazing --火光之龙菲莱克
---------------------------
L= DBM:GetModLocalization(2519)

L:SetTimerLocalization{
	timerMythicDebuffs			= "牢笼 (%s)"
}

L:SetWarningLocalization{
	warnMythicDebuffs			= "牢笼 (%s)"
}

L:SetOptionLocalization{
	warnMythicDebuffs			= "警告：当Debuff $spell:428988 和 $spell:428970 被施放时 (带计数)",
	timerMythicDebuffs			= "计时器：当Debuff $spell:428988 和 $spell:428970 被施放时 (带计数)"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"梦境之愿小怪"
})

L:SetMiscLocalization({
	FyrakkRP			= "You again. A pity I do not have time to eradicate you myself."
})
