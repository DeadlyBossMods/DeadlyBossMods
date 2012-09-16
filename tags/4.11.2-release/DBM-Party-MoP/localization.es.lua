if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s en %s (%d)"
})

L:SetOptionLocalization({
	SpecWarnIntensity	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS["stack"]:format(6, 113315)
})

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)

-----------------------
-- <<<Stormstout Brewery>>> --
-----------------------
-----------------------
-- Ook-Ook --
-----------------------
L= DBM:GetModLocalization(668)

-----------------------
-- Hoptallus --
-----------------------
L= DBM:GetModLocalization(669)

-----------------------
-- Yan Zhu the Uncasked --
-----------------------
L= DBM:GetModLocalization(670)

L:SetWarningLocalization({
	SpecWarnFizzyBubbles	= "Obtén Burbuja gaseosa y vuela"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "Mostrar aviso especial cuando te falta $spell:114459",
	RangeFrame				= "Mostrar distancia (10) para $spell:106546"
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetMiscLocalization({
	Defeat		= "I am bested.  Give me a moment and we will venture forth together to face the Sha."--translate
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "Mostrar información para $journal:5827"
})

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------
---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

L:SetOptionLocalization({
	IconOnSabotage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(107268)
})

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization({
	StaffingRun		= "Striker Ga'dok prepares to make a strafing run!"--translate
})

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

-----------------------
-- <<<Mogu'Shan Palace>>> --
-----------------------
-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Kuai		= "Clan Gurthan will show our King and the rest of you power-hungry imposters why we are the rightful ones at his side!",--translate
	Ming		= "Clan Harthak will show all why they are the truest of Mogu!",--translate
	Haiyan		= "Clan Korgesh will demonstrate why only the strong deserve to stand at our King's side!",--translate
	Defeat		= "Who allowed these outsiders inside our halls? Only Clan Harthak or Clan Kargesh would stoop to such treachery!"--translate
})

-----------------------
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

-----------------------
-- <<<Siege of Niuzao Temple>>> --
-----------------------
-----------------------
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

-----------------------
-- Vo'jak --
-----------------------
L= DBM:GetModLocalization(738)

L:SetTimerLocalization({
	TimerWave	= "Empieza a enviar: %s"
})

L:SetOptionLocalization({
	TimerWave	= "Mostrar tiempo para la siguiente oleada de adds"
})

L:SetMiscLocalization({
	WaveStart	= "Fools! Attacking the might of the mantid head on?  Your deaths will be swift."--translate
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)

-----------------------
-- <<<Scholomance>>> --
-----------------------
-----------------------
-- Instructor Chillheart --
-----------------------
L= DBM:GetModLocalization(659)

-----------------------
-- Jandice Barov --
-----------------------
L= DBM:GetModLocalization(663)

-----------------------
-- Rattlegore --
-----------------------
L= DBM:GetModLocalization(665)

L:SetWarningLocalization({
	SpecWarnGetBoned	= "Obtén Armadura ósea"
})

L:SetOptionLocalization({
	SpecWarnGetBoned	= "Mostrar aviso especial cuando te falta $spell:113996",
	InfoFrame			= "Mostrar información con jugadores sin $spell:113996"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Sin Armadura ósea"
})

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetMiscLocalization({
	Kill	= "What?!"--translates
})

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

-----------------------
-- <<<Scarlet Halls>>> --
-----------------------
-----------------------
-- Braun --
-----------------------
L= DBM:GetModLocalization(660)

-----------------------
-- Harlan --
-----------------------
L= DBM:GetModLocalization(654)

L:SetMiscLocalization({
	Call		= "Armsmaster Harlan calls on two of his allies to join the fight!"--translate
})

-----------------------
-- Flameweaver Koegler --
-----------------------
L= DBM:GetModLocalization(656)

-----------------------
-- <<<Scarlet Cathedral>>> --
-----------------------
-----------------------
-- Thalnos Soulrender --
-----------------------
L= DBM:GetModLocalization(688)

-----------------------
-- Korlof --
-----------------------
L= DBM:GetModLocalization(671)

L:SetOptionLocalization({
	KickArrow	= "Mostrar flecha cuando $spell:114487 está cerca de ti",
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)

