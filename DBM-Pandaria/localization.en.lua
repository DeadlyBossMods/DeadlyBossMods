local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Show dynamic range frame based on player debuff status for\n$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

L:SetMiscLocalization({
	Pull				= "Yes, YES! Bring your rage to bear! Try to strike me down!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "Bring me their corpses!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 137511)
})

L:SetMiscLocalization({
	Pull				= "How dare you interrupt our preparations! The Zandalari will not be stopped, not this time!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 136340)
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	SetIconOnBeacon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144473),
	BeaconArrow				= "Show DBM Arrow when someone is affected by $spell:144473"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
