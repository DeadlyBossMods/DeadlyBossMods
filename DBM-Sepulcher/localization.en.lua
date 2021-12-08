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

L:SetMiscLocalization({
	Deathtouch		= "Deathtouch",
	Dispel			= "Dispel",
	Sin				= "Sin",
	Stacks			= "Stacks"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
--L= DBM:GetModLocalization(2465)

---------------------------
--  Halondrus the Reclaimer --
---------------------------
--L= DBM:GetModLocalization(2463)

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "Set mod behavior for Blasphemy. Raid Leaders preference is used if using DBM",
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

L:SetMiscLocalization({
	Pylon		= "Pylon"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"Sepulcher Trash"
})
