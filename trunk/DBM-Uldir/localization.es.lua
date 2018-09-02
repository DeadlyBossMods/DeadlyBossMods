if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Taloc  --
------------
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
	CThunDisc	 =	"Acceso al disco. Cargando datos de C'Thun.",
	YoggDisc	 =	"Acceso al disco. Cargando datos de Yogg-Saron.",
	CorruptedDisc =	"Acceso al disco. Cargando datos corruptos."
})

------------
-- Vectis --
------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst	 =	"Ordenar marco de información de $spell:265127 de mayor a menor cantidad de acumulaciones (en lugar de menor a mayor)"
})
--Mostrar spellid en lugar de texto, pendiente de prueba

------------------------------
-- Mythrax el Desintegrador --
------------------------------
L= DBM:GetModLocalization(2194)

---------------------
-- Zul el Renacido --
---------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Tragadones (%s)",
	timerCallofHexerCD 		= "Aojasangres (%s)",
	timerCallofCrusherCD	= "Trituradora (%s)",
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerAddIncoming		= "Mostrar temporizador para cuando los esbirros se vuelvan atacables"
})

L:SetMiscLocalization({
	Crusher			=	"Trituradora",
	Bloodhexer		=	"Aojasangre",
	Crawg			=	"Tragadón"
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
