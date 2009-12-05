if GetLocale() ~= "koKR" then return end

local L
---------------
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
	WarningTenebron			= "테네브론 생성 타이머 보기",
	WarningShadron			= "샤드론 생성 타이머 보기",
	WarningVesperon			= "베스페론 생성 타이머 보기",
	WarningTenebronPortal	= "테네브론 포탈 특수 경고 보기",
	WarningShadronPortal	= "샤드론 포탈 특수 경고 보기",
	WarningVesperonPortal	= "베스페론 포탈 특수 경고 보기",
})

L:SetMiscLocalization({
	Wall			= "%s를 둘러싼 용암이 끓어오릅니다!",
	Portal			= "%s이 황혼의 차원문을 엽니다!!",
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
