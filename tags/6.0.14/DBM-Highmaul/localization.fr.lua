if GetLocale() ~= "frFR" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "MONTAGNES, ÉLEVEZ-VOUS !"
})


------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "Réinitialiser le nombre de Décomposition après",
	Two					= "Après deux lancers",
	Three				= "Après trois lancers",
	Four				= "Après quatre lancers"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial		= "Joue le compte à rebours sonore pour les cooldowns de Phémos",
	PolSpecial			= "Joue le compte à rebours sonore pour les cooldowns de Pol",
	PhemosSpecialVoice	= "Joue les alertes vocales pour les compétences de Phémos en utilisant le pack de voix sélectionné",
	PolSpecialVoice		= "Joue les alertes vocales pour les compétences de Pol en utilisant le pack de voix sélectionné"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "Gangrène dissipé dans 5s - revenez à votre point de départ"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "Affiche un avertissement spécial pour revenir à son point de départ lorsque $spell:172895 se dissipe"
})

L:SetMiscLocalization({
	supressionTarget1	= "Je vous écraserai !",
	supressionTarget2	= "Silence !",
	supressionTarget3	= "Taisez-vous !", 
	supressionTarget4	= "Je vous réduirai en pièces !"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetMiscLocalization({
	BrandedYell			= "Marque (%s) sur %s",
	GazeYell			= "Regard disparaît dans %d",
	PlayerDebuffs		= "Plus proche de l'Aperçu"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Trash de Cognefort"
})