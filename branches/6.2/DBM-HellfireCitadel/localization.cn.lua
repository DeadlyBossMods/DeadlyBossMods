-- Mini Dragon(projecteurs@gmail.com)
-- Blizzard Entertainment
-- Last update: May 11, 2015@13734

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "下一辆攻城车"
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"倒计时：下一辆攻城车"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"乘胜追击！",
	AddsSpawn2		=	"投掷手雷！"
})

---------------------------
-- Iron Reaver --
---------------------------
L= DBM:GetModLocalization(1425)

---------------------------
-- Hellfire High Council --
---------------------------
L= DBM:GetModLocalization(1432)

------------------
-- Kormrok --
------------------
L= DBM:GetModLocalization(1392)

--------------
-- Kilrogg Deadeye --
--------------
L= DBM:GetModLocalization(1396)

L:SetMiscLocalization({
	BloodthirstersSoon		=	"来吧，兄弟们！把握你们的命运！"
})

--------------------
--Gorefiend --
--------------------
L= DBM:GetModLocalization(1372)

--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"快传安苏之眼给%s!"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"特殊警报： 当你需要传递$spell:179202给他人时"
})

--------------------------
-- Fel Lord Zakuun --
--------------------------
L= DBM:GetModLocalization(1391)

L:SetWarningLocalization({
	specWarnSeedPosition =	"种子位置：%s"
})

L:SetOptionLocalization({
	SeedsBehavior		= "设定种子的喊叫方式 (需要团长权限)",
	Iconed				= "骷髅, 十字, 方块, 月亮, 三角. 适合分散式开场。",--Default
	Numbered			= "1, 2, 3, 4, 5. 适合已分区的开场。",
	DirectionLine		= "左, 左偏中, 中, 右偏中, 右. 适合直线式开场。",
	--Currently these 3 below are unused unless I see anyone want/need them
	CrossPerception		= "前, 后, 左, 右, 中. 适合十字形开场。",--Unsure if viable with 5 targets/will remain
	CrossCardinal		= "北, 南, 东, 西, 中. 适合十字形开场。",--Unsure if viable 5 targets/will remain
	ExCardinal			= "东北, 东南, 西北, 西南, 中. 适合十字形开场。"--Unsure if viable 5 targets/will remain
})

L:SetMiscLocalization({
	DBMConfigMsg		= "团长已经将种子喊叫方式设定为 %s。",
	BWConfigMsg			= "团长在用Bigwigs, DBM将会使用<Place Holder>的对应方式来提示。",
	customSeedsSay		= "%2$s 中了 毁灭之种! (%1$s)"
	--TODO, talk to some guilds, maybe trim list above, add finalized directions here
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "设定邪能锁链的警告方式",
	Cast				= "当施法开始时只给予原始目标警告。时间在开始施法时同步。",
	Applied				= "当施法结束时给予所有受影响的目标警告。时间在开始施法时同步。",
	Both				= "当施法开始时只给予原始目标警告，并当施法结束时给予所有受影响的目标警告。时间在开始施法时同步。"
})

--------------------------
-- Socrethar the Eternal --
--------------------------
L= DBM:GetModLocalization(1427)

--------------------------
-- Tyrant Velhari --
--------------------------
L= DBM:GetModLocalization(1394)

--------------------------
-- Mannoroth --
--------------------------
L= DBM:GetModLocalization(1395)

L:SetMiscLocalization({
	felSpire		=	"开始强化邪能尖塔！"
})

--------------------------
-- Archimonde --
--------------------------
L= DBM:GetModLocalization(1438)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"地狱火堡垒小怪"
})
