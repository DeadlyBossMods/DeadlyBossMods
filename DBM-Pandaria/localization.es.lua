if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar distancia dinamica basada en el estado de<br/>$spell:119622",
	ReadyCheck			= "Reproducir sonido de comprobación de listos si el jefe es pulleado (incluso si no es mi objetivo actual)"
})

L:SetMiscLocalization({
	Pull				= "Yes, YES! Bring your rage to bear! Try to strike me down!" --TODO needs translation
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "Reproducir sonido de comprobación de listos si el jefe es pulleado (incluso si no es mi objetivo actual)"
})

L:SetMiscLocalization({
	Pull				= "Bring me their corpses!" --TODO needs translation
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "Reproducir sonido de comprobación de listos si el jefe es pulleado (incluso si no es mi objetivo actual)"
})

L:SetMiscLocalization({
	Pull				= "How dare you interrupt our preparations! The Zandalari will not be stopped, not this time!" --TODO need translation
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)


---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "Mostrar flecha del DBM cuando a alguien le afecta $spell:144473"
})

L:SetMiscLocalization({
	Pull					= "Then let us begin.", --TODO need translation
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places." --TODO need translation
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "The trial begins!", --TODO need translation
	Wave1					= "Do not let your judgement be clouded in trying times!", --TODO need translation
	Wave2					= "Listen to your inner voice, and seek out the truth!", --TODO need translation
	Victory					= "Your wisdom has seen you through this trial. May it ever light your way out of dark places." --TODO need translation
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "We shall see.", --TODO need translation
--	Victory					= "",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all, TODO need translation
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "Ha ha! The trial commences", --TODO need translation
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you." --TODO need translation
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

