if GetLocale() ~= "zhTW" then return end

local L

---------------------------
--  Kazzara --
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
	AdvancedBossFiltering	= "在第1階段中積極掃描與每個首領的距離，並自動隱藏您非接近首領的某些警報和淡出的計時器（超過43距離）"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "大怪出現 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "顯示新來獵人和護衛爬牆的計時器"
})

L:SetMiscLocalization({
	northWall		= "北方的城垛",
	southWall		= "南方的城垛"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "設定坦克切換的模組行為",
	OnlyIfDanger		= "僅當其他坦克即將被不安全的擊中時才顯示嘲諷警告",
	MinMaxSoak			= "僅當第一次連續攻擊之後，或其他坦克即將被不安全的擊中時，才顯示嘲諷警告",
	DoubleSoak			= "僅當第一次連續攻擊結束以後，或其他坦克即將被不安全的擊中時，才顯示嘲諷警告"--Default
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}池 %d",--<icon> Pool 1,2,3
	soakpool	= "吸收池"
})

---------------------------
--  Echo of Neltharion --
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "設置資訊框架層數堆疊追蹤的行為",
	OblivionOnly			= "只顯示空寂湮沒的層數 (階段 1 2 與 3)",--Default
	HowlOnly				= "只顯示壓制嚎叫的層數 (階段 1，否則關閉)",
	Hybrid					= "在階段1顯示壓制嚎叫層數，並且在階段2與3顯示空寂湮沒層數"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"亞貝魯斯小怪"
})
