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
	YellPull		= "적대적인 존재 감지. 위협 수준 평가 체제 가동. 주 목표물과 교전. 위협 수준 재평가까지 30초.",
	Emote			= "%%s 추적중 (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn		= "추적중! >%s<!",
	PursueWarn				= "추적 경고",	
	warnNextPursueSoon		= "추적 전환 5 초전",
	SpecialPursueWarnYou	= "거대 화염전차가 당신을 추적합니다!",	
	SystemOverload			= "시스템 과부화"	
}

L:SetOptionLocalization{
	timerSystemOverload		= "시스템 과부화 타이머 보기",
	timerFlameVents			= "화염 분출 타이머 보기",
	timerPursued			= "추적 타이머 보기",
	SystemOverload			= "시스템 과부화 특수 경고 보기",
	SpecialPursueWarnYou	= "추적자 특수 경보 보기",
	PursueWarn				= "추적 플레이어 레이드 경보로 보기",
	warnNextPursueSoon		= "다음 추적 경고"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "용광로 군주 이그니스"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "화염 분사",
	TimerFlameJetsCooldown	= "다음 화염 분사",
	TimerScorch				= "다음 불태우기",
	TimerScorchCast			= "불태우기",
	TimerSlagPot			= "용암재 단지 : %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= ">%s< 에게 용암재 단지",
	SpecWarnJetsCast		= "분사 - 시전 중지"
}

L:SetOptionLocalization{
	SpecWarnJetsCast			= "화염 분사 시전의 특수 경보 보기(counterspell)",
	TimerFlameJetsCast			= "화염 분사 시전 타이머 보기",
	TimerFlameJetsCooldown		= "화염 분사 쿨다운 타이머 보기",
	TimerScorch					= "불태우기 쿨다운 타이머 보기",
	TimerScorchCast				= "불태우기 시전 타이머 보기",
	WarningSlagPot				= "용암재 단지 대상 알리기",
	TimerSlagPot				= "용암재 단지 타이머 보기",
	SlagPotIcon					= "용암재 단지 대상 아이콘(징표) 설정"	
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "칼날비늘"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "활활 타오르는 화염 - 이동! 이동! 이동!",
	SpecWarnDevouringFlameCast	= "당신에게 활활 타오르는 화염!",
	WarnDevouringFlameCast		= ">%s< 에게 활활 타오르는 화염", 	
	warnTurretsReadySoon		= "20초 후 4번째 포탑 준비",
	warnTurretsReady			= "4번째 포탑 준비"
	
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "다음 화염 숨결",
	timerDeepBreathCast			= "화염 숨결",
	timerAllTurretsReady		= "포탑"	
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "다음 화염 숨결 타이머 보기",
	timerDeepBreathCast			= "화염 숨결 시전 타이머 보기",
	SpecWarnDevouringFlame		= "활활 타오르는 화염 대상 특수 경보 보기",
	SpecWarnDevouringFlameCast	= "활활 타오르는 화염 시전 경보 보기",	
	PlaySoundOnDevouringFlame	= "활활 타오르는 화염의 데미지를 받을 때 사운드 재생",
	timerAllTurretsReady		= "포탑 타이머 보기",
	warnTurretsReadySoon		= "포탑 사전 경보 보기",
	warnTurretsReady			= "포탑 경보 보기",
	WarnDevouringFlameCast      	= "활활 타오르는 화염 시전 경보 보기", 	
}

L:SetMiscLocalization{
	YellAir 						= "저희에게 잠깐 포탑을 설치할 시간을 주세요.",
	FlamecastUnknown			= "UNKNOWN"
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
	SpecialWarningLightBomb	 	= "당신에게 빛의 폭탄",
	WarningLightBomb			= ">%s< 에게 빛의 폭탄",
	SpecialWarningGravityBomb	= "당신에게 중력 폭탄",
	WarningGravityBomb			= ">%s< 에게 중력 폭탄",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "당신이 빛의 폭탄에 영향을 받을 때 특수 경고 보기",
	WarningLightBomb			= "빛의 폭탄 알리기",
	SpecialWarningGravityBomb	= "당신이 중력 폭탄에 영향을 받을 때 특수 경고 보기",
	WarningGravityBomb			= "중력 폭탄 알리기",
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
	WarningSupercharge			= "전력 충전 시전",
	WarningChainlight			= "연쇄 번개",
	WarningFusionPunch			= "융해의 주먹",
	WarningOverwhelmingPower	= ">%s< 에게 압도적인 힘",
	WarningRuneofPower			= "마력의 룬",
	WarningRuneofDeath			= "죽음의 룬",
	WarningRuneofSummoning		= "소환의 룬",	
	RuneofDeath					= "죽음의 룬 - 이동! 이동! 이동!",
	LightningTendrils			= "번개 덩굴 - 느리면 푹!찍! 이동!",	
}

L:SetTimerLocalization{
	TimerSupercharge			= "전력 충전",  -- gives the other bosses more power
	TimerOverload				= "고전압",
	TimerLightningWhirl			= "번개 소용돌이",
	TimerLightningTendrils		= "번개 덩굴",
	timerFusionPunchCast		= "융합 주먹 시전",
	timerFusionPunchActive		= "융합 주먹 : %s",
	timerOverwhelmingPower		= "압도적인 힘 : %s",
	timerRunicBarrier			= "방어막의 룬",
	timerRuneofDeath			= "죽음의 룬",	
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
	WarningOverwhelmingPower	= "압도적인 힘 알리기",
	timerOverwhelmingPower		= "압도적인 힘 타이머 보기",
	SetIconOnOverwhelmingPower	= "압도적인 힘 대상 아이콘 설정",
	timerRunicBarrier			= "방어막의 룬 타이머 보기",
	WarningRuneofPower			= "마력의 룬 알리기",
	WarningRuneofDeath			= "죽음의 룬 알리기",
	WarningRuneofSummoning		= "소환의 룬 알리기",	
	RuneofDeath					= "죽음의 룬 특수 경고 보기",
	timerRuneofDeath			= "죽음의 룬 지속 타이머 보기",
	PlaySoundDeathRune			= "죽음의 룬일 때 소리 재생"	
}

L:SetMiscLocalization{
	Steelbreaker				= "강철파괴자",
	RunemasterMolgeim 			= "룬술사 몰가임",
	StormcallerBrundir 			= "폭풍소환사 브룬디르",
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
	WarningBlackHole	= "블랙 홀",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Show Castbar for Big Bang",
	SpecWarnPhasePunch	= "Show Special Warning when Phase Punch on you",
	WarningPhasePunch	= "Announce Phase Punch target",
	WarningBlackHole	= "블랙 홀 알리기",
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
	WarnGrip				= ">%s< 에게 바위 손아귀"
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
	WarnGrip				= "바위 손아귀 대상 알리기",
	SetIconOnGripTarget		= "바위 손아귀 대상 아이콘 설정",
	timerLeftArm			= "왼쪽 팔 재생성 타이머 보기",	
	timerRightArm			= "오른쪽 팔 재생성 타이머 보기"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "얕은 상처야!",
	Yell_Trigger_arm_right		= "꽉꽉 쥐어짜 주마!"
}

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "아우리아야"
}

L:SetMiscLocalization{
	Defender = "야생 수호자 (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast 		= "수호자의 폭파 - 차단!",
	SpecWarnVoid		= "공허의 지대 - 이동!",	
	WarnCatDied 			= "야생의 수호자 죽음 (%d 번 남음)",
	WarnCatDiedOne 		= "야생의 수호자 죽음 (1 번 남음)",	
	WarnFear 			= "공포!",
	WarnFearSoon 		= "곧 다음 공포",
	WarnSonic			= "날카로운 음파!",
	WarnSwarm			= ">%s< 에게 무리의 수호자"
}

L:SetOptionLocalization{
	SpecWarnBlast 		= "수호자의 폭파 특수 경고 보기",
	SpecWarnVoid		= "공허의 지대에 서있을 경우 특수 경보 보기",	
	WarnFear 			= "공포 경보 보기",
	WarnFearSoon		= "공포 시전 전에 경보 보기",
	WarnCatDied 			= "남은 야생의 수호자 경보 보기",
	WarnCatDiedOne 		= "마지막 야생의 수호자 경보 보기(1 번 남음)",		
	WarnSwarm			= "무리의 수호자 대상 경보 보기",
	WarnSonic			= "날카로운 음파 경보 보기"
}


-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "순간 빙결",
	WarningBitingCold	= "매서운 추위 - 움직이세요!"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "순간 빙결 시전",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "순간 빙결 시전 타이머 보기",
	WarningFlashFreeze	= "순간 빙결 경보 보기",
	WarningBitingCold	= "매서운 추위 경보 보기",
	PlaySoundOnFlashFreeze	= "순간 빙결 시전일 때 사운드 재생"	
}

L:SetMiscLocalization{
	YellKill		= "드디어... 드디어 그의 손아귀를... 벗어나는구나."
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
	WarningBomb				= "룬 폭파 알리기",	
	RangeFrame				= "거리 창 보기",
	LightningOrb 			= "번개 충격 알리기"	
}

L:SetMiscLocalization{
	YellPhase1		= "침입자라니! 감히 내 취미 생활을 방해하는 놈들은 쓴맛을 단단히... 잠깐... 너는...",
	YellPhase2		= "건방진 젖먹이 같으니... 감히 여기까지 기어올라와 내게 도전해? 내 손으로 쓸어버리겠다!",
	YellKill		= "무기를 거둬라! 내가 졌다!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetMiscLocalization{
	SpawnYell		 = "얘들아, 날 도와라!",
	WaterSpirit		 = "고대 물의 정령",
	Snaplasher 		= "악어덩굴손",
	StormLasher 		= "폭풍덩굴손",
	EmoteTree		= "|cFF00FFFF생명의 어머니의 선물|r이 자라기 시작합니다!", -- /chatlog does not log messages with color codes...lol
	YellKill		= "내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다."	
}

L:SetWarningLocalization{
	WarnPhase2 			= "2 페이즈",
	WarnSimulKill		= "첫번째 애드 죽음 - 1분 후 부활",
	WarnFury 			= ">%s< 에게 자연의 분노",
	SpecWarnFury 		= "당신에게 자연의 분노!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam 	= "태양 광선: %s",
	TimerAlliesOfNature		= "자연 조화 쿨다운",
	TimerSimulKill 			= "부활",
	TimerFuryYou 			= "당신에게 자연의 분노"
}

L:SetOptionLocalization{
	TimerAlliesOfNature 		= "자연의 조화 타이머 보기",
	TimerSimulKill 			= "부활 타이머 보기",
	TimerFuryYou 			= "자연의 분노 타이머 보기",
	WarnPhase2 				= "2 페이즈 경고 보기",
	WarnSimulKill			= "부활 경고 보기",
	WarnFury 				= "자연의 분노 경고 보기",
	SpecWarnFury 			= "자연의 분노 특수 경고 보기"
}

-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	DarkGlare			= "레이저 탄막",
	WarningPlasmaBlast	= "%s 에게 플라즈마 폭발 - 폭힐! 폭힐!",
	Phase2Engaged		= "곧 2 페이즈 - 지금 자리 잡으세요.",
	Phase3Engaged		= "곧 3 페이즈 - 지금 자리 잡으세요.",	
	WarnShell			= ">%s< 에게 네이팜 탄!",
	WarnBlast			= ">%s< 에게 플라즈마 폭발!",
	MagneticCore		= ">%s< 자기 증폭기를 획득했습니다.",
	WarningShockBlast	= "충격파 - 움직이세요!"	
}

L:SetTimerLocalization{
	ProximityMines			= "새로운 접근 지뢰",
	TimeToPhase2			= "2 페이즈 시작",
	TimeToPhase3			= "3 페이즈 시작",	
}


L:SetOptionLocalization{
	ProximityMines			= "접근 지뢰 알리기",
	DarkGlare 				= "레이저 탄막 알리기",
	WarningPlasmaBlast		= "플라즈마 폭발 알리기",	
	WarningShockBlast		= "충격파 알리기",
	PlaySoundOnShockBlast 	= "충격파 특수 사운드 경보 재생",
	PlaySoundOnDarkGlare 	= "레이저 탄막 대상 특수 사운드 경보 재생",	
	NextDarkGlare 			= "다음 레이저 탄막",
	TimeToPhase2			= "페이즈 2 시작",
	TimeToPhase3			= "페이즈 3 시작",
	MagneticCore			= "자기 증폭기 획득자 알리기",
	WarnShell				= "네이팜 탄 대상 알리기",
	WarnBlast				= "플라즈마 폭발 대상 알리기",	
	HealthFramePhase4		= "페이즈 4 의 체력 프레임 보기"	
}

L:SetMiscLocalization{
	YellPull		= "시간이 없어, 친구들! 내가 최근에 만든 기막힌 발명품을 시험하게 도와 주겠지? 자, 마음 바꿀 생각은 말라고. XT-002를 그 꼬락서니로 만들었으니, 너흰 나한테 빚진 셈이란 걸 잊지 마!",	
	YellPhase2		= "멋지군! 참으로 경이적인 결과야! 차체 내구도 98.9 퍼센트라! 손상이라고 보기도 어렵지! 계속하자고.",
	YellPhase3		= "고맙다, 친구들! 너희 덕분에 멋진 자료를 좀 얻었어! 자, 그걸 어디 뒀더라... 아, 여기 있군.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)",
	MobPhase1 		= "거대 전차 Mk II",
	MobPhase2 		= "VX-001",
	MobPhase3 		= "공중지휘기"
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "당신에게 어둠 붕괴",
	SpecialWarningSurgeDarkness		= "어둠 쇄도",
	WarningShadowCrash				= ">%s< 에게 어둠 붕괴!",
	SpecialWarningLLYou				= "당신에게 얼굴 없는 자의 징표!",
	SpecialWarningLLNear			= "%s 에게 가까운 당신에게 생명력 흡수 시전!"	
}

L:SetTimerLocalization{
	timerSurgeofDarkness			= "어둠 쇄도"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "어둠 붕괴의 특수 경보 보기",
	SetIconOnShadowCrash			= "어둠 붕괴 대상 표시하기(해골 징표)",
	SetIconOnLifeLeach				= "얼굴 없는 자의 징표 대상 아이콘 설정 (엑스 징표)",
	SpecialWarningSurgeDarkness		= "어둠 쇄도 특수 경고 보기",
	SpecialWarningShadowCrash		= "어둠 붕괴 특수 경고 보기",
	SpecialWarningLLYou				= "얼굴 없는 자의 징표 특수 경보 보기",
	SpecialWarningLLNear			= "생명력 흡수 주변 특수 경보 보기",
	CrashWhisper					= "어둠 붕괴 대상에게 귓속말 보내기"	
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "가까운 사로나이트 증기 구름이 합쳐집니다!",
	CrashWhisper			= "당신에게 어둠 붕괴! 뛰세요!"	
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 			= "나는, 살아 있는 꿈이다.",
	Sara 				= "사라",
	WhisperBrainLink 	= "당신에게 두뇌의 고리! %s 에게 뛰세요!",
	WarningYellSqueeze	= "압착의 촉수에 붙잡혔어요! 살려주세요!"	
}

L:SetWarningLocalization{
	WarningGuardianSpawned 	= "요그사론의 수호자 소환!",
	WarningP2 				= "2 페이즈",
	WarningP3 				= "3 페이즈",	
	WarningBrainLink 		= ">%s< 그리고 >%s< 두뇌의 고리",
	SpecWarnBrainLink		= "당신 그리고 %s 에게 두뇌의 고리!",
	WarningSanity 			= "%d Sanity debuffs remaining",
	SpecWarnSanity 			= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow 		= "Stop attacking this Guardian!",
	WarnMadness 				= "Casting Induce Madness",
	SpecWarnMadnessOutNow	= "Madness ends - MOVE OUT",
	WarnBrainPortalSoon		= "3 초 후 포탈",	
	WarnSqueeze 				= "Squeeze: >%s<"
}

L:SetTimerLocalization{
	NextPortal			= "다음 차원문",
}

L:SetOptionLocalization{
	WarningGuardianSpawned	= "요그사론의 수호자 소환 알리기",
	WarningP2				= "2 페이즈 알리기",
	WarningP3				= "3 페이즈 알리기",	
	WarningBrainLink		= "두뇌의 고리 알리기",
	SpecWarnBrainLink		= "두뇌의 고리 특수 경고 보기",
	WarningSanity			= "Show Warning when Sanity low",
	SpecWarnSanity			= "Show Special Warning when Sanity very low",
	SpecWarnGuardianLow		= "Show Special Warning when Guardian (P1) is low (for DDs)",
	WarnMadness				= "광기 유발 알리기",
	WarnBrainPortalSoon		= "차원문 알리기",	
	SpecWarnMadnessOutNow	= "Show Special Warning shortly before Madness ends"
}
