local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Lord Marrowgar"
})

L:SetWarningLocalization({
	WarnImpale				= ">%s< is impaled",
	SpecWarnWhirlwind		= "Whirlwind - Run away",
	SpecWarnColdflame		= "Coldflame - Move away"
})

L:SetOptionLocalization({
	WarnImpale				= "Announce Impale targets",
	SpecWarnWhirlwind		= "Show special warning for Whirlwind",
	SpecWarnColdflame		= "Show special warning when you take damage from Coldflame",
	PlaySoundOnWhirlwind	= "Play sound on Whirlwind"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Lady Deathwhisper"
})

L:SetTimerLocalization({
	TimerAdds		= "New adds"
})

L:SetWarningLocalization({
	WarnAddsSoon		= "New adds soon",
	WarnDeathDecay		= "Death and Decay",
	WarnAdherent		= "Cult Adherent transforming",
	SpecWarnDeathDecay	= "Death and Decay - move away",
	SpecWarnCurseTorpor	= "Curse of Torpor on you"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "Show warning for new adds spawning soon",
	WarnDeathDecay		= "Show warning for Death and Decay",
	WarnAdherent		= "Show warning for Adherent yell",	-- Cult Adherent -> Reanimated Adherent transformation iirc
	SpecWarnDeathDecay	= "Show special warning when you are affected by Death and Decay",
	SpecWarnCurseTorpor	= "Show special warning when you are affected by Curse of Torpor",
	TimerAdds		= "Show a timer for new adds spawning"
})

L:SetMiscLocalization({
	YellAdds		= "Arise, and exult in your pure form!",
	YellPull		= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellAdherent		= "Loyal adherent, I release you from the curse of flesh!",
	YellEmbrace		= "Embrace the darkness... darkness eternal.",
	YellBlessing		= "Take this blessing and show these intruders a taste of the Master's power!"
})
------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "The Deathbringer"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Gunship Battle"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Festergut"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Rotface"
})

L:SetWarningLocalization({
	SpecWarnStickyOoze			= "Sticky Ooze - Move out",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection 	= "Mutated Infection on you"
})

L:SetTimerLocalization({
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
})

L:SetOptionLocalization({
	SpecWarnStickyOoze			= "Show special warning for Sticky Ooze",
	SpecWarnRadiatingOoze		= "Show special warning for Radiating Ooze",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning when you are affected by Mutated Infection",
	InfectionIcon				= "Set icons on Mutated Infection targets",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
})

L:SetMiscLocalization({
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Professor Putricide"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Blood Prince Council"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Queen Lana'thel"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Valithria Dreamwalker"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Sindragosa"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "Next air phase",
	TimerNextGroundphase	= "Next ground phase"
})

L:SetWarningLocalization({
	WarnAirphase			= "Air phase",
	WarnBlisteringCold		= "Blistering Cold",
	SpecWarnBlisteringCold	= "Blistering Cold - Run away",
	SpecWarnFrostBeacon		= "Frost Beacon on you",
	WarnGroundphaseSoon		= "Sindragosa landing soon",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
})

L:SetOptionLocalization({
	WarnAirphase			= "Announce air phase",
	WarnBlisteringCold		= "Show warning for Blistering Cold",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon		= "Show special warning when you are affected by Frost Beacon",
	WarnGroundphaseSoon		= "Show pre-warning for ground phase",
	TimerNextAirphase		= "Show timer for next air phase",
	TimerNextGroundphase	= "Show timer for next ground phase",
	SpecWarnUnchainedMagic	= "Show special warning when you are affected by Unchained Magic"
})

L:SetMiscLocalization({
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "The Lich King"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

