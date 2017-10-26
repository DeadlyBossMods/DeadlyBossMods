if GetLocale() ~= "zhTW" then return end
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
	TauntOnPainSuccess	= "同步痛苦重擔的計時器和嘲諷警告改為施放成功而不是開始施放(為了某些傳奇戰術，否則不建議使用此選項。)"
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
	IgnoreTemplarOn3Tank	= "當使用三或更多坦克時忽略再活化的聖殿騎士的骨盾訊息框架/提示/名條(勿在戰鬥變更，這會打亂次數)"
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
	InfoFrame =	"為戰鬥總覽顯示訊息框架"
})

L:SetMiscLocalization({
	FallenAvatarDialog	= "你看到的這個軀殼原本蘊含薩格拉斯的力量，但我們要的是這整座聖殿！只要得到聖殿，就能把你們的世界燒成灰燼！"
})

---------------------------
-- Kil'jaeden --
---------------------------
L= DBM:GetModLocalization(1898)

L:SetWarningLocalization({
	warnSingularitySoon		= "%d秒後擊退"
})

L:SetMiscLocalization({
	Obelisklasers	= "石碑雷射"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name =	"薩格拉斯之墓小怪"
})
