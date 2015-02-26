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
	specWarnExpelMagicFelFades	= "Afficher une alerte spéciale pour revenir à son point de départ lorsque $spell:172895 se dissipe"
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

L:SetOptionLocalization({
	GazeYellType		= "Choisir le type de cri pour le Regard des Abysses",
	Countdown			= "Compte à rebours jusqu'à disparition",
	Stacks				= "Nombre de stacks à chaque application",
	timerNightTwistedCD	= "Afficher le compte à rebours pour le prochain Fidèle corrompu par la nuit"
})

L:SetMiscLocalization({
	BrandedYell			= "Marque (%s) sur %s",
	GazeYell			= "Regard disparaît dans %d",
	GazeYell2			= "Regard (%d) sur %s",
	PlayerDebuffs		= "Plus proche de l'Aperçu"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Trash de Cognefort"
})
