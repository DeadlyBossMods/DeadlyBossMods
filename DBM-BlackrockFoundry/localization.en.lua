local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

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
	specWarnSplitSoon	= "Show special warning 10 seconds before raid split"
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

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Blackrock Foundry Trash"
})
