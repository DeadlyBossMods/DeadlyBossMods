if GetLocale() ~= "zhTW" then return end
local L

----<<<<奈幽巴宮殿>>>>----
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
	EggBreakerBehavior	= "設定破蛋的行為 (如果您是團隊的領隊，將覆蓋每個人的設置)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.CROSS_ICON_SMALL .. " 使用近戰 > 遠程 > 治療者的優先級 (匹配 Bigwigs 的行為)",--Default
	UseAllAscending		= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t, 其他使用近戰 > 遠程 > 治療者 的優先級",
	AvoidRedNPurple		= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " 使用進戰 > 遠程 > 治療者優先級",
	DisableIconsForRaid	= "停用設置標記並顯示沒有標記的大喊",
	DisableAllForRaid	= "完全停用設置標記和大喊"
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
	Red		= " [紅-塔卡茲]",--Skeinspinner Takazj
	Blue	= " [藍-阿努]"--Anub'arash
})

---------------------------
--  Queen Ansurek (2922) --
---------------------------
L= DBM:GetModLocalization(2602)

L:SetOptionLocalization({
	ToxinBehavior		= "設定反應泡沫的行為 (如果您是團隊的領隊，將覆蓋每個人的設置))",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. "(所有難度) 使用近戰 > 遠程 > 治療者的優先級 (匹配 Bigwigs 的行為)",--Default
	UseAllAscending		= DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.MOON_ICON_SMALL .. " (所有難度) 使用近戰 > 遠程 > 治療者的優先級",
	DisableIconsForRaid	= "停用設置標記並顯示沒有標記的大喊",
	DisableAllForRaid	= "完全停用設置標記和大喊"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NerubarPalaceTrash")

L:SetGeneralLocalization({
	name =	"奈幽巴宮殿小怪"
})

L:SetMiscLocalization({
	AutoPotioned	= "藥水會自動使用（注意如果您已經有減益，DBM則不會自動使用藥水）。如果您不希望自動使用藥水，則可以在設置中禁用它。"
})


----<<<<解放幽坑城>>>>----
---------------------------
--  Vexie and the Geargrinders) --
---------------------------
--L= DBM:GetModLocalization(2639)

---------------------------
--  Cauldron of Carnage --
---------------------------
L= DBM:GetModLocalization(2640)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "積極掃描每個首領的距離，並自動隱藏您未接近的首領的某些警報和淡出計時器（超過60個距離）"
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
	name =	"幽坑城小怪"
})
