-- Mini Dragon(projecteurs@gmail.com)
-- Blizzard Entertainment
-- Last update: Aug 6 2015, 6:47 UTC@14262

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Hellfire Assault --
---------------
L= DBM:GetModLocalization(1426)

L:SetTimerLocalization({
	timerSiegeVehicleCD		= "下一辆攻城车-%s"
})

L:SetOptionLocalization({
	timerSiegeVehicleCD =	"计时条：下一辆攻城车"
})

L:SetMiscLocalization({
	AddsSpawn1		=	"乘胜追击！",
	AddsSpawn2		=	"投掷手雷！",
	BossLeaving		=	"我会回来的..."--无法确定全角还是半角句号。有问题请联系我
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

L:SetMiscLocalization({
	ExRTNotice		= "%s 向你指派了ExRT的位置。你的位置: 橙色:%s, 绿色:%s, 紫色:%s"
})

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

L:SetTimerLocalization({
	SoDDPS2		= "下一次死亡之影 (%s)",
	SoDTank2	= "下一次死亡之影 (%s)",
	SoDHealer2	= "下一次死亡之影 (%s)"
}) 

L:SetOptionLocalization({
	SoDDPS2		= "计时条：下一次针对DPS的$spell:179864",
	SoDTank2	= "计时条：下一次针对坦克的$spell:179864",
	SoDHealer2	= "计时条：下一次针对治疗的$spell:179864"
})
--------------------------
-- Shadow-Lord Iskar --
--------------------------
L= DBM:GetModLocalization(1433)

L:SetWarningLocalization({
	specWarnThrowAnzu =	"快传安苏之眼给%s！"
})

L:SetOptionLocalization({
	specWarnThrowAnzu =	"特殊警报：当你需要传递$spell:179202给他人时"
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
	Iconed				= "星星, 大饼, 菱形, 三角, 月亮。 适合分散式开场。",--Default
	Numbered			= "1, 2, 3, 4, 5. 适合已分区的开场。",
	DirectionLine		= "左, 左偏中, 中, 右偏中, 右. 适合直线式开场。",
	FreeForAll			= "自由发挥. 不分配位置, 只大喊。",
	CrossPerception		= "前, 后, 左, 右, 中. 适合十字形开场。",--Unsure if viable with 5 targets/will remain
	CrossCardinal		= "北, 南, 东, 西, 中. 适合十字形开场。",--Unsure if viable 5 targets/will remain
	ExCardinal			= "东北, 东南, 西北, 西南, 中. 适合十字形开场。"--Unsure if viable 5 targets/will remain
})

L:SetMiscLocalization({
	DBMConfigMsg		= "团长已经将种子喊叫方式设定为 %s。",
	BWConfigMsg			= "团长在用Bigwigs, DBM将会使用数字来提示。"
	--TODO, talk to some guilds, maybe trim list above, add finalized directions here
})

--------------------------
-- Xhul'horac --
--------------------------
L= DBM:GetModLocalization(1447)

L:SetOptionLocalization({
	ChainsBehavior		= "设定邪能锁链的警告方式。时间在开始施法时同步。",
	Cast				= "当施法开始时只给予原始目标警告。",
	Applied				= "当施法结束时给予所有受影响的目标警告。",
	Both				= "开始和结束"
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

L:SetWarningLocalization({
	specWarnBreakShackle	= "枷锁酷刑：拉断%s！"
})

L:SetOptionLocalization({
	specWarnBreakShackle	= "特殊警报：当你受到$spell:184964影响时。DBM会自动分配拉断次序，使得伤害最小化。",
	ExtendWroughtHud2		= "将HUD连线延长到受到$spell:185014影响的目标上。 (可能会导致连线准确度下降)",
	NamesWroughtHud			= "在HUD中显示受到$spell:185014影响的目标的姓名",
	FilterOtherPhase		= "过滤掉不在同一阶段的事件"
})

L:SetMiscLocalization({
	phase2point5		= "面对现实吧，愚蠢的凡人。你们无法抵抗燃烧军团的无穷大军。",
	First				= "第一个",
	Second				= "第二个",
	Third				= "第三个",
	Fourth				= "第四个",
	Fifth				= "第五个"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HellfireCitadelTrash")

L:SetGeneralLocalization({
	name =	"地狱火堡垒小怪"
})
