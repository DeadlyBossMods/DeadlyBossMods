-- Last update: 12/20/2012 (20/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)
if GetLocale() ~= "frFR" then return end
local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Invasions de Fief"
})

L:SetWarningLocalization({
	specWarnRylak	= "Charognard sombraile arrive",
	specWarnWorker	= "Paysan terrifié apparu",
	specWarnSpy		= "Un espion s'est infiltré",
	specWarnBuilding= "Un bâtiment est attaqué"
})

L:SetOptionLocalization({
	specWarnRylak	= "Afficher une alerte spéciale quand un rylak arrive",
	specWarnWorker	= "Afficher une alerte spéciale quand un Paysan terrifié apparait",
	specWarnSpy		= "Afficher une alerte spéciale quand un espion s'est infiltré",
	specWarnBuilding= "Afficher une alerte spéciale quand un bâtiment est attaqué"
})
