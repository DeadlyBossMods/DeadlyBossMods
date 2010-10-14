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
	WarnWhelpsSoon		= "Скоро дракончики Ониксии",
	WarnPhase2Soon		= "Скоро фаза 2",
	WarnPhase3Soon		= "Скоро фаза 3"
}

L:SetTimerLocalization{
	TimerWhelps	= "Вызов дракончиков Ониксии"
}

L:SetOptionLocalization{
	TimerWhelps				= "Отсчет времени до дракончиков Ониксии",
	WarnWhelpsSoon			= "Предупреждать заранее о дракончиках Ониксии",
	SoundWTF				= "Воспроизводить забавное озвучивание легендарного классического рейда на Ониксию (англ.)",
	WarnPhase2Soon			= "Предупреждать заранее о фазе 2 (на ~67%)",
	WarnPhase3Soon			= "Предупреждать заранее о фазе 3 (на ~41%)"
}

L:SetMiscLocalization{
	YellP2 = "Эта бессмысленная возня вгоняет меня в тоску. Я сожгу вас всех!",
	YellP3 = "Похоже, вам требуется преподать еще один урок, смертные!"
}

