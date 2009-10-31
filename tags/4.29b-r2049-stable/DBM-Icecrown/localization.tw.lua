if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "瑪洛加爾領主"
})

L:SetWarningLocalization({
	warnImpale				= ">%s< 被刺穿了",
	specWarnWhirlwind		= "Whirlwind - 快跑開!",
	specWarnColdflame		= "Coldflame, MOVE!"
})

L:SetOptionLocalization({
	warnImpale				= "為被刺穿的目標顯示警告",
	specWarnWhirlwind		= "為Whirlwind顯示特別警告",
	specWarnColdflame		= "當你受到Coldflame的傷害時顯示特別警告",
	PlaySoundOnWhirlwind	= "為Whirlwind播放音效"
})


-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Lady Deathwhisper"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
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
	SpecWarnStickyOoze = "Ooze - 快跑出去!",
	SpecWarnRadiationOoze		= "Radiation Ooze",
	SpecWarnMutatedInfection 	= "Mutated Infection on you"
})
L:SetTimerLocalization({
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
})
L:SetOptionLocalization({
	SpecWarnStickyOoze = "為Sticky Ooze顯示特別警告",
	SpecWarnRadiationOoze = "為Radiation Ooze顯示特別警告",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning for Mutated Infection",
	InfectionIcon				= "Set icon on Mutated Infection target",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
})
L:SetMiscLocalization({
	YellSlimePipes		= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
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
	NextAirphase 		= "Next airphase",
	NextGroundphase		= "Next groundphase"
})
L:SetWarningLocalization({
	WarnAirphase		= "Airphase",
	WarnBlisteringCold	= "Blistering Cold",
	SpecWarnBlisteringCold	= "Blisstering Cold - run out",
	SpecWarnFrostBeacon	= "Frost beacon on you",
	PrewarnGroundphase	= "Sindragosa landing soon",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
})
L:SetOptionLocalization({
	WarnAirphase		= "Show warning for airphase",
	WarnBlisteringCold	= "Show warning for Blistering Cold",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon	= "Show special warning for Frost Beacon",
	PrewarnGroundphase	= "Show prewarning for groundphase",
	NextAirphase		= "Show timer for next airphase",
	NextGroundphase		= "Show timer for next groundphase",
	SpecWarnUnchainedMagic	= "Show special warning for Unchained Magix"
})
L:SetMiscLocalization({
	YellAirphase		= "Your incursion ends here! None shall survive!",
	YellPull		= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
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