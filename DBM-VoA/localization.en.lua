local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon the Stone Watcher"
})

L:SetWarningLocalization({
	WarningGrab	= "Archavon grabbed >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Archavon berserk"
})

L:SetMiscLocalization({
	TankSwitch	= "%%s lunges for (%S+)!"
})

L:SetOptionLocalization({
	WarningGrab		= "Announce grab targets",
	ArchavonEnrage	= "Show timer for $spell:26662"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon the Storm Watcher"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Overcharge explosion",
	EmalonEnrage		= "Emalon berserk"
}

L:SetOptionLocalization{
	NovaSound			= "Play sound on $spell:65279",
	timerMobOvercharge	= "Show timer for Overcharged mob (stacking debuff)",
	EmalonEnrage		= "Show timer for $spell:26662",
	RangeFrame			= "Show range frame (10)"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon the Flame Watcher"
}

L:SetWarningLocalization{
	BurningFury		= "Burning Fury >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Koralon berserk"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "Play sound when you are affected by $spell:67332",
	BurningFury			= "Show warning for $spell:66721",
	KoralonEnrage		= "Show timer for $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "%s casts Meteor Fists!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon the Ice Watcher"
}

L:SetWarningLocalization{
	Frostbite	= "Frostbite on >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Toravon berserk"
}

L:SetOptionLocalization{
	Frostbite	= "Show warning for $spell:72098",
}

L:SetMiscLocalization{
	ToravonEnrage	= "Show timer for enrage"
}