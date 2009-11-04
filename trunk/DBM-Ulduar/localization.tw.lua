if GetLocale() ~= "zhTW" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name 				= "烈焰戰輪"
}

L:SetTimerLocalization{
	timerPursued			= "獵殺: %s",
	timerFlameVents			= "烈焰外洩",
	timerSystemOverload		= "系統關閉"
}
	
L:SetMiscLocalization{
	YellPull			= "發現敵意實體。啟動威脅評估協定。首要目標接近中。30秒後將再度評估。",
	Emote				= "%%s緊追(%S+)%。"
}

L:SetWarningLocalization{
	PursueWarn			= "獵殺: >%s<",
	warnNextPursueSoon		= "5秒後 獵殺轉換",
	SpecialPursueWarnYou		= "你中了獵殺 - 快跑",
	SystemOverload			= "電路超載",
	warnWardofLife			= "生命結界 出現",
--	warnWrithingLasher		= "盤繞鞭笞者 出現"
}

L:SetOptionLocalization{
	timerSystemOverload		= "為系統關閉顯示計時器",
	timerFlameVents			= "為烈焰外洩顯示計時器",
	timerPursued			= "為獵殺顯示計時器",
	SystemOverload			= "為系統關閉顯示特別警告",
	SpecialPursueWarnYou		= "當你中了獵殺時顯示特別警告",
	PursueWarn			= "提示獵殺的目標",
	warnNextPursueSoon		= "為下一次 獵殺顯示預先警告",
	warnWardofLife			= "為生命結界 出現顯示特別警告",
--	warnWrithingLasher		= "為盤繞鞭笞者 出現顯示特別警告" --commenting out as it is currently unused for Flame Leviathan
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name 				= "『火爐之主』伊格尼司"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "烈焰噴洩",
	TimerFlameJetsCooldown		= "下一次 烈焰噴洩",
	TimerScorch			= "下一次 灼燒",
	TimerScorchCast			= "灼燒",
	TimerSlagPot			= "熔渣之盆: %s",
}

L:SetWarningLocalization{
	WarningSlagPot			= "熔渣之盆: >%s<",
	SpecWarnJetsCast		= "烈焰噴洩 - 停止施法"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "為烈焰噴洩顯示特別警告",
	TimerFlameJetsCast		= "為烈焰噴洩的施法顯示計時器",
	TimerFlameJetsCooldown		= "為烈焰噴洩顯示冷卻計時器",
	TimerScorch			= "為灼燒顯示冷卻計時器",
	TimerScorchCast			= "為灼燒的施法顯示計時器",
	WarningSlagPot			= "提示熔渣之盆的目標",
	TimerSlagPot			= "為熔渣之盆顯示計時器",
	SlagPotIcon			= "為熔渣之盆的目標設置標記"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name 				= "銳鱗"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "吞噬烈焰 - 快跑開",
	warnTurretsReadySoon		= "20秒後 最後一座砲塔完成",
	warnTurretsReady		= "最後一座砲塔已完成",
	SpecWarnDevouringFlameCast	= "你中了吞噬烈焰",
	WarnDevouringFlameCast		= "吞噬烈焰: >%s<", 
}
L:SetTimerLocalization{
	timerAllTurretsReady		= "砲塔",
	timerTurret1			= "砲塔1",
	timerTurret2			= "砲塔2",
	timerTurret3			= "砲塔3",
	timerTurret4			= "砲塔4",
	timerGroundedTemp		= "地上階段",
}
L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "當你受到吞噬烈焰時顯示特別警告",
	PlaySoundOnDevouringFlame	= "當你受到吞噬烈焰時播放音效",
	timerAllTurretsReady		= "為砲塔顯示計時器",
	warnTurretsReadySoon		= "為砲塔顯示預先警告",
	warnTurretsReady		= "為砲塔顯示警告",
	SpecWarnDevouringFlameCast	= "當你中了吞噬烈焰時顯示特別警告",
	timerTurret1			= "為砲塔1顯示計時器",
	timerTurret2			= "為砲塔2顯示計時器",
	timerTurret3			= "為砲塔3顯示計時器 (25人)",
	timerTurret4			= "為砲塔4顯示計時器 (25人)",
	OptionDevouringFlame		= "提示吞噬烈焰的目標 (不準確)",
	timerGroundedTemp		= "為地上階段顯示計時器"
}

L:SetMiscLocalization{
	YellAir				= "給我們一點時間來準備建造砲塔。",
	YellAir2			= "火熄了!讓我們重建砲塔!",
	YellGroundTemp			= "快!她可不會在地面上待太久!",
	EmotePhase2			= "%%s再也飛不動了!",
	FlamecastUnknown		= DBM_CORE_UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002拆解者"
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "你中了裂光彈",
	SpecialWarningGravityBomb	= "你中了重力彈",
	specWarnConsumption		= "耗損 - 快跑開"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "當你中了裂光彈時顯示特別警告",
	SpecialWarningGravityBomb	= "當你中了重力彈時顯示特別警告",
	specWarnConsumption		= "當你受到耗損的傷害時顯示特別警告",
	PlaySoundOnGravityBomb		= "當你中了重力彈時播放音效",
	PlaySoundOnTympanicTantrum	= "躁怒時播放音效",
	SetIconOnLightBombTarget	= "為裂光彈的目標設置標記",
	SetIconOnGravityBombTarget	= "為重力彈的目標設置標記"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "鐵之集會所"
}

L:SetWarningLocalization{
	WarningSupercharge		= "超級充能 即將到來",
	RuneofDeath			= "死亡符文 - 快跑開",
	LightningTendrils		= "閃電觸鬚 - 快跑開",
	Overload			= "超載 - 快跑開",
	WarningStaticDisruption		= "靜電崩裂: >%s<"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge		= "當超級充能開始施放時顯示警告",
	LightningTendrils		= "為閃電觸鬚顯示特別警告",
	PlaySoundLightningTendrils	= "為閃電觸鬚播放音效",
	WarningFusionPunch		= "提示熔能拳擊的目標",
	timerFusionPunchActive		= "為熔能拳擊顯示減益計時器",
	SetIconOnOverwhelmingPower	= "為極限威能的目標設置標記",
	RuneofDeath			= "為死亡符文顯示特別警告",
	SetIconOnStaticDisruption	= "為靜電崩裂的目標設置標記",
	Overload			= "為超載顯示特別警告",
	AlwaysWarnOnOverload		= "總是對超載顯示警告(否則只有當目標是風暴召喚者的時候顯示)",
	PlaySoundOnOverload		= "當超載施放時播放音效",
	WarningStaticDisruption		= "提示靜電崩裂的目標",
	PlaySoundDeathRune		= "當死亡符文施放時播放音效"
}

L:SetMiscLocalization{
	Steelbreaker			= "破鋼者",
	RunemasterMolgeim		= "符文大師墨吉姆",
	StormcallerBrundir 		= "風暴召喚者布倫迪爾"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name 				= "『觀察者』艾爾加隆"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "下一次 崩陷之星",
	PossibleNextCosmicSmash		= "下一次 宇宙潰擊"
}
L:SetWarningLocalization{
	WarningPhasePunch		= "相位拳擊: >%s< - 第%d層",
	WarningBlackHole		= "黑洞爆炸",
	SpecWarnBigBang			= "大霹靂",
	PreWarningBigBang		= "約10秒後 大霹靂",
	WarningCosmicSmash 		= "宇宙潰擊 - 約4秒後爆炸",
	SpecWarnCosmicSmash 		= "宇宙潰擊"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "當你中了相位拳擊時顯示特別警告",
	PreWarningBigBang		= "為大霹靂顯示預先警告",
	SpecWarnBigBang			= "為大霹靂顯示特別警告",
	WarningPhasePunch		= "提示相位拳擊的目標",
	WarningBlackHole		= "為黑洞爆炸顯示警告",
	NextCollapsingStar		= "為下一次 崩陷之星顯示計時器",
	WarningCosmicSmash 		= "為宇宙潰擊顯示警告",
	SpecWarnCosmicSmash 		= "為宇宙潰擊顯示特別警告",
	PossibleNextCosmicSmash		= "為下一次 宇宙潰擊顯示計時器"
}

L:SetMiscLocalization{
	YellPull			= "你的行為毫無意義。這場衝突的結果早已計算出來了。不論結局為何，萬神殿仍將收到觀察者的訊息。",
	YellPullFirst			= "從我的雙眼觀看你的世界:一個無邊無際的宇宙--連你們之中最具智慧者都無法想像的廣闊無垠。",
	Emote_CollapsingStars		= "%s開始召喚崩陷之星!",
	Emote_CosmicSmash		= "%s開始施展宇宙潰擊!"
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name 				= "柯洛剛恩"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "集束目光看著你 - 快跑開",
	WarningEyeBeam			= "集束目光: >%s<",
	WarnGrip			= "堅石之握: >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "集束目光: %s",
	timerPetrifyingBreath		= "石化之息",
	timerLeftArm			= "左臂 重生",
	timerRightArm			= "右臂 重生",
	achievementDisarmed		= "卸除手臂 計時器"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "當集束目光看著你時顯示特別警告",
	WarningEyeBeam			= "提示集束目光的目標",
	timerEyebeam			= "為集束目光顯示計時器",
	timerPetrifyingBreath		= "為石化之息顯示計時器",
	timerLeftArm			= "為左臂重生顯示計時器",
	timerRightArm			= "為右臂重生顯示計時器",
	achievementDisarmed		= "為成就:卸除手臂顯示計時器",
	WarnGrip			= "提示堅石之握的目標",
	SetIconOnGripTarget		= "為堅石之握的目標設置標記"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "小小的擦傷!",
	Yell_Trigger_arm_right		= "只是皮肉之傷!",
	Health_Body			= "柯洛剛恩身體",
	Health_Right_Arm		= "右臂",
	Health_Left_Arm			= "左臂",
	FocusedEyebeam			= "%s正在注視著你!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name 				= "奧芮雅"
}

L:SetMiscLocalization{
	Defender 			= "野性防衛者 (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast			= "哨兵衝擊 - 快斷法",
	SpecWarnVoid			= "滲洩野性精華 - 快跑開",
	WarnCatDied 			= "野性防衛者倒下 (剩餘%d隻)",
	WarnCatDiedOne 			= "野性防衛者倒下 (剩下最後一隻)",
	WarnFearSoon 			= "下一次 恐嚇尖嘯即將到來"
}

L:SetOptionLocalization{
	SpecWarnBlast			= "為哨兵衝擊顯示特別警告",
	SpecWarnVoid			= "當你中了滲洩野性精華時顯示特別警告",
	WarnFearSoon			= "為恐嚇尖嘯顯示預先警告",
	WarnCatDied			= "當野性防衛者死亡時顯示警告",
	WarnCatDiedOne			= "當野性防衛者剩下最後一隻時顯示警告"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name 				= "霍迪爾"
}

L:SetWarningLocalization{
	WarningFlashFreeze		= "閃霜"
}

L:SetTimerLocalization{
	TimerFlashFreeze		= "閃霜 即將到來",
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "為閃霜的施放顯示計時器",
	WarningFlashFreeze		= "為閃霜顯示特別警告",
	PlaySoundOnFlashFreeze		= "當施放閃霜時播放音效",
	WarningStormCloud		= "提示風暴雷雲的目標",
	SetIconOnStormCloud		= "為風暴雷雲的目標設置標記"
}

L:SetMiscLocalization{
	YellKill			= "我…我終於從他的掌控中…解脫了。",
	YellCloud			= "我中了風暴雷雲 快接近我!",
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name 				= "索林姆"
}

L:SetWarningLocalization{
	WarningPhase2			= "第二階段",
	LightningOrb			= "你中了閃電震擊 - 快跑開"
}

L:SetTimerLocalization{
	TimerHardmode			= "困難模式"
}

L:SetOptionLocalization{
	TimerHardmode			= "為困難模式顯示計時器",
	WarningPhase2			= "提示第二階段",
	RangeFrame			= "顯示距離框",
	AnnounceFails			= "公佈中了閃電充能的玩家到團隊頻道(需要團隊隊長或助理權限)",
	LightningOrb			= "為閃電充能顯示特別警告"
}

L:SetMiscLocalization{
	YellPhase1			= "擅闖者!像你們這種膽敢干涉我好事的凡人將付出…等等--你……",
	YellPhase2			= "無禮的小輩，你竟敢在我的王座之上挑戰我?我會親手碾碎你們!",
	YellKill			= "住手!我認輸了!",
	ChargeOn			= "閃電充能: %s",
	Charge				= "中了閃電充能 (這一次): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name 				= "芙蕾雅"
}

L:SetMiscLocalization{
	SpawnYell			= "孩子們，協助我!",
	WaterSpirit			= "上古水之靈",
	Snaplasher			= "猛攫鞭笞者",
	StormLasher			= "風暴鞭笞者",
	YellKill			= "他對我的操控已然退散。我已再次恢復神智了。感激不盡，英雄們。"
}

L:SetWarningLocalization{
	WarnPhase2			= "第二階段",
	WarnSimulKill			= "第一隻元素死亡 - 大約12秒後復活",
	SpecWarnFury			= "你中了自然烈怒",
	WarningTremor			= "地面震顫 - 停止施法",
	WarnRoots			= "鐵之根鬚: >%s<",
	UnstableEnergy			= "不穩定的能量 - 快跑開"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam		= "太陽光束: %s",
	TimerSimulKill			= "復活",
	TrashRespawnTimer		= "芙蕾雅的小怪重生"
}

L:SetOptionLocalization{
	WarnPhase2			= "提示第二階段",
	WarnSimulKill			= "提示第一隻元素死亡",
	WarnRoots			= "提示鐵之根鬚的目標",
	SpecWarnFury			= "當你中了自然烈怒時顯示特別警告",
	WarningTremor			= "為地面震顫顯示特別警告 (困難模式)",
	PlaySoundOnFury			= "當你中了自然烈怒時播放音效",
	TimerSimulKill			= "為三元素復活顯示計時器",
	UnstableEnergy			= "當你中了不穩定的能量時顯示特別警告"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name 				= "芙蕾雅的長者們"
}

L:SetMiscLocalization{
	TrashRespawnTimer		= "芙蕾雅的小怪重生"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor		= "地面震顫 - 停止施法",
	SpecWarnFistOfStone		= "石拳連擊"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "為石拳連擊顯示特別警告",
	SpecWarnGroundTremor		= "當地面震顫時顯示特別警告",
	PlaySoundOnFistOfStone		= "當石拳連擊施放時播放音效",
	TrashRespawnTimer		= "為芙蕾雅的小怪重生顯示計時器"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name 				= "彌米倫"
}

L:SetWarningLocalization{
	MagneticCore			= ">%s< 拿到了磁能之核",
	WarningShockBlast		= "震爆 - 快跑開",
	WarnBombSpawn			= "炸彈機器人出現了"
}

L:SetTimerLocalization{
	TimerHardmode			= "困難模式 - 自毀程序",
	TimeToPhase2			= "第二階段開始",
	TimeToPhase3			= "第三階段開始",
	TimeToPhase4			= "第四階段開始"
}

L:SetOptionLocalization{
	DarkGlare			= "為P3Wx2雷射彈幕顯示特別警告",
	TimeToPhase2			= "為第二階段開始顯示計時器",
	TimeToPhase3			= "為第三階段開始顯示計時器",
	TimeToPhase4			= "為第四階段開始顯示計時器",
	MagneticCore			= "提示磁能之核的拾取者",
	HealthFramePhase4		= "顯示第四階段的首領血量框架",
	AutoChangeLootToFFA		= "第三階段自動轉換拾取方式為自由拾取",
	WarnBombSpawn			= "為炸彈機器人顯示警告",
	TimerHardmode			= "為困難模式顯示計時器",
	PlaySoundOnShockBlast		= "當震爆施放時播放音效",
	PlaySoundOnDarkGlare		= "當P3Wx2雷射彈幕施放前播放音效",
	ShockBlastWarningInP1		= "為第一階段的震爆顯示特別警告",
	ShockBlastWarningInP4		= "為第四階段的震爆顯示特別警告"
}

L:SetMiscLocalization{
	MobPhase1			= "戰輪MK II",
	MobPhase2			= "VX-001",
	MobPhase3			= "空中指揮裝置",
	YellPull			= "我們沒有太多時間，朋友們!你們要幫我測試我最新也是最偉大的創作。在你們改變心意之前，別忘了就是你們把XT-002搞得一團糟，你們欠我一次。",
	YellHardPull			= "為什麼你要做出這種事?難道你沒看見標示上寫著「請勿觸碰這個按鈕!」嗎?現在自爆裝置已經啟動了，我們要怎麼完成測試呢?",
	YellPhase2			= "太好了!絕妙的良好結果!外殼完整度98.9%!幾乎只有一點擦痕!繼續下去。",
	YellPhase3			= "感謝你，朋友們!我們的努力讓我獲得了一些絕佳的資料!現在，我把東西放在哪兒了--噢，在這裡。",
	YellPhase4			= "初步測試階段完成。現在要玩真的啦!",
	LootMsg				= "(.+)拾取了物品:.*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name 				= "威札斯將軍"
}

L:SetTimerLocalization{
	hardmodeSpawn 			= "薩倫聚惡體 出現"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "你中了暗影暴擊 - 快跑開",
	SpecialWarningSurgeDarkness	= "暗鬱奔騰",
	WarningShadowCrash		= "暗影暴擊: >%s<",
	SpecialWarningShadowCrashNear	= "你附近有人中暗影暴擊 - 快遠離",
	WarningLeechLife		= "無面者印記: >%s<",
	SpecialWarningLLYou		= "你中了無面者印記 - 快跑開",
	SpecialWarningLLNear		= "你附近的%s中了無面者印記"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "提示暗影暴擊的目標",
	SetIconOnShadowCrash		= "為暗影暴擊的目標設置標記 (頭顱)",
	SetIconOnLifeLeach		= "為無面者印記的目標設置標記 (十字)",
	SpecialWarningSurgeDarkness	= "為暗鬱奔騰顯示特別警告",
	SpecialWarningShadowCrash	= "為暗影暴擊顯示特別警告",
	SpecialWarningShadowCrashNear	= "當你附近的人中了暗影暴擊時顯示特別警告",
	SpecialWarningLLYou		= "當你中了無面者印記時顯示特別警告",
	SpecialWarningLLNear		= "當你附近的人中了無面者印記時顯示特別警告",
	CrashWhisper			= "密語提示暗影暴擊的目標",
	YellOnLifeLeech			= "當你中了無面者印記時大喊",
	YellOnShadowCrash		= "當你中了暗影暴擊時大喊",
	WarningLeechLife		= "提示無面者印記的目標",
	hardmodeSpawn			= "為薩倫聚惡體出現顯示計時器 (困難模式)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "一片薩倫煙霧在附近聚合",
	CrashWhisper			= "你中了暗影暴擊 - 快跑開",
	YellLeech			= "我中了無面者印記 - 遠離我",
	YellCrash			= "我中了暗影暴擊 - 遠離我"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name 				= "尤格薩倫"
}

L:SetMiscLocalization{
	YellPull 			= "我們即將有機會打擊怪物的首腦!現在將你的憤怒與仇恨貫注在他的爪牙上!",
	YellPhase2			= "我是清醒的夢境。",
	Sara 				= "薩拉",
	WhisperBrainLink 		= "你中了腦波連結 - 跑向 %s",
	WarningYellSqueeze		= "我被觸手抓住了 - 快救我",
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "尤格薩倫守護者 出現了",
	WarningCrusherTentacleSpawned	= "粉碎觸手 出現了",
	WarningP2 			= "第二階段",
	WarningP3 			= "第三階段",
	WarningBrainLink 		= "腦波連結: >%s< 和 >%s<",
	SpecWarnBrainLink 		= "你和%s中了腦波連結",
	WarningSanity 			= "剩下 %d 理智",
	SpecWarnSanity 			= "剩下 %d 理智",
	SpecWarnGuardianLow		= "停止攻擊這隻守護者",
	WarnMadness			= "正在施放 瘋狂誘陷",
	SpecWarnMadnessOutNow		= "瘋狂誘陷即將結束 - 快傳送出去",
	WarnBrainPortalSoon		= "3秒後 腦部傳送門",
	SpecWarnFavor			= "你中了薩拉的熱誠",
	WarnEmpowerSoon			= "暗影信標 即將到來",
	SpecWarnMaladyNear		= "你附近的>%s<中了心靈缺陷",
	SpecWarnDeafeningRoar		= "震耳咆哮",
	specWarnBrainPortalSoon		= "腦部傳送門 即將到來"
}

L:SetTimerLocalization{
	NextPortal			= "下一次 傳送門"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "為尤格薩倫守護者出現顯示警告",
	WarningCrusherTentacleSpawned	= "為粉碎觸手出現顯示警告",
	WarningP2			= "提示第二階段",
	WarningP3			= "提示第三階段",
	WarningBrainLink		= "提示腦波連結的目標",
	SpecWarnBrainLink		= "當你中了腦波連結時顯示特別警告",
	WarningSanity			= "當理智剩下50時顯示警告",
	SpecWarnSanity			= "當理智過低(25,15,5)時顯示特別警告",
	SpecWarnGuardianLow		= "當守護者(P1)血量過低時顯示特別警告 (DD用)",
	WarnMadness			= "為瘋狂誘陷顯示警告",
	WarnBrainPortalSoon		= "為腦部傳送門顯示預先警告",
	SpecWarnMadnessOutNow		= "為瘋狂誘陷結束前顯示特別警告",
	SetIconOnFearTarget		= "為心靈缺陷的目標設置標記 (頭顱)",
	SpecWarnFavor			= "當你中了薩拉的熱誠時顯示特別警告",
	specWarnBrainPortalSoon		= "為下一次 腦部傳送門顯示特別警告",
	WarningSqueeze			= "當你中了壓榨 (觸手綁人)時大喊",
	NextPortal			= "為下一次 傳送門顯示計時器",
	WhisperBrainLink		= "密語提示腦波連結的目標",
	SetIconOnFavorTarget		= "為薩拉的熱誠的目標設置標記 (三角)",
	SetIconOnMCTarget		= "為支配心靈的目標設置標記 (三角)",
	ShowSaraHealth			= "顯示薩拉在P1的血量 (需要最少一名團隊成員的目標是薩拉)",
	WarnEmpowerSoon			= "為暗影信標顯示預先警告",
	SpecWarnMaladyNear		= "當你附近的人中了心靈缺陷時顯示特別警告",
	SpecWarnDeafeningRoar		= "當施放震耳咆哮時顯示特別警告 (沉默和橘錘用!)",
	SetIconOnBrainLinkTarget	= "為腦波連結的目標設置標記"
}