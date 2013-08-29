if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Zeige dynamisches Abstandsfenster (5m) basierend auf Spieler-Debuffs für $spell:119622",
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Ja... JA! Nutzt Eure Wut aus! Streckt mich nieder!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Bringt mir ihre Leichen!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "How dare you interrupt our preparations! The Zandalari will not be stopped, not this time!"--translate (trigger)
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Könnt Ihr den kalten Hauch spüren?"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "Zeige DBM-Pfeil, wenn jemand von $spell:144473 betroffen ist"
})

L:SetMiscLocalization({
	Pull					= "Then let us begin.",--translate (trigger)
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."--translate (trigger)
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "The trial begins!",--translate (trigger)
	Wave1					= "Do not let your judgement be clouded in trying times!",--translate (trigger)
	Wave2					= "Listen to your inner voice, and seek out the truth!",--translate (trigger)
	Victory					= "Your wisdom has seen you through this trial. May it ever light your way out of dark places."--translate (trigger)
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "We shall see.",--translate (trigger)
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--translate (trigger)
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "Ha ha! The trial commences",--translate (trigger)
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."--translate (trigger)
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
