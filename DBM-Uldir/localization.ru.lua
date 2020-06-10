if GetLocale() ~= "ruRU" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"Has Aggro"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Chute has opened - Adds Soon"--Translate
})

L:SetTimerLocalization({
	chuteTimer		= "Next Chute (%s)"--Translate
})

L:SetOptionLocalization({
	addsSoon		= "Show pre warning for when chutes open and start spawning adds",--Translate
	chuteTimer		= "Show timer for when Chutes open"--Translate
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetMiscLocalization({
	CThunDisc		=	"Доступ получен. Загрузка данных К'Туна.",
	YoggDisc		=	"Доступ получен. Загрузка данных Йогг-Сарона.",
	CorruptedDisc	=	"Доступ получен. Загрузка поврежденных данных."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Sort Lingering Infection Infoframe by highest debuff stack (instead of lowest)"
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerAddIncoming		= DBM_CORE_L.INCOMING
})

L:SetOptionLocalization({
	timerAddIncoming		= "Show timer for when incoming add is attackable"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Power Matrix dropped"--Translate
})

L:SetOptionLocalization({
	warnMatrixFail		= "Show warning when Power Matrix is dropped."--Translate
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Current Matrix:",--Mythic--Translate
	NextMatrix			=	"Next Matrix:",--Mythic--Translate
	CurrentMatrixLong	=	"Current Matrix (%s):",--Non Mythic--Translate
	NextMatrixLong		=	"Next Matrix (%s):"--Non Mythic--Translate
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Uldir Trash"
})
