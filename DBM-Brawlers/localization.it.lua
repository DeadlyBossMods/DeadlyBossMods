if GetLocale() ~= "itIT" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Circolo: Generale"
})

L:SetWarningLocalization({
	warnQueuePosition2	= "Sei il numero %d in coda",
	specWarnYourNext	= "Sei il prossimo!",
	specWarnYourTurn	= "Tocca a te!",
	specWarnRumble		= "Rissa!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "Annuncia la posizione in coda quando cambia",
	specWarnYourNext	= "Mostra avviso speciale quando sei il prossimo",
	specWarnYourTurn	= "Mostra avvio speciale a inizio scontro",
	specWarnRumble		= "Mostra avviso speciale quando iniziano una rissa",
	SpectatorMode		= "Mostra avvisi/temporizzatori come spettatore<br/>(I messaggi personali degli 'Avvisi Speciali' non sono visibili agli spettatori)",
	SpeakOutQueue		= "Conteggia il tuo numero in coda quando aggiornato",
	NormalizeVolume		= "Normalizza automaticamente il volume del canale sonoro DIALOGHI per coincidere SFX quando nella zona Combattenti per abbassare le urla."
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo", -- Alleanza
	Bazzelflange	= "Boss Flangiabix", -- Orda
	--Alliance pre berserk
	-- BizmoIgnored	= "We Don't have all night. Hurry it up already!", -- TODO
	-- BizmoIgnored2	= "Do you smell smoke?", -- TODO
	-- BizmoIgnored3	= "I think it's about time to call this fight.", -- TODO
	-- BizmoIgnored4	= "Is it getting hot in here? Or is it just me?", -- TODO
	-- BizmoIgnored5	= "The fire's coming!", -- TODO
	-- BizmoIgnored6	= "I think we've seen just about enough of this. Am I right?", -- TODO
	-- BizmoIgnored7	= "We've got a whole list of people who want to fight, you know.", -- TODO
	--Horde pre berserk
	-- BazzelIgnored	= "Sheesh, guys! Hurry it up already!", -- TODO
	-- BazzelIgnored2	= "Uh oh... I smell smoke...", -- TODO
	-- BazzelIgnored3	= "Time's almost up!", -- TODO
	-- BazzelIgnored4	= "Is it gettin' hot in here?", -- TODO
	-- BazzelIgnored5	= "Fire's comin'!", -- TODO
	-- BazzelIgnored6	= "Let's keep it movin' in there!", -- TODO
	-- BazzelIgnored7	= "Alright, alright. We've got a line going out here, you know.", -- TODO
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Grado 1",
	Rank2			= "Grado 2",
	Rank3			= "Grado 3",
	Rank4			= "Grado 4",
	Rank5			= "Grado 5",
	Rank6			= "Grado 6",
	Rank7			= "Grado 7",
	Rank8			= "Grado 8",
--	Rank9			= "Grado 9",
--	Rank10			= "Grado 10",
	Rumbler			= "rumbler",
	-- Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus.", -- Alliance -- TODO
	-- Proboskus2		= "Ha ha ha! What bad luck you have! It's Proboskus! Ahhh ha ha ha! I've got twenty five gold that says you die in the fire!" -- Horde -- TODO
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Circolo: Grado 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Circolo: Grado 2"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Icona (teschio) sul vero Blat"
})

L:SetMiscLocalization({
	Sand			= "Sabbia"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Circolo: Grado 3"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Circolo: Grado 4"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Circolo: Grado 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Circolo: Grado 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Circolo: Grado 7"
})

--[[
------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Circolo: Grado 8"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Circolo: Grado 9"
})
--]]

-------------
-- Brawlers: Rumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "Circolo: Rissa"
})

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Circolo: Altri"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Conteggia il numero di $spell:141190"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Circolo: Altri II"
})

L:SetWarningLocalization({
	specWarnRPS			= "Usa %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Mostra Freccia DBM durante $spell:140868, $spell:140862 e $spell:140886",
	specWarnRPS			= "Mostra avviso speciale su cosa usare con $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Sasso",
	paper			= "Carta",
	scissors		= "Forbici"
})
