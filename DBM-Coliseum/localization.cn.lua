if GetLocale() ~= "zhCN" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "诺森德猛兽"
}

L:SetMiscLocalization{
	Charge				= "%%s等着(%S+)，发出一阵震耳欲聋的怒吼！",
	CombatStart			= "他来自风暴峭壁最幽深，最黑暗的洞穴，穿刺者戈莫克！准备战斗，英雄们！",
	Phase2				= "做好准备，英雄们，两头猛兽已经进入了竞技场！它们是酸喉和恐鳞！",
	Phase3				= "当下一名斗士出场时，空气都会为之冻结！它是冰吼，胜或是死，勇士们！",
	Gormok				= "穿刺者戈莫克",
	Acidmaw				= "酸喉",
	Dreadscale			= "恐鳞",
	Icehowl				= "冰吼"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarningSnobold			= "为狗头人奴隶出现显示警报",
	SpecialWarningImpale3		= "为穿刺 (大于3层)显示特别警报",
	SpecialWarningAnger3		= "为渐怒 (大于3层)显示特别警报",
	SpecialWarningSilence		= "为震地践踏显示特别警报",
	SpecialWarningCharge		= "当冰吼即将冲锋你时显示特别警报",
	SpecialWarningTranq		= "当冰吼获得寒冰狂怒时显示特别警报 (驱散用)",
	PingCharge			= "当冰吼即将冲锋你时自动点击小地图",
	SpecialWarningChargeNear	= "当冰吼即将冲锋在你附近时显示特别警报",
	SetIconOnChargeTarget		= "为冲锋的目标设置标记 (骷髅)",
	SetIconOnBileTarget		= "为麻痹毒素的目标设置标记",
	ClearIconsOnIceHowl		= "冲锋前清除所有标记",
	TimerNextBoss			= "为下一个首领到来显示计时器",
	TimerCombatStart		= "为战斗开始显示计时器",
	TimerEmerge			= "为钻地显示计时器",
	TimerSubmerge			= "为下一次 钻地显示计时器",
	RangeFrame                  	= "在第2阶段显示距离框",
	IcehowlArrow			= "当冰吼即将冲锋在你附近时显示DBM箭头"
}

L:SetTimerLocalization{
	TimerNextBoss			= "下一个首领到来",
	TimerCombatStart		= "战斗开始",
	TimerEmerge			= "正在钻地",
	TimerSubmerge			= "下一次 钻地"
}

L:SetWarningLocalization{
	WarningSnobold			= "狗头人奴隶 出现了",
	SpecialWarningImpale3		= "你中了穿刺>%d<",
	SpecialWarningAnger3		= "渐怒: >%d<",
	SpecialWarningSilence		= "1.5秒后 震地践踏",
	SpecialWarningCharge		= "你是冲锋的目标 - 快躲开",
	SpecialWarningChargeNear	= "你附近有人被冲锋 - 快躲开",
	SpecialWarningTranq		= "寒冰狂怒 - 现在驱散"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "加拉克苏斯大王"
}

L:SetWarningLocalization{
	WarnNetherPower			= "加拉克苏斯大王拥有虚空之能 - 快驱散",
	SpecWarnTouch			= "你中了加拉克苏斯之触",
	SpecWarnTouchNear		= "你附近的%s中了加拉克苏斯之触",
	SpecWarnNetherPower		= "现在驱散",
	SpecWarnFelFireball		= "魔能火球 - 现在打断"
}

L:SetTimerLocalization{
	TimerCombatStart		= "战斗开始"
}

L:SetMiscLocalization{
	WhisperFlame			= "你中了军团烈焰 - 快跑开",
	IncinerateTarget		= "血肉成灰: %s"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	TimerCombatStart		= "为战斗开始显示计时条",
	WarnNetherPower			= "当加拉克苏斯大王拥有虚空之能时显示警报 (驱散/偷取用)",
	SpecWarnTouch			= "当你中了加拉克苏斯之触时显示特别警报",
	SpecWarnTouchNear		= "当你附近的人中了加拉克苏斯之触时显示特别警报",
	SpecWarnNetherPower		= "为虚空之能显示特别警报 (驱散/偷取用)",
	SpecWarnFelFireball		= "为魔能火球显示特别警报 (打断用)",
	TouchJaraxxusIcon		= "为加拉克苏斯之触的目标设置标记 (十字)",
	IncinerateFleshIcon		= "为血肉成灰的目标设置标记 (骷髅)",
	LegionFlameIcon			= "为军团烈焰的目标设置标记 (方形)",
	LegionFlameWhisper		= "密语提示军团烈焰的目标",
	LegionFlameRunSound		= "为军团烈焰播放音效",
	IncinerateShieldFrame		= "在首领血量里显示血肉成灰的血量"
}

L:SetMiscLocalization{
	FirstPull			= "大术士威尔弗雷德•菲斯巴恩将会召唤你们的下一个挑战者。等待他的登场吧。"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "阵营冠军"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	--Horde NPCS
	Gorgrim				= "死骑 - 高葛林•影斩",		-- 34458
	Birana 				= "小德 - 碧菈娜•风暴之蹄",	-- 34451
	Erin				= "小德 - 艾琳•雾蹄",		-- 34459
	Rujkah				= "猎人 - 茹卡",		-- 34448
	Ginselle			= "法师 - 金赛儿•凋掷",		-- 34449
	Liandra				= "圣骑 - 黎安卓•唤日",		-- 34445
	Malithas			= "圣骑 - 玛力萨•亮刃",		-- 34456
	Caiphus				= "牧师 - 严厉的凯普司",	-- 34447
	Vivienne			= "牧师 - 薇薇安•黑语",		-- 34441
	Mazdinah			= "盗贼 - 马兹迪娜",		-- 34454
	Thrakgar			= "萨满 - 瑟瑞克加尔",		-- 34444
	Broln				= "萨满 - 伯洛连•顽角",		-- 34455
	Harkzog				= "术士 - 哈克佐格",		-- 34450
	Narrhok				= "战士 - 纳霍克•破钢者",	-- 34453
	--Alliance NPCS
	Tyrius				= "死骑 - 提瑞斯•暮刃",		-- 34461
 	Kavina				= "小德 - 卡薇娜•林地之歌",	-- 34460
 	Melador				= "小德 - 梅拉朵•谷行者",	-- 34469
 	Alyssia 			= "猎人 - 爱莉希雅•月巡者",	-- 34467
 	Noozle				= "法师 - 诺佐•啸棍",		-- 34468
 	Baelnor 			= "圣骑 - 贝尔诺•携光者",	-- 34471
 	Velanaa				= "圣骑 - 维兰娜", 		-- 34465
 	Anthar				= "牧师 - 安萨•修炉匠",		-- 34466
 	Brienna				= "牧师 - 布芮娜•夜坠",		-- 34473
 	Irieth				= "盗贼 - 艾芮丝•影步",		-- 34472
 	Saamul				= "萨满 - 萨缪尔", 		-- 34470
 	Shaabad				= "萨满 - 夏巴德", 		-- 34463
 	Serissa				= "术士 - 瑟芮莎•厉溅",		-- 34474
 	Shocuul				= "战士 - 修库尔",		-- 34475

	AllianceVictory			= "荣耀归于联盟!",
	HordeVictory			= "那只是让你们知道将来必须面对的命运。为了部落!",
	YellKill			= "肤浅而悲痛的胜利。今天痛失的生命反而令我们更加的颓弱。除了巫妖王之外，谁还能从中获利?伟大的战士失去了宝贵生命。为了什么?真正的威胁就在前方 - 巫妖王在死亡的领域中等着我们。"
} 

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	PlaySoundOnBladestorm		= "为剑刃风暴播放音效"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "瓦格里双子"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "下一次 特别技能"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "特别技能 即将到来",
	SpecWarnSpecial			= "快变换颜色",
	SpecWarnSwitchTarget		= "快换目标打双子相协",
	SpecWarnKickNow			= "现在打断",
	WarningTouchDebuff		= "光明或黑暗之触: >%s<",
	WarningPoweroftheTwins		= "双生之能 - 加大治疗: >%s<",
	SpecWarnPoweroftheTwins		= "双生之能"
}

L:SetMiscLocalization{
	YellPull 			= "以我们的黑暗君王之名。为了巫妖王。你‧得‧死。",
	Fjola 				= "光明邪使菲奥拉",
	Eydis				= "黑暗邪使艾蒂丝"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	TimerSpecialSpell		= "为下一次 特别技能显示计时器",
	WarnSpecialSpellSoon		= "为下一次 特别技能显示提前警报",
	SpecWarnSpecial			= "当你需要变换颜色时显示特别警报",
	SpecWarnSwitchTarget		= "当另一个首领施放双子相协时显示特别警报",
	SpecWarnKickNow			= "当你可以打断时显示特别警报",
	SpecialWarnOnDebuff		= "当你中了光明或黑暗之触时显示特别警报 (需切换颜色)",
	SetIconOnDebuffTarget		= "为光明或黑暗之触的目标设置标记 (英雄模式)",
	WarningTouchDebuff		= "提示光明或黑暗之触的目标",
	WarningPoweroftheTwins		= "提示双生之能的目标",
	SpecWarnPoweroftheTwins		= "当你坦克的首领拥有双生之能时显示特别警报"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "阿努巴拉克"
}

L:SetTimerLocalization{
	TimerEmerge			= "正在钻地",
	TimerSubmerge			= "下一次 钻地",
	timerAdds			= "下一次 中虫出现"
}

L:SetWarningLocalization{
	WarnEmerge			= "阿努巴拉克钻出地面了",
	WarnEmergeSoon			= "10秒后 钻出地面",
	WarnSubmerge			= "阿努巴拉克钻进地里了",
	WarnSubmergeSoon		= "10秒后 钻进地里",
	specWarnSubmergeSoon		= "10秒后 钻进地里!",
	SpecWarnPursue			= "你被追击了 - 快跑",
	warnAdds			= "中虫 出现了",
	SpecWarnShadowStrike		= "暗影突击 - 现在打断"
}

L:SetMiscLocalization{
	YellPull			= "这里将会是你们的坟墓!",
	Emerge				= "从地底钻出!",
	Burrow				= "钻进地里!",
	PcoldIconSet			= "刺骨之寒{rt%d}: %s",
	PcoldIconRemoved		= "移除标记: %s"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警报语音",
	WarnEmerge			= "为钻出地面显示警报",
	WarnEmergeSoon			= "为钻出地面显示提前警报",
	WarnSubmerge			= "为钻进地里显示警报",
	WarnSubmergeSoon		= "为钻进地里显示提前警报",
	specWarnSubmergeSoon		= "为即将钻进地里显示特别警报",
	SpecWarnPursue			= "当你被追击时显示特别警报",
	warnAdds			= "提示中虫出现",
	timerAdds			= "为下一次 中虫出现显示计时器",
	TimerEmerge			= "为首领钻地显示计时器",
	TimerSubmerge			= "为下一次 钻地显示计时器",
	PlaySoundOnPursue		= "当你开始被追击时播放音效",
	PursueIcon			= "为被追击的目标设置标记 (骷髅)",
	SpecWarnShadowStrike		= "为$spell:66134显示特别警报 (打断用)",
	RemoveHealthBuffsInP3		= "当进入第3阶段时移除耐力的增益",
	SetIconsOnPCold			= "为$spell:68510的目标设置标记",
	AnnouncePColdIcons		= "公布$spell:68510目标设置的标记到团队频道\n(需要团长或助理权限)",
	AnnouncePColdIconsRemoved	= "当移除$spell:68510的标记时也提示\n(需要上述选项)"
}
