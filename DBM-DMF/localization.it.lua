if GetLocale() ~= "itIT" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Ultracannone Scoppiamicce 5000"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Pesta-lo-Gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Ottenuti %d di %d possibili punti apparsi",
	warnGameOverNoQuest	= "Gioco terminato con %d possibili punti apparsi",
	warnGnoll			= "Apparso Gnoll",
	warnHogger			= "Apparso Hogger",
	specWarnHogger		= "Apparso Hogger!"
})

L:SetOptionLocalization({
	warnGameOver	= "Annuncia punti totali possibile a fine gioco",
	warnGnoll		= "Annuncia apparizione Gnoll",
	warnHogger		= "Annuncia apparizione Hogger",
	specWarnHogger	= "Annuncio Speciale apparizione Hogger"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Tiro al Bersaglio"
})

L:SetOptionLocalization({
	SetBubbles			= "Disabilita automaticamente le bolle chat durante $spell:101871<br/>(ripristinale al termine della partita)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Sfida dei Carri Giocattolo"
})

---------------------------
--  Fire Ring Challenge  --
---------------------------
L = DBM:GetModLocalization("Rings")

L:SetGeneralLocalization({
	name = "Sfida dell'Uccello di Fuoco"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Coniglio di Lunacupa"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Zannastrale"
})

L:SetWarningLocalization({
	specWarnCallPack		= "Chiamata del Branco - Corri > 40 m da Zannastrale!",
	specWarnMoonfangCurse	= "Maledizione di Zannastrale - Corri > 10 m da Zannastrale!"
})

L:SetOptionLocalization({
	specWarnCallPack		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144602),
	specWarnMoonfangCurse	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144590)
})
