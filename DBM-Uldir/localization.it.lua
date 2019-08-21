if GetLocale() ~= "itIT" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"Ha l'Aggro"
})

---------------------------
-- MOTHER --
---------------------------
L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "Scarico aperto - Add a Breve"
})

L:SetTimerLocalization({
	chuteTimer		= "Prossimo Scarico (%s)"
})

L:SetOptionLocalization({
	addsSoon		= "Mostra preavviso all'apertura scarichi e inizio evocazione add",
	chuteTimer		= "Mostra temporizzatore apertura Scarichi"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "Sfera (%s) Atterrata"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"Mostra temporizzatore all'Atterraggio della Sfera della Corruzione",
	EarlyTankSwap	 =	"Mostra avviso cambio tank immediatamente dopo Frantumazione, anziché attendere la 2^ Sferzata del Vuoto"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Accesso al disco effettuato. Caricamento dati di C'thun.",
	YoggDisc	 =	"Accesso al disco effettuato. Caricamento dati di Yogg-Saron.",
	CorruptedDisc =	"Accesso al disco effettuato. Caricamento dati corrotti."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"Ordina riquadro info Infezione Persistente dal più alto numero di debuff (anziché dal più basso). Applicabile solo se non impostato solo per il tuo gruppo.",
	ShowOnlyParty		 =	"Mostra Infezione Persistente solo per il tuo gruppo. L'opzione ordina il riquadro per ordine gruppo.",
	SetIconsRegardless	 =	"Imposta icone indipendentemente dall'assist o meno dell'utente con BW (Avanzate)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM ha passato la marcatura icone a un utente promosso con BW nell'incursione per evitare conflitti. Assicurarsi di abilitare la marcatura, o degradarlo per abilitare ma marcatura DBM, o abilitare l'opzione di esclusione nelle opzioni di Vectis"
})

---------------
-- Mythrax the Unraveler --
---------------
L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "Prossima Pozza Crog (%s)",
	timerCallofHexerCD 		= "Prossima Pozza Sanguemalefico (%s)",
	timerCallofCrusherCD	= "Prossima Pozza Frantumatrice (%s)",
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "Mostra temporizzatore alla formazione delle pozze Crog",
	timerCallofHexerCD 		= "Mostra temporizzatore alla formazione delle pozze Sanguemalefico",
	timerCallofCrusherCD	= "Mostra temporizzatore alla formazione delle pozze Frantumatrici",
	timerAddIncoming		= "Mostra temporizzatore all'attaccabilità dell'add in arrivo",
	TauntBehavior			= "Imposta funzionamento scambi tra tank",
	TwoHardThreeEasy		= "Scambio a 2 stack in eroico/mitico, 3 stack nelle altre difficoltà", -- Default
	TwoAlways				= "Scambia sempre a 2 stack indipendentemente dalla difficoltà",
	ThreeAlways				= "Scambia sempre a 3 stack indipendentemente dalla difficoltà"
})

L:SetMiscLocalization({
	Crusher			=	"Frantumatrice",
	Bloodhexer		=	"Sanguemalefico",
	Crawg			=	"Crog"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "Matrice d'Alimentazione caduta"
})

L:SetOptionLocalization({
	warnMatrixFail		= "Mostra avviso alla caduta della Matrice d'Alimentazione."
})

L:SetMiscLocalization({
	CurrentMatrix		=	"Matrice Attuale:", -- Mitico
	NextMatrix			=	"Prossima Matrice:", -- Mitico
	CurrentMatrixLong	=	"Matrice Attuale (%s):", -- Non Mitico
	NextMatrixLong		=	"Prossima Matrice (%s):" -- Non Mitico
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"Scartini Uldir"
})
