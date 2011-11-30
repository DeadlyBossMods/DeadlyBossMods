if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/19/2011 (by Sasmira) 


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

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

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

L:SetTimerLocalization({
	achievementGauntlet	= "Gantelet"
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

L:SetOptionLocalization{
	PingBlitz	= "Ping sur la minimap lorsque le Général Umbriss est sur le point de vous faire une Attaque éclair"
}

L:SetMiscLocalization{
	Blitz		= "Son regard se fixe sur |cFFFF0000(%S+)"
}

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

----------------
--  Zul'Aman  --
----------------
-- Nalorakk --
--------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "Nalorakk (Bear)"
}

L:SetWarningLocalization{
	WarnBear		= "Bear Form",
	WarnBearSoon	= "Bear Form in 5 sec",
	WarnNormal		= "Normal Form",
	WarnNormalSoon	= "Normal Form in 5 sec"
}

L:SetTimerLocalization{
	TimerBear		= "Bear Form",
	TimerNormal		= "Normal Form"
}

L:SetOptionLocalization{
	WarnBear		= "Show warning for Bear form",
	WarnBearSoon	= "Show pre-warning for Bear form",
	WarnNormal		= "Show warning for Normal form",
	WarnNormalSoon	= "Show pre-warning for Normal form",
	TimerBear		= "Show timer for Bear form",
	TimerNormal		= "Show timer for Normal form"
}

L:SetMiscLocalization{
	YellBear 	= "You call on da beast, you gonna get more dan you bargain for!",
	YellNormal	= "Make way for Nalorakk!"
}

--------------
-- Akil'zon --
--------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Akil'zon (Eagle)"
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Show range frame (10 yards)",
	StormArrow	= "Show DBM Arrow for $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

--------------
-- Jan'alai --
--------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "Jan'alai (Dragonhawk)"
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "I burn ya now!",
	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
}

-------------
-- Halazzi --
-------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Halazzi (Lynx)"
}

L:SetWarningLocalization{
	WarnSpirit	= "Spirit Phase",
	WarnNormal	= "Normal Phase"
}

L:SetOptionLocalization{
	WarnSpirit	= "Show warning for Spirit phase",
	WarnNormal	= "Show warning for Normal phase"
}

L:SetMiscLocalization{
	YellSpirit	= "I fight wit' untamed spirit....",
	YellNormal	= "Spirit, come back to me!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "Hexlord Malacrass"
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Show timer for $spell:43501"
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "Daakara"
}

L:SetOptionLocalization{
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "High Priest Venoxis"
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "Show DBM arrow when you are affected by $spell:96477"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Bloodlord Mandokir"
}

L:SetWarningLocalization{
	WarnRevive		= "%d ghosts remaining",
	SpecWarnOhgan	= "Ohgan revived! Attack now!" -- check this, i'm not good at English
}

L:SetOptionLocalization{
	WarnRevive		= "Announce how many ghost revive remaining",
	SpecWarnOhgan	= "Show warning when Ohgan is revived", -- check this, i'm not good at English
	SetIconOnOhgan	= "Put an icon on Ohgan when he revives" 
}

L:SetMiscLocalization{
	Ohgan		= "Ohgan"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "Zanzil"
}

L:SetOptionLocalization{
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "High Priestess Kilnara"
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do the Godbreaker"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "Hakkar's Chains Barrier Down - %d/3 left"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Announce when Hakkar's Chains barrier down",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill			= "Oh no, Hakkar's spirit is free!" -- temporarily
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
--L= DBM:GetModLocalization(603)

L = DBM:GetModLocalization("CoMGrilek")

L:SetGeneralLocalization{
	name = "Gri'lek"
}

---------------
-- Hazza'rah --
---------------
--L= DBM:GetModLocalization(604)

L = DBM:GetModLocalization("CoMGHazzarah")

L:SetGeneralLocalization{
	name = "Hazza'rah"
}

--------------
-- Renataki --
--------------
--L= DBM:GetModLocalization(605)

L = DBM:GetModLocalization("CoMRenataki")

L:SetGeneralLocalization{
	name = "Renataki"
}

---------------
-- Wushoolay --
---------------
--L= DBM:GetModLocalization(606)

L = DBM:GetModLocalization("CoMWushoolay")

L:SetGeneralLocalization{
	name = "Wushoolay"
}

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "Echo of Sylvanas"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "Echo of Tyrande"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "Echo of Jaina"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Flarecore detonate"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Show timer for $spell:101927 detonate"
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "Echo of Baine"
}

--------------
-- Murozond --
--------------
L = DBM:GetModLocalization("Murozond")

L:SetGeneralLocalization{
	name = "Murozond"
}

L:SetMiscLocalization{
	Kill		= "You know not what you have done. Aman'Thul... What I... have... seen..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L = DBM:GetModLocalization("Perotharn")

L:SetGeneralLocalization{
	name = "Peroth'arn"
}

-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "Azshara"
}

L:SetMiscLocalization{
	Kill		= "Enough! As much as I adore playing hostess, I have more pressing matters to attend to."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "Mannoroth & Varo'then"
}

L:SetMiscLocalization{
	Kill		= "No...no! This victory will not be ripped from my grasp! I will not return to him in failure! I will not be torn from this pitiful world! No...NOOOOOOOO!!!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "Arcurion"
}

----------------------
-- Asira Dawnslayer --
----------------------
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "Asira Dawnslayer"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "Archbishop Benedictus"
}