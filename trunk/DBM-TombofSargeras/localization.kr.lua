if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Goroth --
---------------------------
L= DBM:GetModLocalization(1862)

L:SetTimerLocalization({
	timerComboWamboCD =	"다음 유성/가시 (%d)"
})

L:SetOptionLocalization({
	timerComboWamboCD =	"다음 몰아치는 유성/지옥불 가시 타이머 바 보기"
})

L:SetMiscLocalization({
})

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
	InfoFrame =	"보스 기력을 정보 창에 표시"
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
	name =	"살게라스의 무덤 일반몹"
})
