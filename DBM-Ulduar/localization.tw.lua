if GetLocale() ~= "zhTW" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "烈焰戰輪"
}

L:SetTimerLocalization{
	timerPursued			= "獵殺: %s",
	timerFlameVents			= "烈焰外洩",
	timerSystemOverload		= "電路超載"
}
	
L:SetMiscLocalization{
	YellPull			= "發現敵意實體。啟動威脅評估協定。首要目標接近中。30秒後將再度評估。",
	Emote				= "%%s獵殺(%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn		= "獵殺 >%s<!",
	warnNextPursueSoon		= "5秒後 獵殺轉換"
}

L:SetOptionLocalization{
	timerSystemOverload		= "顯示電路超載計時器",
	timerFlameVents			= "顯示烈焰外洩計時器",
	timerPursued			= "顯示獵殺計時器",
	SystemOverload			= "為電路超載顯示特別警告",
	SpecialPursueWarnYou		= "當獵殺時顯示特別警告",
	PursueWarn			= "當玩家中了獵殺時顯示團隊警告",
	warnNextPursueSoon		= "獵殺轉換前警告"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "『火爐之主』伊格尼司"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "烈焰噴洩",
	TimerFlameJetsCooldown		= "下一次 烈焰噴洩",
	TimerScorch			= "下一次 灼燒",
	TimerScorchCast			= "灼燒",
	TimerSlagPot			= "熔渣之盆: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "熔渣之盆: >%s<",
	SpecWarnJetsCast		= "烈焰噴洩 - 停止施法"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "為烈焰噴洩顯示特別警告 (斷法)",
	TimerFlameJetsCast		= "顯示烈焰噴洩的施法計時器",
	TimerFlameJetsCooldown		= "顯示烈焰噴洩的冷卻計時器",
	TimerScorch			= "顯示灼燒的冷卻計時",
	TimerScorchCast			= "顯示灼燒的施法計時",
	WarningSlagPot			= "提示熔渣之盆的目標",
	TimerSlagPot			= "顯示熔渣之盆計時器",
	SlagPotIcon			= "設置標記在熔渣之盆的目標"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "銳鱗"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "吞噬烈焰 - 移動囉!!",
	warnTurretsReadySoon		= "20秒後 第四座砲塔完成",
	warnTurretsReady		= "第四座砲塔已完成",
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "下一次 火息術",
	timerDeepBreathCast		= "火息術",
	timerAllTurretsReady		= "砲塔"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "為下一次火息術顯示計時器",
	timerDeepBreathCast		= "顯示火息術的施法計時器",
	SpecWarnDevouringFlame		= "當你在吞噬烈焰的攻擊範圍時顯示特別警告",
	PlaySoundOnDevouringFlame	= "當受到吞噬烈焰時播放音效",
	timerAllTurretsReady		= "為砲塔顯示計時器",
	warnTurretsReadySoon		= "顯示砲塔的預先警告",
	warnTurretsReady		= "顯示砲塔的警告",
}

L:SetMiscLocalization{
	YellAir 			= "給我們一點時間來準備建造砲塔。"
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002拆解者"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "你中了裂光彈!",
	WarningLightBomb		= "裂光彈: >%s<",
	SpecialWarningGravityBomb	= "你中了重力彈!",
	WarningGravityBomb		= "重力彈: >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "當你中了裂光彈時顯示特別警告",
	WarningLightBomb		= "提示裂光彈",
	SpecialWarningGravityBomb	= "當你中了重力彈時顯示特別警告",
	WarningGravityBomb		= "提示重力彈",
	PlaySoundOnGravityBomb		= "當你中了重力彈時播放音效",
	PlaySoundOnTympanicTantrum	= "躁怒時播放音效",
	SetIconOnLightBombTarget	= "設置標記在裂光彈的目標",
	SetIconOnGravityBombTarget	= "設置標記在重力彈的目標",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "鐵之議會"
}

L:SetWarningLocalization{
	WarningSupercharge		= "超級充能 即將到來",
	WarningChainlight		= "閃電鏈",
	WarningFusionPunch		= "熔能拳擊",
	WarningOverwhelmingPower	= "極限威能: >%s<",
	WarningRuneofPower		= "力之符文",
	WarningRuneofDeath		= "死亡符文",
	RuneofDeath			= "死亡符文 - 移動",
	LightningTendrils		= "閃電觸鬚 - 跑開!",
}

L:SetTimerLocalization{
	TimerSupercharge		= "超級充能",
	TimerOverload			= "超載",
	TimerLightningWhirl		= "閃電旋風",
	TimerLightningTendrils		= "閃電觸鬚",
	timerFusionPunchCast		= "熔能拳擊施放",
	timerFusionPunchActive		= "熔能拳擊: %s",
	timerOverwhelmingPower		= "極限威能: %s",
	timerRunicBarrier		= "符刻屏障",
	timerRuneofDeath		= "死亡符文",
}

L:SetOptionLocalization{
	TimerSupercharge		= "顯示超級充能計時器",
	WarningSupercharge		= "當超級充能施放時顯示警告",
	WarningChainlight		= "提示閃電鏈",
	TimerOverload			= "顯示超載的施法計時器",
	PlaySoundOnOverload		= "當超載施放時播放音效",
	TimerLightningWhirl		= "顯示閃電旋風的施法計時器",
	LightningTendrils		= "為閃電觸鬚顯示特別警告",
	TimerLightningTendrils		= "顯示閃電旋風的持續時間計時器",
	PlaySoundLightningTendrils	= "閃電觸鬚時播放音效",
	WarningFusionPunch		= "提示熔能拳擊",
	timerFusionPunchCast		= "為熔能拳擊顯示施法計時條",
	timerFusionPunchActive		= "顯示熔能拳擊計時器",
	WarningOverwhelmingPower	= "提示極限威能",
	timerOverwhelmingPower		= "顯示極限威能計時器",
	SetIconOnOverwhelmingPower	= "設置標記在極限威能的目標",
	timerRunicBarrier		= "顯示符刻屏障計時器",
	WarningRuneofPower		= "提示力之符文",
	WarningRuneofDeath		= "提示死亡符文",
	RuneofDeath			= "為死亡符文顯示特別警告",
	timerRuneofDeath		= "顯示死亡符文的持續時間計時器",
	PlaySoundDeathRune		= "當死亡符文施放時播放音效"
}

L:SetMiscLocalization{
	Steelbreaker			= "破鋼者",
	RunemasterMolgeim		= "符文大師墨吉姆",
	StormcallerBrundir 		= "風暴召喚者布倫迪爾"
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "『觀察者』艾爾加隆"
}

L:SetTimerLocalization{
	TimerBigBangCast		= "大爆炸 施放",
}
L:SetWarningLocalization{
	WarningPhasePunch		= "相位拳擊: >%s<",
	WarningBlackHole		= "黑洞爆炸",
}

L:SetOptionLocalization{
	TimerBigBangCast		= "為大爆炸顯示施法計時條",
	SpecWarnPhasePunch		= "當你中了相位拳擊顯示特別警告",
	WarningPhasePunch		= "提示相位拳擊的目標",
	WarningBlackHole		= "提示黑洞爆炸",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "柯洛剛恩"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "集束目光看著你 - 跑開",
	WarningEyebeam			= "集束目光: >%s<",
	WarnGrip			= "堅石之握: >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "集束目光: %s",
	timerPetrifyingBreath		= "石化之息",
	timerNextShockwave		= "下一個 震攝波",
	timerLeftArm			= "左臂 重生",
	timerRightArm			= "右臂 重生"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "當集束目光看著你顯示特別警告",
	WarningEyebeam			= "提示集束目光的目標",
	timerEyebeam			= "顯示集束目光的計時器",
	SetIconOnEyebeamTarget		= "設置標記在集束目光的目標",
	timerPetrifyingBreath		= "顯示石化之息的計時器",
	timerNextShockwave		= "顯示震攝波的計時器",
	timerLeftArm			= "顯示手臂重生(左) 的計時器",
	timerRightArm			= "顯示手臂重生(右) 的計時器",
	WarnGrip			= "提示堅石之握的目標",
	SetIconOnGripTarget		= "設置標記在堅石之握的目標",
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "小小的擦傷!",
	Yell_Trigger_arm_right		= "只是皮肉之傷!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "奧芮雅"
}

L:SetMiscLocalization{
	Defender 			= "野性防衛者 (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast 			= "哨兵衝擊 - 打斷!",
	SpecWarnVoid	= "虛空區域 - 移動!",
	WarnCatDied 			= "野性防衛者倒下 (剩餘%d支)",
	WarnFear 			= "恐懼!",
	WarnFearSoon 			= "下一次恐懼即將到來!",
	WarnSonic			= "音速尖嘯!",
	WarnSwarm			= "貓群守護者: >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast	 		= "為哨兵衝擊顯示特別警告",
	SpecWarnVoid	= "當站在野性精華上面時顯示特別警告",
	WarnFear 			= "顯示恐懼警告",
	WarnFearSoon 			= "顯示即將恐懼警告",
	WarnCatDied 			= "當野性防衛者死亡時顯示警告",
	WarnSwarm			= "當貓群守護者出現時顯示警告",
	WarnSonic			= "顯示音速尖嘯警告"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "霍迪爾"
}

L:SetWarningLocalization{
	WarningFlashFreeze		= "閃霜",
	WarningBitingCold		= "刺骨之寒 - 移動"
}

L:SetTimerLocalization{
	TimerFlashFreeze		= "閃霜 即將到來",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "顯示閃霜的施放計時器",
	WarningFlashFreeze		= "為閃霜顯示警告",
	WarningBitingCold		= "為刺骨之寒顯示警告",
	PlaySoundOnFlashFreeze		= "當閃霜施放時播放音效"
}

L:SetMiscLocalization{

}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "索林姆"
}

L:SetWarningLocalization{
	WarningStormhammer		= "風暴之錘: >%s<",
	UnbalancingStrike		= "失衡打擊: >%s<",
	WarningPhase2			= "第二階段",
	WarningBomb			= "引爆符文: >%s<",
	LightningOrb 			= "你中了閃電充能! 快跑!"
}

L:SetTimerLocalization{
	TimerStormhammer		= "風暴之錘冷卻",
	TimerUnbalancingStrike		= "失衡打擊冷卻",
	TimerHardmode			= "困難模式"
}

L:SetOptionLocalization{
	TimerStormhammer		= "顯示風暴之錘冷卻時間",
	TimerUnbalancingStrike		= "顯示失衡打擊計時器",
	TimerHardmode			= "顯示困難模式計時器",
	UnbalancingStrike		= "提示失衡打擊的目標",
	WarningStormhammer		= "提示風暴之錘的目標",
	WarningPhase2			= "提示第二階段",
	RangeFrame			= "顯示距離框",
	WarningBomb			= "提示引爆符文",
	LightningOrb 			= "當你中了閃電充能時顯示特別警告"
}

L:SetMiscLocalization{
	YellPhase1			= "擅闖者!像你們這種膽敢干涉我好事的凡人將付出…等等--你……",
	YellPhase2			= "無禮的小輩，你竟敢在我的王座之上挑戰我?我會親手碾碎你們!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "芙蕾雅"
}

L:SetMiscLocalization{
	SpawnYell 			= "孩子們，協助我!",
	WaterSpirit 			= "上古水之靈",
	Snaplasher 			= "猛攫鞭笞者",
	StormLasher 			= "風暴鞭笞者",
	EmoteTree 			= "???" -- /chatlog does not log messages with color codes...lol
}

L:SetWarningLocalization{
	WarnPhase2 			= "第二階段",
	WarnSimulKill			= "第一支小怪死亡 - 1分鐘後復活",
	WarnFury 			= "自然烈怒: >%s<",
	SpecWarnFury 			= "你中了自然烈怒!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam 		= "太陽光束: %s",
	TimerAlliesOfNature 		= "自然和諧冷卻",
	TimerSimulKill 			= "復活",
	TimerFuryYou 			= "你中了自然烈怒"
}

L:SetOptionLocalization{
	TimerAlliesOfNature 		= "顯示自然和諧冷卻時間",
	TimerSimulKill 			= "顯示小怪復活計時器",
	TimerFuryYou 			= "顯示自然烈怒計時器",
	WarnPhase2 			= "提示第二階段",
	WarnSimulKill			= "提示小怪復活",
	WarnFury 			= "提示自然烈怒",
	SpecWarnFury 			= "當你中了自然烈怒時顯示特別警告"
}

-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "彌米倫"
}

L:SetWarningLocalization{
	DarkGlare 			= "雷射彈幕",
	WarningPlasmaBlast		= "離子衝擊: %s - 治療", --unusable?
	Phase2Engaged			= "第二階段即將到來 - 現在重組",
	Phase3Engaged			= "第三階段即將到來 - 現在重組",
	Warnshell			= "凝汽彈: >%s<",
	WarnBlast			= "離子衝擊: >%s<",
	MagneticCore			= ">%s< 拿到了磁能之核",
	WarningShockBlast		= "震爆 - 跑開!"
}

L:SetTimerLocalization{
	ProximityMines			= "新的環罩地雷",
	TimeToPhase2			= "第二階段開始",
	TimeToPhase3			= "第三階段開始",
}

L:SetOptionLocalization{
	WarningShockBlast		= "顯示震爆警告",
	WarningPlasmaBlast		= "顯示離子衝擊",
	ProximityMines			= "顯示環罩地雷計時器",
	PlaySoundOnShockBlast 		= "當震爆施放時播放音效",
	DarkGlare 			= "提示雷射彈幕",
	PlaySoundOnDarkGlare 		= "雷射彈幕施放前播放音效",
	NextDarkGlare 			= "下一次 雷射彈幕的計时器",
	TimeToPhase2			= "顯示第二階段開始計时器", --第二階段開始
	TimeToPhase3			= "顯示第三階段開始計时器", --第三階段開始
	SpinUp 				= "顯示暖機(雷射彈幕施放前的技能)計時器",
	MagneticCore			= "提示磁能之核的拾取者",
	HealthFramePhase4		= "顯示第4階段的首領血量框架",
	WarnShell			= "提示凝汽彈的目標",
	WarnBlast			= "提示離子衝擊的目標"
}

L:SetMiscLocalization{
	YellPull			= "我們沒有太多時間，朋友們!你們要幫我測試我最新也是最偉大的創作。在你們改變心意之前，別忘了就是你們把XT-002搞得一團糟，你們欠我一次。",	
	YellPhase2			= "太好了!絕妙的良好結果!外殼完整度98.9%!幾乎只有一點擦痕!繼續下去。",
	YellPhase3			= "感謝你，朋友們!我們的努力讓我獲得了一些絕佳的資料!現在，我把東西放在哪兒了--噢，在這裡。",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "威札斯將軍"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "你中了暗影暴擊",
	SpecialWarningSurgeDarkness	= "暗鬱奔騰",
	WarningShadowCrash		= "暗影暴擊: >%s<",
	SpecialWarningLLYou		= "你中了無面者印記!",
	SpecialWarningLLNear		= "接近你的%s中了無面者印記!"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "為暗影暴擊顯示特別警告",
	SetIconOnShadowCrash		= "為暗影暴擊的目標設置標記(頭顱)",
	SetIconOnLifeLeach		= "為無面者印記的目標設置標記(十字)",
	SpecialWarningSurgeDarkness	= "為暗鬱奔騰顯示特別警告",
	SpecialWarningShadowCrash	= "為暗影暴擊顯示特別警告",
	SpecialWarningLLYou		= "當你中了無面者印記時顯示特別警告",
	SpecialWarningLLNear		= "當你附近的人中了無面者印記時顯示特別警告",
	CrashWhisper 			= "密語提示中了暗影暴擊的人"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "一片薩倫煙霧在附近聚合!",
	CrashWhisper			= "你中了暗影暴擊! 跑開!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "尤格薩倫"
}

L:SetMiscLocalization{
	YellPull 			= "我們即將有機會打擊怪物的首腦!現在將你的憤怒與仇恨貫注在他的爪牙上!",
	YellPhase2 			= "讓仇恨與狂怒帶領你的攻擊!",
	Sara 				= "薩拉",
	WhisperBrainLink 		= "你中了腦波連結! 跑向 %s!",
}

L:SetWarningLocalization{
	WarningWellSpawned 		= "理智之井 出現了",
	WarningGuardianSpawned 		= "尤格薩倫守護者 出現了",
	WarningP2 			= "第二階段",
	WarningBrainLink 		= "腦波連結: >%s< 和 >%s<",
	SpecWarnBrainLink 		= "你和%s中了腦波連結!",
	WarningSanity 			= "剩下 %d 理智",
	SpecWarnSanity 			= "剩下 %d 理智",
	SpecWarnGuardianLow 		= "停止攻擊這支守護者!",
	WarnMadness 			= "正在施放 瘋狂誘陷",
	SpecWarnMadnessOutNow		= "瘋狂誘陷即將完結 - 快傳送出去"
}

L:SetTimerLocalization{
	NextPortal			= "下一次 傳送門",
}

L:SetOptionLocalization{
	WarningWellSpawned 		= "提示理智之井的出現",
	WarningGuardianSpawned 		= "提示尤格薩倫守護者的出現",
	WarningP2 			= "提示第二階段",
	WarningBrainLink		= "提示腦波連結",
	SpecWarnBrainLink 		= "當你中了腦波連結顯示特別警告",
	WarningSanity			= "當理智剩下50時顯示警告",
	SpecWarnSanity			= "當理智過低(25,15,5)時顯示特別警告",
	SpecWarnGuardianLow		= "當守護者(P1)血量過低時(DD用)顯示特別警告",
	WarnMadness 			= "顯示瘋狂誘陷的施放警告",
	SpecWarnMadnessOutNow		= "在瘋狂誘陷完結前顯示特別警告",
	WhisperBrainLink 		= "密語提示中了腦波連結的人",
	NextPortal			= "顯示下一次 傳送門的計時器",
	ShowSaraHealth			= "顯示薩拉的血量"
}