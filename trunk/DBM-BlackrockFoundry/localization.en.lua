local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "Set Mythic difficulty group soak preference for special warnings",
	ThreeGroup			= "3 Group 1 stack each strat",
	TwoGroup			= "2 Group 2 stacks each strat" 
})

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators		= "Heat Regulator remaining: %d",
	warnBlastFrequency	= "Blast frequency increased: Approx Every %d sec"
})

L:SetOptionLocalization({
	warnRegulators		= "Announce how many Heat Regulator remain",
	warnBlastFrequency	= "Announce when $spell:155209 frequency increased",
	VFYellType			= "Set yell type for Volatile Fire (Mythic difficulty only)",
	Countdown			= "Countdown until expires",
	Apply				= "Only applied"
})

L:SetMiscLocalization({
	heatRegulator		= "Heat Regulator"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

L:SetTimerLocalization({
	timerStamperDodge			= DBM_CORE_AUTO_TIMER_TEXTS.nextcount:format((GetSpellInfo(160582)))
})

L:SetOptionLocalization({
	timerStamperDodge			= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format(160582)
})

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s sent ExRT rune position assignents. Your position: %s"
})

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "Raid split in 10"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "Show special warning 10 seconds before raid split",
	InfoFrameSpeed		= "Set when InfoFrame shows next train information",
	Immediately			= "As soon as doors open for current train",
	Delayed				= "After current train has come out" 
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "Lane",
	oneTrain		= "1 Random Lane: Train",
	oneRandom		= "Appear on 1 random lane",
	threeTrains		= "3 Random Lanes: Train",
	threeRandom		= "Appear on 3 random lanes",
	helperMessage	= "This encounter can be improved with 3rd party mod 'Thogar Assist' or one of many available DBM Voice packs (they audibly call out trains), available on Curse."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "Return to dock!"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Show special warning when boat player can safely return to dock",
	filterBladeDash		= "Do not show special warning for $spell:155794 when affected by $spell:170395",
	filterBloodRitual	= "Do not show special warning for $spell:158078 when affected by $spell:170405"
})

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition	= "Marked Position: %s"
})

L:SetMiscLocalization({
	customMFDSay	= "Marked %s on %s",
	customSlagSay	= "Bomb %s on %s",
	left			= "left",
	middle			= "middle",
	right			= "right"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Blackrock Foundry Trash"
})
