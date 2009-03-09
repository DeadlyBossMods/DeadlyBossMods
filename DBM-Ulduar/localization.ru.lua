if GetLocale() ~= "ruRU" then return end

local L

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

--L:SetMiscLocalization({ })

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
	RunemasterMolgeim 	= "Мастер рун Молгейн",
	StormcallerBrundir 	= "Призыватель бури Брундир",
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
	WarningBitingCold	= "Лютый холод - ДВИГАЙТЕСЬ",
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "Приближается Мгновенная заморозка",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "Отображать отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Отображать предупреждение для Мгновенной заморозки",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при чтении заклинания Мгновенная заморозка",
})

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
}








