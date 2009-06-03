if GetLocale() ~= "ruRU" then return end

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке DBM для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен DBM для '%s'!"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)";
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s погибает спустя %s! Последний бой длился %s, лучший бой: %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s погибает спустя %s! Это новая запись! (Предшествующая запись была %s)"
DBM_CORE_COMBAT_ENDED				= "Бой с %s длился %s"

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4сек.:сек.;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4мин.:мин.;"
DBM_CORE_TIMER_FORMAT				= "%d |4мин.:мин.; %d |4сек.:сек.;"

DBM_CORE_MIN						= "мин."
DBM_CORE_SEC						= "сек."
DBM_CORE_DEAD						= "мертвы"
DBM_CORE_OK							= "ОК"

DBM_CORE_GENERIC_WARNING_ENRAGE		= "Исступление через %s %s"
DBM_CORE_GENERIC_TIMER_ENRAGE		= "Исступление"
DBM_CORE_OPTION_TIMER_ENRAGE		= "Отображать отсчет времени до Исступления"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Предупреждения"
DBM_CORE_OPTION_CATEGORY_MISC		= "Прочие"

DBM_CORE_AUTO_RESPONDED				= "Авто-ответ."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d человек живые"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s сейчас не может ответить, в бою с %s (%s, %d/%d человек живые)"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d игроков с установленным Deadly Boss Mods"

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods, устарела.\n Для загрузки доступна новая версия %s (r%d) здесь:"
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
DBM_CORE_RANGECHECK_HIDE			= "Скрыть"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm version: выполнение проверки, используемой рейдом версии (alias: ver)",
	"/dbm unlock: отображение перемещаемой строки состояния таймера (alias: move)",
	"/dbm timer <x> <text>: Начинает отсчет <x> сек. Pizza Timer с указанным именем <text>",
	"/dbm broadcast timer <x> <text>: Транслирует <x> сек. Pizza Timer с указанным именем <text> в рейд (требуются права лидера или помощника)",
	"/dbm help: вывод этой справки",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав, для выполнение этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"

DBM_CORE_UNKNOWN					= "неизвестно"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек."
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"


-- Generic Warnings
DBM_CORE_GENERIC_TARGET_WARN = "%s под воздействием >%%s<!"
DBM_CORE_GENERIC_TARGET_OPTION = "Объявлять цели о %s"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Скорость убийства"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
    active = "%s",
	cd = "%s",
	next = "Следующий %s",
	achievement = "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target = "Отображать время действия эффекта |cff71d5ff|Hspell:%d|h%s|h|r",
	cast = "Отображать время действия заклинания|cff71d5ff|Hspell:%d|h%s|h|r",
	active = "Отображать продолжительность |cff71d5ff|Hspell:%d|h%s|h|r",
	cd = "Отображать отсчет времени до восстановления |cff71d5ff|Hspell:%d|h%s|h|r",
	next = "Отображать отсчет времени до следующего |cff71d5ff|Hspell:%d|h%s|h|r",
	achievement = "Отображать отсчет времени для %s",
}
