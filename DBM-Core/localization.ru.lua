if GetLocale() ~= "ruRU" then return end

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке DBM для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен DBM для \"%s\"!"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)";
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s погибает спустя %s! Последний бой длился %s, лучший бой длился %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s погибает спустя %s! Это новая запись! (Предшествующая запись была %s)"
DBM_CORE_COMBAT_ENDED				= "Бой с %s длился %s"

DBM_CORE_TIMER_FORMAT_SECS			= "%d сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %d сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%d сек"
DBM_CORE_DEAD						= "мертв"
DBM_CORE_OK							= "ОК"

DBM_CORE_GENERIC_WARNING_ENRAGE		= "Исступление через %s %s"
DBM_CORE_GENERIC_TIMER_ENRAGE		= "Исступление"
DBM_CORE_OPTION_TIMER_ENRAGE		= "Отсчет времени до Исступления"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Предупреждения"
DBM_CORE_OPTION_CATEGORY_MISC		= "Прочее"

DBM_CORE_AUTO_RESPONDED				= "Авто-ответ."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d человек живые"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s сейчас не может ответить, в бою с %s (%s, %d/%d человек живые)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s одержал победу над %s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s потерпел поражение от %s"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с установленным Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Ваша версия Deadly Boss Mods устарела! Пожалуйста, посетите www.deadlybossmods.com для загрузки последней версии."

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods устарела.\n Версия %s (r%d) доступна для загрузки здесь:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Нажмите CTRL+C, чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Всплывающее сообщение при наличии новой версии"

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует Pizza Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот Pizza Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать Pizza Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Вы действительно хотите проигнорировать Pizza Timer данного сеанса от %s?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods запущен дважды, поскольку установлены DBMv3 и DBMv4 и включены!\nНажмите кнопку \"ОК\" для отключения DBMv3 и перезагрузки интерфейса.\nНаведите порядок в вашей папке AddOns, удалите старые папки DBMv3."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_SOUNDS			= "Звуки"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Звуковой сигнал, когда игрок находится в диапазоне"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Звуковой сигнал для всех остальных игроков в диапазоне"
DBM_CORE_RANGECHECK_SOUND_0			= "Без звука"
DBM_CORE_RANGECHECK_SOUND_1			= "По умолчанию"
DBM_CORE_RANGECHECK_SOUND_2			= "Раздражающий звуковой сигнал"
DBM_CORE_RANGECHECK_HIDE			= "Скрыть"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"
DBM_CORE_RANGECHECK_LOCK			= "Закрепить полосу"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm version: выполнение проверки используемой рейдом версии (псевдоним: ver)",
	"/dbm unlock: отображение перемещаемой строки состояния таймера (псевдоним: move)",
	"/dbm timer <x> <text>: начинает отсчет <x> сек. Pizza Timer с именем <text>",
	"/dbm broadcast timer <x> <text>: транслирует <x> сек. Pizza Timer с именем <text> в рейд (требуются права лидера или помощника)",
	"/dbm break <min>: начинает отсчет отдыха на <min> мин., транслирует отсчет отдыха всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm help: вывод этой справки",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав, для выполнение этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"

DBM_CORE_UNKNOWN					= "неизвестно"

DBM_CORE_BREAK_START				= "Отдых начинается -- у вас есть %s мин.!"
DBM_CORE_BREAK_MIN					= "Отдых заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Отдых заканчивается через %s сек.!"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек."
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Быстрое убийство"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
	active = "%s",
	cd = "Восстановление %s",
	next = "Следующий %s",
	achievement = "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target = "Время действия эффекта |cff71d5ff|Hspell:%d|h%s|h|r",
	cast = "Время действия заклинания |cff71d5ff|Hspell:%d|h%s|h|r",
	active = "Время действия |cff71d5ff|Hspell:%d|h%s|h|r",
	cd = "Отсчет времени до восстановления |cff71d5ff|Hspell:%d|h%s|h|r",
	next = "Отсчет времени до следующего |cff71d5ff|Hspell:%d|h%s|h|r",
	achievement = "Отсчет времени для %s",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target = "%s на |3-5(>%%s<)",
	spell = "%s",
	cast = "Чтение заклинания %s: %.1f сек",
	soon = "Скоро %s",
	prewarn = "%s через %s",
	phase = "Фаза %d",
}

local prewarnOption = "Предупреждать заранее о |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target = "Объявлять цель, под воздействием |cff71d5ff|Hspell:%d|h%s|h|r",
	spell = "Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r",
	cast = "Предупреждение о прочтении заклинания |cff71d5ff|Hspell:%d|h%s|h|r",
	soon = prewarnOption,
	prewarn = prewarnOption,
	phase = "Объявлять фазу %d"
}

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Индикатор спец-предупреждения"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Специальное предупреждение"

