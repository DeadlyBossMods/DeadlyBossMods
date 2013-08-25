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
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."--translate (trigger)
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

L:SetMiscLocalization({
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."--translate (trigger)
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
