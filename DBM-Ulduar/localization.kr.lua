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
}
	
L:SetMiscLocalization{
	YellPull				= "적대적인 존재 감지. 위협 수준 평가 체제 가동. 주 목표물과 교전. 위협 수준 재평가까지 30초.",
	Emote					= "%%s 추적중 (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "추적 >%s<!",	
	warnNextPursueSoon		= "추적 전환 5 초전",
	SpecialPursueWarnYou	= "거대 화염전차가 당신을 추적합니다!",	
	SystemOverload			= "시스템 과부화",
	warnWardofLife			= "생명지기 덩굴손 등장"
--	warnWrithingLasher		= "고뇌의 덩굴손 등장"	
}

L:SetOptionLocalization{
	SystemOverload			= "시스템 과부화 특수 경고 보기",
	SpecialPursueWarnYou	= "추적자 특수 경고 보기",
	PursueWarn				= "추적 플레이어 레이드 경고로 보기",
	warnNextPursueSoon		= "다음 추적 경고 보기",
	warnWardofLife			= "생명지기 덩굴손 등장 특수 경고 보기"
--	warnWrithingLasher		= "고뇌의 덩굴손 등장 특수 경고 보기"	
}

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "용광로 군주 이그니스"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningSlagPot			= ">%s< 에게 용암재 단지",
	SpecWarnJetsCast		= "화염 분출 - 시전 중지"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "화염 분출 시전의 특수 경고 보기",
	WarningSlagPot			= "용암재 단지 대상 알리기",
	SlagPotIcon				= "용암재 단지 대상 공격대 아이콘 설정"	
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "칼날비늘"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "파멸의 불길 - 이동! 이동! 이동!",
	SpecWarnDevouringFlameCast	= "당신에게 파멸의 불길!",
	WarnDevouringFlameCast		= "파멸의 불길 : >%s<", 	
	warnTurretsReadySoon		= "마지막 포탑 20초 전",
	warnTurretsReady			= "마지막 포탑 준비"	
}

L:SetTimerLocalization{
	timerTurret1			= "1 번째 포탑",
	timerTurret2			= "2 번째 포탑",
	timerTurret3			= "3 번째 포탑",
	timerTurret4			= "4 번째 포탑",
	timerGrounded			= "지상 착지",	
}

L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "파멸의 불길 대상 특수 경고 보기",
	SpecWarnDevouringFlameCast	= "파멸의 불길 대상이 되었을 때 특수 경고 보기",	
	PlaySoundOnDevouringFlame	= "파멸의 불길 데미지를 받을 때 사운드 재생",
	warnTurretsReadySoon		= "포탑 사전 경고 보기",
	warnTurretsReady			= "포탑 경고 보기",
	timerTurret1				= "첫번째 포탑 타이머 보기",
	timerTurret2				= "두번째 포탑 타이머 보기",
	timerTurret3				= "세번째 포탑 타이머 보기(25인)",
	timerTurret4				= "네번째 포탑 타이머 보기(25인)", 
	timerGrounded				= "지상 착지 유지 시간 보기",
	OptionDevouringFlame		= "파멸의 불길 대상 알리기 (부정확함)"
}

L:SetMiscLocalization{
	YellAir 			= "저희에게 잠깐 포탑을 설치할 시간을 주세요.",
	YellAir2			= "불꽃이 꺼졌습니다! 포탑을 재설치합시다!",	
	YellGround			= "움직이세요! 오래 붙잡아둘 순 없을 겁니다!",
--	EmotePhase2			= "%%s이 완전히 땅에 내려앉았습니다!",	
	EmotePhase2			= "완전히 땅에 내려앉았습니다!",	
	FlamecastUnknown	= DBM_CORE_UNKNOWN
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
	SpecialWarningLightBomb	 		= "당신에게 타오르는 빛",
	SpecialWarningGravityBomb		= "당신에게 중력 폭탄",
	specWarnConsumption				= "공허의 지대! - 이동하세요!"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb			= "당신이 타오르는 빛의 영향을 받을 때 특수 경고 보기",
	SpecialWarningGravityBomb		= "당신이 중력 폭탄의 영향을 받을 때 특수 경고 보기",
	specWarnConsumption				= "공허의 지대로부터 데미지를 받을 경우 특수 경고 보기",	
	SetIconOnLightBombTarget		= "타오르는 빛 대상에게 공격대 아이콘 표시",
	SetIconOnGravityBombTarget		= "중력 폭탄 대상에게 공격대 아이콘 표시",
}

-------------------
--  무쇠 평의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "무쇠 평의회"
}

L:SetWarningLocalization{
	WarningSupercharge			= "전기 충전 시전",
	RuneofPower        			= "마력의 룬 : >%s<"	
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge				= "전기 충전 시전 경고 보기",
	AlwaysWarnOnOverload			= "과부하 일 때 지속적인 경고 알리기(타겟일 경우만)",
	PlaySoundOnOverload				= "과부화 일 때 소리 재생",	
	PlaySoundLightningTendrils		= "번개 덩굴일 때 소리 재생",
	PlaySoundDeathRune				= "죽음의 룬일 때 소리 재생",
	SetIconOnOverwhelmingPower		= "압도적인 힘 대상 아이콘 설정",
	SetIconOnStaticDisruption		= "전자기 붕괴 대상 타겟 아이콘 설정하기(하드 모드)",
	RuneofPower        				= "보스가 마력의 룬의 영향을 받을 경우 특수 경고 보기"	
}

L:SetMiscLocalization{
	Steelbreaker			= "강철파괴자",
	RunemasterMolgeim 		= "룬술사 몰가임",
	StormcallerBrundir 		= "폭풍소환사 브룬디르",
}

---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "관찰자 알갈론"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "다음 붕괴의 별",
	PossibleNextCosmicSmash	= "다음 우주의 강타",
	TimerCombatStart		= "전투 시작"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "위상의 주먹 : >%s< - %d 중첩",
	WarningBlackHole		= "블랙홀 폭발",
	SpecWarnBigBang			= "대 폭발!",
	PreWarningBigBang		= "대 폭발 10초 전!",
	WarningCosmicSmash 		= "우주의 강타 - 폭발 4초 전",
	SpecWarnCosmicSmash 	= "우주의 강타",
	WarnPhase2Soon			= "곧 2 페이즈",
	warnStarLow				= "붕괴의 별 체력 낮음"
}

L:SetOptionLocalization{
	PreWarningBigBang			= "대 폭발 사전(미리) 알리기",
	SpecWarnBigBang				= "대 폭발 특수 경고 알리기",	
	WarningPhasePunch			= "위상의 주먹 대상 알리기",
	WarningBlackHole			= "블랙 홀 알리기",
	NextCollapsingStar			= "다음 붕괴의 별 시전 타이머 보기",
	PossibleNextCosmicSmash		= "다음 우주의 강타 시전 타이머 보기",	
	WarningCosmicSmash 			= "우주의 강타 알리기",
	SpecWarnCosmicSmash 		= "우주의 강타 특수 경고 보기",
	TimerCombatStart			= "전투 시작 타이머 보기",
	WarnPhase2Soon				= "2 페이즈 사전 경고 보기(23% 이하)",
	warnStarLow					= "붕괴의 별 체력이 낮을 경우 특수 경고 보기(25% 이하)"
}

L:SetMiscLocalization{
	YellPull				= "너희 행동은 비논리적이다. 이 전투에서 가능한 결말은 모두 계산되었다. 결과와 상관없이 판테온은 관찰자의 전갈을 받을 것이다.",
	YellKill				= "나는 창조주의 불길이 씻어내린 세상을 보았다. 모두 변변히 저항도 못하고 사그라졌지. 너희 필멸자의 심장이 단 한번 뛸 시간에 전 행성계가 탄생하고 무너졌다. 그러나 그 모든 시간 동안, 나는 공감이란 감정을... 몰랐다. 나는, 아무것도, 느끼지, 못했다. 무수한, 무수한 생명이 꺼졌다. 그들이 모두 너희처럼 강인했더냐? 그들이 모두 너희처럼 삶을 사랑했단 말이냐?",	
--	Emote_CollapsingStar	= "%s에게 붕괴의 별을 시전 합니다!",
	Emote_CollapsingStar	= "붕괴의 별을 시전 합니다!",
	Phase2					= "창조의 도구를 바라보아라!",
	PullCheck				= "(%d+)분 후에 알갈론이 신호 전송을 시작합니다."	
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
	WarnGrip				= ">%s< 에게 바위 손아귀",
	SpecWarnCrunchArmor2	= "방어구 씹기 중첩 : >%d<"	
}

L:SetTimerLocalization{
	timerLeftArm			= "왼쪽 팔 재생성",
	timerRightArm			= "오른쪽 팔 재생성",
	achievementDisarmed		= "무장해제 업적"	
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "당신에게 안광 집중이 될 때 특수 경고 보기",
	SpecWarnCrunchArmor2	= "방어구 씹기 특수 경고 보기(2중첩 이상)",	
	WarningEyeBeam			= "안광 집중 대상 알리기",
	timerLeftArm			= "왼쪽 팔 재생성 타이머 보기",
	timerRightArm			= "오른쪽 팔 재생성 타이머 보기",	
	WarnGrip				= "바위 손아귀 대상 알리기",
	SetIconOnGripTarget		= "바위 손아귀 대상 아이콘 설정",
	achievementDisarmed		= "무장해제 타이머 보기",
	SetIconOnEyebeamTarget	= "안광 집중 대상 공격대 아이콘 설정(네모)",
	PlaySoundOnEyebeam		= "안광 집중 특수 소리 재생"	
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "얕은 상처야!",
	Yell_Trigger_arm_right	= "꽉꽉 쥐어짜 주마!",
	Health_Body				= "콜로간 몸통",
	Health_Right_Arm		= "오른쪽 팔",
	Health_Left_Arm			= "왼쪽 팔",
--	FocusedEyebeam			= "%s이 당신에게 안광을 집중합니다!"
	FocusedEyebeam			= "당신에게 안광을 집중합니다!"
}

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "아우리아야"
}

L:SetMiscLocalization{
	Defender 		= "수호 야수 (%d)",
	YellPull 		= "내버려두는 편이 나았을 텐데!"
}

L:SetTimerLocalization{
	timerDefender	= "수호 야수 활성"
}

L:SetWarningLocalization{
	SpecWarnBlast 		= "수호 야수 폭발 - 차단!",
	SpecWarnVoid		= "공허의 지대 - 이동!",	
	WarnCatDied 		= "수호 야수 죽음 (%d 번 남음)",
	WarnCatDiedOne 		= "수호 야수 죽음 (1 번 남음)",	
	WarnFearSoon 		= "곧 다음 공포의 비명소리",
}

L:SetOptionLocalization{
	SpecWarnBlast 		= "수호 야수 폭발 특수 경고 보기",
	SpecWarnVoid		= "공허의 지대에 서있을 경우 특수 경고 보기",	
	WarnFearSoon		= "공포의 비명소리 사전 경고 보기",
	WarnCatDied 		= "수호 야수의 남은 부활 횟수 경고 보기",
	WarnCatDiedOne 		= "마지막 수호 야수 경고 보기(1 번 남음)",
	timerDefender       = "다음 수호 야수 활성 타이머 보기"	
}

-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetWarningLocalization{
	WarningFlashFreeze		= "순간 빙결",
	specWarnBitingCold		= "매서운 추위 - 이동!!"	
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningFlashFreeze		= "순간 빙결 경고 보기",
 	PlaySoundOnFlashFreeze	= "순간 빙결 경고 소리 듣기",	
	YellOnStormCloud		= "폭풍 구름을 얻을 경우 외치기",
	SetIconOnStormCloud		= "폭풍 구름 대상 아이콘 설정 하기",
	specWarnBitingCold		= "매서운 추위의 영향을 받을 경우 특수 경고 보기"	
}

L:SetMiscLocalization{
	YellKill			= "드디어... 드디어 그의 손아귀를... 벗어나는구나.",
	YellCloud			= "폭풍 구름! 비벼요!!"
}

--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "토림"
}

L:SetWarningLocalization{
	LightningOrb 			= "당신은 번개 충격 범위! 이동하세요!"
}

L:SetTimerLocalization{
	TimerHardmode			= "하드 모드"
}

L:SetOptionLocalization{
	TimerHardmode			= "하드 모드를 위한 타이머 보기",
	RangeFrame				= "거리 창 보기",
	LightningOrb 			= "번개 충격 알리기",
	AnnounceFails			= "번개 충전을 피하지 못했을 경우 공격대에 알리기\n(번개 충전 알리기/공대장 권한이 있을 경우)" 
}

L:SetMiscLocalization{
	YellPhase1				= "침입자라니! 감히 내 취미 생활을 방해하는 놈들은 쓴맛을 단단히... 잠깐... 너는...",
	YellPhase2				= "건방진 젖먹이 같으니... 감히 여기까지 기어올라와 내게 도전해? 내 손으로 쓸어버리겠다!",
	YellKill				= "무기를 거둬라! 내가 졌다!",
	ChargeOn				= "번개 충전: %s",
	Charge					= "번개 충전 실패 (현재 트라이): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetMiscLocalization{
	SpawnYell			= "얘들아, 날 도와라!",
	WaterSpirit			= "고대 물의 정령",
	Snaplasher 			= "악어덩굴손",
	StormLasher 		= "폭풍덩굴손",
	YellKill			= "내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다.",
	TrashRespawnTimer	= "프레이야 지역 리젠타임"
}

L:SetWarningLocalization{
	WarnSimulKill		= "첫번째 소환수 죽음 - 12초 후 부활",
	SpecWarnFury 		= "당신에게 자연의 격노!",
	WarningTremor   	= "지진! - 시전 중지!",
	WarnRoots 			= "무쇠 뿌리! : >%s<"	,
	UnstableEnergy		= "불안정한 힘 - 움직이세요!"
}

L:SetTimerLocalization{
	TimerSimulKill 			= "소환수 부활"
}

L:SetOptionLocalization{
	WarnSimulKill			= "첫번째 소환수 죽음 알리기",
	WarnRoots 				= "무쇠뿌리 대상 알리기",	
	SpecWarnFury 			= "당신이 자연의 격노일 경우 특수 경고 보기",
	PlaySoundOnFury			= "자연의 격노 특수 사운드 재생",
	WarningTremor  	 		= "지진 시전 특수 경고 보기 (하드 모드)",
	TimerSimulKill			= "소환수 부활 타이머 보기",	
	UnstableEnergy			= "당신이 불안정한 힘에게 영향을 받을 때 특수 경고 보기"	
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "프레이야의 장로"
}

L:SetWarningLocalization{
	SpecWarnFistOfStone 	= "돌덩이 주먹",
	SpecWarnGroundTremor  	= "지진 - 시전 중지!"
}

L:SetMiscLocalization{
	TrashRespawnTimer 		= "프레이야 지역 리젠타임"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "돌덩이 주먹 특수 경고 보기",
	PlaySoundOnFistOfStone	= "돌덩이 주먹 특수 사운드 재생",
	SpecWarnGroundTremor	= "지진 특수 경고 보기",
	TrashRespawnTimer		= "프레이야 지역 리젠 타이머 보기"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	DarkGlare				= "레이저 탄막",
	MagneticCore			= "자기 증폭기 획득 : >%s<",
	WarningShockBlast		= "충격파 - 움직이세요!",
	WarnBombSpawn			= "폭탄 로봇 생성!"
}

L:SetTimerLocalization{
	TimerHardmode			= "하드 모드 - 자폭장치 가동",
	TimeToPhase2			= "2 페이즈",
	TimeToPhase3			= "3 페이즈",
	TimeToPhase4			= "4 페이즈"
}

L:SetOptionLocalization{
	DarkGlare 				= "레이저 탄막 특수 경고 알리기",
	TimeToPhase2			= "페이즈 2 시작 알리기",
	TimeToPhase3			= "페이즈 3 시작 알리기",
	TimeToPhase4			= "페이즈 4 시작 알리기",
	MagneticCore			= "자기 증폭기 획득자 알리기",
	HealthFramePhase4		= "페이즈 4 의 체력 프레임 보기",
	AutoChangeLootToFFA		= "3 페이즈에서 루팅 옵션 자동 변경하기",	
	WarnBombSpawn			= "폭탄 로봇 생성 알리기",
	TimerHardmode			= "하드 모드를 위한 타이머 보기",
	PlaySoundOnShockBlast 	= "충격파 특수 사운드 경고 재생",
	PlaySoundOnDarkGlare 	= "레이저 탄막 대상 특수 사운드 경고 재생",
	ShockBlastWarningInP1	= "1 페이즈 충격파의 특수 경고 보기(근접 딜러)",
	ShockBlastWarningInP4	= "4 페이즈 충격파의 특수 경고 보기(근접 딜러)",
	RangeFrame				= "1 페이즈에서 거리 프레임 보기(6 미터)"
}

L:SetMiscLocalization{
	MobPhase1 		= "거대 전차 Mk II",
	MobPhase2 		= "VX-001",
	MobPhase3 		= "공중지휘기",
	YellPull		= "시간이 없어, 친구들! 내가 최근에 만든 기막힌 발명품을 시험하게 도와 주겠지? 자, 마음 바꿀 생각은 말라고. XT-002를 그 꼬락서니로 만들었으니, 너흰 나한테 빚진 셈이란 걸 잊지 마!",	
	YellHardPull	= "아니, 대체 왜 그런 짓을 한 게지? \"누르지 마시오.\"라고 쓰인 경고 문구 못 봤나? 자폭 장치를 활성화해 놓으면, 도대체 어떻게 발명품을 시험하지?",	
	YellPhase2		= "멋지군! 참으로 경이적인 결과야! 차체 내구도 98.9 퍼센트라! 손상이라고 보기도 어렵지! 계속하자고.",
	YellPhase3		= "고맙다, 친구들! 너희 덕분에 멋진 자료를 좀 얻었어! 자, 그걸 어디 뒀더라... 아, 여기 있군.",
	YellPhase4		= "예비 시험은 이걸로 끝이다. 자 이제부터가 진짜라고!",	
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetTimerLocalization{
	hardmodeSpawn = "사로나이트 원혼 생성"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "당신에게 어둠 붕괴 - 이동하세요!",
	SpecialWarningSurgeDarkness		= "어둠의 쇄도",
	WarningShadowCrash				= "어둠 붕괴 : >%s<",
	SpecialWarningShadowCrashNear	= "당신 주변에 어둠 붕괴!",	
	WarningLeechLife				= ">%s< 에게 생명력 흡수 시전!",
	SpecialWarningLLYou				= "당신에게 얼굴 없는 자의 징표!",
	SpecialWarningLLNear			= ">%s< 에게 가까운 당신에게 생명력 흡수 시전!"	
}

L:SetOptionLocalization{
	WarningShadowCrash				= "어둠의 붕괴 대상 알리기",
	SetIconOnShadowCrash			= "어둠 붕괴 대상 공격대 아이콘 설정하기(해골)",
	SetIconOnLifeLeach				= "얼굴 없는 자의 징표 대상 공격대 아이콘 설정하기(엑스)",
	SpecialWarningSurgeDarkness		= "어둠 쇄도 특수 경고 보기",
	SpecialWarningShadowCrash		= "어둠 붕괴 특수 경고 보기(공대원 중 베작스 대상/주시 일 경우)",
	SpecialWarningShadowCrashNear	= "주변에 어둠 붕괴일 때 특수 경고 보기",	
	SpecialWarningLLYou				= "얼굴 없는 자의 징표 특수 경고 보기",
	SpecialWarningLLNear			= "생명력 흡수 주변 특수 경고 보기",	
	CrashWhisper					= "어둠 붕괴 대상에게 귓속말 보내기"	,
	YellOnLifeLeech					= "생명력 흡수를 당할 때 외치기",
	YellOnShadowCrash				= "어둠 붕괴일 때 외치기",
	WarningLeechLife				= "생명력 흡수 시전 경고 보기",		
	hardmodeSpawn					= "사로나이드 원혼 생성 타이머 보기(하드모드)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "가까운 사로나이트 증기 구름이 합쳐집니다!",
	CrashWhisper			= "당신에게 어둠 붕괴! 뛰세요!",
	YellLeech				= "저에게 생명력 흡수 시전!",
	YellCrash				= "저에게 어둠 붕괴! 피하세요!"
}

-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetMiscLocalization{
	YellPull 				= "짐승의 대장을 칠 때가 곧 다가올 거예요! 놈의 졸개들에게 노여움과 미움을 쏟아부으세요!",
	YellPhase2 				= "나는, 살아 있는 꿈이다.",
	Sara 					= "사라",
	WarningYellSqueeze		= "압착의 촉수에 붙잡혔어요! 살려주세요!"	
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "요그사론의 수호자 %d 소환!",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수가 생성되었습니다!",	
	SpecWarnBrainLink				= "당신에게 두뇌의 고리!",
	WarningSanity 					= "> %d < 이성이 낮습니다.",
	SpecWarnSanity 					= ">> %d << 이성이 매우 낮습니다. 채우세요!",
	SpecWarnGuardianLow 			= "수호자 딜 주의하세요! - 공격 주의!",
	SpecWarnMadnessOutNow			= "광기 유발이 끝났습니다. - 밖으로 이동!",
	WarnBrainPortalSoon				= "3 초 후 내부 포탈이 열립니다.",
	SpecWarnFervor					= "당신에게 사라의 열정",
	SpecWarnFervorCast				= "당신에게 사라의 열정을 시전했습니다.",	
	WarnEmpowerSoon					= "곧 어둠의 봉화!",
	SpecWarnMaladyNear				= ">%s< 의 주변에 병든 정신",
	SpecWarnDeafeningRoar			= "귀청이 터질듯한 포효",
	specWarnBrainPortalSoon			= "곧 내부 포탈이 열립니다!",		
}

L:SetTimerLocalization{
	NextPortal			= "내부 차원문"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "요그사론의 수호자 소환 알리기",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수 생성 알리기",	
	WarningBrainLink				= "두뇌의 고리 알리기",
	SpecWarnBrainLink				= "두뇌의 고리 특수 경고 보기",
	WarningSanity					= "이성이 낮은 경우 경고 보기",
	SpecWarnSanity					= "이성이 매우 낮은 경우 특수 경고 보기",
	SpecWarnGuardianLow				= "수호자의 생명력이 낮을 때 특수 경고 보기(1페이즈 / 딜러)",
	NextPortal						= "다음 내부 차원문 알리기",	
	WarnBrainPortalSoon				= "내부 차원문 알리기",
	specWarnBrainPortalSoon			= "내부 차원문 특수 경고 알리기",	
	SpecWarnMadnessOutNow			= "광기 유발이 끝나기 전 특수 경고 알리기",
	WarningSqueeze					= "압착의 촉수의 대상이 됏을 경우 외치기",
	SetIconOnFearTarget				= "병든 정신 타겟 아이콘 설정하기",
	SetIconOnFervorTarget			= "사라의 열정 타겟 아이콘 설정하기",
	SetIconOnMCTarget				= "정신 지배에 걸린 플레이어 타겟 아이콘 설정하기",	
	ShowSaraHealth					= "사라 체력 보기(공대원 중 사라 대상/주시 일 경우)",
	SpecWarnFervor					= "사라의 열정 특수 경고 보기",
	SpecWarnFervorCast				= "당신에게 사라의 열정을 시전 할 때 특수 경고 보기(사라 대상/주시 일 경우)",	
	WarnEmpowerSoon					= "어둠의 봉화 경고 보기",
	SpecWarnMaladyNear				= "병든 정신이 걸린 플레이어가 근처에 있을 경우 특수 경고 알리기(병든 정신 종료 후)",
	SpecWarnDeafeningRoar			= "귀청이 터질듯한 포효 시전을 할 경우 특수 경고 보기 (침묵 그리고 레전드리를 위하여!!)",
	SetIconOnBrainLinkTarget		= "두뇌 연결 대상 공격대 아이콘 설정"	
}
