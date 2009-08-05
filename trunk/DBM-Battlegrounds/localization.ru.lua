if GetLocale() ~= "ruRU" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Общие функции ПБ"
})
L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass = "Показывать имена цветом класса в таблице очков",
	ShowInviteTimer = "Отображать отсчет времени до входа на ПБ",
	AutoSpirit = "Автоматически покидать тело"
})

L:SetMiscLocalization({
	ArenaInvite	= "Приглашение на Арену"
})
--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Арены"
})

L:SetTimerLocalization({
	TimerStart = "Бой начался!",
    TimerShadow	= "Сумеречное зрение"
})

L:SetOptionLocalization({
	TimerStart = "Отображать отсчет времени до начала боя"
	TimerShadow 	= "Отображать отсчет времени для Сумрачного кристалла"
})

L:SetMiscLocalization({
	Start60 = "Битва начнется через 1 минуту!",
	Start30 = "Битва начнется через 30 секунд!",
	Start15 = "Битва начнется через 15 секунд!"
})
---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "Альтеракская долина"
})

L:SetTimerLocalization({
	TimerStart = "Бой начался!", 
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту!",
	BgStart30 = "Битва начнется через 30 секунд!",
	ZoneName = "Альтеракская долина",
})

L:SetOptionLocalization({
	TimerStart  = "Отображать отсчет времени до начала боя",
	TimerTower = "Отображать отсчет времени до захвата",
	TimerGY = "Отображать отсчет времени до захвата кладбищь",
	AutoTurnIn = "Авто-сдача заданий в Альтеракской долине"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name = "Низина Арати"
})

L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту!",
	BgStart30 = "Битва начнется через 30 секунд!",
	ZoneName = "Низина Арати",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Альянса",
	Horde = "Орды",
	WinBarText = "Победа %s",
	BasesToWin = "Захвачено баз: %d",
	Flag = "Флаг"
})

L:SetTimerLocalization({
	TimerStart = "Бой начался!", 
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerStart  = "Отображать отсчет времени до начала боя",
	TimerWin = "Отображать отсчет времени до победы",
	TimerCap = "Отображать отсчет времени до захвата",
	ShowAbEstimatedPoints = "Отображать предполагаемые очки оставшиеся до победы/поражения",
	ShowAbBasesToWin = "Отображать базы, которые необходимо захватить"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "Око Бури"
})

L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту!",
	BgStart30 = "Битва начнется через 30 секунд!",
	ZoneName = "Око Бури",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Альянса",
	Horde = "Орды",
	WinBarText = "Победа %s",
	FlagReset = "Флаг возвращен на базу.",
	FlagTaken = "(.+) захватывает флаг!",
	FlagCaptured = "(.+) захватывает флаг (%w+)!",
	FlagDropped = "Флаг уронили!",

})

L:SetTimerLocalization({
	TimerStart = "Бой начался!", 
	TimerFlag = "Флаг восстановлен",
})

L:SetOptionLocalization({
	TimerStart  = "Отображать отсчет времени до начала боя",
	TimerWin = "Отображать отсчет времени до победы",
	TimerFlag = "Отображать отсчет времени до восстановления флага",
	ShowPointFrame = "Отображать флагоносца и предполагаемые очки",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name = "Ущелье Песни Войны"
})

L:SetMiscLocalization({
	BgStart60 = "Битва начнется через 1 минуту!",
	BgStart30 = "Битва начнется через 30 секунд!",
	ZoneName = "Ущелье Песни Войны",
	Alliance = "Альянса",
	Horde = "Орды",
	InfoErrorText = "Функция выбора флагоносца, будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp = "(.+) подымает флаг (%w+)",
	ExprFlagCaptured = "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn = "(.+) возвращает флаг (%w+) на базу!",
	FlagAlliance = "Флаг Альянса: ",
	FlagHorde = "Флаг Орды: ",
	FlagBase = "База",
})

L:SetTimerLocalization({
	TimerStart = "Бой начался!", 
	TimerFlag = "Флаг восстановлен",
})

L:SetOptionLocalization({
	TimerStart  = "Отображать отсчет времени до начала боя",
	TimerWin = "Отображать отсчет времени до победы",
	TimerFlag = "Отображать отсчет времени до восстановления флага",
	ShowFlagCarrier = "Показать флагоносца",
	ShowFlagCarrierErrorNote = "Отображать сообщения об ошибках в режиме боя",
})

----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Склеп Аркавона"
})

L:SetWarningLocalization({
	WarningShards = "Град из острых камней на >%s<",
	WarningGrab = "Страж бросается к >%s<"
})

L:SetTimerLocalization({
	TimerShards = "Каменные осколки: %s"
})

L:SetMiscLocalization({
	TankSwitch = "%%s нападает на (%S+)!"
})

L:SetOptionLocalization({
	TimerShards = "Отображать отсчет времени до града из Каменных осколков",
	WarningShards = "Отображать предупреждение для Каменных осколков",
	WarningGrab = "Отображать предупреждение для Захвата"
})
--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Эмалон Созерцатель Бури"
}

L:SetWarningLocalization{
	specWarnNova	= "Вспышка молнии",
	warnNova 	= "Вспышка молнии",
	warnOverCharge	= "Перезарядка"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Взрыв избыточно заряда"
}

L:SetOptionLocalization{
	specWarnNova 		= ("Отображать спец-предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Вспышки молнии"),
	warnNova 		= ("Отображать предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "Вспышки молнии"),
	warnOverCharge 		= ("Отображать предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "Перезарядки")
	timerMobOvercharge	= "Отсчет времени для Избыточно заряда (складывающийся отрицательный эффект)"
}

