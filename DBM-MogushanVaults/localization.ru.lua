if GetLocale() ~= "ruRU" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s через 7 секунд!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "Спец-предупреждение перед перенасыщением",
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
	WarnPhase	= "Объявлять смену фаз"
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

L:SetOptionLocalization({
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

L:SetMiscLocalization({
	Pull		= "Пора умирать!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "Показывать окно проверки дистанции (8м)"
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
	InfoFrame		= "Показывать игроков под $spell:116525"
})

L:SetMiscLocalization({
	Pull		= "Машина гудит, возвращаясь к жизни! Надо спуститься на нижний уровень!",--Emote
	Rage		= "Ярость Императора эхом звучит среди холмов.",--Yell
	Strength	= "Сила Императора сжимает эти земли в железных тисках.",--Emote
	Courage		= "Смелость Императора безгранична.",--Emote
	Boss		= "Бессмертная армия сокрушит врагов Императора."--Emote
})