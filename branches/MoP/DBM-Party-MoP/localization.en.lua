local L

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization{
	StaffingRun		= "%s prepares to make a strafing run!"
}

---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

L:SetOptionLocalization{
	IconOnSabotage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(107268)
}

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

-----------------------
-- LibraryEvent --
-----------------------
L= DBM:GetModLocalization(664)

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)--This right?

-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

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
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

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
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)

-----------------------
-- Korlof --
-----------------------
L= DBM:GetModLocalization(671)

L:SetOptionLocalization({
	KickArrow	= "Show DBM arrow when $spell:114021 is near you",
})

-----------------------
-- Thalnos Soulrender --
-----------------------
L= DBM:GetModLocalization(688)

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
	specwarnGetBoned	= "Get Bone Armor"
}

L:SetOptionLocalization{
	specwarnGetBoned	= "Show special warning when you are missing $spell:113996 debuff",
	InfoFrame			= "Show info frame for players not affected by $spell:113996"
}

L:SetMiscLocalization{
	PlayerDebuffs	= "No Bone Armor"
}

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

L:SetMiscLocalization{
	HarshLesson		= "spell:113395"--This is in the emote, shouldn't need localizing, just msg:find
}


-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

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
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

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
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Show dynamic range frame based on player debuff status for\n$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)


