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
--L= DBM:GetModLocalization(2167)

----------------------
-- Devorador fétido --
----------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Esclusa abierta - ¡esbirros en breve!"
})

L:SetOptionLocalization({
	addsSoon		= "Mostrar aviso previo cuando las esclusas se abran en preparación para la aparición de esbirros"
})

--------------------------------
-- Zek'voz, Heraldo de N'Zoth --
--------------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Orbe (%s) aterriza"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Mostrar temporizador para el momento en que $spell:267334 toca el suelo",
	EarlyTankSwap	 =	"Mostrar avisos de cambio de tanque inmediatamente tras $spell:265248 en lugar de esperar al segundo $spell:265264"
})

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
	ShowHighestFirst3	 =	"Ordenar marco de información de $spell:265127 de mayor a menor cantidad de acumulaciones (en lugar de menor a mayor)",
	ShowOnlyParty		 =	"Mostrar solo las acumulaciones de $spell:265127 de tu grupo",
	SetIconsRegardless	 =	"Poner iconos independientemente de si un jugador con permisos de ayudante tiene BigWigs (avanzado)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM ha relevado la colocación de iconos a un ayudante con BigWigs para evitar conflictos de iconos. Asegúrate de que el jugador en cuestión tiene la colocación de iconos activada. En caso contrario, quítale los permisos de ayudante para rehabilitar la colocación de iconos de DBM o habilita en la configuración de Vectis la opción de ignorar si un ayudante tiene BigWigs."
})

------------------------------
-- Mythrax el Desintegrador --
------------------------------
--L= DBM:GetModLocalization(2194)

---------------------
-- Zul el Renacido --
---------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Tragadones (%s)",
	timerCallofHexerCD 		= "Aojasangres (%s)",
	timerCallofCrusherCD	= "Trituradora (%s)",
	timerAddIncoming		= DBM_CORE_L.INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Mostrar temporizador para cuando las siluetas de los tragadones comiencen a formarse",
	timerCallofHexerCD 		= "Mostrar temporizador para cuando las siluetas de las aojasangres comiencen a formarse",
	timerCallofCrusherCD	= "Mostrar temporizador para cuando la silueta de la trituradora comience a formarse",
	timerAddIncoming		= "Mostrar temporizador para cuando los esbirros se vuelvan atacables",
	TauntBehavior			= "Patrón de cambios de tanque",
	TwoHardThreeEasy		= "Cambiar a tres acumulaciones en LFR/normal y dos en heroico/mítico",--Default
	TwoAlways				= "Cambiar siempre a dos acumulaciones independientemente de la dificultad",
	ThreeAlways				= "Cambiar siempre a tres acumulaciones independientemente de la dificultad"
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

L:SetWarningLocalization({
	warnMatrixFail		= "Una matriz de poder ha caído al suelo"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Mostrar aviso cuando una $spell:263372 caiga al suelo"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Matriz actual:",--Mythic
	NextMatrix			=	"Siguiente matriz:",--Mythic
	CurrentMatrixLong	=	"Matriz actual (%s):",--Non Mythic
	NextMatrixLong		=	"Siguiente matriz (%s):"--Non Mythic
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
