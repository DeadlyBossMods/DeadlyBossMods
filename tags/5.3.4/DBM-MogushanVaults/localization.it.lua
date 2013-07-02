if GetLocale() ~= "itIT" then return end

local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s tra 7s!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "Mostra un avviso speciale prima del Sovraccarico",
})

L:SetMiscLocalization({
	Overload	= "%s sta per Sovraccaricarsi!"
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
	Fire		= "Oh, potente! Attraverso me scioglierai la carne dalle ossa!", -- Copied from ChatLog
	Arcane		= "Oh, saggio delle ere! Concedimi la tua saggezza arcana!",-- Copied from ChatLog
	Nature		= "Oh, grande spirito... concedimi il potere della terra!",---- Copied from ChatLog
	Shadow		= "Grande spirito dei campioni del passato! concedimi il tuo scudo!"-- Need Review
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull		= "È giunta l'ora di schiattare!" -- ChatLog
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
	Pull		= "La macchina si mette in moto! Raggiungi il piano inferiore!",--Emote (ChatLog)
	Rage		= "La Rabbia dell'Imperatore risuona tra le colline.",--Yell (ChatLog)
	Strength	= "La Forza dell'Imperatore appare nelle volte!",--Emote (ChatLog)
	Courage		= "Il Coraggio dell'Imperatore appare nelle volte!",--Emote (ChatLog)
	Boss		= "Due Costrutti Titanici appaiono nelle alcove più grandi!"--Emote (ChatLog)
})

