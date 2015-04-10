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

L:SetOptionLocalization({
	InterruptBehavior	= "Set behavior for interrupt warnings",
	Smart				= "Interrupt warnings are based on bosses spine stacks",
	Fixed				= "Interrupts use a 5 or 3 sequence no matter what (even if boss doesn't)"
})

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "Heat Regulator remaining: %d",
	warnBlastFrequency		= "Blast frequency increased: Approx Every %d sec",
	specWarnTwoVolatileFire	= "Double Volatile Fire on you!"
})

L:SetOptionLocalization({
	warnRegulators			= "Announce how many Heat Regulator remain",
	warnBlastFrequency		= "Announce when $spell:155209 frequency increased",
	specWarnTwoVolatileFire	= "Show special warning when you have double $spell:176121",
	InfoFrame				= "Show info frame for $spell:155192 and $spell:155196",
	VFYellType2				= "Set yell type for Volatile Fire (Mythic difficulty only)",
	Countdown				= "Countdown until expires",
	Apply					= "Only applied"
})

L:SetMiscLocalization({
	heatRegulator		= "Heat Regulator",
	Regulator			= "Regulator %d",--Can't use above, too long for infoframe
	bombNeeded			= "%d Bomb(s)"
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
	Delayed				= "After current train has come out",
	HudMapUseIcons		= "Use raid Icons for HudMap instead of green circle",
	TrainVoiceAnnounce	= "Set when spoken alerts will play for trains",
	LanesOnly			= "Only announce incoming lanes",
	MovementsOnly		= "Only announce lane movements (Mythic Only)",
	LanesandMovements	= "Announce incoming lanes & movmeents (Mythic Only)"
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
	filterBladeDash3	= "Do not show special warning for $spell:155794 when affected by $spell:170395",
	filterBloodRitual3	= "Do not show special warning for $spell:158078 when affected by $spell:170405"
})

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "Marked Position: %s",
	specWarnSlagPosition	= "Bomb Position: %s"
})

L:SetOptionLocalization({
	PositionsAllPhases	= "Give positions for $spell:156096 yells during all phases (Instead of just phase 3. This is mostly for testing and assurances, this option is not actually recommended)"
})

L:SetMiscLocalization({
	customMFDSay	= "Marked %s on %s",
	customSlagSay	= "Bomb %s on %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Blackrock Foundry Trash"
})
