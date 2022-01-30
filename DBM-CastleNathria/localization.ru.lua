if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "Сортировать $spell:334755 Инфофрейм по наибольшему стаку дебаффов (вместо наименьшего).",
	ShowTimeNotStacks		= "Показать оставшееся время $spell:334755 Инфофрейм вместо количества стака."
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "Желания полны",
	timerBottledContainer		= "Бутылка полная",
	timerSinsContainer			= "Грехи полны",
	timerConcentrateContainer	= "Концентрат полный"
}

L:SetOptionLocalization({
	timerContainers2			= "Показать таймер, который будет показывать прогресс заполнения контейнера и время, оставшееся до заполнения"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "Автоматически настраивать таймеры, когда способности попадают в очередь заклинаний из-за других способностей",
	BladeMarking				= "Set marking behavior for raid (If raid leader, overrides raid)",
	SetOne						= "DBM по умолчанию",
	SetTwo						= "BigWigs по умолчанию"
})

L:SetMiscLocalization({
	DBMConfigMsg		= "Marking icons configuration set to %s to match raid leaders configuration."
})

---------------------------
--  Sire Denathrius --
---------------------------
--L= DBM:GetModLocalization(2424)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Замок Нафрия"
})
