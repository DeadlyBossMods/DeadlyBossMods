local L

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
L= DBM:GetModLocalization(2368)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Maut --
---------------------------
L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetMiscLocalization({
	ObeliskSpawn	= "Obelisks of shadow, rise!"--Only as backup, in case the NPC target check stops working
})

---------------------------
--  The Hivemind --
---------------------------
L= DBM:GetModLocalization(2372)

L:SetMiscLocalization({
	Together	= "Bosses Together",
	Apart		= "Bosses Apart"
})

---------------------------
--  Shad'har the Insatiable --
---------------------------
L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetOptionLocalization({
	OnlyParentBondMoves		= "Only show special warning for Charged Bonds if you are the parent point"
})

L:SetMiscLocalization({
	Furthest	= "Furthest Target",
	Closest		= "Closest Target"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "Set icon only once, per lowest health ooze scan, then disable until at least one dies",
	InterruptBehavior	= "Set Pumping Blood interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Two					= "2 person rotation ",--Default
	Three				= "3 person rotation ",
	Four				= "4 person rotation ",
	Five				= "5 person rotation "
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetMiscLocalization({
	ExitMind		= "Exit Mind",
	Away			= "Away",
	Toward			= "Toward"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"Ny'alotha Trash"
})

