--Mini Dragon <流浪者酒馆-Brilla@金色平原> 20201221
--夏一可，暴雪娱乐

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "使用降序排列 $spell:334755 debuff 层数的信息窗",
	ShowTimeNotStacks		= "显示 $spell:334755 的时间代替层数"
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
L= DBM:GetModLocalization(2418)

L:SetMiscLocalization({
	Phase2			= "我一直想玩玩这件圣物，都快想疯了！而你们的死，可以填补我多年的空虚。",
	Phase2Demonic	= "Lok zennshinagas xi ril zila refir il rethule no Rakkas az alar alar archim maev shi ",--Boss has Curse of Tongues
	Phase3			= "如此美妙的东西，如果没有杀伤力就太可惜了！",
	Phase3Demonic	= "X ante zila romathis alar il re thorje re az modas "--Boss has Curse of Tongues
})

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "欲望满",
	timerBottledContainer		= "瓶装心能满",
	timerSinsContainer			= "罪孽满",
	timerConcentrateContainer	= "浓缩心能满"
}

L:SetOptionLocalization({
	timerContainers2			= "显示容器装满的进度与时间"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
--L= DBM:GetModLocalization(2425)

L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "当技能发生排队时，自动调整计时器"
})

---------------------------
--  Sire Denathrius --
---------------------------
L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	CrimsonSpawn	= "赤红秘法师回应了德纳修斯的召唤。"
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"纳斯利亚堡小怪"
})
