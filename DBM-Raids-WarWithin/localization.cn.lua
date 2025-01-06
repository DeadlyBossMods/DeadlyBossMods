--Mini Dragon <流浪者酒馆-Brilla@金色平原(The Golden Plains-CN)> projecteurs@gmail.NOSPAM.com 20250106
--Blizzard Entertainment

if GetLocale() ~= "zhCN" then return end
local L

----<<<<尼鲁巴宫殿>>>>----
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
	EggBreakerBehavior	= "设定打破卵的处理机制(团长设定覆盖全团)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.CROSS_ICON_SMALL .. " 按照近战、远程、治疗的优先级 (与 Bigwigs 行为一致)",--Default
	UseAllAscending		= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t, 其他按照近战、远程、治疗的优先级",
	AvoidRedNPurple		= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " 按照近战、远程、治疗的优先级",
	DisableIconsForRaid	= "取消标记设置，喊话内容不显示标记",
	DisableAllForRaid	= "完全取消标记与喊话"
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
	Red		= " [红-塔]",--Skeinspinner Takazj 纺束者塔卡兹基
	Blue	= " [蓝-阿]"--Anub'arash 阿努巴拉什
})

---------------------------
--  Queen Ansurek (2922) --
---------------------------
L= DBM:GetModLocalization(2602)

L:SetOptionLocalization({
	ToxinBehavior		= "设定活性毒素的处理机制(团长设定覆盖全团)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " (所有难度) 按照近战、远程、治疗的优先级 (与 Bigwigs 行为一致)",--Default
	UseAllAscending		= DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.MOON_ICON_SMALL .. " (所有难度) 按照近战、远程、治疗的优先级",
	DisableIconsForRaid	= "取消标记设置，喊话内容不显示标记",
	DisableAllForRaid	= "完全取消标记与喊话"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NerubarPalaceTrash")

L:SetGeneralLocalization({
	name =	"尼鲁巴宫殿小怪"
})

L:SetMiscLocalization({
	AutoPotioned	= "自动使用药水。 (DBM不会在已有debuff的情况下使用药水。) 如果不想自动使用药水可以关闭本选项。"
})

----<<<<解放安德麦>>>>----
---------------------------
--  Vexie and the Geargrinders --维克茜和磨轮
---------------------------
--L= DBM:GetModLocalization(2639)

---------------------------
--  Cauldron of Carnage --血腥大熔炉
---------------------------
L= DBM:GetModLocalization(2640)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "自动扫描与每个Boss的距离，如果Boss在60码之外屏蔽掉一些不太重要的警报和计时条。"
})

---------------------------
--  Rik Reverb --里克·混响
---------------------------
--L= DBM:GetModLocalization(2641)

---------------------------
--  Stix Bunkjunker --斯提克斯·堆渣
---------------------------
--L= DBM:GetModLocalization(2642)

---------------------------
--  Sprocketmonger Lockenstock --链齿狂人洛肯斯多
---------------------------
--L= DBM:GetModLocalization(2653)

---------------------------
--  The One-Armed Bandit --独臂盗匪
---------------------------
--L= DBM:GetModLocalization(2644)

---------------------------
--  Mug'Zee, Heads of Security --穆格·兹伊，安保头子
---------------------------
--L= DBM:GetModLocalization(2645)

---------------------------
--  Chrome King Gallywix --铬武大王加里维克斯
---------------------------
--L= DBM:GetModLocalization(2646)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"解放安德麦小怪"
})
