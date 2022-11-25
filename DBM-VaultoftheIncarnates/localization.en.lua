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
	timerDamageCD = "Damage (%s)",
	timerAvoidCD = "Avoid (%s)",
	timerUltimateCD = "Ultimate (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "Show timers for targeted damage attacks: $spell:382563, $spell:373678, $spell:391055, $spell:373487",
	timerAvoidCD = "Show timers for avoidable attacks: $spell:373329, $spell:391019, $spell:395893, $spell:390920",
	timerUltimateCD = "Show timers for 100 energy ultimate attacks: $spell:374022, $spell:372456, $spell:374691, $spell:374215"
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
L= DBM:GetModLocalization(2499)

L:SetMiscLocalization({
	negative = "negative",
	positive = "positive"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"VotI Trash"
})
