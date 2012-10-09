if GetLocale() ~= "itIT" then return end

local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s utilizzabile in 7s!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "Mostra un avviso speciale prima del Sovraccarico",
})

L:SetMiscLocalization({
	Overload	= "%s sta per Sovraccaricare!"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Fase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Annuncia le Transizioni di Fase"
})

L:SetMiscLocalization({
	Fire		= "Oh, potente! Attraverso me scioglierai la carne dalle ossa!", -- Need Review
	Arcane		= "Oh, saggio delle ere! Concedimi la tua saggezza arcana!",-- Need Review
	Nature		= "Oh, grande spirito ... concedimi il potere della terra!",---- Need Review
	Shadow		= "Grande spirito dei campioni del passato! concedimi il tuo scudo!"-- Need Review
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	RangeFrame			= "Mostra Monitor di Prossimita' (8)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "E' ora di morire, ora!" -- NEED REVIEW
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "Mostra Monitor di Prossimita' (8)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "Guarda dove metti i piedi!" -- NEED REVIEW
})

L:SetTimerLocalization({
	timerDespawnFloor			= "Guarda dove metti i piedi!" -- NEED REVIEW
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "Mostra un avviso speciale prima che il vortice svanisca",
	timerDespawnFloor			= "Mostra un timer per la scomparsa del vortice"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Visualizza nella Finestra Informativa chi e' afflitto da $spell:116525"
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "Rabbia dell'Imperatore echeggia tra le colline.",--Yell
	Strength	= "Forza dell'Imperatore appare nelle alcove!",--Emote
	Courage		= "Coraggio dell'Imperatore appare nelle alcove!",--Emote
	Boss		= "Due costrutti titanici appaiono nelle grandi alcove!"--Emote
})

