local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "Debuffs (%s)",
	timerAvoidCD = "Avoid (%s)",
	timerUltimateCD = "Ultimate (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "Show timers for targeted debuff attacks: Magma Burst, Biting Chill, Enveloping Earth, Lightning Crash",
	timerAvoidCD = "Show timers for avoidable attacks: Molten Rupture, Frigid Torrent, Erupting Bedrock, Shocking Burst",
	timerUltimateCD = "Show timers for 100 energy ultimate attacks: Searing Carnage, Absolute Zero, Seismic Rupture, Thunder Strike"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff	= "Staff",
	eStaff	= "Empowered Staff"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
--L= DBM:GetModLocalization(2499)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"VotI Trash"
})
