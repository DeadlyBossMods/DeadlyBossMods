if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Hermandad de camorristas"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "You're up!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Mostrar aviso especial cuando es tu combate",
	SpectatorMode		= "Mostrar tiempos/avisos cuando estas en modo espectador"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Jefa Zumbarriel",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Rank 1",
	Rank2			= "Rank 2",
	Rank3			= "Rank 3",
	Rank4			= "Rank 4",
	Rank5			= "Rank 5",
	Rank6			= "Rank 6",
	Rank7			= "Rank 7",
	Rank8			= "Rank 8",
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus."
})
