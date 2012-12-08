if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Kampfgildengegner"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "Du bist dran!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Zeige Spezialwarnung, wenn es dein Kampf ist",
	SpectatorMode		= "Zeige Warnungen/Timer auch beim Zuschauen fremder Kämpfe"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",
	--I wish there was a better way to do this....so much localizing. :(
	EnteringArena1	= "Und jetzt in der Arena",
	EnteringArena2	= "Hier kommt der Herausforderer",
	EnteringArena3	= "Achtung... hier kommt",
	EnteringArena4	= "Applaus für",
	Victory1		= "hat gewonnen",
	Victory2		= "Glückwunsch",
	Victory3		= "Ein prächtiger Sieg",
	Victory4		= "gewinnt",
	Victory5		= "Macht weiter so",
	Victory6		= "hat es geschafft, nicht zu sterben",
	Lost1			= "Habt Ihr Euch überhaupt angestrengt",
	Lost2			= "Könntet Ihr jetzt wohl bitte Eure Leiche aus dem Weg räumen",
	Lost3			= "Ahhh ha ha ha! So viel Blut! Herrlich",
	Lost4			= "Stellt Euch wieder an und versucht's erneut",
	Lost5			= "Wo gehobelt wird, fallen auch Späne",
	Lost6			= "versucht doch bitte, nicht so häufig zu sterben",
	Lost7			= "Argh... das sieht nicht so schön aus",
	Lost8			= "Sein Name war",
})
