if GetLocale() ~= "koKR" then return end
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

L:SetTimerLocalization{
	TimerTransition		= "Phase transition"
}

L:SetOptionLocalization{
	TimerTransition		= "Show time for phase transitions"
}

L:SetMiscLocalization({
	Pull		= "If you truly wish to undo what your kind have wrought upon our land you must first prove yourselves here in our school.",
	Adds1Ended	= "You have bested our most junior of students.  Now you will face two of my most senior.",
	Adds2Ended	= "You have bested my prize students. Perhaps you can be of use to us after all...",
	Phase1Ended	= "%s vanishes to the shadows!",
	Defeat		= "I am bested.  Give me a moment and we will venture forth together to face the Sha."
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------
---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

L:SetOptionLocalization{
	IconOnSabotage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(107268)
}

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization{
	StaffingRun		= "%s prepares to make a strafing run!"
}

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
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Pull		= "Clan Gurthan will show our King and the rest of you power-hungry imposters why we are the rightful ones at his side!",
	Phase2		= "We will never surrender our right to rule the destiny of our people!",
	Phase3		= "Our clan is the true clan! No interloper can change that!",
	Defeat		= "Impossible! Our might is the greatest in all the empire!"
})

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

L:SetMiscLocalization({
	Axes		= "%s activates his Whirlwinding Axe trap!",--Possibly wrong, if the realtext has a link in it(not shown in chat log) it won't be right
	Blades		= "%s activates his Stream of Blades trap!"--Since both of these are RAID EMOTES and not yells.
})

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
	timerWave	= "Starts Sending: %s"
})

L:SetOptionLocalization({
	timerWave	= "Show timer for next mob wave"
})

L:SetMiscLocalization({
	Pull		= "Fools! Attacking the might of the mantid head on?  Your deaths will be swift.",
	Wave		= "A wave of",--msg find, not full trigger, full trigger includes group type name.
	Bombard		= "Bombard the platform!"--Don't you just love spells that don't show in combat log and need to be localized triggers?
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

L:SetWarningLocalization{
	specWarnGetBoned	= "뼈 갑옷 클릭!"
}

L:SetOptionLocalization{
	specWarnGetBoned	= "$spell:113996 효과가 없을 경우 특수 경고 보기",
	InfoFrame			= "$spell:113996 효과 없음에 대한 정보 프레임 보기"
}

L:SetMiscLocalization{
	PlayerDebuffs	= "뼈 갑옷 없음"
}

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetMiscLocalization{
	Kill	= "죽어라, 강령술사여!"
}

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

L:SetMiscLocalization{
	HarshLesson		= "spell:113395"--This is in the emote, shouldn't need localizing, just msg:find
}

-----------------------
-- <<<Scarlet Halls>>> --
-----------------------
-----------------------
-- Braun --
-----------------------
L= DBM:GetModLocalization(660)

-----------------------
-- Flameweaver Koegler --
-----------------------
L= DBM:GetModLocalization(656)

-----------------------
-- Harlan --
-----------------------
L= DBM:GetModLocalization(654)

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
	KickArrow	= "$spell:114487 주문이 근처에 시전된 경우 DBM 화살표 보기",
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)
