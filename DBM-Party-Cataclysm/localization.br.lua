if GetLocale() ~= "ptBR" then return end

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
	WarnAdd		= "Ajudante solto"
})

L:SetOptionLocalization({
	WarnAdd		= "Avisar quando um ajudante perder o bônus $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "Armadura Superaquecida (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Exibir cronógrafo para duração de $spell:75846"
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
	SetIconOnBoss	= "Colocar um ícone no chefe após $spell:76200"
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
	achievementGauntlet	= "Gauntlet" --TODO
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "Apontar no minimapa quando o General Umbriss está prestes a usar Ataque Relâmpago em você"
}

L:SetMiscLocalization{
	Blitz		= "sets his eyes on |cFFFF0000(%S+)" --TODO
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
	achievementGauntlet	= "Gauntlet" --TODO
})

L:SetMiscLocalization({
	Brann				= "Right, let's go! Just need to input the final entry sequence into the door mechanism... and..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "Dividir em breve"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Exibir aviso antecipado para divisão"
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
	RangeFrame	= "Exibir medidor de distância (5 metros)"
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
	BossHealthAdds	= "Exibir vida dos ajudantes no Quadro de Vida do Boss"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Fase 2 em 5 segundos"
}

L:SetTimerLocalization({
	timerPhase2 		= "Fase 2 inicia"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Exibir aviso especial para fase 2 em breve (5 segundos)",
	timerPhase2 		= "Exibir cronógrafo para início da fase 2"
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
	TimerAdds		= "Próximos ajudantes"
})

L:SetOptionLocalization{
	TimerAdds		= "Exibir cronógrafo para os ajudantes"
}

L:SetMiscLocalization{
	YellAdds		= "Repel the intruders!"
}

-----------------
-- Lord Walden --
-----------------
L= DBM:GetModLocalization(99)

L:SetWarningLocalization{
	specWarnCoagulant	= "Mistura Verde - Mova-se!",	-- Green light
	specWarnRedMix		= "Mistura Vermelha - Não se mexa!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Exibir avisos especiais para Misturas Vermelha/Verde"
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
	WarnEmerge		= "Emergir",
	WarnSubmerge	= "Submergir"
})

L:SetTimerLocalization({
	TimerEmerge		= "Próx. Emergir",
	TimerSubmerge	= "Próx. Submergir"
})

L:SetOptionLocalization({
	WarnEmerge		= "Exibir aviso para emergir",
	WarnSubmerge	= "Exibir aviso para submergir",
	TimerEmerge		= "Exibir cronógrafo para emergir",
	TimerSubmerge	= "Exibir cronógrafo para submergir",
	CrystalArrow	= "Exibir seta do DBM quando $spell:81634 está próximo de você",
	RangeFrame		= "Exibir medidor de distância (5 metros)"
})

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "Fase aérea",
	WarnGroundphase			= "Fase terrestre",
	specWarnCrystalStorm	= "Tempestade de Cristal - Proteja-se"
})

L:SetTimerLocalization({
	TimerAirphase			= "Próx. Fase aérea",
	TimerGroundphase		= "Próx. Fase terrestre"
})

L:SetOptionLocalization({
	WarnAirphase			= "Exibir aviso quando Couro-pétreo levanta voo",
	WarnGroundphase			= "Exibir aviso quando Couro-pétreo pousa",
	TimerAirphase			= "Exibir cronógrafo para próxima fase aérea",
	TimerGroundphase		= "Exibir cronógrafo para próxima fase terrestre",
	specWarnCrystalStorm	= "Exibir aviso especial para $spell:92265"
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
	Retract		= "%s retracts its cyclone shield!"
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
	SpecWarnStaticCling	= "Exibir aviso especial para $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "SALTE!"
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
	RangeFrame	= "Exibir medidor de distância (10 metros)",
	StormArrow	= "Exibir seta do DBM para $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

L:SetWarningLocalization{
	WarnBear		= "Forma de Urso",
	WarnBearSoon	= "Forma de Urso em 5 seg",
	WarnNormal		= "Forma Normal",
	WarnNormalSoon	= "Forma Normal em 5 seg"
}

L:SetTimerLocalization{
	TimerBear		= "Forma de Urso",
	TimerNormal		= "Forma Normal"
}

L:SetOptionLocalization{
	WarnBear		= "Exibir aviso para Forma de Urso",
	WarnBearSoon	= "Exibir aviso antecipado para Forma de Urso",
	WarnNormal		= "Exibir aviso para Forma Normal",
	WarnNormalSoon	= "Exibir aviso antecipado para Forma Normal",
	TimerBear		= "Exibir cronógrafo para Forma de Urso",
	TimerNormal		= "Exibir cronógrafo para Forma Normal",
	InfoFrame		= "Exibir quadro de aviso de jogadores afetados por $spell:42402"
}

L:SetMiscLocalization{
	YellBear 		= "You call on da beast, you gonna get more dan you bargain for!",
	YellNormal		= "Make way for Nalorakk!",
	PlayerDebuffs	= "Surge Debuff"
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
	YellHatchAll= "I show you strength... in numbers.",
	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
}

--------------
--  Halazzi --
--------------
L= DBM:GetModLocalization(189)

L:SetWarningLocalization{
	WarnSpirit	= "Fase Espírito",
	WarnNormal	= "Fase Normal"
}

L:SetOptionLocalization{
	WarnSpirit	= "Exibir aviso para Fase Espírito",
	WarnNormal	= "Exibir aviso para Fase Normal"
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
	TimerSiphon	= "Exibir cronógrafo para $spell:43501"
}

L:SetMiscLocalization{
	YellPull	= "Da shadow gonna fall on you...."
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "Próx. mudança de forma"
}

L:SetOptionLocalization{
	timerNextForm	= "Exibir cronógrafo para mudança de forma.",
	InfoFrame		= "Exibir quadro de aviso para jogadores afetados por $spell:42402",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Surge Debuff"
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "Exibir seta do quando você é afetado por $spell:96477"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "%d fantasmas restantes",
	SpecWarnOhgan	= "Ohgan revivido! Ataque agora!" 
}

L:SetOptionLocalization{
	WarnRevive		= "Anunciar quantos fantasmas ainda restam",
	SpecWarnOhgan	= "Exibir aviso quando Ohgan é revivido", 
	SetIconOnOhgan	= "Colocar um ícone em Ohgan quando ele reviver" 
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
	SpecWarnToxic	= "Pegue tormento tóxico"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "Exibir aviso especial quando você não tiver $spell:96328",
	InfoFrame		= "Exibir quadro de avisos para jogadores sem $spell:96328",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "Sem tormento tóxico"
}

----------------------------
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

L:SetWarningLocalization{
	WarnBarrierDown	= "Correntes de Hakkar- Barreira Quebradiças - %d/3 Restantes"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Anunciar destruição de Barreiras Quebradiças",
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
	TimerFlarecoreDetonate	= "Flamífero explode"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Exibir cronógrafo para detonação de $spell:101927"
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
	WarnAdds	= "Novos ajudantes em breve"
}

L:SetTimerLocalization{
	TimerAdds	= "Próx. ajudantes"
}

L:SetOptionLocalization{
	WarnAdds	= "Anunciar quando novos ajudantes \"surgem\"",
	TimerAdds	= "Exibir cronógrafo para quando \"surgirão\" próximos ajudantes"
}

L:SetMiscLocalization{
	Kill		= "Enough! As much as I adore playing hostess, I have more pressing matters to attend to."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetTimerLocalization{
	TimerTyrandeHelp	= "Tyrande precisa de ajuda"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "Exibir cronógrafo para quando Tyrande precisará de ajuda"
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
	TimerCombatStart	= "Combate inicia"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Exibir cronógrafo para início do combate"
}

L:SetMiscLocalization{
	Event		= "Apareça!",
	Pull		= "Forças do Crepúsculo começam a aparecer nas beiradas do cânion."
}

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "...e com isso fora do caminho, você e seu bando de amigos desajeitados são os próximos da minha lista. Mmm, achei que vocês não iam chegar nunca!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "Combate inicia"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Exibir cronógrafo para início do combate"
}

L:SetMiscLocalization{
	Event		= "E agora, Xamã, entregue a Alma Dragônica para MIM."
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

