if GetLocale() ~= "koKR" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "곧 %s - 전도성 물에서 빠지세요!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "$spell:138470 위에 있을 때 특수 경고 보기<br/>($spell:137313 이전 또는 $spell:138732 시간이 얼마 안 남았을때)"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "조종의 구슬 떨어짐",
	specWarnOrbofControl	= "조종의 구슬 떨어짐!"
})

L:SetTimerLocalization({
	timerDoor				= "다음 부족의 문 열림",
	timerAdds				= "다음 %s"
})

L:SetOptionLocalization({
	warnAdds				= "병력 등장시 알림 보기",
	warnOrbofControl		= "$journal:7092 떨어짐시 알림 보기",
	specWarnOrbofControl	= "$journal:7092 떨어짐시 특수 경고 보기",
	timerDoor				= "다음 부족의 문 열림 바 보기",
	timerAdds				= "다음 추가 병력 바 보기",
	SetIconOnAdds			= "추가 병력들에게 전술 목표 아이콘 설정"
})

L:SetMiscLocalization({
	newForces				= "병력들이 쏟아져",
	chargeTarget			= "꼬리를 바닥에 쿵쿵 내려칩니다!"
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s : %s - 대상 전환!"
})

L:SetOptionLocalization({
	PHealthFrame		= "우두머리 체력 바 사용시 $spell:136442 사라짐까지 남은체력도 함께 보기",
	AnnounceCooldowns	= "공격대 생존기 사용을 위해 $spell:137166 횟수를 소리로 듣기<br/>(카즈라진의 빙의가 풀리면 초기화됨)"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s 사용 : >%s< (%d 남음)",
	specWarnCrystalShell	= "%s 받으세요!"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "$spell:137633 없고 체력이 90% 이상인 경우 특수 경고 보기",
	InfoFrame				= "$spell:137633 없는 대상을 정보 창으로 보기",
	ClearIconOnTurtles		= "$journal:7129이 $spell:133971를 얻은 경우 전술 목표 아이콘 지우기",
	AnnounceCooldowns		= "공격대 생존기 사용을 위해 $spell:134920 횟수를 소리로 듣기"
})

L:SetMiscLocalization({
	WrongDebuff				= "%s 없음"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "다음 숨결"
})

L:SetOptionLocalization({
	timerBreaths			= "다음 숨결 바 보기",
	AnnounceCooldowns		= "공격대 생존기 사용을 위해 광란/확산 횟수를 소리로 듣기",
	Never					= "알리지 않음",
	Every					= "횟수 초기화 하지 않음",
	EveryTwo				= "2번 후 초기화",
	EveryThree				= "3번 후 초기화",
	EveryTwoExcludeDiff		= "2번 후 초기화(확산 제외)",
	EveryThreeExcludeDiff	= "3번 후 초기화(확산 제외)"
})

L:SetMiscLocalization({
	rampageEnds				= "분노가 가라앉습니다."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%2$s : %1$s %3$s",
	specWarnFlock		= "%2$s : %1$s %3$s",
	specWarnBigBird		= "곧 둥지 수호자 : %s",
	specWarnBigBird		= "둥지 수호자 : %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "둥지 (%d): %s"
})

L:SetOptionLocalization({
	ShowNestArrows		= "활성화된 둥지쪽으로 화살표 보기",
	Never				= "보이지 않음",
	Northeast			= "파랑 - 아래/위 북동쪽",
	Southeast			= "초록 - 아래/위 남동쪽",
	Southwest			= "보라/빨강 - 아래 남서쪽 & 위 남서쪽(25인)/위 중앙(10인)",
	West				= "빨강 - 아래 서쪽 & 위 중앙(25인)",
	Northwest			= "노랑 - 아래/위 북서쪽(25인)",
	Guardians			= "둥지 수호자"
})

L:SetMiscLocalization({
	eggsHatch		= "있는 알들이 부화하기 시작합니다!",
	Upper			= "윗쪽",
	Lower			= "아래쪽",
	UpperAndLower	= "윗쪽 + 아래쪽",
	TrippleD		= "윗쪽 + 아래쪽 + 아래쪽",
	TrippleU		= "윗쪽 + 윗쪽 + 아래쪽",
	NorthEast		= "|cff0000ff북동쪽|r",
	SouthEast		= "|cFF088A08남동쪽|r",
	SouthWest		= "|cFF9932CD남서쪽|r",
	West			= "|cffff0000서쪽|r",
	NorthWest		= "|cffffff00북서쪽|r",
	Middle10		= "|cFF9932CD중앙|r",
	Middle25		= "|cffff0000중앙|r"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "광선 - |cffff0000적색|r : >%s<, |cff0000ff청색|r : >%s<",
	warnBeamHeroic				= "광선 - |cffff0000적색|r : >%s<, |cff0000ff청색|r : >%s<, |cffffff00황색|r : >%s<",
	warnAddsLeft				= "안개도깨비 남음 : %d",
	specWarnBlueBeam			= "당신에게 청색 광선 - 절대 이동 금지!",
	specWarnFogRevealed			= "%s 드러남!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "광선 대상 알림 보기",
	warnAddsLeft				= "안개도깨비 남은 횟수알림 보기",
	specWarnFogRevealed			= "안개도깨비가 드러날 때 특수 경고 보기",
	ArrowOnBeam					= "$journal:6882 활성화 중에 이동해야 될 방향을 DBM 화살표로 보기",
	InfoFrame					= "$spell:133795 중첩을 정보 창으로 보기",
	SetParticle					= "전투 시작시 입자 밀도를 최저로 설정<br/>(전투 종료 후 원상태로 복구됨)"
})

L:SetMiscLocalization({
	LifeYell					= "%s 생명력 흡수 중! (%d중첩)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "변형 정보 : 이로운 효과 - %d/5개, 해로운 효과 - %d개"
})

L:SetOptionLocalization({
	warnDebuffCount				= "웅덩이를 흡수할 때 변형 상태 알림 보기",
	SetIconOnBigOoze			= "$journal:6969 에게 전술 목표 아이콘 설정"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s 자리바꿈 : >%s<, >%s<"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "$spell:138618 자리바꿈 알림 보기"
})

L:SetMiscLocalization({
	Pull				= "구슬이 폭발합니다!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s : %s, %s"
})

L:SetOptionLocalization({
	RangeFrame		= "전투 진영에 따라 거리 창 보기(10m)<br/>(일정 인원 이상이 뭉쳐 있을 때만 보이는 똑똑한 거리 창 입니다.)",
	InfoFrame		= "$spell:136193 대상을 정보 창으로 보기"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "밤 단계",
	warnDay			= "낮 단계",
	warnDusk		= "황혼 단계"
})

L:SetTimerLocalization({
	timerDayCD		= "낮 단계",
	timerDuskCD		= "황혼 단계"
})

L:SetMiscLocalization({
	DuskPhase		= "루린! 힘을 빌려다오!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "곧 사잇단계!",
	warnDiffusionChainSpread	= "%s 전이 : >%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "도관 기술 가능"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "사잇단계 진입 전에 특수 경고 보기",
	warnDiffusionChainSpread	= "$spell:135991 전이 대상 알림 보기",
	timerConduitCD				= "최초 도관 기술 대기시간 바 보기",
	StaticShockArrow			= "$spell:135695 대상이 정해진 경우 DBM 화살표 보기",
	OverchargeArrow				= "$spell:136295 대상이 정해진 경우 DBM 화살표 보기"
})

L:SetMiscLocalization({
	StaticYell		= "%s의 전하 충격 발생 전! (%d초 남음)"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump		= "당신에게 불안정한 생령 전이됨!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump		= "$spell:138297 전이 대상이 당신이 된 경우 특수 경고 보기",
	SetIconsOnVita				= "$spell:138297 대상과 그 대상에서 가장 먼 공격대원에게 전술 목표 아이콘 설정"
})

L:SetMiscLocalization({
	Defeat						= "잠깐",
	BigWigsRecommendation		= "불안정한 생령 전이 도우미가 필요할 경우, BigWigs 및 BigWigs Ra-den assist 애드온을 이용하시는 것을 권장합니다."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name = "천둥의 왕좌: 일반구간"
})
