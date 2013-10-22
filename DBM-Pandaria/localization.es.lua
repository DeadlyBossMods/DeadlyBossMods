if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar distancia dinamica basada en el estado de<br/>$spell:119622"
})

L:SetMiscLocalization({
	Pull				= "Dejad que vuestra ira florezca"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "¡Quiero sus cadáveres!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetMiscLocalization({
	Pull				= "How dare you interrupt our preparations! The Zandalari will not be stopped, not this time!" --TODO need translation
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetMiscLocalization({
	Pull				= "un viento frío? Se avecina la tormenta" -- first word is different in esMX, so we skip it
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "Mostrar flecha del DBM cuando a alguien le afecta $spell:144473"
})

L:SetMiscLocalization({
	Pull					= "Comencemos.",
	Victory					= "Vuestra esperanza brilla con fuerza, sobre todo cuando lucháis juntos."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "¡Comienza la prueba!",
	Wave1					= "¡No dejéis que las dificultades os nublen el juicio!",
	Wave2					= "¡Escuchad vuestra voz interior y buscad la verdad!",
	Wave3					= "¡Considerad siempre las consecuencias de vuestros actos!",
	Victory					= "Vuestra sabiduría os ha hecho superar esta prueba. Que siempre ilumine vuestro camino en la oscuridad."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "Ya veremos.",
--	Victory					= "",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all, TODO need translation
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "¡Ja! ¡La prueba comienza!",
	Victory					= "Sois fuertes, más de lo que creéis. Tenedlo presente en la oscuridad que os espera y dejad que os sirva de escudo."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetMiscLocalization({
	Pull					= "Ocuparéis mi lugar en el fuego eterno."
})
