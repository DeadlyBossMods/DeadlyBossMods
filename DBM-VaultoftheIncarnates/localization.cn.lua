--Mini Dragon <流浪者酒馆-Brilla@金色平原(The Golden Plains-CN)> 20221128
--Blizzard Entertainment

if GetLocale() ~= "zhCN" then return end
local L

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
