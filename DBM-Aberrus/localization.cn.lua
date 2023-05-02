--Mini Dragon <流浪者酒馆-Brilla@金色平原(The Golden Plains-CN)> 20230502

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
--  The Amalgamation Chamber --融合体密室
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "在1阶段中动态扫描与每个Boss的距离，并自动隐藏大于43码的部分警告和计时条"
})

---------------------------
--  The Forgotten Experiments --被遗忘的实验体
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Assault of the Zaqali --扎卡利突袭
---------------------------
--L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "大怪 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "计时条：显示下一波爬上来的的猎人或者卫士"
})

L:SetMiscLocalization({
	northWall		= "Commanders ascend the northern battlement!",
	southWall		= "Commanders ascend the southern battlement!"
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

---------------------------
--  The Vigilant Steward, Zskarn --兹斯卡恩
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --玛格莫莱克斯
---------------------------
--L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}岩浆池 %d",--<icon> Pool 1,2,3
	soakpool	= "吸收岩浆池"
})

---------------------------
--  Echo of Neltharion --奈萨里奥的回响
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --鳞长萨卡雷斯
---------------------------
--L= DBM:GetModLocalization(2520)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"亚贝鲁斯小怪"
})
