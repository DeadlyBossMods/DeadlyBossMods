if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/19/2011 (by Sasmira) 

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "Add libérés"
})

L:SetOptionLocalization({
	WarnAdd		= "Afficher lorsqu'un add perd l'amélioration $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "(%d) Armure en vif-argent surchauffé"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Afficher le timer de la durée du sort $spell:75846"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "Poser un icône sur le Boss après le sort $spell:76200 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "Gantelet"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "Ping sur la minimap lorsque le Général Umbriss est sur le point de vous faire une Attaque éclair"
}

L:SetMiscLocalization{
	Blitz		= "Son regard se fixe sur |cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "Dragon, vous faites ce que je commande! Attrape-moi!"	-- Yell when Valiona is incoming
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "Ptah... n'est ... plus la..." -- à vérifier
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "Vitesse de la Lumière"
})

L:SetMiscLocalization({
	Brann		= "Bien, allons y maintenant ! J'ai juste besoin de saisir la séquence d'entrée définitive dans le mécanisme de la porte ... et ..." -- Traduction litérale, a vérifier ...
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "Séparation imminente !"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Afficher la pré-alerte pour la Séparation"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

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

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "Afficher la vie des adds dans la fenêtre de vie du Boss"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

-----------------
-- Lord Walden --
-----------------
L= DBM:GetModLocalization(99)

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
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

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

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	specWarnCrystalStorm		= "Tempête de cristal - Cachez vous derrière les pierres !"
})

L:SetOptionLocalization({
	specWarnCrystalStorm		= "Afficher une alerte spéciale pour le sort $spell:92265"
})

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

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
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

----------------
--  Zul'Aman  --
----------------
--  Akil'zon --
---------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Show range frame (10 yards)",
	StormArrow	= "Show DBM Arrow for $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

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

---------------
--  Jan'alai --
---------------
L= DBM:GetModLocalization(188)

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "I burn ya now!",
	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
}

--------------
--  Halazzi --
--------------
L= DBM:GetModLocalization(189)

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
L= DBM:GetModLocalization(190)

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Show timer for $spell:43501"
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetOptionLocalization{
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "Show DBM arrow when you are affected by $spell:96477"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "%d ghosts remaining",
	SpecWarnOhgan	= "Ohgan revived! Attack now!" -- check this, i'm not good at English
}

L:SetOptionLocalization{
	WarnRevive		= "Announce how many ghost revive remaining",
	SpecWarnOhgan	= "Show warning when Ohgan is revived", -- check this, i'm not good at English
	SetIconOnOhgan	= "Put an icon on Ohgan when he revives" 
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

L:SetOptionLocalization{
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

----------------------------
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

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

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Flarecore detonate"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Show timer for $spell:101927 detonate"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "You know not what you have done. Aman'Thul... What I... have... seen..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetMiscLocalization{
	Kill		= "Enough! As much as I adore playing hostess, I have more pressing matters to attend to."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetMiscLocalization{
	Kill		= "No...no! This victory will not be ripped from my grasp! I will not return to him in failure! I will not be torn from this pitiful world! No...NOOOOOOOO!!!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L= DBM:GetModLocalization(322)

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)
