if GetLocale() ~= "ruRU" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Общие параметры"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Показывать имена цветом класса в таблице очков",
	ShowInviteTimer	= "Отсчет времени до входа на ПБ",
	AutoSpirit		= "Автоматически покидать тело",
	HideBossEmoteFrame	= "Скрыть фрейм эмоций рейдового босса"
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
	TimerShadow	= "Сумеречное зрение"
})

L:SetOptionLocalization({
	TimerShadow = "Отсчет времени до сумеречного зрения"
})

L:SetMiscLocalization({
	Start15	= "Пятнадцать секунд до начала боя на арене!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Альтеракская долина"
})

L:SetTimerLocalization({
	TimerTower	= "%s",
	TimerGY		= "%s"
})

L:SetOptionLocalization({
	TimerTower	= "Отсчет времени до захвата",
	TimerGY		= "Отсчет времени до захвата кладбищ",
	AutoTurnIn	= "Автоматическая сдача заданий"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Низина Арати"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1600",
	Alliance	= "Альянса",
	Horde		= "Орды",
	WinBarText	= "Победа %s",
	BasesToWin	= "Захвачено баз: %d",
	Flag		= "Флаг"
})

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin				= "Отсчет времени до победы",
	TimerCap				= "Отсчет времени до захвата",
	ShowAbEstimatedPoints	= "Отображать предполагаемые очки оставшиеся до победы/поражения",
	ShowAbBasesToWin		= "Отображать базы, которые необходимо захватить"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Око Бури"
})

L:SetMiscLocalization({
	ZoneName		= "Око Бури",
	ScoreExpr		= "(%d+)/1600",
	Alliance 		= "Альянс",
	Horde 			= "Орда",
	WinBarText 		= "Победа %s",
	FlagReset 		= "Флаг возвращен на базу.",
	FlagTaken 		= "(.+) захватывает флаг!",
	FlagCaptured	= "(.+) захватил флаг!", --"Орда захватила флаг!"
	FlagDropped		= "Флаг уронили!"

})

L:SetTimerLocalization({
	TimerFlag	= "Флаг восстановлен"
})

L:SetOptionLocalization({
	TimerWin 		= "Отсчет времени до победы",
	TimerFlag 		= "Отсчет времени до восстановления флага",
	ShowPointFrame	= "Отображать флагоносца и предполагаемые очки"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Ущелье Песни Войны"
})

L:SetMiscLocalization({
	BgStart60 			= "Битва начнется через 1 минуту.",
	BgStart30 			= "Битва начнется через 30 секунд. Приготовиться!",
	Alliance 			= "Альянса",
	Horde 				= "Орды",
	InfoErrorText		= "Функция выбора флагоносца, будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp		= "(.+) несет флаг (%w+)!",
	ExprFlagPickUp2		= "Флаг (%w+) у (.+)!",				-- only used for Russian language
	ExprFlagCaptured	= "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn		= "(.+) возвращает на базу .лаг (%w+)!", --
	FlagAlliance		= "Флаг Альянса: ",
	FlagHorde			= "Флаг Орды: ",
	FlagBase			= "База"
})

L:SetTimerLocalization({
	TimerStart	= "Битва начнется через", 
	TimerFlag	= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerStart					= "Отсчет времени до начала битвы",
	TimerFlag					= "Отсчет времени до восстановления флага",
	ShowFlagCarrier				= "Показать флагоносца",
	ShowFlagCarrierErrorNote	= "Сообщения об ошибках в режиме боя"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Остров Завоеваний"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Осадная машина готова!",
	WarnSiegeEngineSoon	= "Осадная машина через ~10 сек"
})

L:SetTimerLocalization({
	TimerStart			= "Битва начнется через", 
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Осадная машина"
})

L:SetOptionLocalization({
	TimerStart			= "Отсчет времени до начала битвы", 
	TimerPOI			= "Отсчет времени до захвата",
	TimerSiegeEngine	= "Отсчет времени до создания Осадной машины",
	WarnSiegeEngine		= "Показать сообщение когда создание Осадной машины завершено",
	WarnSiegeEngineSoon	= "Показать сообщение когда создание Осадной машины почти завершено"
})

L:SetMiscLocalization({
	BgStart60				= "Битва начнется через 60 секунд.",
	BgStart30				= "Битва начнется через 30 секунд.",
	BgStart15				= "Битва начнется через 15 секунд.",
	SiegeEngine				= "Осадная машина",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "Я буду работать над осадной машиной, я ты меня прикрывай. Вот, можешь пользоваться этими сефориевыми бомбами, если тебе надо взорвать ворота.",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("TwinPeaks")

L:SetGeneralLocalization({
	name = "Два Пика"
})

L:SetMiscLocalization({
	BgStart60 			= "Битва начнется через 1 минуту.",
	BgStart30 			= "Битва начнется через 30 секунд. Приготовиться!",
	ZoneName 			= "Два Пика",
	Alliance			= "Альянса",
	Horde				= "Орды",
	InfoErrorText		= "Функция выбора флагоносца, будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp		= "(.+) несет флаг (%w+)!", --"Флаг (%w+) у (.+)!"
	ExprFlagCaptured	= "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn		= "(.+) возвращает на базу флаг (%w+)!",
	FlagAlliance		= "Флаг Альянса: ",
	FlagHorde			= "Флаг Орды: ",
	FlagBase			= "База",
	Vulnerable1			= "Персонажи, несущие флаг, стали более уязвимы!",
	Vulnerable2			= "Персонажи, несущие флаг, стали еще более уязвимы!"
})

L:SetTimerLocalization({
	TimerStart	= "Битва начнется через", 
	TimerFlag	= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerStart					= "Отсчет времени до начала битвы",
	TimerFlag					= "Отсчет времени до восстановления флага",
	ShowFlagCarrier				= "Показать флагоносца",
	ShowFlagCarrierErrorNote	= "Сообщения об ошибках в режиме боя"
})


--------------------------
--  Battle for Gilneas  --
--------------------------
L = DBM:GetModLocalization("Gilneas")

L:SetGeneralLocalization({
	name = "Битва за Гилнеас"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/2000",
	Alliance	= "Альянса",
	Horde		= "Орды",
	WinBarText	= "Победа %s",
	BasesToWin	= "Захвачено баз: %d",
	Flag		= "Флаг"
})

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin				= "Отсчет времени до победы",
	TimerCap				= "Отсчет времени до захвата",
	ShowGilneasEstimatedPoints	= "Отображать предполагаемые очки оставшиеся до победы/поражения",
	ShowGilneasBasesToWin		= "Отображать базы, которые необходимо захватить"
})