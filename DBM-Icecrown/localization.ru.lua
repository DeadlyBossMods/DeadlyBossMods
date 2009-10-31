if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Лорд Ребрад"
})

L:SetWarningLocalization({
	warnImpale			= ">%S< проткнут(а)",
	specWarnWhirlwind		= "Вихрь - бегите",
	specWarnColdflame		= "Холодное пламя - отбегите"
})

L:SetOptionLocalization({
	warnImpale			= "Предупредить о проткнутой цели",
	specWarnWhirlwind		= "Спец-предупреждение для Вихря",
	specWarnColdflame		= "Спец-предупреждение, когда вы получаете урон от Холодного пламени",
	PlaySoundOnWhirlwind		= "Звуковой сигнал при Вихре"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Леди Смертный Шёпот"
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
	name = "Смертеносец"
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
	name = "Воздушное Сражение"
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
	name = "Тухлопуз"
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
	name = "Гниломорд"
})
L:SetWarningLocalization({
	SpecWarnStickyOoze		= "Липкая жижа - бегите",
	SpecWarnRadiationOoze		= "Radiation Ooze",
	SpecWarnMutatedInfection 	= "Mutated Infection on you"
})
L:SetTimerLocalization({
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
})
L:SetOptionLocalization({
	SpecWarnStickyOoze		= "Спец-предупреждение для Липкой жижи",
	SpecWarnRadiationOoze		= "Show special warning for Radiation Ooze",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning for Mutated Infection",
	InfectionIcon				= "Set icon on Mutated Infection target",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
})
L:SetMiscLocalization({
	YellSlimePipes		= "Хорошие новости, для всех!"	-- Good news, everyone! I've fixed the poison slime pipes!
})



---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Профессор Мерзоцид"
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
	name = "Совет Принцев Крови"
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
	name = "Королева Лана'Тель"
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
	name = "Валитрия Сновидица"
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
	name = "Синдрагоса"
})
L:SetTimerLocalization({
	NextAirphase 		= "Воздушная фаза",
	NextGroundphase		= "Наземная фаза"
})
L:SetWarningLocalization({
	WarnAirphase		= "Воздушная фаза",
	WarnBlisteringCold	= "Blistering Cold",
	SpecWarnBlisteringCold	= "Blisstering Cold - run out",
	SpecWarnFrostBeacon	= "Frost beacon on you",
	PrewarnGroundphase	= "Синдрагоса приземляется",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
})
L:SetOptionLocalization({
	WarnAirphase		= "Предупредить о воздушной фазе",
	WarnBlisteringCold	= "Show warning for Blistering Cold",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon	= "Show special warning for Frost Beacon",
	PrewarnGroundphase	= "Предупредить зарание о наземной фазе",
	NextAirphase		= "Отсчет времени до воздушной фазы",
	NextGroundphase		= "Отсчет времени до наземной фазы",
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
	name = "Король-Лич"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})