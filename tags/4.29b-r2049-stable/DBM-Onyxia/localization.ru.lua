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
	SpecWarnBreath		= "Глубокий вдох",
	specWarnBlastNova	= "Страж логова Ониксии читает заклинание Вспышка Огненной звезды. Бегите!",
	WarnWhelpsSoon		= "Скоро дракончики Ониксии",
	WarnPhase3Soon		= "Скоро фаза 3"
}

L:SetTimerLocalization{
	TimerBreath		= "Глубокий вдох",
	TimerWhelps 		= "Вызов дракончиков Ониксии"
}

L:SetOptionLocalization{
	SpecWarnBreath		= "Спец-предупреждение для Глубокого вдоха",
	BlastNovaWarning	= "Спец-предупреждение для Вспышки Огненной звезды",
	TimerBreath		= "Отсчет времени до Глубокого вдоха",
	TimerWhelps		= "Отсчет времени до дракончиков Ониксии",
	WarnWhelpsSoon		= "Предупредить зарание о дракончиках Ониксии",
	SoundBreath		= "Звуковой сигнал, когда Глубокий вдох",
	PlaySoundOnBlastNova	= "Звуковой сигнал, когда Вспышка Огненной звезды",
	SoundWTF		= "Воспроизводить забавное озвучивание легендарного классического рейда на Ониксию (англ.)",
	WarnPhase3Soon		= "Предупредить зарание о фазе 3 (при ~41% здоровья босса)"
}

L:SetMiscLocalization{
	Breath = "%s под воздействием Глубокого вдоха...",
	YellP2 = "Эта бессмысленная возня вгоняет меня в тоску. Я сожгу вас всех!",
	YellP3 = "Похоже, вам требуется преподать еще один урок, смертные!"
}
