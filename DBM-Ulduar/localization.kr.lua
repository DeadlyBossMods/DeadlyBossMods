if GetLocale() ~= "koKR" then return end

local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Flame Leviathan"
})

L:SetMiscLocalization({
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
})

L:SetWarningLocalization({
	pursueWarn = "Pursuing >%s<!"
})

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Razorscale"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "XT002"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------------
--  철의 의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "철의 의회"
})

L:SetWarningLocalization({
	WarningSupercharge	= "과충전 시전",
})

L:SetTimerLocalization({
	TimerSupercharge	= "과충전",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "과충전 타이머 보기",
	WarningSupercharge	= "과충전 시전 경보 보기",
})

L:SetMiscLocalization({
	Steelbreaker		= "강철파괴자",
	RunemasterMolgeim 	= "룬마스터 몰게임",
	StormcallerBrundir 	= "폭풍소환사 브룬디르",
})

---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriya")

L:SetGeneralLocalization({
	name = "Auriya"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "호디르"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "급속 결빙",
	WarningBitingCold	= "매서운 추위 - 움직이세요!"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "급속 결빙 시전",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "급속 결빙 시전 타이머 보기",
	WarningFlashFreeze	= "급속 결빙 경보 보기",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "급속 결빙 시전 사운드 듣기",
})


--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "토림"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Stormhammer on %s",
})

L:SetTimerLocalization({
	TimerStormhammer	= "Next Stormhammer",  -- applys AE Silience on the target
})

L:SetOptionLocalization({
	TimerStormhammer	= "Show Stormhammer Cooldown",
	WarningStormhammer	= "Announce Stormhammer Target",
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	WarningPlasmaBlast	= "Plasma Blast on %s - heal",
})

L:SetTimerLocalization({
	ProximityMines		= "New Proximity Mines",
})

L:SetOptionLocalization({
	WarningShockBlast	= "Show Shock Blast Warning",
	WarningPlasmaBlast	= "Show Plasma Blast Warning",
	ProximityMines		= "Show Timer for Proximity Mines",
})

L:SetMiscLocalization({
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	PlaySoundOnShockBlast 	= "Play sound on Shock Blast cast",
	
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	Phase2Engaged		= "Phase 2 incoming - regroup now",

	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	Phase3Engaged		= "Phase 3 incoming - regroup now",
})


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "General Vezax"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})







