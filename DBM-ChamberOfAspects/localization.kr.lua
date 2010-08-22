if GetLocale() ~= "koKR" then return end

local L
----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  샤드론  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "샤드론"
})


---------------
--  테네브론  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "테네브론"
})


---------------
--  베스페론  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "베스페론"
})


---------------
--  살타리온  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "살타리온"
})

L:SetWarningLocalization({
	WarningTenebron			= "테네브론 진입",
	WarningShadron			= "샤드론 진입",
	WarningVesperon			= "베스페론 진입",
	WarningFireWall			= "화염의 벽!",
	WarningVesperonPortal	= "베스페론의 포탈!!",
	WarningTenebronPortal	= "테네브론의 포탈!!",
	WarningShadronPortal	= "샤드론의 포탈!!",
})

L:SetTimerLocalization({

	TimerTenebron		= "테네브론 진입",
	TimerShadron		= "샤드론 진입",
	TimerVesperon		= "베스페론 진입"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "화염의 벽 특수 소리 듣기",
	AnnounceFails			= "화염의 벽 및 어둠의 균열을 피하지 못한 공대원 채팅창에 알리기\n(공대 경보 권한이 있을 경우)",
	TimerTenebron			= "테네브론 타이머 보기",
	TimerShadron			= "샤드론 타이머 보기",
	TimerVesperon			= "베스페론 타이머 보기",
	WarningFireWall			= "화염의 벽 특수 경고 보기",
	WarningTenebron			= "테네브론 생성 알리기",
	WarningShadron			= "샤드론 생성 알리기",
	WarningVesperon			= "베스페론 생성 알리기",
	WarningTenebronPortal	= "테네브론 포탈 특수 경고 보기",
	WarningShadronPortal	= "샤드론 포탈 특수 경고 보기",
	WarningVesperonPortal	= "베스페론 포탈 특수 경고 보기",
})

L:SetMiscLocalization({
--	Wall			= "%s를 둘러싼 용암이 끓어오릅니다!",
--	Portal			= "%s이 황혼의 차원문을 엽니다!!",
	Wall			= "둘러싼 용암이 끓어오릅니다!",
	Portal			= "황혼의 차원문을 엽니다!!",
	NameTenebron	= "테네브론",
	NameShadron		= "샤드론",
	NameVesperon	= "베스페론",
	FireWallOn		= "용암 파도 : %s",
	VoidZoneOn		= "어둠의 균열 : %s",
	VoidZones		= "어둠의 균열 실패(현재 트라이): %s",
	FireWalls		= "용암 파도 실패 (현재 트라이): %s",
	--[[ not in use; don't translate.
	Vesperon	= "베스페론, 알이 위험하다! 날 도와라!",
	Shadron		= "샤드론! 이리 와라! 위험한 상황이다!",
	Tenebron	= "테네브론! 너도 알을 지킬 책임이 있어!"
	--]]
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "전쟁의 아들 발타루스"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "곧 분리"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "분리 사전 경고 보기",
	RangeFrame			= "거리 프레임 보기 (12 미터)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
})


-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "사비아나 레이지파이어"
})

L:SetWarningLocalization({
	SpecialWarningTranq		= "격노 - 지금 평정!"
})

L:SetOptionLocalization({
	SpecialWarningTranq		= "$spell:78722 특수 경고 보기(마취)",
	RangeFrame				= "거리 프레임 보기 (10 미터)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

L:SetMiscLocalization{
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "장군 자리스리안"
})

L:SetWarningLocalization({
	WarnAdds			= "새로운 몹",
	warnCleaveArmor		= "%s : >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "새로운 몹"
})

L:SetOptionLocalization({
	WarnAdds		= "새로운 추가몹 알리기",
	TimerAdds		= "새로운 추가몹 타이머 보기",
	warnCleaveArmor	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(74367, GetSpellInfo(74367) or "알 수 없음")	
})

L:SetMiscLocalization({
	SummonMinions	= "저놈들을 재로 만들어버려라!"
})
-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "황혼의 파괴자 할리온"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "곧 2 단계",
	WarnPhase3Soon		= "곧 3 단계",
	TwilightCutterCast	= "황혼 절단기 시전 : 5 초"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "2 단계 사전 경고 보기 (79% 전)",
	WarnPhase3Soon			= "3 단계 사전 경고 보기 (54% 전)",
	TwilightCutterCast		= "$spell:77844을 시전할 때 경고 보기",	
	AnnounceAlternatePhase	= "해당 위치에 없을 경우에도 모든 단계의 경고/타이머 보기",
	SoundOnConsumption		= "$spell:74562 또는 $spell:74792 소리 재생",--We use localized text for these functions
	SetIconOnConsumption	= "$spell:74562 또는 $spell:74792 대상 공격대 아이콘 설정",--So we can use single functions for both versions of spell.
	YellOnConsumption		= "$spell:74562 또는 $spell:74792 외치기",
	WhisperOnConsumption	= "$spell:74562 또는 $spell:74792의 대상에게 귓속말 보내기"	
})

L:SetMiscLocalization({
	NormalHalion			= "Physical Halion",
	TwilightHalion			= "Twilight Halion",
	MeteorCast				= "하늘이 타오른다!",
	Phase2					= "황혼 세계에서는 고통만이 있으리라! 자신 있다면 들어와 봐라!",
	Phase3					= "나는 빛이자 어둠이다! 필멸자들어, 데스윙의 사자 앞에 무릎 꿇어라!",
	twilightcutter			= "주위를 회전하는 구슬들이 고동치며 어둠의 기운을 내뿜습니다!",
	YellCombustion			= "나에게 맹렬한 발화!",
	WhisperCombustion		= "당신에게 맹렬한 발화! 외곽으로 뛰셈!",	
	YellConsumption			= "나에게 영혼 소진!",
	WhisperConsumption		= "당신에게 영혼 소진! 외곽으로 뛰셈!",	
	Kill					= "필멸자들아, 승리를 만끽해라. 그것이 마지막일 테니. 주인님이 돌아오시면 이 세상은 불타버리리라!"
})
