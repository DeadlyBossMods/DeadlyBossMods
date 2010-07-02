if GetLocale() ~= "koKR" then return end

local L

----------------
--  아카본  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "바위 감시자 아카본"
})

L:SetWarningLocalization({
	WarningGrab		= "분쇄의 도약 : >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "아카본 광폭화"
})

L:SetMiscLocalization({
	TankSwitch 		= "(%S+)에게 돌진합니다!"
})

L:SetOptionLocalization({
	WarningGrab 	= "분쇄의 도약 대상 알리기",
	ArchavonEnrage	= "$spell:26662 타이머 보기"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "폭풍의 감시자 에말론"
}

L:SetWarningLocalization{
--	specWarnNova 		= "번개 회오리 - 피하세요!",
}

L:SetTimerLocalization{
	timerMobOvercharge	= "과충전 폭발",
	EmalonEnrage		= "에말론 광폭화"
}

L:SetOptionLocalization{
	NovaSound			= "$spell:65279의 특수 소리 재생",	
	timerMobOvercharge	= "과충전 된 몹의 시간 보기(디버프 중첩)",
	EmalonEnrage		= "$spell:26662 타이머 보기",
	RangeFrame			= "거리 프레임 보기(10 m)"
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "화염 감시자 코랄론"
}

L:SetWarningLocalization{
	BurningFury			= "불타는 격노 : >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage		= "코랄론 광폭화"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "$spell:67332의 영향을 받을 경우 특수 소리 재생하기",
	BurningFury			= "$spell:66721 경고 보기",
	KoralonEnrage		= "$spell:26662 타이머 보기"
}

L:SetMiscLocalization{
--	Meteor	= "%s이 유성 주먹을 시전합니다!"
	Meteor	= "유성 주먹을 시전합니다!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "얼음 감시자 토라본"
}

L:SetWarningLocalization{
	Frostbite		= "동상 : >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "토라본 광폭화"
}

L:SetOptionLocalization{
	Frostbite		= "$spell:72098의 경고 보기",
}

L:SetMiscLocalization{
	ToravonEnrage	= "$spell:26662 타이머 보기"
}