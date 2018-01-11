-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2017/08/24

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
-- Goroth --
---------------------------
L= DBM:GetModLocalization(1862)

---------------------------
-- Demonic Inquisition --
---------------------------
L= DBM:GetModLocalization(1867)

---------------------------
-- Harjatan the Bludger --
---------------------------
L= DBM:GetModLocalization(1856)

---------------------------
-- Mistress Sassz'ine --
---------------------------
L= DBM:GetModLocalization(1861)

L:SetOptionLocalization({
	TauntOnPainSuccess	= "同步痛苦负担的的计时器和嘲讽提示为释放技能之后(高级打法，不懂别乱用)"
})

---------------------------
-- Sisters of the Moon --
---------------------------
L= DBM:GetModLocalization(1903)

---------------------------
-- The Desolate Host --
---------------------------
L= DBM:GetModLocalization(1896)

L:SetOptionLocalization({
	IgnoreTemplarOn3Tank	= "当使用三个或以上Tank时忽略复活的圣殿骑士的骨盾的信息窗/提示/姓名条(请勿在战斗中更改，会打乱计次)"
})

---------------------------
-- Maiden of Vigilance --
---------------------------
L= DBM:GetModLocalization(1897)

---------------------------
-- Fallen Avatar --
---------------------------
L= DBM:GetModLocalization(1873)

L:SetOptionLocalization({
	InfoFrame =	"信息窗：战斗总览"
})

L:SetMiscLocalization({
	FallenAvatarDialog	= "你们眼前的躯壳曾承载过萨格拉斯的力量。但这座圣殿才是我们想要的。它能让我们将这世界化为灰烬！"
})

---------------------------
-- Kil'jaeden --
---------------------------
L= DBM:GetModLocalization(1898)

L:SetMiscLocalization({
	Obelisklasers	= "石碑激光"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name =	"萨格拉斯之墓小怪"
})
