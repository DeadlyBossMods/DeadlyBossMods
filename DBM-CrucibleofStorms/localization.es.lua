if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
-- La Cábala Infatigable --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "Zaxasj",
	Fathuul = "Fa'thuul"
})

----------------------------------
-- Uu'nat, Presagista del Vacío --
----------------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({

})

L:SetMiscLocalization({

})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
