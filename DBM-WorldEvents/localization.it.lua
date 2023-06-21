if GetLocale() ~= "itIT" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Bifido"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Hummel becomes active",
	BaxterActive		= "Baxter becomes active",
	FryeActive			= "Frye becomes active"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Show timers for when Apothecary Trio becomes active"
})

L:SetMiscLocalization({
	SayCombatStart		= "Did they bother to tell you who I am and why I am doing this?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Emersione",
	specWarnAttack	= "Ahune è vulnerabile - Attaccalo!"
})

L:SetTimerLocalization{
	SubmergeTimer	= "Immersione",
	EmergeTimer		= "Emersione"
}

L:SetOptionLocalization({
	Emerged			= "Mostra avviso all'emersione di Ahune",
	specWarnAttack	= "Mostra avviso speciale quando Ahune diventa vulnerabile",
	SubmergeTimer	= "Mostra temporizzatore immersione",
	EmergeTimer		= "Mostra temporizzatore emersione"
})

L:SetMiscLocalization({
	Pull			= "The Ice Stone has melted!" -- TODO
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Sbarazzati della botte prima che te ne lanci un altro!",
	specWarnBrewStun	= "SUGGERIMENTO: Sei stato colpito, ricordati di bere la birra la prossima volta!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Mostra avviso speciale per $spell:47376",
	specWarnBrewStun	= "Mostra avviso speciale per $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Botte su di me!"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "Festa della Birra"
})

L:SetOptionLocalization({
	NormalizeVolume			= "Normalizza automaticamente il volume del canale sonoro DIALOGHI per corrispondere a quello degli effetti quando nella zona Festa della Birra per ridurre il disturbo. (Se il volume della musica non è impostato, verrà silenziato.)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Evocazione Zucche Pulsanti",
	warnHorsemanHead		= "Testa del Cavaliere Attiva"
})

L:SetOptionLocalization({
	WarnPhase				= "Mostra avviso per ogni cambio fase",
	warnHorsemanSoldiers	= "Mostra avviso evocazione Zucche Pulsanti",
	warnHorsemanHead		= "Mostra avviso evocazione Testa del Cavaliere"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Horseman rise...", -- TODO
	HorsemanSoldiers		= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!" -- TODO
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Abominevole Greench"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Piante Vs. Zombie"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Zombi evocati dall'ultima ondata massiva: %d",
	specWarnWave	= "Ondata Massiva!"
})

L:SetTimerLocalization{
	timerWave		= "Prossima Ondata Massiva"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Annuncia conteggio totale evocazioni tra ondate massive",
	specWarnWave	= "Mostra avviso speciale a inizio Ondata Massiva",
	timerWave		= "Mostra temposizzatore prossima Ondata Massiva"
})

L:SetMiscLocalization({
	MassiveWave		= "A Massive Wave of Zombies is Approaching!" -- TODO
})

--------------------------
--  Demonic Invasions  --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "Invasioni Demoniache"
})

--------------------------
--  Memories of Azeroth: Burning Crusade  --
--------------------------
L = DBM:GetModLocalization("BCEvent")

L:SetGeneralLocalization({
	name = "MoA: Burning Crusade"
})

--------------------------
--  Memories of Azeroth: Wrath of the Lich King  --
--------------------------
L = DBM:GetModLocalization("WrathEvent")

L:SetGeneralLocalization({
	name = "MoA: WotLK"
})

L:SetMiscLocalization{
	Emerge				= "emerges from the ground!",
	Burrow				= "burrows into the ground!"
}

--------------------------
--  Memories of Azeroth: Cataclysm  --
--------------------------
L = DBM:GetModLocalization("CataEvent")

L:SetGeneralLocalization({
	name = "MoA: Cataclysm"
})

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
