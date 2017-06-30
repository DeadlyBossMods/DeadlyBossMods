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

---------------------------
-- Sisters of the Moon --
---------------------------
L= DBM:GetModLocalization(1903)

---------------------------
-- The Desolate Host --
---------------------------
L= DBM:GetModLocalization(1896)

---------------------------
-- Maiden of Vigilance --
---------------------------
L= DBM:GetModLocalization(1897)

---------------------------
-- Fallen Avatar --
---------------------------
L= DBM:GetModLocalization(1873)

L:SetOptionLocalization({
	InfoFrame =	"為首領能量顯示訊息框架"
})

---------------------------
-- Kil'jaeden --
---------------------------
L= DBM:GetModLocalization(1898)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name =	"薩格拉斯之墓小怪"
})
