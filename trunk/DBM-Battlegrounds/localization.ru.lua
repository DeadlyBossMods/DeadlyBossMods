if GetLocale() ~= "ruRU" then return end

local L

----------------------------
--  General BG Options  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name 			= "Общие параметры"
})
L:SetTimerLocalization({
	TimerInvite 		= "%s"
})

L:SetOptionLocalization({
	ColorByClass 		= "Показывать имена цветом класса в таблице очков",
	ShowInviteTimer 	= "Отсчет времени до входа на ПБ",
	AutoSpirit 		= "Автоматически покидать тело"
})

L:SetMiscLocalization({
	ArenaInvite		= "Приглашение на Арену"
})
--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name 			= "Арены"
})

L:SetTimerLocalization({
	TimerStart 		= "Битва начнется через",
    TimerShadow			= "Сумеречное зрение"
})

L:SetOptionLocalization({
	TimerStart 		= "Отсчет времени до начала битвы",
	TimerShadow 		= "Отсчет времени для Сумрачного кристалла"
})

L:SetMiscLocalization({
	Start60 		= "Битва на Арене начнется через минуту!",
	Start30 		= "Битва на Арене начнется через 30 секунд!",
	Start15 		= "Пятнадцать секунд до начала схватки на арене!"
})
----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name 			= "Альтеракская долина"
})

L:SetTimerLocalization({
	TimerStart 		= "Битва начнется через", 
	TimerTower 		= "%s",
	TimerGY 		= "%s"
})

L:SetMiscLocalization({
	BgStart60 		= "До начала сражения за Альтеракскую долину остается 1 минута.",
	BgStart30 		= "30 секунд до начала сражения в Альтеракской долине.",
	ZoneName 		= "Альтеракская долина"
})

L:SetOptionLocalization({
	TimerStart  		= "Отсчет времени до начала битвы",
	TimerTower 		= "Отсчет времени до захвата",
	TimerGY 		= "Отсчет времени до захвата кладбищь",
	AutoTurnIn 		= "Автоматическая сдача заданий"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name 			= "Низина Арати"
})

L:SetMiscLocalization({
	BgStart60 		= "Битва за Низину Арати начнется через минуту.",
	BgStart30 		= "Битва за Низину Арати начнется через 30 секунд.",
	ZoneName 		= "Низина Арати",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "Альянса",
	Horde 			= "Орды",
	WinBarText 		= "Победа %s",
	BasesToWin 		= "Захвачено баз: %d",
	Flag 			= "Флаг"
})

L:SetTimerLocalization({
	TimerStart 		= "Битва начнется через", 
	TimerCap 		= "%s"
})

L:SetOptionLocalization({
	TimerStart  		= "Отсчет времени до начала битвы",
	TimerWin 		= "Отсчет времени до победы",
	TimerCap 		= "Отсчет времени до захвата",
	ShowAbEstimatedPoints 	= "Отображать предполагаемые очки оставшиеся до победы/поражения",
	ShowAbBasesToWin 	= "Отображать базы, которые необходимо захватить"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name 			= "Око Бури"
})

L:SetMiscLocalization({
	BgStart60 		= "Битва начнется через минуту!",
	BgStart30 		= "Битва начнется через 30 секунд!",
	ZoneName 		= "Око Бури",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "Альянса",
	Horde 			= "Орды",
	WinBarText 		= "Победа %s",
	FlagReset 		= "Флаг возвращен на базу.",
	FlagTaken 		= "(.+) захватывает флаг!",
	FlagCaptured 		= "(.+) захватывает флаг (%w+)!",
	FlagDropped 		= "Флаг уронили!"

})

L:SetTimerLocalization({
	TimerStart 		= "Битва начнется через", 
	TimerFlag 		= "Флаг восстановлен"
})

L:SetOptionLocalization({
	TimerStart  		= "Отсчет времени до начала битвы",
	TimerWin 		= "Отсчет времени до победы",
	TimerFlag 		= "Отсчет времени до восстановления флага",
	ShowPointFrame 		= "Отображать флагоносца и предполагаемые очки"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name 			= "Ущелье Песни Войны"
})

L:SetMiscLocalization({
	BgStart60 		= "Битва за Ущелье Песни Войны начнется через 1 минуту.",
	BgStart30 		= "Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовтесь!",
	ZoneName 		= "Ущелье Песни Войны",
	Alliance 		= "Альянса",
	Horde 			= "Орды",
	InfoErrorText 		= "Функция выбора флагоносца, будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp 		= "(.+) подымает флаг (%w+)",
	ExprFlagCaptured 	= "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn 		= "(.+) возвращает флаг (%w+) на базу!",
	FlagAlliance 		= "Флаг Альянса: ",
	FlagHorde 		= "Флаг Орды: ",
	FlagBase 		= "База"
})

L:SetTimerLocalization({
	TimerStart 		= "Битва начнется через", 
	TimerFlag 		= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerStart  		= "Отсчет времени до начала битвы",
	TimerWin 		= "Отсчет времени до победы",
	TimerFlag 		= "Отсчет времени до восстановления флага",
	ShowFlagCarrier 	= "Показать флагоносца",
	ShowFlagCarrierErrorNote = "Сообщения об ошибках в режиме боя"
})

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name 			= "Склеп Аркавона"
})

L:SetWarningLocalization({
	WarningShards 		= "Град из острых камней на >%s<",
	WarningGrab 		= "Страж бросается к >%s<"
})

L:SetTimerLocalization({
	TimerShards 		= "Каменные осколки: %s"
})

L:SetMiscLocalization({
	TankSwitch 		= "%%s нападает на (%S+)!"
})

L:SetOptionLocalization({
	TimerShards 		= "Отсчет времени до града из Каменных осколков",
	WarningShards 		= "Предупреждение для Каменных осколков",
	WarningGrab 		= "Предупреждение для Захвата"
})
--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name 			= "Эмалон Созерцатель Бури"
}

L:SetWarningLocalization{
	specWarnNova		= "Вспышка молнии - бегите",
	warnNova 		= "Вспышка молнии",
	warnOverCharge		= "Перезарядка"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Взрыв избыточно заряда"
}

L:SetOptionLocalization{
	specWarnNova 		= ("Спец-предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Вспышка молнии"),
	warnNova 		= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Вспышка молнии"),
	warnOverCharge 		= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "Перезарядка"),
	NovaSound		= "Звуковой сигнал при Вспышке молнии",
	timerMobOvercharge	= "Отсчет времени для Избыточно заряда (суммирующийся отрицательный эффект)"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name 			= "Коралон Страж Огня"
}

L:SetWarningLocalization{
	SpecWarnCinder		= "Пылающая головня - бегите"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SpecWarnCinder		= "Спец-предупреждение, когда вы в Пылающей головне",
	PlaySoundOnCinder	= "Звуковое уведомление, когда вы в Пылающей головне"
}

L:SetMiscLocalization{
	Meteor			= "%s бросает Кулаки-метеоры!"
}


------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleOfConquest")

L:SetGeneralLocalization({
	name 			= "Остров Завоеваний"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerStart		= "Битва начнется через", 
	TimerPOI		= "%s"
})

L:SetOptionLocalization({
	TimerStart		= "Отсчет времени до начала битвы", 
	TimerPOI		= "Отсчет времени до захвата"
})

L:SetMiscLocalization({
	ZoneName		= "Остров Завоеваний",
	BgStart60		= "Битва начнется через 60 секунд.",
	BgStart30		= "Битва начнется через 30 секунд.",
	BgStart15		= "Битва начнется через 15 секунд."
})
