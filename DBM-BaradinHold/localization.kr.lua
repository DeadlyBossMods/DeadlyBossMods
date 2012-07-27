if GetLocale() ~= "koKR" then return end
local L

----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

L:SetOptionLocalization({
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial		= "다음 증오 또는 꼬챙이"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "$spell:105738 주문 시전 후 다음 특수 공격에 대한 바 표시\n(첫번째 특수 공격은 $spell:105067 와 $spell:104936 중 무작위로 결정됩니다.)"
})
