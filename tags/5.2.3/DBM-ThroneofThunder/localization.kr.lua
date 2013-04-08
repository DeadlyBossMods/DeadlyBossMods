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
	specWarnWaterMove	= "$spell:138470 위에 있을 때 특수 경고 보기\n($spell:137313 시전 직전 또는 $spell:138732 약화 효과 시간이 얼마 안 남았을때)",
	RangeFrame			= "거리 창 보기"
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
	timerDoor				= "다음 부족의 문 열림 바 표시",
	timerAdds				= "다음 추가 병력 바 표시"
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
	PHealthFrame		= "우두머리 체력 바 사용시 $spell:136442 사라짐까지 남은 체력도 함께 보기",
	RangeFrame			= "거리 창 보기"
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
	specWarnCrystalShell	= "$spell:137633 효과가 없을 경우 특수 경고 보기",
	InfoFrame				= "$spell:137633 효과가 없는 대상을 정보 창에서 보기",
	SetIconOnTurtles		= "$journal:7129에 전술 목표 아이콘 설정",
	ClearIconOnTurtles		= "$journal:7129이 $spell:133971의 영향을 받은 경우 전술 목표 아이콘 지우기"
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
	timerBreaths			= "다음 숨결 바 표시"
})

L:SetMiscLocalization({
	rampageEnds				= "분노가 가라앉습니다."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%2$s : %1$s %3$s",
	specWarnFlock	= "%2$s : %1$s %3$s",
	specWarnBigBird	= "둥지 수호자 : %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "둥지 (%d): %s"
})

L:SetOptionLocalization({
	RangeFrame		= "$spell:138923 주문에 대한 거리 창 보기(10m)"
})

L:SetMiscLocalization({
	eggsHatchL		= "아랫둥지에 있는 알들이 부화하기 시작합니다!",
	eggsHatchU		= "위쪽 둥지에 있는 알들이 부화하기 시작합니다!",
	Upper			= "윗쪽",
	Lower			= "아래쪽",
	UpperAndLower	= "윗쪽 + 아래쪽",
	TrippleD		= "윗쪽 + 아래쪽 + 아래쪽",
	TrippleU		= "윗쪽 + 윗쪽 + 아래쪽",
	SouthWest		= "남서쪽",
	SouthEast		= "남동쪽",
	NorthWest		= "북서쪽",
	NorthEast		= "북동쪽",
	West			= "서쪽",
	Middle			= "중앙"
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
	warnAddsLeft				= "안개도깨비 남은 횟수 알림 보기",
	specWarnFogRevealed			= "안개도깨비가 드러날 때 특수 경고 보기",
	ArrowOnBeam					= "$journal:6882 시전 중에 이동해야 될 방향을 DBM 화살표로 보기",
	InfoFrame					= "$spell:133795 중첩 정보 창 보기"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "변형 정보 : 이로운 효과 - %d/5개, 해로운 효과 - %d개"
})

L:SetOptionLocalization({
	warnDebuffCount				= "웅덩이를 흡수할 때 변형 상태에 대한 알림 보기",
	RangeFrame					= "거리 창 보기(5m/2m)"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s 자리바꿈 : >%s<, >%s<"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "$spell:138618 대상 알림"
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
	RangeFrame		= "전투 진영에 따라 거리 창 보기\n(일정 인원 이상이 뭉쳐 있을 때만 보이는 똑똑한 거리 창 입니다.)",
	InfoFrame		= "$spell:136193 주문에 영향을 받은 대상을 정보 창에서 보기"
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
	timerDuskCD		= "황혼 단계",
})

L:SetOptionLocalization({
	warnNight		= "밤 단계 알림 보기",
	warnDay			= "낮 단계 알림 보기",
	warnDusk		= "황혼 단계 알림 보기",
	timerDayCD		= "낮 단계 바 표시",
	timerDuskCD		= "황혼 단계 바 표시",
	RangeFrame		= "거리 창 보기(8m)"
})

L:SetMiscLocalization({
	DuskPhase		= "루린! 힘을 빌려다오!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "곧 사잇단계!"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "사잇단계 진입 전에 특수 경고 보기",
	RangeFrame					= "거리 창 보기",
	StaticShockArrow			= "$spell:135695 주문의 영향을 누군가 받은 경우 DBM 화살표 보기",
	OverchargeArrow				= "$spell:136295 주문의 영향을 누군가 받은 경우 DBM 화살표 보기"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name = "천둥의 왕좌 일반구간"
})

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기(10m)"
})
