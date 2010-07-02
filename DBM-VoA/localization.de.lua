if GetLocale() ~= "deDE" then return end

local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon der Steinwächter"
})

L:SetWarningLocalization({
	WarningGrab	= "Archavon greift nach >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Archavon-Berserker"
})

L:SetMiscLocalization({
	TankSwitch	= "%%s stürzt sich auf (%S+)!"	-- to be checked
})

L:SetOptionLocalization({
	WarningGrab		= "Verkünde Griffziele",
	ArchavonEnrage	= "Zeige Timer für $spell:26662"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon der Sturmwächter"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Überladungsexplosion",
	EmalonEnrage		= "Emalon-Berserker"
}

L:SetOptionLocalization{
	NovaSound			= "Spiele Sound bei $spell:65279",
	timerMobOvercharge	= "Zeige Timer für Überladen (stapelnder Debuff)",
	EmalonEnrage		= "Zeige Timer für $spell:26662",
	RangeFrame			= "Zeige Abstandsfenster (10 m)"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon der Flammenwächter"
}

L:SetWarningLocalization{
	BurningFury		= "Brennender Atem >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Koralon-Berserker"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "Spiele Sound wenn du von $spell:67332 betroffen bist",
	BurningFury			= "Zeige Warnung für $spell:66721",
	KoralonEnrage		= "Zeige Timer für $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "%s wirkt Meteorfäuste!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon der Eiswächter"
}

L:SetWarningLocalization{
	Frostbite	= "Erfrierung auf >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Toravon-Berserker"
}

L:SetOptionLocalization{
	Frostbite	= "Zeige Warnung für $spell:72098",
}

L:SetMiscLocalization{
	ToravonEnrage	= "Zeige Timer für Berserker"
}