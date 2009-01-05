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
	ShowInviteTimer = "Показать отсчет времени до входа на ПБ",
	AutoSpirit = "Автоматически покидать тело"
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
	TimerStart = "Показать отсчет времени до начала боя"
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
	TimerStart  = "Показать отсчет времени до начала боя",
	TimerTower = "Показать отсчет времени до захвата",
	TimerGY = "Показать отсчет времени до захвата кладбищь",
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
	TimerStart  = "Показать отсчет времени до начала боя",
	TimerWin = "Показать отсчет времени до победы",
	TimerCap = "Показать отсчет времени до захвата",
	ShowAbEstimatedPoints = "Показать предполагаемые очки оставшиеся до победы/поражения",
	ShowAbBasesToWin = "Показать базы, которые необходимо захватить"
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
	TimerStart  = "Показать отсчет времени до начала боя",
	TimerWin = "Показать отсчет времени до победы",
	TimerFlag = "Показать отсчет времени до восстановления флага",
	ShowPointFrame = "Показать флагоносца и предполагаемые очки",
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
	TimerStart  = "Показать отсчет времени до начала боя",
	TimerWin = "Показать отсчет времени до победы",
	TimerFlag = "Показать отсчет времени до восстановления флага",
	ShowFlagCarrier = "Показать флагоносца",
	ShowFlagCarrierErrorNote = "Показать сообщения об ошибках в режиме боя",
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
	TimerShards = "Показать отсчет времени до града из Каменных осколков",
	WarningShards = "Показать предупреждение для Каменных осколков",
	WarningGrab = "Показать предупреждение для Захвата"
})