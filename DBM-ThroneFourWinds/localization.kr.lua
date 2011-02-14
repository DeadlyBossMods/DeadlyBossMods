if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "바람의 비밀의회"
})

L:SetWarningLocalization({
	warnSpecial				= "특수 능력 활성화!!", --Hurricane/Zephyr/Sleet Storm Active",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "특수 능력 활성화!!"
})

L:SetTimerLocalization({
	timerSpecial			= "특수 능력 쿨타임",
	timerSpecialActive		= "특수 능력 활성화"
})

L:SetMiscLocalization({
--	gatherstrength			= "%s에게서 힘을 모으기 시작합니다!"
	gatherstrength			= "힘을 모으기 시작합니다!"
})

L:SetOptionLocalization({
	warnSpecial				= "특수 능력 시전 경고 보기", -- Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "특수 능력 시전을 할 경우 특수 경고 보기",
	timerSpecial			= "특수 능력 쿨다운 타이머 보기",
	timerSpecialActive		= "특수 능력 유지 타이머 보기",
	OnlyWarnforMyTarget		= "오직 대상/주시대상일 경우만 타이머/경고 보기\n(풀링 포함. 그외에 모두 숨김)"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "알아키르"
})


L:SetWarningLocalization({
	WarnFeedback		= "%s : >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd				= "곧 폭풍 정령"	
})

L:SetTimerLocalization({
	TimerFeedback 		= "역순환 (%d)",
	TimerAddCD			= "다음 폭풍 정령"	
})

L:SetOptionLocalization({
	WarnFeedback		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "알 수 없음"),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback		= "$spell:87904 유지 타이머 보기",
	WarnAdd				= "폭풍 정령이 생성 될 때 경고 보기",
	TimerAddCD			= "폭풍 정령 생성 쿨타임 보기"
})

L:SetMiscLocalization({
	summonSquall		= "폭풍이여! 너를 소환하노라!",
--	phase2				= "집요한 것들. 이젠 화가 나는구나!" "Your futile persistance angers me!",--Not used, Acid rain is, but just in case there is reliability issues with that, localize this anyways.
	phase3				= "그만! 더는 자제하지 않겠다!" -- check "Enough! I will no longer be contained!"
})
