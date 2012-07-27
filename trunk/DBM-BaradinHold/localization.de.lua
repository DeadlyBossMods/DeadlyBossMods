if GetLocale() ~= "deDE" then return end
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
	TimerFirstSpecial		= "Erste Spezialfähigkeit"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "Zeige Zeit bis erste Spezialfähigkeit nach $spell:105738 (erste Spezialfähigkeit\nist zufällig, entweder $spell:105067 oder $spell:104936)"
})
