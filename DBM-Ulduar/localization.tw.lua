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
}
	
L:SetMiscLocalization{
	YellPull			= "發現敵意實體。啟動威脅評估協定。首要目標接近中。30秒後將再度評估。",
	Emote				= "%%s緊追(%S+)%。"
}

L:SetWarningLocalization{
	PursueWarn			= "獵殺: >%s<",
	warnNextPursueSoon		= "5秒後 獵殺轉換",
	SpecialPursueWarnYou		= "你中了獵殺 - 快跑",
	warnWardofLife			= "生命結界 出現"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou		= "當你中了獵殺時顯示特別警告",
	PursueWarn			= "提示獵殺的目標",
	warnNextPursueSoon		= "為下一次 獵殺顯示預先警告",
	warnWardofLife			= "為生命結界 出現顯示特別警告"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name 				= "『火爐之主』伊格尼司"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63477)
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name 				= "銳鱗"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "20秒後 最後一座砲塔完成",
	warnTurretsReady		= "最後一座砲塔已完成",
	SpecWarnDevouringFlameCast	= "你中了吞噬烈焰",
	WarnDevouringFlameCast		= "吞噬烈焰: >%s<"
}
L:SetTimerLocalization{
	timerTurret1			= "砲塔1",
	timerTurret2			= "砲塔2",
	timerTurret3			= "砲塔3",
	timerTurret4			= "砲塔4",
	timerGrounded			= "地上階段"
}
L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "當你中了$spell:64733時顯示特別警告",
	warnTurretsReadySoon		= "為砲塔顯示預先警告",
	warnTurretsReady		= "為砲塔顯示警告",
	SpecWarnDevouringFlameCast	= "當你中了$spell:64733時顯示特別警告",
	timerTurret1			= "為砲塔1顯示計時器",
	timerTurret2			= "為砲塔2顯示計時器",
	timerTurret3			= "為砲塔3顯示計時器 (25人)",
	timerTurret4			= "為砲塔4顯示計時器 (25人)",
	OptionDevouringFlame		= "提示$spell:64733的目標 (不準確)",
	timerGrounded			= "為地上階段顯示計時器"
}

L:SetMiscLocalization{
	YellAir				= "給我們一點時間來準備建造砲塔。",
	YellAir2			= "火熄了!讓我們重建砲塔!",
	YellGround			= "快!她可不會在地面上待太久!",
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
}

L:SetOptionLocalization{

	SetIconOnLightBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65121),
	SetIconOnGravityBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64234)
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "鐵之集會所"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundLightningTendrils	= "為$spell:63486播放音效",
	SetIconOnOverwhelmingPower	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61888),
	SetIconOnStaticDisruption	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61912),
	AlwaysWarnOnOverload		= "總是對$spell:63481顯示警告(否則只有當目標是風暴召喚者的時候顯示)",
	PlaySoundOnOverload		= "當$spell:63481施放時播放音效",
	PlaySoundDeathRune		= "當$spell:63490施放時播放音效"
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
	PossibleNextCosmicSmash		= "下一次 宇宙潰擊",
	TimerCombatStart		= "戰鬥開始"
}
L:SetWarningLocalization{
	WarningPhasePunch		= "相位拳擊: >%s< - 第%d層",
	WarningCosmicSmash 		= "宇宙潰擊 - 約4秒後爆炸",
	WarnPhase2Soon			= "第2階段 即將到來",
	warnStarLow			= "崩陷之星血量低"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "提示相位拳擊的目標",
	NextCollapsingStar		= "為下一次 崩陷之星顯示計時器",
	WarningCosmicSmash 		= "為宇宙潰擊顯示警告",
	PossibleNextCosmicSmash		= "為下一次 宇宙潰擊顯示計時器",
	TimerCombatStart		= "為戰鬥開始顯示計時器",
	WarnPhase2Soon			= "為第2階段顯示預先警告 (大約23%)",
	warnStarLow			= "當崩陷之星血量低 (大約25%)時顯示特別警告"
}

L:SetMiscLocalization{
	YellPull			= "你的行為毫無意義。這場衝突的結果早已計算出來了。不論結局為何，萬神殿仍將收到觀察者的訊息。",
--	YellKill			= "我曾經看過塵世沉浸在造物者的烈焰之中，眾生連一聲悲泣都無法呼出，就此凋零。整個星系在彈指之間歷經了毀滅與重生。然而在這段歷程之中，我的心卻無法感受到絲毫的…惻隱之念。我‧感‧受‧不‧到。成千上萬的生命就這麼消逝。他們是否擁有與你同樣堅韌的生命?他們是否與你同樣熱愛生命?",
	Emote_CollapsingStar		= "%s開始召喚崩陷之星!",
	Phase2				= "瞧瞧泰坦造物的能耐吧!",
	PullCheck			= "艾爾加隆開始上傳滅世訊息的剩餘時間= (%d+)分鐘。"
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name 				= "柯洛剛恩"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm			= "左臂 重生",
	timerRightArm			= "右臂 重生",
	achievementDisarmed		= "卸除手臂 計時器"
}

L:SetOptionLocalization{
	timerLeftArm			= "為左臂重生顯示計時器",
	timerRightArm			= "為右臂重生顯示計時器",
	achievementDisarmed		= "為成就:卸除手臂顯示計時器",
	SetIconOnGripTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64292),
	SetIconOnEyebeamTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63346),
	PlaySoundOnEyebeam		= "為$spell:63346播放音效",
	YellOnBeam			= "當你中了$spell:63346時大喊"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "小小的擦傷!",
	Yell_Trigger_arm_right		= "只是皮肉之傷!",
	Health_Body			= "柯洛剛恩身體",
	Health_Right_Arm		= "右臂",
	Health_Left_Arm			= "左臂",
	FocusedEyebeam			= "正在注視著你",
	YellBeam			= "柯洛剛恩正在注視我!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name 				= "奧芮雅"
}

L:SetMiscLocalization{
	Defender 			= "野性防衛者 (%d)",
	YellPull 			= "有些事情不該公諸於世!"
}

L:SetTimerLocalization{
	timerDefender			= "野性防衛者復活"
}

L:SetWarningLocalization{
	SpecWarnBlast			= "哨兵衝擊 - 現在斷法",
	WarnCatDied 			= "野性防衛者倒下 (剩餘%d隻)",
	WarnCatDiedOne 			= "野性防衛者倒下 (剩下最後一隻)"
}

L:SetOptionLocalization{
	SpecWarnBlast			= "為哨兵衝擊顯示特別警告 (斷法用)",
	WarnCatDied			= "當野性防衛者死亡時顯示警告",
	WarnCatDiedOne			= "當野性防衛者剩下最後一隻時顯示警告",
	timerDefender       		= "當野性防衛者準備復活時顯示計時器"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name 				= "霍迪爾"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFlashFreeze		= "當施放$spell:61968時播放音效",
	YellOnStormCloud		= "當你中了$spell:65133時大喊",
	SetIconOnStormCloud		= "為$spell:65133的目標設置標記",
}

L:SetMiscLocalization{
	YellKill			= "我…我終於從他的掌控中…解脫了。",
	YellCloud			= "我中了風暴雷雲 快接近我!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name 				= "索林姆"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode			= "困難模式"
}

L:SetOptionLocalization{
	TimerHardmode			= "為困難模式顯示計時器",
	RangeFrame			= "顯示距離框",
	AnnounceFails			= "公佈中了閃電充能的玩家到團隊頻道\n(需要團隊隊長或助理權限)"
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
	YellKill			= "他對我的操控已然退散。我已再次恢復神智了。感激不盡，英雄們。",
	TrashRespawnTimer		= "芙蕾雅的小怪重生"
}

L:SetWarningLocalization{
	WarnSimulKill			= "第一隻元素死亡 - 大約12秒後復活"
}

L:SetTimerLocalization{
	TimerSimulKill			= "復活"
}

L:SetOptionLocalization{
	WarnSimulKill			= "提示第一隻元素死亡",
	PlaySoundOnFury			= "當你中了$spell:63571時播放音效",
	TimerSimulKill			= "為三元素復活顯示計時器"
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
}

L:SetOptionLocalization{
	PlaySoundOnFistOfStone		= "為石拳連擊播放音效",
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
	TimeToPhase2			= "第2階段開始",
	TimeToPhase3			= "第3階段開始",
	TimeToPhase4			= "第4階段開始"
}

L:SetOptionLocalization{
	TimeToPhase2			= "為第2階段開始顯示計時器",
	TimeToPhase3			= "為第3階段開始顯示計時器",
	TimeToPhase4			= "為第4階段開始顯示計時器",
	MagneticCore			= "提示磁能之核的拾取者",
	HealthFramePhase4		= "顯示第4階段的首領血量框架",
	AutoChangeLootToFFA		= "第3階段自動轉換拾取方式為自由拾取",
	WarnBombSpawn			= "為炸彈機器人顯示警告",
	TimerHardmode			= "為困難模式顯示計時器",
	PlaySoundOnShockBlast		= "當$spell:63631施放時播放音效",
	PlaySoundOnDarkGlare		= "當$spell:63414施放前播放音效",
	ShockBlastWarningInP1		= "為第1階段的$spell:63631顯示特別警告",
	ShockBlastWarningInP4		= "為第4階段的$spell:63631顯示特別警告",
	RangeFrame			= "在第1階段顯示距離框"
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
	SpecialWarningShadowCrashNear	= "你附近有人中暗影暴擊 - 快遠離",
	SpecialWarningLLNear		= "你附近的%s中了無面者印記"
}

L:SetOptionLocalization{
	SetIconOnShadowCrash		= "為$spell:62660的目標設置標記 (頭顱)",
	SetIconOnLifeLeach		= "為$spell:63276的目標設置標記 (十字)",
	SpecialWarningShadowCrash	= "為$spell:62660顯示特別警告(必須有最少一名團隊成員設置目標或專注目標)",
	SpecialWarningShadowCrashNear	= "當你附近的人中了$spell:62660時顯示特別警告",
	SpecialWarningLLNear		= "當你附近的人中了$spell:63276時顯示特別警告",
	YellOnLifeLeech			= "當你中了$spell:63276時大喊",
	YellOnShadowCrash		= "當你中了$spell:62660時大喊",
	hardmodeSpawn			= "為薩倫聚惡體出現顯示計時器 (困難模式)",
	CrashArrow			= "當你附近的人中了$spell:62660時顯示DBM箭頭",
	BypassLatencyCheck		= "不對$spell:62660使用同步延遲查詢\n(只有出現問題時才使用這個)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "一片薩倫煙霧在附近聚合",
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
	WarningYellSqueeze		= "我被觸手抓住了 - 快救我"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "尤格薩倫守護者 %d 出現了",
	WarningCrusherTentacleSpawned	= "粉碎觸手 出現了",
	WarningSanity 			= "剩下 %d 理智",
	SpecWarnSanity 			= "剩下 %d 理智",
	SpecWarnGuardianLow		= "停止攻擊這隻守護者",
	SpecWarnMadnessOutNow		= "瘋狂誘陷即將結束 - 快傳送出去",
	WarnBrainPortalSoon		= "3秒後 腦部傳送門",
	SpecWarnFervor			= "你中了薩拉的熱誠",
	SpecWarnFervorCast		= "薩拉的熱誠正在對你施放",
	SpecWarnMaladyNear		= "你附近的%s中了心靈缺陷",
	specWarnBrainPortalSoon		= "腦部傳送門 即將到來"
}

L:SetTimerLocalization{
	NextPortal			= "下一次 腦部傳送門"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "為尤格薩倫守護者出現顯示警告",
	WarningCrusherTentacleSpawned	= "為粉碎觸手出現顯示警告",
	WarningSanity			= "當理智剩下50時顯示警告",
	SpecWarnSanity			= "當理智過低(25,15,5)時顯示特別警告",
	SpecWarnGuardianLow		= "當守護者(第1階段)血量過低時顯示特別警告 (DD用)",
	WarnBrainPortalSoon		= "為腦部傳送門顯示預先警告",
	SpecWarnMadnessOutNow		= "為瘋狂誘陷結束前顯示特別警告",
	SetIconOnFearTarget		= "為心靈缺陷的目標設置標記 (頭顱)",
	SpecWarnFervor			= "當你中了薩拉的熱誠時顯示特別警告",
	SpecWarnFervorCast		= "當薩拉的熱誠正在對你施放時顯示特別警告 (必須有最少一名團隊成員設置目標或專注目標)",
	specWarnBrainPortalSoon		= "為下一次 腦部傳送門顯示特別警告",
	WarningSqueeze			= "當你中了壓榨 (觸手綁人)時大喊",
	NextPortal			= "為下一次 傳送門顯示計時器",
	SetIconOnFervorTarget		= "為薩拉的熱誠的目標設置標記 (三角)",
	SetIconOnMCTarget		= "為支配心靈的目標設置標記 (三角)",
	ShowSaraHealth			= "顯示薩拉在第1階段的血量 (必須有最少一名團隊成員設置目標或專注目標)",
	WarnEmpowerSoon			= "為暗影信標顯示預先警告",
	SpecWarnMaladyNear		= "當你附近的人中了心靈缺陷時顯示特別警告",
	MaladyArrow			= "當你附近的人中了$spell:63881時顯示DBM箭頭"
}