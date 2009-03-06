if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Stormhammer: %s",
})

L:SetTimerLocalization({
	TimerStormhammer	= "Следующий Stormhammer",  -- applys AE Silience on the target
})

L:SetOptionLocalization({
	TimerStormhammer	= "Отображать время до восстановления Stormhammer",
	WarningStormhammer	= "Отображать спец-предупреждение для Stormhammer",
})

--L:SetMiscLocalization({ })

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Iron Council"
})

L:SetWarningLocalization({
	WarningSupercharge	= "Приближается Supercharge",
})

L:SetTimerLocalization({
	TimerSupercharge	= "Supercharge",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "Отображать отсчет времени до Supercharge",
	WarningSupercharge	= "Отображать предупреждение для Supercharge",
})

L:SetMiscLocalization({
	"Steelbreaker"		= "Steelbreaker",
	"RunemasterMolgeim" 	= "Runemaster Molgeim",
	"StormcallerBrundir" 	= "Stormcaller Brundir",
})


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "Мгновенная заморозка",
	WarningBitingCold	= "Biting Cold - ДВИГАЙТЕСЬ"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "Приближается Мгновенная заморозка",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "Отображать отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Отображать предупреждение для Мгновенной заморозки",
})

L:SetMiscLocalization({
	"PlaySoundOnFlashFreeze"	= "Звуковой сигнал при чтении заклинания Мгновенная заморозка",
})

