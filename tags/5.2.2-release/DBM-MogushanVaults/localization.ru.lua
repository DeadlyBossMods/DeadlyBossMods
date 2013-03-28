if GetLocale() ~= "ruRU" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s скоро!", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "Рвите цепи!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Спец-предупреждение перед насыщением", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "Спец-предупреждение, когда можно разорвать $spell:130395",
	ArrowOnJasperChains			= "Показывать стрелку DBM, когда на вас $spell:130395",
	InfoFrame					= "Показывать информационное окно с энергией боссов"
})

L:SetMiscLocalization({
	Overload	= "%s вот-вот перенасытится!"
})

------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Фаза %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Объявлять смену фаз",
	RangeFrame	= "Показывать окно проверки дистанции (6 м) во время аркан-фазы"
})

L:SetMiscLocalization({
	Fire		= "О, превозносимый! Моими руками ты отделишь их плоть от костей!",
	Arcane		= "О, великий мыслитель! Да снизойдет на меня твоя древняя мудрость!",
	Nature		= "О, великий дух! Даруй мне силу земли!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull		= "Пора умирать!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Щить тьмы через %ds"
})

L:SetTimerLocalization({
	timerUSRevive		= "Бессмертные тени",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Производить 5-секундный отсчет для $spell:117697",
	timerUSRevive		= "Отсчет времени до формирования $spell:117506",
	RangeFrame			= "Показывать окно проверки дистанции (8 м)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "Смотрите под ноги!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "Пол исчезает!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "Спец-предупреждение перед исчезновением пола",
	timerDespawnFloor			= "Отсчет времени до исчезновения пола"
})


------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Показывать игроков под $spell:116525",
	CountOutCombo	= "Отсчитывать количество кастов $journal:5673",
	ArrowOnCombo	= "Показывать стрелку DBM во время $journal:5673\nПодразумевается, что танк стоит перед боссом, а все остальные - позади."
})

L:SetMiscLocalization({
	Pull		= "Машина гудит, возвращаясь к жизни! Надо спуститься на нижний уровень!",--Emote
	Rage		= "Ярость Императора эхом звучит среди холмов.",--Yell
	Strength	= "Сила Императора сжимает эти земли в железных тисках.",--Emote
	Courage		= "Смелость Императора безгранична.",--Emote
	Boss		= "Бессмертная армия сокрушит врагов Императора."--Emote
})