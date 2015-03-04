if GetLocale() ~= "deDE" then return end
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
	warnRegulators		= "Heat Regulator remaining: %d",--translate
	warnBlastFrequency	= "Blast frequency increased: Approx Every %d sec"--translate
})

L:SetOptionLocalization({
	warnRegulators		= "Announce how many Heat Regulator remain",--translate
	warnBlastFrequency	= "Announce when $spell:155209 frequency increased",--translate
	VFYellType			= "Set yell type for Volatile Fire (Mythic difficulty only)",--translate
	Countdown			= "Countdown until expires",--translate
	Apply				= "Only applied"--translate
})

L:SetMiscLocalization({
	heatRegulator		= "Heat Regulator"--translate
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

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
	lane			= "Lane",--translate
	oneTrain		= "1 Random Lane: Train",--translate
	oneRandom		= "Appear on 1 random lane",--translate
	threeTrains		= "3 Random Lanes",--translate
	threeRandom		= "Appear on 3 random lanes",--translate
	helperMessage	= "Dieser Kampf kann durch das Drittanbieter-Addon \"Thogar Assist\" oder einen der zahlreichen DBM-Sprachpacks (diese sagen die Züge akus­tisch an) erleichtert werden, verfügbar auf Curse."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "Return to dock NOW!"--translate
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Show special warning when boat player can safely return to dock"--translate
})

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"--translate
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
	name =	"Trash der Schwarzfelsgießerei"
})
