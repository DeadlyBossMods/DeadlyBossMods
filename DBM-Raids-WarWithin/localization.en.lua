local L

---------------------------
--  Ulgrax the Devourer (2902) --
---------------------------
--L= DBM:GetModLocalization(2607)

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
--  The Bloodbound Horror (2917) --
---------------------------
--L= DBM:GetModLocalization(2611)

---------------------------
--  Sikran, Captain of the Sureki (2898) --
---------------------------
--L= DBM:GetModLocalization(2599)

---------------------------
--  Rasha'nan (2918) --
---------------------------
--L= DBM:GetModLocalization(2609)

---------------------------
--  Bloodtwister Ovi'nax (2919) --
---------------------------
L= DBM:GetModLocalization(2612)

L:SetOptionLocalization({
	EggBreakerBehavior	= "Set Egg Breaker Behavior (Will override everyone elses setting if you are raid leader)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.CROSS_ICON_SMALL .. " with a melee > ranged > healer priority (matches Bigwigs behavior)",--Default
	UseAllAscending		= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t, etc with a melee > ranged > healer priority",
	AvoidRedNPurple		= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " with a melee > ranged > healer priority",
	DisableIconsForRaid	= "Disable setting icons and show yells with no icons",
	DisableAllForRaid	= "Disable setting icons and yells entirely"
})

---------------------------
--  Nexus-Princess Ky'veza(2920) --
---------------------------
--L= DBM:GetModLocalization(2601)

---------------------------
--  The Silken Court (2921) --
---------------------------
L= DBM:GetModLocalization(2608)

L:SetMiscLocalization({
	Red		= " [R-Takazj]",--Skeinspinner Takazj
	Blue	= " [B-Anub]"--Anub'arash
})

---------------------------
--  Queen Ansurek (2922) --
---------------------------
L= DBM:GetModLocalization(2602)

L:SetOptionLocalization({
	ToxinBehavior		= "Set Reactive Toxin Behavior (Will override everyone elses setting if you are raid leader)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " (all difficulties) with a melee > ranged > healer priority (matches Bigwigs behavior)",--Default
	UseAllAscending		= DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.MOON_ICON_SMALL .. " (all difficulties) with a melee > ranged > healer priority",
	DisableIconsForRaid	= "Disable setting icons and show yells with no icons",
	DisableAllForRaid	= "Disable setting icons and yells entirely"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NerubarPalaceTrash")

L:SetGeneralLocalization({
	name =	"Nerub-ar Palace Trash"
})

L:SetMiscLocalization({
	AutoPotioned	= "Potion automatically used (Note DBM will not auto use potion if you already have debuff). You can disable this in settings if you don't want it to auto use potion."
})

---------------------------
--  Vexie and the Geargrinders) --
---------------------------
--L= DBM:GetModLocalization(2639)

---------------------------
--  Cauldron of Carnage --
---------------------------
L= DBM:GetModLocalization(2640)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "Actively scan distance to each of bosses and automatically hide certain alerts and fade timers for the boss you are NOT near (more than 60 distance)"
})

---------------------------
--  Rik Reverb --
---------------------------
--L= DBM:GetModLocalization(2641)

---------------------------
--  Stix Bunkjunker --
---------------------------
--L= DBM:GetModLocalization(2642)

---------------------------
--  Sprocketmonger Lockenstock --
---------------------------
--L= DBM:GetModLocalization(2653)

---------------------------
--  The One-Armed Bandit --
---------------------------
--L= DBM:GetModLocalization(2644)

---------------------------
--  Mug'Zee, Heads of Security --
---------------------------
--L= DBM:GetModLocalization(2645)

---------------------------
--  Chrome King Gallywix --
---------------------------
--L= DBM:GetModLocalization(2646)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"Undermine Trash"
})
