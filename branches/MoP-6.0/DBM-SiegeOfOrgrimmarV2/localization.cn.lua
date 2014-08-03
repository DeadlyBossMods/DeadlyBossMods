if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "啊，你成功了!水又再次纯净了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures	= "绝处求生即将到来(%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "很好，我会创造一个力场隔离你们的腐化。"
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "为腐化的碎片设置图示"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "炮塔门被打开了",
	warnTowerGrunt		= "塔防蛮兵"
})

L:SetTimerLocalization({
	timerTowerCD		= "下一波塔攻",
	timerTowerGruntCD	= "下一次塔防蛮兵"
})

L:SetOptionLocalization({
	warnTowerOpen		= "提示炮塔门被打开",
	warnTowerGrunt		= "提示新的塔防蛮兵重生",
	timerTowerCD		= "为下一波塔攻显示计时器",
	timerTowerGruntCD	= "为下一次塔防蛮兵显示计时器"
})

L:SetMiscLocalization({
	wasteOfTime		= "做得好!登陆小，集合!步兵打前锋!",
	wasteOfTime2	= "很好，第一梯队已经登陆。",
	Pull			= "龙喉氏族，夺回码头，把他们推进海里去!以地狱咆哮及正統部落之名!",
	newForces1		= "他们来了!",
	newForces1H		= "赶快把她弄下来，让我用手掐死她。",
	newForces2		= "龙喉氏族，前进!",
	newForces3		= "为了地狱咆哮!",
	newForces4		= "下一队，前进!",
	tower			= "的门已经遭到破坏!"
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "%s的囚犯被释放 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "%d秒后防御姿态"
})

L:SetMiscLocalization({
	newForces1			= "战士们，快点过来!",
	newForces2			= "守住大门!",
	newForces3			= "重整部队!",
	newForces4			= "库卡隆，来我身边!",
	newForces5			= "下一队，来前线!",
	allForces			= "所有库卡隆...听我号令...杀死他们!",
	nextAdds			= "下一次小兵: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "我们在录音吗?有吗?好。哥布林-泰坦控制模组开始运作，请后退。",
	Module1 		= "模组一号已准备好系統重置。",
	Victory			= "模组二号已准备好系統重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "显示动态距离框架(10码)<br/>(这是智慧距离框架，当到达血之狂暴阶段时自动切换)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "尚未完成的武器开始从生产线上掉落。",
	newShredder	= "有个自动化伐木机靠近了!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "你虛弱于%s - 换坦!",
	specWarnMoreParasites		= "你需要更多的寄生虫 - 不要开招!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "当你虛弱于活动的议会成员时显示特別警告",
	specWarnMoreParasites		= "当你需要更多寄生虫时显示特別警告"
})

L:SetMiscLocalization({
	one					= "一",
	two					= "二",
	three				= "三",
	four				= "四",
	five				= "五",
	hisekFlavor			= "现在是谁寂然无声啊",
	KilrukFlavor		= "又是个扑杀虫群的一天",
	XarilFlavor			= "我只在你的未来看到黑色天空",
	KaztikFlavor		= "减少只昆虫的虫害",
	KaztikFlavor2		= "1只螳螂倒下了，还有199只要杀",
	KorvenFlavor		= "古代帝国的终结",
	KorvenFlavor2		= "拿着你的格萨尼石板窒息吧",
	IyyokukFlavor		= "看到机会。剥削他们!",
	KarozFlavor			= "你再也跳不起来了!",
	SkeerFlavor			= "一份血腥的喜悦!",
	RikkalFlavor		= "已满足样本要求"
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	RangeFrame			= "显示动态距离框架(10码)<br/>(这是智慧距离框架，当到达$spell:147126门槛时自动切换)",
	InfoFrame			= "为玩家在中场阶段时没有伤害减免显示信息框架",
	yellMaliceFading	= "当$spell:147209將要退去时大喊"
})

L:SetMiscLocalization({
	NoReduce			= "无伤害减免",
	MaliceFadeYell		= "%s的恶意消退中(%d)"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"围攻奥格瑞玛小兵"
})
