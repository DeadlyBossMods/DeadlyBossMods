if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/12/2011 (by Sasmira) 


-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Rom'ogg Broie-les-Os"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "Corla, héraut du Crépuscule"
})

L:SetWarningLocalization({
	WarnAdd		= "Add libérés"
})

L:SetOptionLocalization({
	WarnAdd		= "Afficher lorsqu'un add perd l'amélioration $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Karsh Plielacier"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "(%d) Armure en vif-argent surchauffé"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Afficher le timer de la durée du sort $spell:75846"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "La Belle"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "Seigneur ascendant Obsidius"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "Poser un icône sur le Boss après le sort $spell:76200 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "Glubtok"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "Hélix Engrecasse"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "Faucheur 5000"
})

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "Amiral Grondéventre"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"Captaine\" Macaron"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "Vanessa VanCleef"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name = "Général Umbriss"
})

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Maître-forge Throngus"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Drahga Brûle-Ombre"
})

L:SetMiscLocalization{
	ValionaYell	= "Dragon, vous faites ce que je commande! Attrape-moi!",	-- Yell when Valiona is incoming
	Valiona		= "Valiona"
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "Erudax"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "Gardien du temple Anhuur"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "Enrageterre Ptah"
})

L:SetMiscLocalization{
	Kill		= "Ptah... n'est ... plus la..." -- à vérifier
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Anraphet"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Vitesse de la Lumière"
})

L:SetMiscLocalization({
	Brann		= "Bien, allons y maintenant ! J'ai juste besoin de saisir la séquence d'entrée définitive dans le mécanisme de la porte ... et ..." -- Traduction litérale, a vérifier ...
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "Isiset"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "Séparation imminente !"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Afficher la pré-alerte pour la Séparation"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "Ammunae"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "Setesh"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "Rajh"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "Général Husam"
})

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Siamat"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Grand prophète Barim"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Afficher la vie des adds dans la fenêtre de vie du Boss"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Brasier des cieux",
	HarbringerDarkness	= "Hurlement des ténèbres"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Claque-mâchoire"
})

L:SetOptionLocalization{
	RangeFrame	= "Afficher la fenêtre de portée (5 mêtres)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"		-- he is fightable after Lockmaw :o
})

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "Baron Ashbury"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "Baron d'Argelaine"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "Commandant Printeval"
})

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Seigneur Walden"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "Lumière Verte - Bougez !",	-- Green light
	specWarnRedMix		= "Lumière Rouge - ne bougez plus !"-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Afficher les alertes spéciales pour les mouvements de queues Rouge/Vert"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Seigneur Godfrey"
})

L:SetWarningLocalization{
	WarnMortalWound	= "%s sur >%s< (%d)"		-- Mortal Wound on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(93675, GetSpellInfo(93675) or "inconnu")
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetWarningLocalization({
	WarnEmerge	= "Surgit",
	WarnSubmerge	= "S'enterre"
})

L:SetTimerLocalization({
	TimerEmerge	= "Surgit",
	TimerSubmerge	= "S'enterre"
})

L:SetOptionLocalization({
	WarnEmerge	= "Afficher l'alerte lorsqu'il surgit",
	WarnSubmerge	= "Afficher l'alerte lorsqu'il s'enterre",
	TimerEmerge	= "Afficher le temps lorsqu'il surgit",
	TimerSubmerge	= "Afficher le temps lorsqu'il s'enterre"
})

L:SetGeneralLocalization({
	name = "Corborus"
})

-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "Ozruk"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "Peau-de-pierre"
})

L:SetWarningLocalization({
	specWarnCrystalStorm		= "Tempête de cristal - Cachez vous derrière les pierres !"
})

L:SetOptionLocalization({
	specWarnCrystalStorm		= "Afficher une alerte spéciale pour le sort $spell:92265"
})

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "Grande prêtresse Azil"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "Grand vizir Ertan"
})

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "Altairus"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "Asaad"
})

L:SetOptionLocalization({
	SpecWarnStaticCling	= "Alerte spéciale pour le sort $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "SAUTE !"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "Dame Naz'jar"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "Commandant Ulthok"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "Erunak Parlepierre"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "Ozumat"
})