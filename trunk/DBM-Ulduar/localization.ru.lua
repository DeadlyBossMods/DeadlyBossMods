if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Огненный Левиафан"
})

L:SetMiscLocalization({
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
})

L:SetWarningLocalization({
	pursueWarn = "Цель >%s<!"
})

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Игнис Повелитель Кузни"
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
	name = "XT-002 Разрушитель"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Железный совет"
})

L:SetWarningLocalization({
	WarningSupercharge	= "Приближается Сверхатака",
})

L:SetTimerLocalization({
	TimerSupercharge	= "Сверхатака",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "Отображать отсчет времени до Сверхатаки",
	WarningSupercharge	= "Отображать предупреждение для Сверхатаки",
})

L:SetMiscLocalization({
	Steelbreaker		= "Стальной разрушитель",
	RunemasterMolgeim	= "Мастер рун Молгейн",
	StormcallerBrundir 	= "Призыватель бури Брундир",
})


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Алгалон"
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
	name = "Кологарн"
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
	name = "Ауриайя"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Ходир"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "Мгновенная заморозка",
	WarningBitingCold	= "Лютый холод - ДВИГАЙТЕСЬ"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "Приближается Мгновенная заморозка",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "Отображать отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Отображать предупреждение для Мгновенной заморозки",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при чтении заклинания Мгновенная заморозк",
})


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Торим"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Буремолот: %s",
})

L:SetTimerLocalization({
	TimerStormhammer	= "Следующий Буремолот",  -- applys AE Silience on the target
})

L:SetOptionLocalization({
	TimerStormhammer	= "Отображать время до восстановления Буремолота",
	WarningStormhammer	= "Отображать спец-предупреждение для Буремолота",
})


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Фрея"
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
	name = "Мимирон"
})

L:SetWarningLocalization({
	WarningPlasmaBlast	= "Plasma Blast: %s - лечение",
})

L:SetTimerLocalization({
	ProximityMines		= "Мины ближнего действия",
})

L:SetOptionLocalization({
	WarningShockBlast	= "Отображать предупреждение для Шокового удара",
	WarningPlasmaBlast	= "Отображать предупреждение для Plasma Blast",
	ProximityMines		= "Отображать отсчет времени до Мин ближнего действия",
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
	name = "Генерал Везакс"
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
	name = "Йогг Сарон"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})




