local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

L:SetOptionLocalization({
	SetIconOnAdds	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej5616")
})

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s on %s (%d)"
})

L:SetOptionLocalization({
	SpecWarnIntensity	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(6, 113315)
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
	SpecWarnFizzyBubbles	= "Get Fizzy Bubble and fly"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "Show special warning when you are missing $spell:114459 debuff",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 106546)
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

L:SetWarningLocalization({
	warnStaticField	= "%s"
})

L:SetOptionLocalization({
	warnStaticField	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(106923)
})

-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetWarningLocalization({
	warnRemainingNovice	= "Novices remaining: %d"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "Announce how many Novices remain"
})

L:SetMiscLocalization({
	NovicesPulled	= "You!  You have allowed the Sha to reawaken after all these years!",
	NovicesDefeated = "You have bested our most junior of students.  Now you will face two of my most senior.",
--	Defeat			= "I am bested.  Give me a moment and we will venture forth together to face the Sha."
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetMiscLocalization({
	Kill		= "So long has violence lurks in your heart...I will return...",
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "Show info frame for $journal:5827"
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
	StaffingRun		= "Striker Ga'dok prepares to make a strafing run!"
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
	Pull		= "Useless, all of you! Even the guards you give me in tribute can't keep these lesser beings from my palace.",
	Kuai		= "Clan Gurthan will show our King and the rest of you power-hungry imposters why we are the rightful ones at his side!",
	Ming		= "Clan Harthak will show all why they are the truest of Mogu!",
	Haiyan		= "Clan Kargesh will demonstrate why only the strong deserve to stand at our King's side!",
	Defeat		= "Who allowed these outsiders inside our halls? Only Clan Harthak or Clan Kargesh would stoop to such treachery!"
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
	TimerWave	= "Sending: %s"
})

L:SetOptionLocalization({
	TimerWave	= "Show timer for next mob wave"
})

L:SetMiscLocalization({
	WaveStart	= "Fools! Attacking the might of the mantid head on?  Your deaths will be swift."
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
	SpecWarnGetBoned	= "Get Bone Armor"
})

L:SetOptionLocalization({
	SpecWarnGetBoned	= "Show special warning when you are missing $spell:113996 debuff",
	InfoFrame			= "Show info frame for players not affected by $spell:113996"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "No Bone Armor"
})

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetMiscLocalization({
	Kill	= "DIE, NECROMANCER!"
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
	Call		= "Armsmaster Harlan calls on two of his allies to join the fight!"
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
	KickArrow	= "Show DBM arrow when $spell:114487 is near you",
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)