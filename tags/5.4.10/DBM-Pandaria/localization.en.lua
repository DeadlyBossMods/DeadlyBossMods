local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Show dynamic range frame based on player debuff status for<br/>$spell:119622",
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

L:SetMiscLocalization({
	Pull				= "Can you feel a chill wind blow?"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	SetIconOnBeacon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144473),
	BeaconArrow				= "Show DBM Arrow when someone is affected by $spell:144473"
})

L:SetMiscLocalization({
	Pull					= "Then let us begin.",
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetOptionLocalization({
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(11, 144532)
})

L:SetMiscLocalization({
	Pull					= "The trial begins!",
	Wave1					= "Do not let your judgement be clouded in trying times!",
	Wave2					= "Listen to your inner voice, and seek out the truth!",
	Wave3					= "Always consider the consequences of your actions!",
	Victory					= "Your wisdom has seen you through this trial. May it ever light your way out of dark places."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "We shall see.",
	Victory					= "SOME RANDOM BLAH BLAH BLAH",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetOptionLocalization({
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 144642)
})

L:SetMiscLocalization({
	Pull					= "Ha ha! The trial commences!",
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetOptionLocalization({
	SetIconOnBurningSoul	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144689),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 144689)
})

L:SetMiscLocalization({
	Pull					= "You will take my place on the eternal brazier."
})
