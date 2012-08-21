if GetLocale() ~= "koKR" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "크초르모 주문사용: %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "$journal:4262가 사용하는 주문 알림 보기 (영웅 난이도)",
	KohcromCD		= "$journal:4262가 사용할 주문 바 표시 (영웅 난이도)",
	RangeFrame		= "거리 프레임 보기 (5m, 업적 용도)"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "$spell:103434 주문의 영향을 받은 경우 대화로 알리기 (영웅 난이도)",
	CustomRangeFrame	= "교란의 그림자 주문에 대한 거리 프레임 설정 (영웅 난이도)",
	Never				= "거리 프레임 사용안함",
	Normal				= "일반 거리 프레임",
	DynamicPhase2		= "고라스의 검은 피 도중에만 필터링 사용",
	DynamicAlways		= "항상 디버프 필터링 사용"
})

L:SetMiscLocalization({
	voidYell	= "굴카와스 언고브 느조스."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "핏방울 흡수 (%s) : %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "핏방울 공격 가능",
	timerOozesReach		= "핏방울 도착"
})

L:SetOptionLocalization({
	warnOozesHit		= "보스에게 흡수된 핏방울에 대한 알림 보기",
	timerOozesActive	= "핏방울이 소환된 후 공격 가능하기까지 남은시간 바 표시",
	timerOozesReach		= "소환된 핏방울이 보스에게 도착하기까지 남은시간 바 표시",
	RangeFrame			= "$spell:104898 주문이 활성화 된 경우 거리 프레임 보기 (4m)\n(일반 난이도 이상)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242검정|r",
	Purple			= "|cFF9932CD보라|r",
	Red				= "|cFFFF0404빨강|r",
	Green			= "|cFF088A08초록|r",
	Blue			= "|cFF0080FF파랑|r",
	Yellow			= "|cFFFFA901노랑|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s : %d 남음",
	warnFrostTombCast		= "8초 후 %s"
})

L:SetTimerLocalization({
	TimerSpecial			= "다음 번개 또는 얼음"
})

L:SetOptionLocalization({
	WarnPillars				= "$journal:3919 또는 $journal:4069 남은 횟수 알림 보기",
	TimerSpecial			= "다음 $spell:105256 또는 $spell:105465 까지 남은시간 바 표시",
	RangeFrame				= "$spell:105269 (3m), $journal:4327 (10m) 주문의 영향을 받은 경우 거리 프레임 보기",
	AnnounceFrostTombIcons	= "$spell:104451 대상을 공격대 대화로 알리기 (승급 권한 필요)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "$spell:105256 또는 $spell:105465 주문의 초읽기 소리 듣기(5,4,3,2,1)",
	SetBubbles				= "$spell:104451 시전이 가능할 때 대화 말풍선을 표시하지 않음\n(전투 종료 후 원래대로 복구됨)"
})

L:SetMiscLocalization({
	TombIconSet				= "얼음 무덤 징표 : {rt%d} %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "5초 후 %s! (%d)"
})

L:SetTimerLocalization({
	TimerCombatStart	= "울트락시온 활성화",
	timerRaidCDs		= "%s 대기시간 : %s"
})

L:SetOptionLocalization({
	TimerCombatStart	= "울트락시온 활성화 바 표시",
	ResetHoTCounter		= "황혼의 시간 시전 횟수 재시작 설정",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "사용 안함",
	ResetDynamic		= "일반 2회, 영웅 3회 단위로 재시작",
	Reset3Always		= "난이도 구분 없이 3회 단위로 재시작",
	SpecWarnHoTN		= "황혼의 시간 5초 전 특수 경고 설정 (시전 횟수 재시작 설정에 영향 받음)",
	One					= "시전 횟수가 1일때 보기 (또는 1, 4, 7 일때)",
	Two					= "시전 횟수가 2일때 보기 (또는 2, 5 일때)",
	Three				= "시전 횟수가 3일때 보기 (또는 3, 6 일때)",
	dropdownRaidCDs		= "공격대 재사용 대기시간 바 표시",
	ShowRaidCDs			= "모두",
	ShowRaidCDsSelf		= "자신 것만"
})

L:SetMiscLocalization({
	Pull				= "엄청난 무언가가 느껴진다. 조화롭지 못한 그의 혼돈이 내 정신을 어지럽히는구나!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "황혼의 정예병!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "전투 시작",
	TimerAdd			= "다음 정예병"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 바 표시",
	TimerAdd			= "다음 황혼의 정예병 등장 바 표시",
	SpecWarnElites		= "황혼의 정예병 등장시 특수 경고 보기",
	SetTextures			= "1 단계 진행 도중 텍스쳐 투영 효과 끄기\n(2 단계에서 다시 활성화 됩니다.)"
})

L:SetMiscLocalization({
	SapperEmote			= "비룡이 빠르게 날아와 황혼의 폭파병을 갑판에 떨어뜨립니다!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat		= "%s|1이;가; 고통에 울부짖으며, 소용돌이치는 구름 속으로 달아납니다."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "등에 달라 붙으세요!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "$spell:105563 약화 효과가 없을 경우 특수 경고 보기",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "$spell:105563 약화 효과 없음에 대한 정보 프레임 보기",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	ShowShieldInfo			= "보스 체력 프레임에 $spell:105479 주문 흡수량 바 표시"
})

L:SetMiscLocalization({
	Pull			= "저 갑옷! 놈의 갑옷이 벗겨지는군! 갑옷을 뜯어내면 놈을 쓰러뜨릴 기회가 생길 거요!",
	NoDebuff		= "%s 없음",
	PlasmaTarget	= "이글거리는 혈장: %s",
	DRoll			= "회전하려고",
	DLevels			= "수평으로 균형을"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "$spell:108649 약화 효과 상태에 따른 거리 프레임 표시 (영웅 난이도)",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "넌 아무것도 못 했다. 내가 이 세상을 조각내주마."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"용의 영혼 일반몹"
})

L:SetWarningLocalization({
	DrakesLeft			= "황혼의 습격자 : %d 남음"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "황혼의 습격자 남은 횟수 알림 보기",
	TimerDrakes			= "황혼의 습격자가 $spell:109904 시전까지 남은시간 바 표시"
})

L:SetMiscLocalization({
	EoEEvent			= "소용없습니다. 용의 영혼이 가진 힘이 너무 강력해 안전하게 다룰 수 없습니다.",
	UltraxionTrash		= "다시 만나 반갑군, 알렉스트라자. 난 떠나 있는 동안 좀 바쁘게 지냈다.",
	UltraxionTrashEnded	= "가련한 녀석들, 이 실험은 위대한 결말을 위한 희생이었다. 알 연구의 결과물을 직접 확인해라."
})