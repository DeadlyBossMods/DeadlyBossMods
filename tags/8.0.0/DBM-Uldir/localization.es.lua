if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-----------------------
-- Taloc el Corrupto --
-----------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"tiene amenaza"
})

-----------
-- MADRE --
-----------
L= DBM:GetModLocalization(2167)

----------------------
-- Devorador fétido --
----------------------
L= DBM:GetModLocalization(2146)

--------------------------------
-- Zek'voz, Heraldo de N'Zoth --
--------------------------------
L= DBM:GetModLocalization(2169)

L:SetMiscLocalization({
	CThunDisc	 =	"Disc accessed. C'thun data loading.",
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",
	CorruptedDisc =	"Disc accessed. Corrupted data loading."
})
--WIP until I get actual footage of the fight in European Spanish, or proper datamining

------------
-- Vectis --
------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst	 =	"Ordenar marco de información de Infección persistente de mayor a menor cantidad de acumulaciones (en lugar de menor a mayor)"
})

------------------------------
-- Mythrax el Desintegrador --
------------------------------
L= DBM:GetModLocalization(2194)

---------------------
-- Zul el Renacido --
---------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerAddIncoming		= "Mostrar temporizador para cuando los esbirros se vuelvan atacables"
})

------------
-- G'huun --
------------
L= DBM:GetModLocalization(2147)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
