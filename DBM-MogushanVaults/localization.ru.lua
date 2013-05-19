if GetLocale() ~= "ruRU" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "Скоро %s!",
	specWarnBreakJasperChains	= "Рвите яшмовые цепи!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Спец-предупреждение перед насыщением",
	specWarnBreakJasperChains	= "Спец-предупреждение, когда можно разорвать $spell:130395",
	ArrowOnJasperChains			= "Показывать стрелку DBM, когда на вас $spell:130395",
	InfoFrame					= "Показывать информационное окно с энергией боссов, окаменением игроков и какой босс кастует окаменение"
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
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. "  во время аркан-фазы"
})

L:SetMiscLocalization({
	Fire		= "О, превозносимый! Моими руками ты отделишь их плоть от костей!",
	Arcane		= "О, великий мыслитель! Да снизойдет на меня твоя древняя мудрость!",
	Nature		= "О, великий дух! Даруй мне силу земли!",
	Shadow		= "Великие души защитников! Охраняйте меня!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull			= "Пора умирать!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Щит тьмы через %d сек."
})

L:SetTimerLocalization({
	timerUSRevive		= "Бессмертные тени формируются",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Производить 5-секундный отсчет для $spell:117697",
	timerUSRevive		= "Отсчет времени до формирования $spell:117506"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Смотрите под ноги!"
})

L:SetTimerLocalization({
	timerDespawnFloor		= "Пол исчезает!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Спец-предупреждение перед исчезновением пола",
	timerDespawnFloor		= "Отсчет времени до исчезновения пола",
	SetIconOnCreature		= "Устанавливать метки на $journal:6193"
})

------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Показывать информационное окно для игроков с $spell:116525",
	CountOutCombo	= "Отсчитывать количество кастов $journal:5673",
	ArrowOnCombo	= "Показывать стрелку DBM во время $journal:5673\nПодразумевается, что танк стоит перед боссом, а все остальные - позади."
})

L:SetMiscLocalization({
	Pull		= "Машина гудит, возвращаясь к жизни. Спуститесь на нижний уровень!",--Emote
	Rage		= "Ярость императора эхом звучит среди холмов.",--Yell
	Strength	= "Сила императора сжимает эти земли в железных тисках.",--Emote
	Courage		= "Смелость императора безгранична.",--Emote
	Boss		= "Бессмертная армия сокрушит врагов императора."--Emote
})
