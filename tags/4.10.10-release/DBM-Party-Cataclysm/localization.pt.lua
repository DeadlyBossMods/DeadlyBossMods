if GetLocale() ~= "ptBR" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Rom'ogg Esmaga-ossos"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "Corla, a Arauto do Crepúsculo"
})

L:SetWarningLocalization({
	WarnAdd		= "Ajudante solto"
})

L:SetOptionLocalization({
	WarnAdd		= "Avisar quando um ajudante perder o bônus $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Karsh Dobraferro"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "Armadura Superaquecida (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "Exibir cronógrafo para duração de $spell:75846"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "Bela"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "Lorde Ascendente Obsidius"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "Colocar um ícone no chefe após $spell:76200"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "Falagrum"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "Helix Quebracâmbio"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "Ceifador de Inimigos 5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "Almirante Rosnarrasga"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"Captain\" Biscoito"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "Vanessa VanCleef"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Gauntlet" --TODO
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name 		= "General Umbriss"
})

L:SetOptionLocalization{
	PingBlitz	= "Apontar no minimapa quando o General Umbriss está prestes a usar Ataque Relâmpago em você"
}

L:SetMiscLocalization{
	Blitz		= "sets his eyes on |cFFFF0000(%S+)" --TODO
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Mestre Forjador Throngus"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Drahga Queimassombra"
})

L:SetMiscLocalization{
	ValionaYell	= "Dragon, you will do as I command! Catch me!",	-- Yell when Valiona is incoming
	Add			= "%s Summons an",
	Valiona		= "Valiona"
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "Erúdax"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "Guardião do Templo Anhuur"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "Ptah Furitérreo"
})

L:SetMiscLocalization{
	Kill		= "Ptah... is... no more..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Anraphet"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Gauntlet" --TODO
})

L:SetMiscLocalization({
	Brann				= "Right, let's go! Just need to input the final entry sequence into the door mechanism... and..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "Isiset"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "Dividir em breve"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Exibir aviso antecipado para divisão"
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
	name = "General Husam"
})

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Siamat"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

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

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Sumo Profeta Barim"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Exibir vida dos ajudantes no Quadro de Vida do Boss"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Blaze of the Heavens",
	HarbringerDarkness	= "Harbringer of Darkness"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Trancabucho"
})

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

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "Barão Ashbury"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "Barão Silverlaine"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "Comandante Floraval"
})

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
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Lorde Walden"
})

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
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Lorde Godfrey"
})

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "Corborus"
})

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
	name = "Couro-pétreo"
})

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

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "Alta-sacerdotiza Azil"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "Grã-vizir Ertan"
})

L:SetMiscLocalization{
	Retract		= "%s retracts its cyclone shield!"
}

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
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "Lady Naz'jar"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "Comandante Ulthok"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "Erunak Falapedra"
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
	name = "Nalorakk (Urso)"
}

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

--------------
-- Akil'zon --
--------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Akil'zon (Águia)"
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "Exibir medidor de distância (10 metros)",
	StormArrow	= "Exibir seta do DBM para $spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

L:SetMiscLocalization{
}

--------------
-- Jan'alai --
--------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "Jan'alai (Falcodrago)"
}

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
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Halazzi (Lince)"
}

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
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "Grão-bagateiro Malacrass"
}

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
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "Daakara"
}

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
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Sumo Sacerdote Venoxis"
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "Exibir seta do quando você é afetado por $spell:96477"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Sangrelorde Mandokir"
}

L:SetWarningLocalization{
	WarnRevive		= "%d fantasmas restantes",
	SpecWarnOhgan	= "Ohgan revivido! Ataque agora!" 
}

L:SetOptionLocalization{
	WarnRevive		= "Anunciar quantos fantasmas ainda restam",
	SpecWarnOhgan	= "Exibir aviso quando Ohgan é revivido", 
	SetIconOnOhgan	= "Colocar um ícone em Ohgan quando ele reviver" 
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
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "Alta-sacerdotisa Kilnara"
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do, o Doma-deus"
}

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

L:SetMiscLocalization({
	pursuitEmote	= "%s está seguindo"
})

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
	name = "Vuxulai"
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

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "Eco de Sylvana"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "Eco de Tyrande"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "Eco de Jaina"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Flamífero explode"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Exibir cronógrafo para detonação de $spell:101927"
}

L:SetMiscLocalization{
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "Eco de Baine"
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

L:SetMiscLocalization{
	Pull		= "No mortal may stand before me and live!"
}


-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "Rainha Azshara"
}

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
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "Mannoroth e Varo'then"
}

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
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "Arcurion"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combate inicia"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Exibir cronógrafo para início do combate"
}

L:SetMiscLocalization{
	Event		= "Show yourself!",
	Pull		= "Twilight forces begin to appear around the canyons edges."
}

----------------------
-- Asira Dawnslayer --
----------------------
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "Asira Raiamorte"
}

L:SetMiscLocalization{
	Pull		= "...and with that out of the way, you and your flock of fumbling friends are next on my list. Mmm, I thought you'd never get here!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "Archbishop Benedictus"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combate inicia"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Exibir cronógrafo para início do combate"
}

L:SetMiscLocalization{
	Event		= "And now, Shaman.. you will give the Dragon Soul to me."
}