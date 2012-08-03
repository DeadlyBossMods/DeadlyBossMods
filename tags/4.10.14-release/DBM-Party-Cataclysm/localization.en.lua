local L

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
	WarnAdd		= "Add released"
})

L:SetOptionLocalization({
	WarnAdd		= "Warn when an add looses $spell:75608 buff"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "Superheated Armor (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Show timer for $spell:75846 duration"
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
	SetIconOnBoss	= "Put an icon on the boss after $spell:76200 "
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
	achievementGauntlet	= "Gauntlet"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "Ping the minimap when General Umbriss is about to blitz you"
}

L:SetMiscLocalization{
	Blitz		= "sets his eyes on |cFFFF0000(%S+)"
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
	ValionaYell	= "Dragon, you will do as I command! Catch me!",	-- Yell when Valiona is incoming
	Add			= "%s Summons an"
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
	Kill		= "Ptah... is... no more..."
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "Gauntlet"
})

L:SetMiscLocalization({
	Brann				= "Right, let's go! Just need to input the final entry sequence into the door mechanism... and..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "Split soon"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Show pre-warning for Split"
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
	RangeFrame	= "Show Range Frame (5 yards)"
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
	BossHealthAdds	= "Show health of adds in the Boss Health Frame"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Phase 2 in 5 seconds"
}

L:SetTimerLocalization({
	timerPhase2 		= "Phase 2 Starts"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Show special warning for phase 2 soon (5 seconds)",
	timerPhase2 		= "Show timer for start of phase 2"
}

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

L:SetTimerLocalization({
	TimerAdds		= "Next Adds"
})

L:SetOptionLocalization{
	TimerAdds		= "Show timer for Adds"
}

L:SetMiscLocalization{
	YellAdds		= "Repel the intruders!"
}

-----------------
-- Lord Walden --
-----------------
L= DBM:GetModLocalization(99)

L:SetWarningLocalization{
	specWarnCoagulant	= "Green Mix - Keep Moving!",	-- Green light
	specWarnRedMix		= "Red Mix - Do Not Move!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Show special warnings for Red/Green movement queues"
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
	WarnEmerge		= "Emerge",
	WarnSubmerge	= "Submerge"
})

L:SetTimerLocalization({
	TimerEmerge		= "Next Emerge",
	TimerSubmerge	= "Next Submerge"
})

L:SetOptionLocalization({
	WarnEmerge		= "Show warning for emerge",
	WarnSubmerge	= "Show warning for submerge",
	TimerEmerge		= "Show timer for emerge",
	TimerSubmerge	= "Show timer for submerge",
	CrystalArrow	= "Show DBM arrow when $spell:81634 is near you",
	RangeFrame		= "Show Range Frame (5 yards)"
})

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "Airphase",
	WarnGroundphase			= "Groundphase",
	specWarnCrystalStorm	= "Crystal Storm - Take cover"
})

L:SetTimerLocalization({
	TimerAirphase			= "Next Airphase",
	TimerGroundphase		= "Next Groundphase"
})

L:SetOptionLocalization({
	WarnAirphase			= "Show warning when Slabhide lifts off",
	WarnGroundphase			= "Show warning when Slabhide lands",
	TimerAirphase			= "Show timer for next airphase",
	TimerGroundphase		= "Show timer for next groundphase",
	specWarnCrystalStorm	= "Show special warning for $spell:92265"
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

L:SetMiscLocalization{
	Retract		= "%s retracts her cyclone shield!"
}

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
	SpecWarnStaticCling	= "Show special warning for $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "JUMP!"
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
-- Akil'zon --
--------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Show range frame (10 yards)",
	StormArrow	= "Show DBM Arrow for $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

--------------
-- Nalorakk --
--------------
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
	TimerNormal		= "Show timer for Normal form",
	InfoFrame		= "Show info frame for players affected by $spell:42402"
}

L:SetMiscLocalization{
	YellBear 		= "You call on da beast, you gonna get more dan you bargain for!",
	YellNormal		= "Make way for Nalorakk!",
	PlayerDebuffs	= "Surge Debuff"
}

--------------
-- Jan'alai --
--------------
L= DBM:GetModLocalization(188)

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "I burn ya now!",
	YellHatchAll= "I show you strength... in numbers.",
	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
}

-------------
-- Halazzi --
-------------
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

L:SetMiscLocalization{
	YellPull	= "Da shadow gonna fall on you...."
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "Next Form Change"
}

L:SetOptionLocalization{
	timerNextForm	= "Show timer for form changes.",
	InfoFrame		= "Show info frame for players affected by $spell:42402",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Surge Debuff"
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "Show DBM arrow when you are affected by $spell:96477"
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

L:SetWarningLocalization{
	SpecWarnToxic	= "Get Toxic Torment"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "Show special warning when you are missing $spell:96328 debuff",
	InfoFrame		= "Show info frame for players not affected by $spell:96328",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "No Toxic Torment"
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
	Kill			= "You overstepped your bounds, Jin'do. You toy with powers that are beyond you. Have you forgotten who I am? Have you forgotten what I can do?!"
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

L:SetMiscLocalization{
	Pull		= "No mortal may stand before me and live!"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetWarningLocalization{
	WarnAdds	= "New adds soon"
}

L:SetTimerLocalization{
	TimerAdds	= "Next adds"
}

L:SetOptionLocalization{
	WarnAdds	= "Announce when new adds \"spawn\"",
	TimerAdds	= "Show timer till next adds \"spawn\""
}

L:SetMiscLocalization{
	Kill		= "Enough! As much as I adore playing hostess, I have more pressing matters to attend to."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetTimerLocalization{
	TimerTyrandeHelp	= "Tyrande needs help"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "Show timer till Tyrande needs help"
}

L:SetMiscLocalization{
	Kill		= "Malfurion, he has done it! The portal is collapsing!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L= DBM:GetModLocalization(322)

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Show timer for start of combat"
}

L:SetMiscLocalization{
	Event		= "Show yourself!",
	Pull		= "Twilight forces begin to appear around the canyons edges."
}

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "...and with that out of the way, you and your flock of fumbling friends are next on my list. Mmm, I thought you'd never get here!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Show timer for start of combat"
}

L:SetMiscLocalization{
	Event		= "And now, Shaman, you will give the Dragon Soul to ME."
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "Akma'hat"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Garr (Cata)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Julak-Doom"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "Mobus"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "Xariona"
}
