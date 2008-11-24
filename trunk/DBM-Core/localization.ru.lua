if GetLocale() ~= "ruRU" then return end

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке DBM для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен DBM для '%s'!"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s engaged. Good luck and have fun! :)";
DBM_CORE_BOSS_DOWN					= "%s down after %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s down after %s! Your last kill took %s and your fastest kill %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s down after %s! This is a new record! (old record was %s)"
DBM_CORE_COMBAT_ENDED				= "Бой с %s закончится через %s."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4сек.:сек.;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4минута:мин.;"
DBM_CORE_TIMER_FORMAT				= "%d |4минута:мин.; и %d |4сек.:сек.;"

DBM_CORE_MIN						= "мин."
DBM_CORE_SEC						= "сек."
DBM_CORE_DEAD						= "мертвы"
DBM_CORE_OK							= "ОК"

DBM_CORE_GENERIC_WARNING_ENRAGE		= "Исступление через %s %s"
DBM_CORE_GENERIC_TIMER_ENRAGE		= "Исступление"
DBM_CORE_OPTION_TIMER_ENRAGE		= "Отображать таймер Исступления"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Предупреждения"
DBM_CORE_OPTION_CATEGORY_MISC		= "Прочие"

DBM_CORE_AUTO_RESPONDED				= "Авто-ответ."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d человек живые"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s занят, в бою с %s (%s, %d/%d человек живые)"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d игроков с Deadly Boss Mods"

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods, устарела.\n Для загрузки доступна новая версия %s (r%d) здесь:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Нажмите CTRL+C, чтобы скопировать ссылку загрузки в буфер обмена."

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h sent you a pizza timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancel this timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignore timers from %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Do you really want to ignore pizza timers from %s for this session?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods is running twice because you have DBMv3 and DBMv4 installed and enabled!\nClick \"Okay\" to disable DBMv3 and reload your interface.\nYou should also clean up your AddOns folder by deleting the old DBMv3 folders."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_HIDE			= "Скрыть"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm version: performans a raid-wide version check (alias: ver)",
	"/dbm unlock: shows a movable status bar timer (alias: move)",
	"/dbm timer <x> <text>: Starts a <x> second Pizza Timer with the name <text>",
	"/dbm broadcast timer <x> <text>: Broadcasts a <x> second Pizza Timer with the name <text> to the raid (required promoted or leader)",
	"/dbm help: вывод этой справки",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав для выполнение этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"