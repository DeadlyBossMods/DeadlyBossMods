if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon el Vigía de piedra"
})

L:SetWarningLocalization({
	WarningGrab	= "Archavon agarró >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Enrage"
})

L:SetMiscLocalization({
	TankSwitch	 = "%%s se abalanza sobre (%S+)!"
})

L:SetOptionLocalization({
	WarningGrab 	= "Mostrar aviso para cambiar tank",
	ArchavonEnrage	= "Mostrar tiempo para $spell:26662"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Sobrecarga",
	EmalonEnrage		= "Enrage"
}

L:SetOptionLocalization{
	NovaSound			= "Reproducir sonido en $spell:65279",
	timerMobOvercharge	= "Mostrar tiempo para que un Mob se haga grande.",
	EmalonEnrage		= "Mostrar tiempo para $spell:26662",
	RangeFrame			= "Mostrar distancia"
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon"
}

L:SetWarningLocalization{
	BurningFury		= "Furia ardiente >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Enrage"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "Reproducir sonido si estas en Ceniza flamigera",
	BurningFury			= "Mostrar aviso para $spell:66721",
	KoralonEnrage		= "Mostrar tiempo para $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "¡%s lanza Puños meteóricos!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon"
}

L:SetWarningLocalization{
	Frostbite	= "Mordedura de Escarcha en >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Enrage"
}

L:SetOptionLocalization{
	Frostbite	= "Mostrar aviso para $spell:72098",
}

L:SetMiscLocalization{
	ToravonEnrage	= "Mostrar tiempo para enrage"
}