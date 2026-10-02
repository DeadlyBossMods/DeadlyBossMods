if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Entombed Sentinels (3445) --
---------------------------
L= DBM:GetModLocalization(2874)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "각 보스와의 거리를 주기적으로 검사해서 자동으로 멀리 있는 보스(48미터 이상)와 관련된 경고를 숨기고 타이머를 흐리게 표시"
})

---------------------------
--  LightblindedVanguard (3180) --
---------------------------
L= DBM:GetModLocalization(2737)

L:SetMiscLocalization({
	JudgementShield	= "심판-응방",
	JudgementFV		= "심판-선고"
})

---------------------------
--  Beloren, Child of Alar (3182) --
---------------------------
L= DBM:GetModLocalization(2739)

L:SetMiscLocalization({
	ColorSwap		= "색 교체"
})

---------------------------
--  Midnight Falls (3183) --
---------------------------

L= DBM:GetModLocalization(2740)

L:SetMiscLocalization({
	MemoryGame		= "메모리 게임"
})
