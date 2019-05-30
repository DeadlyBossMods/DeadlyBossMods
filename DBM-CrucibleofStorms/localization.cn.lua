-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2019/05/29

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "扎克萨奇",
	Fathuul = "法索乌"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "设置不稳定回响的大喊 (团长覆盖全团设置)",
	SetOne				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "深海三叉戟",
	Storm = "风暴召唤者",
	Void = "虚空石",
	Lunacy = "疯狂",
	DBMConfigMsg	= "团长将不稳定回响设置成 %s."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"风暴熔炉小怪"
})
