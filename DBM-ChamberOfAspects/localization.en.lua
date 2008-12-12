local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningWallSoon		= "Fire Wall soon",
	WarningAdd		= "%s incoming"
})

L:SetTimerLocalization({
	TimerWall	= "Fire Wall cooldown",
	TimerAdd	= "%s"
})

L:SetOptionLocalization({
	WarningWallSoon		= "Show \"Fire Wall\" pre-warning",
	WarningAdd		= "Shows a warning when Vesperon\Shadron\Tenebron is incoming",
	TimerWall		= "Show \"Fire Wall\" cooldown timer",
	TimerAdd		= "Shows an incoming timer for Vesperon\Shadron\Tenebron"
})

L:SetMiscLocalization({
	Pull		= "It is my charge to watch over these eggs. I will see you burn before any harm comes to them!",
	Wall		= "The lava surrounding %s churns!",
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
})
