local L

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "Zaxasj",
	Fathuul = "Fa'thuul"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "Set Resonance yell behavior for raid (If raid leader, overrides raid)",
	SetOne				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "Void Stone (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "Trident/Ocean",
	Storm = "Tempest Caller",
	Void = "Void Stone",
	Lunacy = "Lunacy",
	DBMConfigMsg	= "Unstable Resonance configuration set to %s to match raid leaders configuration."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Crucible Trash"
})
