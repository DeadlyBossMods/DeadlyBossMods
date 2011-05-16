if GetLocale() ~= "koKR" then return end
local L

---------------
-- Alysrazor --
---------------
L = DBM:GetModLocalization("Alysrazor")

L:SetGeneralLocalization({
	name = "알리스라조르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-------------------
-- Lord Rhyolith --
-------------------
L = DBM:GetModLocalization("Rhyolith")

L:SetGeneralLocalization({
	name = "군주 라이올리스"
})

L:SetWarningLocalization({
	WarnElementals		= "정령 소환"
})

L:SetTimerLocalization({
	TimerElementals		= "다음 정령"
})

L:SetOptionLocalization({
	WarnElementals		= "정령 소환 경고 보기",
	TimerElementals		= "다음 정령 소환 타이머 보기"
})

L:SetMiscLocalization({
})

----------------
-- Beth'tilac --
----------------
L = DBM:GetModLocalization("Bethtilac")

L:SetGeneralLocalization({
	name = "베스틸락"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "다음 Spinners",
	TimerSpiderlings	= "다음 Spiderlings",
	TimerDrone			= "다음 Drone"
})

L:SetOptionLocalization({
	TimerSpinners		= "다음 Cinderweb Spinners 타이머 보기",
	TimerSpiderlings	= "다음 Cinderweb Spiderlings 타이머 보기",
	TimerDrone			= "다음 Cinderweb Drone 타이머 보기"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------
-- Shannox --
-------------
L = DBM:GetModLocalization("Shannox")

L:SetGeneralLocalization({
	name = "샤녹스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-------------
-- Baleroc --
-------------
L = DBM:GetModLocalization("Baleroc")

L:SetGeneralLocalization({
	name = "발레록"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L = DBM:GetModLocalization("FandralStaghelm")

L:SetGeneralLocalization({
	name = "청지기 스태그헬름"	-- too long for interface?
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L = DBM:GetModLocalization("Ragnaros-Cata")

L:SetGeneralLocalization({
	name = "라그나로스 (불의 땅)"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})