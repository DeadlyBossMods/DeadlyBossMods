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
	TimerFirstSpecial		= "First special"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "Show next timer for the first special after $spell:105738\n(First special is random. Either $spell:105067 or $spell:104936)"
})
