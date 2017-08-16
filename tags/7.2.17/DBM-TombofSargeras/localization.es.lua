if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Goroth --
------------
L= DBM:GetModLocalization(1862)

L:SetTimerLocalization({
	timerComboWamboCD =	"Siguiente cometa/pincho (%d)"
})

L:SetOptionLocalization({
	timerComboWamboCD =	"Mostrar temporizador para el siguiente $spell:230345 o $spell:233021"
})

L:SetMiscLocalization({
})

---------------------------
-- Inquisición demoníaca --
---------------------------
L= DBM:GetModLocalization(1867)

--------------
-- Harjatan --
--------------
L= DBM:GetModLocalization(1856)

-----------------------
-- Maestra Sassz'ine --
-----------------------
L= DBM:GetModLocalization(1861)

-------------------------
-- Hermanas de la Luna --
-------------------------
L= DBM:GetModLocalization(1903)

-----------------------
-- Huésped Inhóspito --
-----------------------
L= DBM:GetModLocalization(1896)

--------------------
-- Doncella Vigía --
--------------------
L= DBM:GetModLocalization(1897)

------------------
-- Avatar Caído --
------------------
L= DBM:GetModLocalization(1873)

L:SetOptionLocalization({
	InfoFrame =	"Mostrar marco de información con la energía del jefe"
})

----------------
-- Kil'jaeden --
----------------
L= DBM:GetModLocalization(1898)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
