--Mini Dragon <流浪者酒馆-Brilla@金色平原(The Golden Plains-CN)> 20230329

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Kazzara -- 卡扎拉
---------------------------
--L= DBM:GetModLocalization(2522)

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
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "在1阶段中动态扫描与每个Boss的距离，并自动隐藏大于43码的部分警告和计时条"
})

---------------------------
--  The Forgotten Experiments --龙希尔的实验
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Assault of the Zaqali --
---------------------------
--L= DBM:GetModLocalization(2524)

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

---------------------------
--  The Vigilant Steward, Zskarn --兹斯卡恩
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --玛格莫莱克斯
---------------------------
--L= DBM:GetModLocalization(2527)

---------------------------
--  Echo of Neltharion --奈萨里奥的回响
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --
---------------------------
--L= DBM:GetModLocalization(2520)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"亚贝鲁斯小怪"
})
