local L

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle --
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "Set Ritualist icon setting behavior. Raid Leaders preference is used if they're using DBM",
	SetOne					= "Differ from seeds/Night Hunter (no conflicts) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "Match seeds/Night Hunter (but conflicts if seeds and ritualists at same time) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"-- 1-4
--	SetThree				= "Match seeds/Night Hunter (no conflicts, but requires raid members having extended icons properly installed to see them) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "Deathtouch",
	Dispel			= "Dispel",
	ExtendReset		= "Your Ritualist icon dropdown setting has been reset due to fact you were using extended icons before, but aren't any longer"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~Tank Combo (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "Show timer (with count) for tank combo cooldown"
})

---------------------------
--  Halondrus the Reclaimer --
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "Mote"
})

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "Set mod behavior for Blasphemy. Raid Leaders preference is used if they're using DBM",
	Auto				= "'on you' alert with auto assigned partner. Chat bubbles show unique symbols for matchups",
	Generic				= "'on you' alert with no assignments. Chat bubbles show generic symbols for two debuffs",--Default
	None				= "'on you' alert with no assignments. No Chat bubbles"
})

---------------------------
--  Lords of Dread --
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --
---------------------------
L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "Heal Azeroth (%s)",
	warnDispel			= "Dispel (%s)"
})

L:SetTimerLocalization{
	timerPits			= "Pits Open",
	timerHealAzeroth	= "Heal Azeroth (%s)",
	timerDispels		= "Dispels (%s)"
}

L:SetOptionLocalization({
	timerPits			= "Show timer for when the floor pits open up and expose holes you can fall into.",
	warnHealAzeroth		= "Show warning for when you need to heal azeroth (via fight mechanics) on mythic difficulty, based on Echo's strategy",
	warnDispel			= "Show warning for when you need to dispel Death Sentence on mythic difficulty, based on Echo's strategy",
	timerHealAzeroth	= "Show timer for when you need to heal azeroth (via fight mechanics) on mythic difficulty, based on Echo's strategy",
	timerDispels		= "Show timer for when you need to dispel Death Sentence on mythic difficulty, based on Echo's strategy"
})

L:SetMiscLocalization({
	Pylon				= "Pylon",
	AzerothSoak			= "Azeroth Soak"--Short Text for Desolation
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"Sepulcher Trash"
})
