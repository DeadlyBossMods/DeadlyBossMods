if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar distancia dinamica basada en el estado de\n$spell:119622",
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

