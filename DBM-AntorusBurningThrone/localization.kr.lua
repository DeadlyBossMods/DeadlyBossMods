if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"영웅/신화 난이도일 때 이전에 시전한 스킬의 타이머를 삭제해서 타이머 수를 정리합니다. 대신 약간 타이머 정확도가 떨어지게 됩니다 (1-2초 빠르게 나옴)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"다음 혼란자 (%s)",
	timerDestructor 	=	"다음 파괴자 (%s)",
	timerPurifier 		=	"다음 정화자 (%s)",
	timerBats	 		=	"다음 박쥐 (%s)"
})

L:SetMiscLocalization({
	Obfuscators =	"혼란자",
	Destructors =	"파괴자",
	Purifiers 	=	"정화자",
	Bats 		=	"박쥐",
	EonarHealth	= 	"이오나 생명력",
	EonarPower	= 	"이오나 기력",
	NextLoc		=	"다음 위치:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"단상 위치와 관계 없이 모든 알림 보기"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe =		"해제 해주세요!"
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"전투의 전반적인 상황을 정보 창에 표시",
	UseAddTime = "초기화 페이즈가 끝났을 때 항상 보스의 다음 스킬 타이머가 표시됩니다. (옵션을 끄면 보스가 다시 활성화됐을 때 정확한 스킬 타이머가 표시되지만, 1~2초 남은 스킬의 쿨타임에 대한 경고만 뜰 수도 있습니다)"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetOptionLocalization({
	timerBossIncoming		= "다음 보스 교대 타이머 바 보기",
	TauntBehavior		= "탱커 교대 도발 알림 설정",
	TwoMythicThreeNon	= "신화에선 2중첩, 그 외 난이도에선 3중첩",--Default
	TwoAlways			= "난이도 관계없이 2중첩",
	ThreeAlways			= "난이도 관계없이 3중첩",
	SetLighting				= "쉬바라 전투가 시작되면 조명 품질 설정이 자동으로 낮음으로 바뀌고 전투가 끝나면 원래 설정으로 복구 (맥용 클라이언트에선 조명 품질을 낮음으로 설정할 수 없으므로 지원하지 않음)",
	InterruptBehavior	= "공대원 차단 방식 설정 (공대장 권한 필요)",
	Three				= "3인 로테이션 ",--Default
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 ",
	IgnoreFirstKick		= "이 옵션을 켜면 맨 처음 차단은 로테이션에서 제외됩니다 (공대장 권한 필요)"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetOptionLocalization({
	ignoreThreeTank	= "3탱 이상 구성일 땐 분쇄/적 해체 도발 특수 경고를 표시하지 않습니다. (이런 구성에선 DBM이 정확한 탱킹 로테이션을 감지할 수 없음) 탱커가 죽어서 2명으로 줄어들면 꺼졌던 도발 알림이 다시 작동합니다"
})

L:SetMiscLocalization({
	Foe			=	"적 해체",
	Rend		=	"분쇄",
	Tempest 	=	"폭풍",
	Current		=	"현재 스킬:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "선고 쿨타임 (%s)"
})

L:SetMiscLocalization({
	SeaText		=	"{rt6} 가속/유연",
	SkyText		=	"{rt5} 치명/특화",
	Blight		=	"역병",
	Burst		=   	"분출",
	Sentence	=	"선고",
	Bomb		=	"폭탄"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"안토러스 일반몹"
})
