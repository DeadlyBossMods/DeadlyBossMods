local L

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "Announce personal Remnant debuff stacks"
})

L:SetMiscLocalization({
	Remnant	= "Remnant"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "Continue repeating icon yells for Scorn and Ire until debuffs are gone"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "Fragment "--Space is intentional, leave a space to add a number after it
})

---------------------------
--  Remnant of Ner'zhul --
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain --
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal --
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones --
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "Set marking behavior for raid (If raid leader, overrides raid)",
	TypeOne			= "DBM Default (Melee > Ranged)",
	TypeTwo			= "BW Default (Combatlog order)"
})

L:SetMiscLocalization({
	Dissection	= "Dissection!",
	Dismantle	= "Dismantle"
})

---------------------------
--  Fatescribe Roh-Kalo --
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad --
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner --
---------------------------
--L= DBM:GetModLocalization(2441)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"SoD Trash"
})
