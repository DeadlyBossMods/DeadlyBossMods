if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Ониксия"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Глубокий вдох",
	WarnWhelpsSoon	= "Скоро вызов дракончиков",
}

L:SetTimerLocalization{
	TimerBreath	= "Глубокий вдох",
	TimerWhelps = "Вызов дракончиков"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Спец-предупреждение для Глубокого вдоха",
	TimerBreath		= "Отсчет времени до Глубокого вдоха",
	TimerWhelps		= "Отсчет времени до вызова дракончиков",
	WarnWhelpsSoon	= "Пред-предупреждение для вызова дракончиков",
	SoundBreath		= "Звуковой сигнал, когда Глубокий вдох"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s takes in a deep breath...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}
