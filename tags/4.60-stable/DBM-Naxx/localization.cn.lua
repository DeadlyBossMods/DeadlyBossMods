-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name 				= "阿努布雷坎"
})

L:SetWarningLocalization({
	SpecialLocust			= "虫群风暴",
	WarningLocustFaded		= "虫群风暴结束"
})

L:SetOptionLocalization({
	SpecialLocust			= "为虫群风暴显示特别警报",
	WarningLocustFaded		= "当虫群风暴结束时显示警报",
	ArachnophobiaTimer		= "为蜘蛛克星(成就)显示计时条"
})

L:SetMiscLocalization({
	ArachnophobiaTimer		= "蜘蛛克星"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name 				= "黑女巫法琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceExpire		= "黑女巫的拥抱5秒后结束",
	WarningEmbraceExpired		= "黑女巫的拥抱结束"
})

L:SetOptionLocalization({
	WarningEmbraceExpire		= "为黑女巫的拥抱结束显示提前警报",
	WarningEmbraceExpired		= "为黑女巫的拥抱结束显示警报"
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name 				= "迈克斯纳"
})

L:SetWarningLocalization({
	WarningSpidersSoon		= "迈克斯纳之子 5秒后出现",
	WarningSpidersNow		= "迈克斯纳之子出现了"
})

L:SetTimerLocalization({
	TimerSpider			= "下一次 迈克斯纳之子"
})

L:SetOptionLocalization({
	WarningSpidersSoon		= "为迈克斯纳之子显示提前警报",
	WarningSpidersNow		= "为迈克斯纳之子显示警报",
	TimerSpider			= "为下一次迈克斯纳之子显示计时条"
})

L:SetMiscLocalization({
	YellWebWrap			= "我被缠绕住了！救我！",
	ArachnophobiaTimer		= "蜘蛛克星"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name 				= "瘟疫使者诺斯"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "传送",
	WarningTeleportSoon		= "20秒后 传送"
})

L:SetTimerLocalization({
	TimerTeleport			= "传送",
	TimerTeleportBack		= "传送回来"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "为传送显示警报",
	WarningTeleportSoon		= "为传送显示提前警报",
	TimerTeleport			= "为传送显示计时条",
	TimerTeleportBack		= "为传送回来显示计时条"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name 				= "肮脏的希尔盖"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "传送",
	WarningTeleportSoon		= "%d秒后 传送"
})

L:SetTimerLocalization({
	TimerTeleport			= "传送"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "为传送显示警报",
	WarningTeleportSoon		= "为传送显示提前警报",
	TimerTeleport			= "为传送显示计时条"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name 				= "洛欧塞布"
})

L:SetWarningLocalization({
	WarningHealSoon			= "3秒后可以治疗",
	WarningHealNow			= "现在治疗"
})

L:SetOptionLocalization({
	WarningHealSoon			= "为3秒后可以治疗显示提前警报",
	WarningHealNow			= "为现在治疗显示警报",
	SporeDamageAlert		= "在团队中提示谁杀死了孢子并发送悄悄话给该玩家\n(需要团长或助理权限)"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name 				= "帕奇维克"
})

L:SetOptionLocalization({
	WarningHateful 			= "公布仇恨打击的目标到团队频道\n(需要团长或助理权限)"
})

L:SetMiscLocalization({
	yell1 				= "帕奇维克要跟你玩！",
	yell2 				= "帕奇维克是克尔苏加德的战神！",
	HatefulStrike 			= "仇恨打击 --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name 				= "格罗布鲁斯"
})

L:SetOptionLocalization({
	SpecialWarningInjection		= "当你中了变异注射时显示特别警报",
	SetIconOnInjectionTarget	= "设定标记给中了变异注射的玩家"
})

L:SetWarningLocalization({
	SpecialWarningInjection		= "你中了变异注射 - 快跑开"
})

L:SetTimerLocalization({
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name 				= "格拉斯"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name 				= "塔迪乌斯"
})

L:SetMiscLocalization({
	Yell				= "斯塔拉格要碾碎你！",
	Emote				= "%s超载了！",
	Emote2				= "电磁圈超载了！",
	Boss1 				= "费尔根",
	Boss2 				= "斯塔拉格",
	Charge1 			= "负极",
	Charge2 			= "正极"
})

L:SetOptionLocalization({
	WarningChargeChanged		= "当你的极性改变时显示特别警报",
	WarningChargeNotChanged		= "当你的极性没有改变时显示特别警报",
	ArrowsEnabled			= "显示箭头 (正常 \"两边\" 站位打法)",
	ArrowsRightLeft			= "显示左/右箭头 给 \"四角\" 站位打法 (如果极性改变显示左箭头, 没变显示右箭头)",
	ArrowsInverse			= "显示反转的 \"四角\" 站位打法 (如果极性改变显示右箭头, 没变显示左箭头)"
})

L:SetWarningLocalization({
	WarningChargeChanged		= "极性变为%s",
	WarningChargeNotChanged		= "极性没有改变"
})

L:SetOptionCatLocalization({
	Arrows				= "箭头"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name 				= "教官拉苏维奥斯"
})

L:SetMiscLocalization({
	Yell1 				= "仁慈无用！",
	Yell2 				= "练习时间到此为止！都拿出真本事来！",
	Yell3 				= "按我教导的去做！",
	Yell4 				= "绊腿……有什么问题吗？"
})

L:SetOptionLocalization({
	WarningShieldWallSoon		= "为盾墙结束显示提前警报"
})

L:SetWarningLocalization({
	WarningShieldWallSoon		= "5秒后 盾墙结束"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name 				= "收割者戈提克"
})

L:SetOptionLocalization({
	TimerWave			= "为下一波小怪显示计时条",
	TimerPhase2			= "为第二阶段显示计时条",
	WarningWaveSoon			= "为小怪出现显示提前警报",
	WarningWaveSpawned		= "为小怪出现显示警报",
	WarningRiderDown		= "当冷酷的骑兵死亡时显示警报",
	WarningKnightDown		= "当冷酷的死亡骑士死亡时显示警报"
})

L:SetTimerLocalization({
	TimerWave			= "第 %d 波",
	TimerPhase2			= "第2阶段"
})

L:SetWarningLocalization({
	WarningWaveSoon			= "3秒后 第%d波: %s",
	WarningWaveSpawned		= "第%d波: %s 出现了",
	WarningRiderDown		= "骑兵已死亡",
	WarningKnightDown		= "死亡骑士已死亡",
	WarningPhase2			= "第二阶段"
})

L:SetMiscLocalization({
	yell				= "你们这些蠢货已经主动步入了陷阱。",
	WarningWave1			= "%d %s",
	WarningWave2			= "%d %s 和 %d %s",
	WarningWave3			= "%d %s, %d %s 和 %d %s",
	Trainee				= "学徒",
	Knight				= "死亡骑士",
	Rider				= "骑兵"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name 				= "四骑士"
})

L:SetOptionLocalization({
	WarningMarkSoon			= "为印记显示提前警报",
	WarningMarkNow			= "为印记显示警报",
	SpecialWarningMarkOnPlayer	= "当你印记叠加多于四层时显示特别警报"
})

L:SetTimerLocalization({
})

L:SetWarningLocalization({
	WarningMarkSoon			= "3秒后 印记 %d",
	WarningMarkNow			= "印记 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz			= "库尔塔兹领主",
	Rivendare			= "瑞文戴尔男爵",
	Blaumeux			= "女公爵布劳缪克丝",
	Zeliek				= "瑟里耶克爵士"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name 				= "萨菲隆"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon		= "为空中阶段显示提前警报",
	WarningAirPhaseNow		= "提示空中阶段",
	WarningLanded			= "提示地上阶段",
	TimerAir			= "为空中阶段显示计时条",
	TimerLanding			= "为降落显示计时条",
	TimerIceBlast			= "为冰霜吐息显示计时条",
	WarningDeepBreath		= "为冰霜吐息显示特别警报",
	WarningIceblock			= "当你中了冰箱时大喊"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s深深地吸了一口气。",
	WarningYellIceblock		= "我是冰块！"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "10秒后 空中阶段",
	WarningAirPhaseNow		= "空中阶段",
	WarningLanded			= "萨菲隆降落了",
	WarningDeepBreath		= "冰霜吐息"
})

L:SetTimerLocalization({
	TimerAir			= "空中阶段",
	TimerLanding			= "降落",
	TimerIceBlast			= "冰霜吐息"	
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name 				= "克尔苏加德"
})

L:SetOptionLocalization({
	TimerPhase2			= "为第二阶段显示计时条",
	specwarnP2Soon			= "为克尔苏加德攻击前10秒显示特别警报",
	warnAddsSoon			= "为寒冰皇冠卫士显示提前警报",
	ShowRange			= "当第二阶段开始时显示距离监视框"
})

L:SetMiscLocalization({
	Yell 				= "仆从们，侍卫们，隶属于黑暗与寒冷的战士们！听从克尔苏加德的召唤！"
})

L:SetWarningLocalization({
	specwarnP2Soon			= "10秒后克尔苏加德开始攻击",
	warnAddsSoon			= "寒冰皇冠卫士即将出现"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二阶段"
})
