if GetLocale() ~= "koKR" then return end
local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "거대 화염전차"
}

L:SetTimerLocalization{
	timerPursued		= "추적: %s",
	timerFlameVents		= "화염 분출",
	timerSystemOverload	= "시스템 과부화"
}
	
L:SetMiscLocalization{
	YellPull		= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote			= "%%s 추적중 (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "추적중! >%s<!",
	warnNextPursueSoon	= "추적 전환 5 초전"
}

L:SetOptionLocalization{
	timerSystemOverload	= "시스템 과부화 타이머 보기",
	timerFlameVents		= "화염 분출 타이머 보기",
	timerPursued		= "추적 타이머 보기",
	SystemOverload		= "시스템 과부화 특수 경고 보기",
	SpecialPursueWarnYou	= "추적자 특수 경보 보기",
	PursueWarn		= "추적 플레이어 레이드 경보로 보기",
	warnNextPursueSoon	= "다음 추적 경고"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "용광로 군주 이그니스"
}

L:SetTimerLocalization{
	TimerFlameJetsCast	= "화염 분사",
	TimerFlameJetsCooldown	= "다음 화염 분사",
	TimerScorch		= "다음 불태우기",
	TimerScorchCast		= "불태우기",
	TimerSlagPot		= "잿가루 구덩이 : %s"
}

L:SetWarningLocalization{
	WarningSlagPot		= ">%s< 에게 잿가루 구덩이",
	SpecWarnJetsCast	= "분사 - 시전 중지"
}

L:SetOptionLocalization{
	SpecWarnJetsCast			= "화염 분사 시전의 특수 경보 보기(counterspell)",
	TimerFlameJetsCast			= "화염 분사 시전 타이머 보기",
	TimerFlameJetsCooldown		= "화염 분사 쿨다운 타이머 보기",
	TimerScorch					= "불태우기 쿨다운 타이머 보기",
	TimerScorchCast				= "불태우기 시전 타이머 보기",
	WarningSlagPot				= "잿가루 구덩이 대상 알리기",
	TimerSlagPot				= "잿가루 구덩이 타이머 보기",
	SlagPotIcon				= "잿가루 구덩이 대상 아이콘(징표) 설정"	
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "칼날비늘"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame	= "활활 타오르는 화염 - 이동! 이동! 이동!",
	warnTurretsReadySoon	= "Fourth Turret Ready in 20 Sec",
	warnTurretsReady		= "Fourth Turret Ready"
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "다음 화염 숨결",
	timerDeepBreathCast			= "화염 숨결",
	timerAllTurretsReady	= "Turrets"	
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "다음 화염 숨결 타이머 보기",
	timerDeepBreathCast			= "화염 숨결 시전 타이머 보기",
	SpecWarnDevouringFlame		= "활활 타오르는 화염 대상 특수 경보 보기",
	PlaySoundOnDevouringFlame	= "활활 타오르는 화염의 데미지를 받을 때 사운드 재생",
	timerAllTurretsReady		= "Show timer for turrets",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady			= "Show warning for turrets",	
}

L:SetMiscLocalization{
	YellAir = "Give us a moment to prepare to build the turrets."
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 해체자"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "당신에게 빛의 폭탄",
	WarningLightBomb		= ">%s< 에게 빛의 폭탄",
	SpecialWarningGravityBomb	= "당신에게 중력 폭탄",
	WarningGravityBomb		= ">%s< 에게 중력 폭탄",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "당신이 빛의 폭탄에 영향을 받을 때 특수 경고 보기",
	WarningLightBomb		= "빛의 폭탄 알리기",
	SpecialWarningGravityBomb	= "당신이 중력 폭탄에 영향을 받을 때 특수 경고 보기",
	WarningGravityBomb		= "중력 폭탄 알리기",
	PlaySoundOnGravityBomb		= "당신이 중력 폭탄일 때 소리 재생",
	PlaySoundOnTympanicTantrum	= "귀청이 찢어지는 소리일 때 소리 재생",
	SetIconOnLightBombTarget	= "빛의 폭탄 대상에게 공격대 아이콘 표시",
	SetIconOnGravityBombTarget	= "중력 폭탄 대상에게 공격대 아이콘 표시",
}

-------------------
--  무쇠 평의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "무쇠 평의회"
}

L:SetWarningLocalization{
	WarningSupercharge	= "과충전(보스 버프) 시전",
	WarningChainlight		= "연쇄 변개",
	WarningFusionPunch		= "융합 주먹",
	WarningOverwhelmingPower	= "Overwhelming Power on >%s<",
	WarningRuneofPower		= "마력의 룬",
	WarningRuneofDeath		= "죽음의 룬",
	RuneofDeath			= "죽음의 룬 - 이동! 이동! 이동!",
	LightningTendrils		= "번개 촉수 - 느리면 푹!찍! 이동!",	
}

L:SetTimerLocalization{
	TimerSupercharge	= "과충전(보스 버프)",  -- gives the other bosses more power
	TimerOverload			= "과충전",
	TimerLightningWhirl		= "번개 소용돌이",
	TimerLightningTendrils		= "번개 촉수",
	timerFusionPunchCast		= "융합 주먹 시전",
	timerFusionPunchActive		= "융합 주먹 : %s",
	timerOverwhelmingPower		= "Overwhelming Power: %s",
	timerRunicBarrier		= "방어막의 룬",
	timerRuneofDeath		= "죽음의 룬",	
}

L:SetOptionLocalization{
	TimerSupercharge			= "과충전 타이머 보기",
	WarningSupercharge			= "과충전 시전 경보 보기",
	WarningChainlight			= "연쇄 번개 알리기",
	TimerOverload				= "과충전 시전 타이머 보기",
	TimerLightningWhirl			= "번개 소용돌이 시전 타이머 보기",
	LightningTendrils			= "번개 촉수 특수 경고 보기",
	TimerLightningTendrils		= "번개 촉수 지속 타이머 보기",
	PlaySoundLightningTendrils	= "번개 촉수일 때 소리 재생",
	WarningFusionPunch			= "융합 주먹 알리기",
	timerFusionPunchCast		= "융합 주먹 시전바 보기",
	timerFusionPunchActive		= "융합 주먹 타이머 보기",
	WarningOverwhelmingPower	= "Announce Overwhelming Power",
	timerOverwhelmingPower		= "Show Overwhelming Power timer",
	SetIconOnOverwhelmingPower	= "Set Icon on Overwhelming Power target",
	timerRunicBarrier			= "방어막의 룬 타이머 보기",
	WarningRuneofPower			= "마력의 룬 알리기",
	WarningRuneofDeath			= "죽음의 룬 알리기",
	RuneofDeath					= "죽음의 룬 특수 경고 보기",
	timerRuneofDeath			= "죽음의 룬 지속 타이머 보기",	
}

L:SetMiscLocalization{
	Steelbreaker		= "강철분쇄자",
	RunemasterMolgeim 	= "룬마스터 몰게임",
	StormcallerBrundir 	= "폭풍을 부르는 브룬디르",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "관찰자 알갈론"
}

L:SetTimerLocalization{
	TimerBigBangCast	= "Big Bang cast",
}
L:SetWarningLocalization{
	WarningPhasePunch	= "Phase Punch on >%s<",
	WarningBlackHole	= "Black Hole",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Show Castbar for Big Bang",
	SpecWarnPhasePunch	= "Show Special Warning when Phase Punch on you",
	WarningPhasePunch	= "Announce Phase Punch target",
	WarningBlackHole	= "Announce Black Hole",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "콜로간"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "당신에게 안광 - 빠르게 이동!",
	WarningEyebeam			= ">%s< 에게 안광 집중",
	WarnGrip				= "Grip on >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "안광 : %s",
	timerPetrifyingBreath	= "석화 숨결",
	timerNextShockwave		= "다음 충격파",
	timerLeftArm			= "왼쪽 팔 재생성",
	timerRightArm			= "오른쪽 팔 재생성"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "당신에게 안광 집중이 될 때 특수 경고 보기",
	WarningEyebeam			= "안광 집중 대상 알리기",
	timerEyebeam			= "안광 집중 타이머 보기",
	SetIconOnEyebeamTarget	= "안광 집중 대상 아이콘 설정",
	timerPetrifyingBreath	= "석화 숨결 타이머 보기",
	timerNextShockwave		= "충격파 타이머 보기",
	timerLeftArm			= "왼쪽 팔 재생성 타이머 보기",
	timerRightArm			= "오른쪽 팔 재생성 타이머 보기"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!"
}

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriya")

L:SetGeneralLocalization{
	name = "아우리아야"
}

L:SetMiscLocalization{
	Defender = "야생 수호자 (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast = "수호자의 폭파 - 차단!",
	WarnCatDied = "야생의 수호자 죽음 (생명력 %d 남음)",
	WarnFear = "공포!",
	WarnFearSoon = "곧 다음 공포",
	WarnSonic		= "Sonic Screech!",
	WarnSwarm		= "Guardian Swarm on >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast = "수호자의 폭파 특수 경고 보기",
	WarnFear = "공포 경보 보기",
	WarnFearSoon = "공포 시전 전에 경보 보기",
	WarnCatDied = "야생 수호자가 죽었을 때 경보 보기",
	WarnSwarm		= "Show Warning on Guardian Swarm",
	WarnSonic		= "Show Sonic Screech Warning"
}


-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "급속 결빙",
	WarningBitingCold	= "살을 애는 추위 - 움직이세요!"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "급속 결빙 시전",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "급속 결빙 시전 타이머 보기",
	WarningFlashFreeze	= "급속 결빙 경보 보기",
	WarningBitingCold	= "Show warning for Biting Cold",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast"	
}

L:SetMiscLocalization{
	
}


--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "토림"
}

L:SetWarningLocalization{
	WarningStormhammer	= "%s 에게 폭풍망치",
	UnbalancingStrike	= ">%s< 에게 넘어트리는 일격",
	WarningPhase2		= "2 페이즈",
	WarningBomb			= ">%s< 에게 룬 폭파",
	LightningOrb 		= "당신은 번개 충격 범위! 이동하세요!"
}

L:SetTimerLocalization{
	TimerStormhammer		= "폭풍망치 쿨다운",
	TimerUnbalancingStrike	= "넘어트리는 일격 쿨다운",
	TimerHardmode			= "하드 모드"
}

L:SetOptionLocalization{
	TimerStormhammer		= "폭풍망치 쿨다운 보기",
	TimerUnbalancingStrike	= "넘어트리는 일격 타이머 보기",
	TimerHardmode			= "하드 모드를 위한 타이머 보기",
	UnbalancingStrike		= "넘어트리는 일격 타겟 알리기",
	WarningStormhammer		= "폭풍망치 타겟 알리기",
	WarningPhase2			= "2 페이즈 알리기",
	UnbalancingStrike		= "Announce Unbalancing Strike",
	WarningBomb				= "Announce Rune Detonation",	
	RangeFrame				= "거리 창 보기"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetMiscLocalization{
	SpawnYell = "Children, assist me!",
	WaterSpirit = "고대 물의 정령",
	Snaplasher = "철썩채찍",
	StormLasher = "폭풍 채찍",
	EmoteTree	= "???" -- /chatlog does not log messages with color codes...lol
}

L:SetWarningLocalization{
	WarnPhase2 = "2 페이즈",
	WarnSimulKill = "첫번째 애드 죽음 - 1분 후 부활",
	WarnFury = ">%s< 에게 자연의 분노",
	SpecWarnFury = "당신에게 자연의 분노!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam = "태양 광선: %s",
	TimerAlliesOfNature = "자연 조화 쿨다운",
	TimerSimulKill = "부활",
	TimerFuryYou = "당신에게 자연의 분노"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	DarkGlare		= "Laser Barrage",
	WarningPlasmaBlast	= "%s 에게 플라즈마 폭발 - 폭힐! 폭힐!",
	Phase2Engaged		= "곧 2 페이즈 - 지금 재 그룹 하세요.",
	Phase3Engaged		= "곧 3 페이즈 - 지금 재 그룹 하세요.",	
	WarnShell			= "Napalm Shells on >%s<",
	WarnBlast			= "Plasma Blast on >%s<",
	MagneticCore		= ">%s< got Magnetic Core",
	WarningShockBlast	= "Shock Blast - MOVE AWAY"	
}

L:SetTimerLocalization{
	ProximityMines		= "새로운 접근 지뢰",
}

L:SetOptionLocalization{
	TimeToPhase2		= "페이즈 2 시작",
	TimeToPhase3		= "페이즈 3 시작",
	MagneticCore		= "Announce Magnetic Core looter",
	HealthFramePhase4	= "페이즈 4 의 체력 프레임 보기"	
}

L:SetMiscLocalization{
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",	
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "당신에게 그림자 충돌",
	SpecialWarningSurgeDarkness	= "밀려오는 어둠",
	WarningShadowCrash			= "당신에게 그림자 충돌!",
	specWarnLifeLeechYou		= "Life Leech on you!",
	specWarnLifeLeechNear		= "Life Leech on %s near you!"	
}

L:SetOptionLocalization{
	WarningShadowCrash			= "그림자 충돌의 특수 경보 보기",
	SetIconOnShadowCrash		= "그림자 충돌 대상 표시하기(해골)",
	SetIconOnLifeLeach			= "Set Icon on Life Leach target (cross)",
	SpecialWarningSurgeDarkness	= "밀려오는 어둠 특수 경고 보기",
	SpecialWarningShadowCrash	= "그림자 충돌 특수 경고 보기",
	SpecialWarningLLYou			= "Show Special Warning for Life Leach on YOU",
	SpecialWarningLLNear		= "Show Special Warning for Life Leach in near of you",
	CrashWhisper				= "그림자 충돌 대상에게 귓속말 보내기"	
	}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper			= "Shadow Crash on You! Run away!"	
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetMiscLocalization{
	YellPull = "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 = "I am the lucid dream.",
	Sara = "Sara",
	WhisperBrainLink = "Brain Link on you! Run to %s!",
}

L:SetWarningLocalization{
	WarningGuardianSpawned 	= "Guardian spawned",
	WarningP2 				= "Phase 2",
	WarningBrainLink 		= "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink		= "Brain Link on you and %s!",
	WarningSanity 			= "%d Sanity debuffs remaining",
	SpecWarnSanity 			= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow 		= "Stop attacking this Guardian!",
	WarnMadness 				= "Casting Induce Madness",
	SpecWarnMadnessOutNow	= "Madness ends - MOVE OUT"
}

L:SetOptionLocalization{
	WarningGuardianSpawned	= "Announce Guardian Spawns",
	WarningP2				= "Announce Phase 2",
	WarningBrainLink		= "Announce Brain Links",
	SpecWarnBrainLink		= "Show Special Warning when Brain Linked",
	WarningSanity			= "Show Warning when Sanity low",
	SpecWarnSanity			= "Show Special Warning when Sanity very low",
	SpecWarnGuardianLow		= "Show Special Warning when Guardian (P1) is low (for DDs)",
	WarnMadness				= "Announce Madness",
	SpecWarnMadnessOutNow	= "Show Special Warning shortly before Madness ends"
}


