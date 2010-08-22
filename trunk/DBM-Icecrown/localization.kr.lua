if GetLocale() ~= "koKR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "성채 하층부 일반몹"
}

L:SetWarningLocalization{
	SpecWarnTrap				= "트랩 활성화! - 죽음에 속박된 감시자!"--creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap				= "트랩 활성화 특수 경고 보기",
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1					= "거기... 누구냐?",
	WarderTrap2					= "내가... 깨어난다!",	
	WarderTrap3					= "주인님의 성소를 어지럽혔구나!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "역병작업장 일반몹"
}

L:SetWarningLocalization{
	WarnMortalWound				= "%s : >%s< (%d)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap				= "트랩 활성화! - 복수의 육신해체자!"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap 				= "트랩 활성화 특수 경고 보기",
	WarnMortalWound				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "알 수 없음")
}

L:SetMiscLocalization{
	FleshreaperTrap1			= "서둘러! 저놈들 뒤에서 습격하자!",
	FleshreaperTrap2			= "우리에게서... 벗어날 수 없다!",
	FleshreaperTrap3			= "살아있는 놈이... 여기에?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "진홍빛 전당 일반몹"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "서리날개 전당 일반몹"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "신드라고사 웨이브"
}

L:SetTimerLocalization{
	GosaTimer			= "신비한 강타"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "신드라고사 웨이브 특수 경고 보기",
	GosaTimer			= "신드라고사 신비한 강타 유지 타이머 보기"
}

L:SetMiscLocalization{
	SindragosaEvent		= "서리 여왕께 다가가도록 두지 않겠다. 서둘러라! 저들을 막아라!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

L:SetTimerLocalization{
	AchievementBoned	= "탈출 시간"
}

L:SetWarningLocalization{
	WarnImpale				= "꿰뚫기 : >%s<"
}

L:SetOptionLocalization{
	WarnImpale				= "$spell:69062 대상 알리기",
	AchievementBoned		= "뼈도 못 추릴라 업적 타이머 보기",	
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "여교주 데스위스퍼"
}

L:SetTimerLocalization{
	TimerAdds						= "이교도 추가"
}

L:SetWarningLocalization{
	WarnReanimating					= "이교도 부활",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s : >%s< (%d)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "곧 새로운 이교도 추가",
	SpecWarnVengefulShade			= "복수의 망령 공격 - 피하세요!"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon					= "이교도 추가 사전 경고 보기",
	WarnReanimating					= "이교도를 부활을 시작 할 경우 경고 보기",								-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "새로운 이교도 추가 타이머 보기",
	SpecWarnVengefulShade			= "복수의 망령으로부터 공격을 받을 경우 특수 경고 보기",--creatureid 38222	
	ShieldHealthFrame				= "$spell:70842의 방어막 바와 보스 체력바를 함께 보기",	
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "알 수 없음"),	-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "이게 무슨 소란이지? 감히 이 신성한 땅을 지나가려 해? 여기가 마지막 숨을 거둘 곳이 되리라!",
	YellReanimatedFanatic			= "일어나라, 순수한 모습을 기뻐하라!",
	ShieldPercent					= "마나 방벽",
	Fanatic1						= "교단 광신자",
	Fanatic2						= "변형된 광신자",
	Fanatic3						= "되살아난 광신자"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "얼음왕관 비행선 전투"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "곧 추가 몹"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "전투 격노"),
	TimerCombatStart	= "전투 시작 타이머 보기",
	WarnAddsSoon		= "몹 생성 사전 경고 보기",
	TimerAdds			= "추가 몹 타이머 보기"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작",
	TimerAdds			= "추가 몹"
}

L:SetMiscLocalization{
	PullAlliance		= "속도를 올려라! 제군들, 곧 운명과 마주할 것이다!",
	KillAlliance		= "악당 놈들, 분명히 경고했다! 형제자매여, 전진!",
	PullHorde			= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	KillHorde			= "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!",
	AddsAlliance		= "Reavers, Sergeants, attack",
	AddsHorde			= "해병, 하사관, 공격하라!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "죽음의 인도자 사울팽"
}

L:SetWarningLocalization{
	WarnFrenzySoon			= "곧 광기"
}

L:SetTimerLocalization{
	TimerCombatStart		= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart		= "전투 시작 타이머 보기",
	WarnFrenzySoon			= "광기 사전 경고 보기 (33% 이하)",
	BoilingBloodIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
--	MarkCastIcon			= "$spell:72444 대상에게 공격대 징표 설정",	
	RangeFrame				= "거리 창 보기 (12 미터)",
	RunePowerFrame			= "보스 체력 바와 함께 $spell:72371 바 보기",
	BeastIcons				= "피의 괴물 공격대 징표 설정"	
}

L:SetMiscLocalization{
	RunePower				= "피 마력",
	PullHorde				= "코르크론, 출발하라! 용사들이여, 뒤를 조심하게. 스컬지는...",
	PullAlliance			= "그러면 이동하자! 이동...",
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "구린속"
}

L:SetWarningLocalization{
	InhaledBlight			= "파멸의 역병 들이마심 : >%d<",
	WarnGastricBloat		= "%s : >%s< (%d)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight			= "$spell:71912 경고 보기",
	RangeFrame				= "거리 창 보기(8 미터)",	
	WarnGastricBloat		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "알 수 없음"),	
	SetIconOnGasSpore		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons		= "$spell:69279 대상 공격대 징표 채팅으로 알리기\n(공대장 혹은 권한을 가진 사람만 사용 가능)",
	AchievementCheck		= "Announce 'Flu Shot Shortage' achievement failure to raid chat\n(requires promoted status)"	
}

L:SetMiscLocalization{
	SporeSet				= "가스 포자 징표{rt%d} : %s",
	AchievementFailed		= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "썩은얼굴"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "작은 수액괴물 생성",
	WarnUnstableOoze			= "%s : >%s< (%d)",			-- Unstable Ooze on >args.destName< (args.amount)
	SpecWarnLittleOoze			= "작은 수액괴물의 공격! - 뛰세요!"--creatureid 36897	
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수 타이머 보기",
	WarnOozeSpawn				= "작은 수액괴물 생성 경고 보기",
	SpecWarnLittleOoze			= "작은 수액괴물로부터 공격을 받을 경우 특수 경고 보기",--creatureid 36897	
	RangeFrame					= "거리 프레임 보기 (8 미터)",	
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "알 수 없음"),	
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "큰 수액괴물 탱커 방향 DBM 화살표 보기(테스트)"
}

L:SetMiscLocalization{
	YellSlimePipes1				= "좋은 소식이에요, 여러분! 독성 수액 배출관을 고쳤어요!",	-- Professor Putricide
	YellSlimePipes2				= "끝내 주는 소식이에요, 여러분! 수액이 다시 나오는군요!"	-- Professor Putricide	
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "교수 퓨트리사이드"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "곧 2 단계",
	WarnPhase3Soon				= "곧 3 단계",
	WarnMutatedPlague			= "%s : >%s< (%d)",			-- Mutated Plague on >args.destName< (args.amount)
	SpecWarnMalleableGoo		= "당신에게 유연한 끈적이 - 이동하세요!",
	SpecWarnMalleableGooNear	= "당신 주변에 유연한 끈적이 - 벗어나세요!",
	SpecWarnUnboundPlague		= "고삐 풀린 역병 전달",
	SpecWarnNextPlageSelf		= "당신이 다음 고삐 풀린 역병, 준비하세요!"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "2 단계 사전 경고 보기(83% 이하)",
	WarnPhase3Soon				= "3 단계 사전 경고 보기(38% 이하)",
	SpecWarnMalleableGoo		= "만약 당신이 $spell:72295의 첫번째 대상이 될 경우 특수 경고 보기",
	SpecWarnMalleableGooNear	= "만약 당신의 주변에 첫번째 $spell:72295 대상이 있을 경우 특수 경고 보기",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "알 수 없음"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	NextUnboundPlagueTargetIcon	= "$spell:72856의 다음 대상 공격대 징표 설정하기",
	MalleableGooIcon			= "$spell:72295 대상 공격대 징표 설정하기",
	YellOnMalleableGoo			= "$spell:72295 외치기",
	YellOnUnbound				= "$spell:72856 말하기",	
	GooArrow					= "당신 주변의 $spell:72295를 DBM 화살표로 표시",	
	SpecWarnUnboundPlague		= "$spell:72856 전달자 특수 경고 보기",
	SpecWarnNextPlageSelf		= "당신이 다음 $spell:72856 대상이 될 때 특수 경고 보기",
	BypassLatencyCheck			= "$spell:72295의 동기화를 사용하지 않거나 네트워크 체크를 하지 않습니다.\n(만약 DBM 사용에 문제가 생기면 사용하세요.)"	
}

L:SetMiscLocalization{
	YellPull					= "좋은 소식이에요, 여러분! 아제로스의 모든 생명체를 파괴할 역병을 완성했어요!",
	YellMalleable				= "나에게 통통이~!",
	YellUnbound					= "나에게 역병~! 이리오삼~!"	
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "피의 공작 의회"
}

L:SetWarningLocalization{
	WarnTargetSwitch			= "대상 전환 : %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon		= "곧 대상 전환",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnVortex				= "당신에게 충격의 소용돌이 - 이동!",
	SpecWarnVortexNear			= "당신 근처에 충격의 소용돌이 - 확인!"	
}

L:SetTimerLocalization{
	TimerTargetSwitch			= "대상 전환"
}

L:SetOptionLocalization{
	WarnTargetSwitch			= "대상 전환 경고 보기", -- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon		= "대상 전환 사전 경고 보기",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch			= "대상 전환 쿨다운 타이머 보기",
	SpecWarnVortex				= "당신이 $spell:72037에 해당 될 경우 특수 경고 보기",
	SpecWarnVortexNear			= "당신 주변에 $spell:72037가 있을 경우 특수 경고 보기",	
	EmpoweredFlameIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon			= "활성화 된 공작에게 공격대 징표 설정하기 (해골)",
	RangeFrame					= "거리 창 보기 (12 m)",
	VortexArrow					= "당신 주변의 $spell:72037를 DBM 화살표로 표시",	
	BypassLatencyCheck			= "$spell:72037의 동기화를 사용하지 않거나 네트워크 체크를 하지 않습니다.\n(만약 DBM 사용에 문제가 생기면 사용하세요.)"	
}


L:SetMiscLocalization{
	Keleseth					= "공작 켈레세스",
	Taldaram					= "공작 탈다람",
	Valanar						= "공작 발라나르",
--	EmpoweredFlames				= "(%S+) 쪽으로 질주합니다!" -- Inferno Flames speed toward (%S+)!
	EmpoweredFlames				= "강력한 불꽃이 (%S+)" -- Inferno Flames speed toward (%S+)!
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "피의 여왕 라나텔"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "거리 창 보기 (8 m)",
	YellOnFrenzy			= "$spell:71474 말하기"
}

L:SetMiscLocalization{
--	SwarmingShadows			= "어둠이 쌓이더니 (%S+)에게 몰려듭니다!", --"Shadows amass and swarm around (%S+)!"
	SwarmingShadows			= "어둠이 쌓이더니 (%S+)",
	YellFrenzy				= "피가 모잘라~! 앙~"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "발리스리아 드림워커"
}

L:SetWarningLocalization{
	WarnCorrosion				= "%s : >%s< (%d)",		-- Corrosion on >args.destName< (args.amount)
	WarnPortalOpen				= "차원문 열림"	
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "차원문 열림",
	TimerBlazingSkeleton		= "다음 타오르는 해골",
	TimerAbom					= "Next Abomination"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "타오르는 해골에게 공격대 징표 설정(해골)",
	WarnPortalOpen				= "$spell:72483 열림 경고 보기",	
	TimerPortalsOpen			= "악몽의 차원문이 열릴 때 타이머 보기",
	TimerBlazingSkeleton		= "타오르는 해골 다음 생성 타이머 보기",
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)",	
	WarnCorrosion				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "알 수 없음")
}

L:SetMiscLocalization{
	YellPull		= "침입자들이 내부 성소로 들어왔다. 서둘러 녹색용을 파멸시켜라! 되살려 낼 때 쓸 뼈와 힘줄만 남겨라!",
	YellKill		= "다시 힘을 얻었다! 이세라여, 더러운 생명들에 안식을 내릴 수 있도록 은혜를 베푸소서!",
	YellPortals		= "에메랄드의 꿈으로 가는 차원문을 열어두었다. 너희의 구원은 그 안에 있다...",
	YellPhase2		= "힘이 돌아오고 있다. 영웅들이여, 계속 싸워라!"--Need to confirm this is when adds spawn faster (phase 2) before used in mod
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "신드라고사"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "다음 공중 단계",
	TimerNextGroundphase	= "다음 지상 단계",
	AchievementMystic		= "신비한 아픔 업적 타이머"	
}

L:SetWarningLocalization{
	WarnPhase2soon			= "곧 2 단계",
	WarnAirphase			= "공중 단계",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙",
	WarnInstability			= "불안정 : >%d<",
	WarnChilledtotheBone	= "사무치는 한기 : >%d<",
	WarnMysticBuffet		= "신비한 강타 : >%d<"	
}

L:SetOptionLocalization{
	WarnAirphase				= "공중 단계 알리기",
	WarnGroundphaseSoon			= "지상 단계 사전 경고 보기",
	WarnPhase2soon				= "2 단계 사전 경고 보기(38% 이하)",	
	TimerNextAirphase			= "다음 공중 단계 타이머 보기",
	TimerNextGroundphase		= "다음 지상 단계 타이머 보기",
	WarnInstability				= "당신의 $spell:69766 중첩 경고 보기",
	WarnChilledtotheBone		= "당신의 $spell:70106 중첩 경고 보기",
	WarnMysticBuffet			= "당신의 $spell:70128 중첩 경고 보기",
	AnnounceFrostBeaconIcons	= "$spell:70126 대상 공격대 징표을 채팅으로 알리기\n(공대장 혹은 부공대장 권한이 있을 경우)",	
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "공중 단계 전 모든 공격대 징표 제거",
	AchievementCheck			= "Announce 'All You Can Eat' achievement warnings to raid chat\n(requires promoted status)",	
	RangeFrame					= "거리 창 보기(일반 10m, 영웅 20m) (해당 플레이어만 보임)"

}

L:SetMiscLocalization{
	YellAirphase			= "여기가 끝이다! 아무도 살아남지 못하리라!",
	YellPhase2				= "자, 주인님의 무한한 힘을 느끼고 절망에 빠져보아라!",--Now, feel my master's limitless power and despair!",	
	BeaconIconSet			= "냉기 봉화 징표{rt%d} : %s",
	AchievementWarning		= "Warning: %s has 5 stacks of Mystic Buffet",
	AchievementFailed		= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<",	
	YellPull				= "여기까지 오다니 너무나 어리석구나. 노스렌드의 얼음 바람이 영혼까지 삼키리라!"--You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "리치 왕"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "곧 2 단계 전환",
	WarnPhase3Soon				= "곧 3 단계 전환",
	ValkyrWarning				= "발키리 : >%s<",
	SpecWarnYouAreValkd			= "발키리가 납치 중!",	
	SpecWarnDefileCast			= "당신에게 파멸! - 이동!",
	SpecWarnDefileNear			= "당신 주변에 파멸! - 이동!",
	SpecWarnTrapNear			= "당신 주변에 암흑의 덫 - 확인!",
	WarnNecroticPlagueJump		= "괴저 역병 전이 : >%s<",
	SpecWarnPALGrabbed			= "발키리가 신기 납치 : %s",
	SpecWarnPRIGrabbed			= "발키리가 사제 납치 : %s",
	SpecWarnValkyrLow			= "발키리 HP 55% 이하!!"
}

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작",
	TimerRoleplay				= "이벤트",
	PhaseTransition				= "다음 단계 전환",
	TimerNecroticPlagueCleanse 	= "괴저 역병"
}

L:SetOptionLocalization{
	TimerCombatStart			= "전투 시작 타이머 보기",
	TimerRoleplay				= "이벤트 타이머 보기",
	WarnNecroticPlagueJump		= "$spell:73912 이동 대상 알리기",	
	TimerNecroticPlagueCleanse	= "$spell:73912의 첫 번째 틱 이후 지속 타이머 보기",	
	PhaseTransition				= "다음 단계 전환 타이머 보기",	
	WarnPhase2Soon				= "2 단계 전환 사전 경고 보기(73% 이하)",
	WarnPhase3Soon				= "3 단계 전환 사전 경고 보기(43% 이하)",
	ValkyrWarning				= "발키리에게 붙잡힌 사람 알리기",
	SpecWarnYouAreValkd			= "발키리에게 붙잡혔을 때 특수 경고 보기",
	SpecWarnHealerGrabbed		= "성기사 또는 사제(힐러)가 발키리에게 붙잡히게 될 경우 특수 경고 보기\n(힐러가 DBM을 사용할 경우)",	
	SpecWarnDefileCast			= "당신에게 $spell:72762이 시전된 경우 특수 경고 보기",
	SpecWarnDefileNear			= "당신 주변에 $spell:72762이 시전된 경우 특수 경고 보기",
	SpecWarnTrapNear			= "주변에 $spell:73539을 하면 특수 경고 보기",	
	YellOnDefile				= "$spell:72762의 대상이 됐을 때 말하기",
	YellOnTrap					= "$spell:73539 말하기",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),	
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	ValkyrIcon					= "발키리에 공격대 징표 설정",
	DefileArrow					= "$spell:72762이 당신 주변에 생성되면 DBM 화살표 보기",
	TrapArrow					= "주변에 $spell:73539을 할 경우 DBM 화살표 보기",
	LKBugWorkaround				= "$spell:73539 또는 $spell:72762의 동기화를 사용하지 않거나 네트워크 체크를 하지 않습니다.\n(만약 DBM 사용에 문제가 생기면 사용하세요.)",	
	AnnounceValkGrabs			= "발키리가 납치할 때 대상과 대상 공격대 아이콘으로 채팅 알리기\n(알림 권한이 있을 경우)",
	SpecWarnValkyrLow			= "발키리의 HP가 55%이하가 될 경우 특수 경고 보기",
	AnnouncePlagueStack			= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)"	
}
L:SetMiscLocalization{
	LKPull					= "그러니까 성스러운 빛이 자랑하던 정의가 마침내 왔다 이건가? 폴드링, 서리한을 내려놓고 자비라도 애걸하라는 건가?",
	YellDefile				= "저에게 파멸!!!",
	YellTrap				= "나에게 암흑의 덫!!!",
	YellValk				= "끌려 가는 중! 살려주삼!",	
	YellKill				= "어떤 의문도 남지 않았다. 어떤 의심도 없다. 너희는 아제로스의 가장 위대한 용사들이다. 너희 앞에 놓아둔 모든 도전을 극복해 내었다. 가장 강력한 종들이 너희의 무자비한 살육 앞에 쓰러졌지... 너희가 억눌렀던 분노 앞에 말이다...",
	LKRoleplay				= "진정으로 정의에 이끌렸단 말이냐? 궁금하구나...",
	ValkGrabbedIcon			= "발키리 납치 : {rt%d} %s",
	ValkGrabbed				= "발키리 납치 : %s",
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague",
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<",
	PlagueWhisper			= "에 감염되었습니다!" --역병 전이 : You have been infected by
}