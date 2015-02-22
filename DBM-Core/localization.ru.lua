if GetLocale() ~= "ruRU" then return end

DBM_CORE_NEED_SUPPORT				= "Вы - программист или хороший переводчик? Нам нужна ваша помощь в локализации DBM на другие языки! Посетите http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/ для получения дополнительной информации."
DBM_CORE_NEED_LOGS					= "DBM needs Transcriptor (http://www.wowace.com/addons/transcriptor/) logs of these test fights to make best mods possible. If you want to help, log these fights with transcriptor and post them to http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing/ (zip them up, they can get quite large otherwise). Only interested in 6.0 raid logs. Do not need dungeon logs."
DBM_HOW_TO_USE_MOD					= "Добро пожаловать в DBM. Для доступа к настройкам наберите /dbm в чате. При желании, загрузите определенные зоны вручную для изменений специфических настроек для каждого босса. DBM пытается подстраиваться под вас на основе вашей специализации на момент первого запуска, но некоторые могут захотеть включить дополнительные опции."

DBM_FORUMS_MESSAGE					= "Нашли баг или неправильный таймер? Считаете что какому-то модулю требуется дополнительное предупреждение, таймер или особенность?\nПосетите новые форумы Deadly Boss Mods для обсуждений, сообщений об ошибках и запроса новых возможностей на |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (нажмите на ссылку, чтобы скопировать URL)"
DBM_FORUMS_COPY_URL_DIALOG			= "Зайдите на новый форум DBM\r\n(организовано Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке босс модуля для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен модуль для '%s'. Для дополнительных настроек введите /dbm или /dbm help в чате."
DBM_CORE_LOAD_MOD_COMBAT			= "Загрузка '%s' отложена до выхода из боя"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "GUI не может быть изначально загружено в бою. GUI будет загружено после боя. После загрузки GUI вы сможете загружать его в бою."
DBM_CORE_LOAD_SKIN_COMBAT			= "DBM timers failed to skin during combat. Your timers will likely not work correctly and generate several lua errors. This is often caused by 3rd party mods trying to apply skin changes in combat. Recommended to reloadui after you leave combat"
DBM_CORE_BAD_LOAD					= "DBM не удалось полностью загрузить модуль для этого подземелья, т.к. вы находитесь в режиме боя. Как только вы выйдите из боя, пожалуйста сделайте /console reloadui как можно скорее."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s не может быть загружен потому что ваш DBM-Core не соответствует требованиям. Требуется обновленная версия."

DBM_CORE_BLIZZ_BUGS					= "Обнаружены следующие баги с аддонами в 6.0:\n1. Если у вас включены звуковые эффекты, то звуки аддонов будут иногда пропадать в бою. Это происходит если одновременное количество звуковых эффектов превышает количество максимальных звуковых каналов (см. настройки звука). В патче 6.0 для звуков аддонов был установлен минимальный приоритет."

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM отключил динамическое окно проверки дистанции на этом боссе, т.к. нет точной информации о необходимом количестве игроков в одном скоплении для рейда вашего размера."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM отключил предупреждения о появлении помощников на этом боссе, т.к. нет точной информации о количестве помощников, которые появляются в рейде вашего размера."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM отключил несколько таймеров и предупреждений на этом боссе, т.к. нет точной информации о том, как работают механики энкаунтера для рейда вашего размера."

DBM_CORE_LOOT_SPEC_REMINDER			= "Ваша текущая специализация %s. Вы выбрали добычу для специализации %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM обнаружил, что у вас включена установка меток в Bigwigs и DBM одновременно. Пожалуйста отключите метки в одном из них, чтобы избежать конфликта с лидером вашей группы"

DBM_CORE_PROVINGGROUNDS_AD			= "Для этого контента доступен дополнительный модуль DBM-ProvingGrounds. Вы можете скачать его с deadlybossmods.com или Curse.com. Это сообщение отображается один раз."

DBM_CORE_MOLTENCORE_AD				= "Для этого контента доступен дополнительный модуль DBM-MC. Вы можете скачать его с deadlybossmods.com или Curse.com. Это сообщение отображается один раз."

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "%s вступает в бой (в процессе). Удачи! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "Гильдия вступает в бой с %s"
DBM_CORE_SCENARIO_STARTED			= "%s начат. Удачи! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "Вы зашли в %s (в процессе). Удачи! :)"
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_I				= "%s погибает! Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_L				= "%s погибает спустя %s! Ваш последний бой длился %s, а лучший бой длился %s. Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_NR				= "%s погибает спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество побед у Вас %d."
DBM_CORE_GUILD_BOSS_DOWN			= "Гильдия победила %s спустя %s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s завершен спустя %s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s завершен! Общее количество прохождений у Вас %d."
DBM_CORE_SCENARIO_COMPLETE_L		= "%s завершен спустя %s! Ваше последнее прохождение заняло %s, а лучшее прохождение заняло %s. Общее количество прохождений у Вас %d."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s завершен спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество прохождений у Вас %d."
DBM_CORE_COMBAT_ENDED_AT			= "Бой с %s (%s) закончился спустя %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Бой с %s (%s) закончился спустя %s. На этом уровне сложности вы вайпнулись уже %d раз."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "Гильдия вайпнулась на %s (%s) спустя %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s закончился спустя %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s закончился спустя %s. На этом уровне сложности вы не завершили сценарий уже %d раз."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s был атакован %s назад, восстанавливаю таймеры..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Логирование с помощью Transcriptor начато."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Логирование с помощью Transcriptor окончено."

DBM_CORE_PROFILE_NOT_FOUND			= "<Deadly Boss Mods> Ваш текущий профиль поврежден. DBM загрузит профиль 'По умолчанию'."
DBM_CORE_PROFILE_CREATED			= "Профиль '%s' создан."
DBM_CORE_PROFILE_CREATE_ERROR		= "Не удалось создать профиль. Некорректное имя профиля."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "Не удалось создать профиль. Профиль '%s' уже существует."
DBM_CORE_PROFILE_APPLIED			= "Профиль '%s' применен."
DBM_CORE_PROFILE_APPLY_ERROR		= "Не удалось применить профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_COPIED				= "Профиль '%s' скопирован."
DBM_CORE_PROFILE_COPY_ERROR			= "Не удалось скопировать профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "Невозможно скопировать профиль сам в себя."
DBM_CORE_PROFILE_DELETED			= "Профиль '%s' удален. Профиль 'По умолчанию' будет применен."
DBM_CORE_PROFILE_DELETE_ERROR		= "Не удалось удалить профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_CANNOT_DELETE		= "Невозможно удалить профиль 'По умолчанию'."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "Настройки модуля от %s (специализация %d) были скопированы."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "Невозможно скопировать настройки персонажа сами в себя."
DBM_CORE_MPROFILE_COPY_S_ERROR		= "Источник поврежден. Настройки не скопированы или скопированы частично. Скопировать не удалось."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "Звуковые настройки модуля от %s (специализация %d) были скопированы."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "Невозможно скопировать звуковые настройки персонажа сами в себя."
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "Источник поврежден. Звуковые настройки не скопированы или скопированы частично. Скопировать не удалось."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "Настройки модуля от %s (специализация %d) были удалены."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "Невозможно удалить настройки модуля, используемого в данный момент."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "Источник поврежден. Настройки не удалены или удалены частично. Удалить не удалось."

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Настройки по умолчанию были загружены для всех модулей в этом подземелье."
DBM_CORE_ALLMOD_STATS_RESETED		= "Вся статистика модуля была сброшена."
DBM_CORE_MOD_DEFAULT_LOADED			= "Настройки по умолчанию для этого боя были загружены."

DBM_CORE_WORLDBOSS_ENGAGED			= "В вашем игровом мире возможно начался бой с %s (%s процентов здоровья, отправил %s)."
DBM_CORE_WORLDBOSS_DEFEATED			= "%s возможно был побежден в вашем игровом мире (отправил %s)."

DBM_CORE_TIMER_FORMAT_SECS			= "%d сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %d сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%s сек"

DBM_CORE_GENERIC_WARNING_OTHERS		= "и еще один"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "и %d других"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Берсерк через %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Берсерк"
DBM_CORE_OPTION_TIMER_BERSERK		= "Отсчет времени до $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Бой начинается"
DBM_CORE_OPTION_TIMER_COMBAT		= "Отсчет времени до начала боя"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Общие предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Персональные предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Предупреждения для цели"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Предупреждения для роли"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Звуки"

DBM_CORE_AUTO_RESPONDED						= "Авто-ответ."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d человек живые"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s сейчас занят, в бою против %s (%s, %d/%d человек живые)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s одержал победу над %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s одержал победу над %s! Общее количество побед у них - %d."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s потерпел поражение от %s на %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s потерпел поражение от %s на %s. Общее количество вайпов у них - %d."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s сейчас занят в %s (%d/%d человек живые)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s завершил %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s завершил %s! Общее количество побед у них - %d."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s не завершил %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s не завершил %s. Общее количество незавершенных у них - %d."

DBM_CORE_VERSIONCHECK_HEADER		= "Boss Mod - Версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) и %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: Boss Mod не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с DBM и %d |4игрок:игрока:игроков; с Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "Следующие %d игрок(и) имеют устаревшую версию: %s"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Ваша версия Deadly Boss Mods устарела! Пожалуйста, посетите http://www.deadlybossmods.com для загрузки последней версии."
DBM_CORE_VOICE_PACK_OUTDATED		= "В вашем голосовом пакете DBM отсутствуют звуки, поддерживаемые этой версией DBM. Фильтр звуков спец-предупреждений был отключен. Пожалуйста скачайте обновленную версию голосового пакета или свяжитесь с автором для обновления, которое содержит отсутствующие звуковые файлы."
DBM_CORE_VOICE_MISSING				= "Выбранный вами голосовой пакет DBM не найден. Ваш выбор был сброшен на 'None'. Если это ошибка, убедитесь что ваш голосовой пакет правильно установлен и включен в модификациях."
DBM_CORE_VOICE_COUNT_MISSING		= "Countdown voice %d is set to a voice pack that could not be found. It has be reset to default settings."
--DBM_BIG_WIGS
--DBM_BIG_WIGS_ALPHA

DBM_CORE_UPDATEREMINDER_HEADER			= "Ваша версия Deadly Boss Mods устарела.\n Версия %s (r%d) доступна для загрузки здесь:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Ваша альфа версия Deadly Boss Mods устарела.\n Вы по крайней мере %d тестовых версий позади. Пользователям DBM рекомендуется использовать последнюю альфа или последнюю стабильную версию. Устаревшие альфы могут привести к плохой или неполной функциональности."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку в буфер обмена."
DBM_CORE_UPDATEREMINDER_DISABLE			= "ПРЕДУПРЕЖДЕНИЕ: В связи с тем, что Ваш Deadly Boss Mods сильно устарел (%d ревизий), он был отключен до обновления. Это сделано для того, чтобы старый и несовместимый код не вызывал плохой игровой опыт для Вас и других членов рейда."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "Ваша версия DBM будет иметь некорректные таймеры или предупреждения во время этого энкаунтера. Это исправлено в новой версии (или альфа-версии, если новая версия не доступна)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "ПРЕДУПРЕЖДЕНИЕ: Из-за того, что ваш Deadly Boss Mods устарел, он был отключен до обновления, т.к. это большой игровой патч. Это необходимо для того, чтобы старый и несовместимый код не приводил к ухудшению игрового опыта для вас и членов вашего рейда. Убедитесь что вы скачали новую версию с deadlybossmods.com или curse.com как только она станет доступна."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "WARNING: You are using a version of Deadly Boss Mods not intended to be used with this game version. Please make sure you download the appropriate version for your game client from deadlybossmods.com or curse."
DBM_CORE_VEM							= "ПРЕДУПРЕЖДЕНИЕ: Вы используете Deadly Boss Mods и Voice Encounter Mods одновременно. DBM не был загружен, т.к. эти два аддона не могут работать вместе."
DBM_CORE_3RDPROFILES					= "ПРЕДУПРЕЖДЕНИЕ: DBM-Profiles не совместим с этой версией DBM. Он должен быть удален прежде чем DBM сможет продолжить, чтобы избежать конфликтов."
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "ПРЕДУПРЕЖДЕНИЕ: Это обновление DBM не будет работать корректно если вы не перезапустите игровой клиент. Это обновление содержит новые файлы или изменения в .toc файле, которые не могут быть загружены через ReloadUI. Вы можете столкнуться со сломанной функциональностью или ошибками если продолжите без перезапуска клиента."

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует DBM Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот DBM Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать DBM Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Игнорировать DBM таймеры от %s на время текущего сеанса?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>. <time> должно быть больше 1."

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить\nAlt+shift+щелчок для свободного перетаскивания"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Настройка порога игроков"
DBM_CORE_RANGECHECK_SOUNDS			= "Звуковой сигнал"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Один из игроков подошел к вам слишком близко"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Несколько человек находятся около вас"
DBM_CORE_RANGECHECK_SOUND_0			= "Без звука"
DBM_CORE_RANGECHECK_SOUND_1			= "По умолчанию"
DBM_CORE_RANGECHECK_SOUND_2			= "Раздражающий звуковой сигнал"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Фреймы"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Показывать радар"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Показывать текстовый фрейм"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Показывать оба фрейма"
DBM_CORE_RANGERADAR_HEADER			= "Радар (%d ярдов)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d игроков в радиусе"
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fм)"--One target

DBM_CORE_INFOFRAME_SHOW_SELF		= "Всегда показывать вашу энергию"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Приглашение в подземелье"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/range <число> or /distance <число>: Показать окно проверки дистанции. /rrange или /rdistance для обратных цветов.",
	"/dbm version: выполняет проверку используемой рейдом версии (псевдоним: ver).",
	"/dbm version2: выполняет проверку используемой рейдом версии и отправляет сообщение шепотом членам рейда с устаревшей версией (псевдоним: ver2).",
	"/dbm unlock: отображает перемещаемую строку состояния таймера (псевдоним: move).",
	"/dbm timer/ctimer/ltimer/cltimer <x> <текст>: Запускает <x> сек. DBM таймер с именем <текст>. Посмотреть как использовать каждый тип таймера можно на http://tinyurl.com/kwsfl59.",
	"/dbm broadcast timer/ctimer/ltimer/cltimer <x> <текст>: Транслирует <x> сек. DBM таймер с именем <текст> в рейд (требуются права лидера или помощника).",
	"/dbm timer endloop: Останавливает любой повторяющийся ltimer или cltimer.",
	"/dbm break <мин>: начинает отсчет времени отдыха на <мин> мин. Транслирует отсчет времени отдыха всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm pull <сек>: начинает отсчет времени до атаки на <сек> сек. Транслирует отсчет времени до атаки всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm arrow: показывает стрелку DBM. Введите /dbm arrow help для получения подробной информации.",
	"/dbm lockout: получает список текущих сохранений подземелий у членов рейда (псведонимы: lockouts, ids) (требуются права лидера или помощника).",
	"/dbm lag: выполняет проверку задержки у всего рейда."
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав для выполнения этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_UNKNOWN					= "неизвестно"
DBM_CORE_LEFT						= "Налево"
DBM_CORE_RIGHT						= "Направо"
DBM_CORE_BACK						= "Назад"
DBM_CORE_FRONT						= "Вперед"
DBM_CORE_INTERMISSION				= "Переходная фаза"--No blizz global for this, and will probably be used in most end tier fights with intermission phases

DBM_CORE_BREAK_START				= "Перерыв начинается -- у вас есть %s мин.!"
DBM_CORE_BREAK_MIN					= "Перерыв заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Перерыв заканчивается через %s сек.!"
DBM_CORE_TIMER_BREAK				= "Перерыв!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Перерыв закончился"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек. (отправил %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"
DBM_CORE_GEAR_WARNING				= "Внимание: Проверка экипировки. Уровень надетых предметов на %d ниже чем максимальный"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Достижение"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target 		= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell 			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends			= "%s заканчивается"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s заканчивается: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades			= "%s спадает"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "Осталось %s: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast 			= "Применение заклинания %s: %.1f сек"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon 			= "Скоро %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn 		= "%s через %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase 			= "Фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase 		= "Скоро фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count 			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack 			= "%s на |3-5(>%%s<) (%%d)"

local prewarnOption = "Предупреждать заранее о $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target 		= "Объявлять цели заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Объявлять цели заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell 		= "Предупреждение для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends			= "Предупреждать об окончании $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Предупреждать об окончании $spell:%s (цель)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Предупреждать о спадении $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Объявлять сколько осталось $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast 		= "Предупреждать о применении заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase 		= "Объявлять фазу %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phasechange	= "Объявлять смены фаз"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase 	= "Предупреждать заранее о фазе %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count 		= "Предупреждение для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack 		= "Объявлять количество стаков $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s заканчивается"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s спадает"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "Скоро %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s через %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel 			= "%s на |3-5(>%%s<) - рассейте заклинание"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - прервите >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - прервите >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you 				= "%s на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target 			= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= "%s на >%%s< - затаунти"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close 			= "%s на |3-5(>%%s<) около вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move 				= "%s - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - отбегите от остальных"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - бегите к >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run 				= "%s - убегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast 				= "%s - прекратите чтение заклинаний"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect 			= "%s на |3-5(>%%s<) - прекратите атаку"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count 			= "%s! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack 			= "На вас %%d стаков от %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch 			= ">%s< - переключитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount 		= ">%s< - переключитесь (%%d)"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "Спец-предупреждение об окончании $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "Спец-предупреждение о спадении $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "Спец-предупреждение что скоро $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 	= "Спец-предупреждение за %s сек. до $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Спец-предупреждение для рассеивания/похищения заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Спец-предупреждение для прерывания заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Спец-предупреждение, когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Спец-предупреждение, когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 		= "Спец-предупреждение \"затаунти\", когда на другом танке $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Спец-предупреждение, когда на ком-то рядом с вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Спец-предупреждение \"отбегите\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= "Спец-предупреждение \"избегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway	= "Спец-предупреждение \"отбегите от остальных\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto		= "Спец-предупреждение \"бегите к кому-то\", на ком $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Спец-предупреждение \"убегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Спец-предупреждение \"прекратите чтение заклинаний\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 	= "Спец-предупреждение \"прекратите атаку\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Спец-предупреждение, когда на вас >=%d стаков $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Спец-предупреждение о смене цели для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target 		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s заканчивается" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s спадает" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "Восст. %s"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Восст. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "Восст. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial		= "Восст. спец-способности"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "След. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "След. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "След. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial	= "След. спец-способность"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.phase			= "След. фаза"

DBM_CORE_AUTO_TIMER_OPTIONS.target 		= "Отсчет времени действия дебаффа $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "Отсчет времени применения заклинания $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Отсчет времени действия $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Отсчет времени до спадения $spell:%s с игроков"
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount 	= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Отсчет времени до восстановления $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial	= "Отсчет времени до восстановления спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount 	= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Отсчет времени до следующего $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial	= "Отсчет времени до следующей спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Отсчет времени для %s"
DBM_CORE_AUTO_TIMER_OPTIONS.phase		= "Отсчет времени до следующей фазы"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay	= "Отсчет времени для ролевой игры"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Устанавливать метки на цели заклинания $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Устанавливать метки на $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Показывать стрелку DBM к цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Показывать стрелку DBM от цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Показывать стрелку DBM к определенному месту для $spell:%s"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "Звуковое оповещение для $spell:%s"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "Звуковое оповещение о сменах фаз"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Звуковой отсчет до восстановления $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Звуковой отсчет до спадения $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Звуковой отсчет во время действия $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Кричать, когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "%s на " .. UnitName("player") .. "!"
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Показывать HudMap для $spell:%s"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Показывать HudMap для различных механик"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Показывать окно проверки дистанции (%s м) для $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Показывать окно проверки дистанции (%s м)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Показывать обратное окно проверки дистанции (%s) для $spell:%s"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Показывать обратное окно проверки дистанции (%s)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Информационное окно для $spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Проигрывать звук проверки готовности когда пулят босса (даже если он не является целью)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "Индикатор предупреждения"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Спасибо за использование Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Индикатор спец-предупреждения"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Специальное предупреждение"

DBM_ARROW_MOVABLE					= "Индикатор стрелки"
DBM_ARROW_ERROR_USAGE	= {
	"Использование DBM-Arrow:",
	"/dbm arrow <x> <y>: создает стрелку, указывающую в определенную точку (используя координаты мира)",
	"/dbm arrow map <x> <y>  создает стрелку, указывающую в определенную точку (используя координаты зоны)",
	"/dbm arrow <player>: создает стрелку, указывающую на определенного игрока в вашей группе или рейде (регистрозависимо!)",
	"/dbm arrow hide: скрывает стрелку",
	"/dbm arrow move: разрешает перемещение стрелки"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Рекордная победа"
DBM_SPEED_KILL_TIMER_OPTION	= "Отсчёт времени вашей самой быстрой победы"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Лучшее прохождение"
DBM_COMBAT_RES_TIMER_TEXT	= "След. заряд БР"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s запрашивает разрешение на просмотр ваших текущих сохранений подземелий.\nВы хотите предоставить %s такое право? Этот игрок получит возможность запрашивать эту информацию без уведомления в течение вашей текущей игровой сессии."
DBM_ERROR_NO_RAID					= "Вы должны состоять в рейдовой группе для использования этой функции."
DBM_INSTANCE_INFO_REQUESTED			= "Отослан запрос на просмотр текущих сохранений подземелий у членов рейда.\nОбратите внимание, что игроки будут уведомлены об этом и могут отклонить ваш запрос."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "На запрос ответили %d игроков из %d пользователей DBM: %d послали данные, %d отклонили запрос. Ожидание ответа продлено на %d секунд..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Получен ответ ото всех членов рейда"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Игрок: %s ТипРезультата: %s Инстанс: %s ID: %s Сложность: %d Размер: %d Прогресс: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, сложность %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, прогресс %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    прогресс %d: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "Ваша рейдовая группа не имеет сохранений подземелий."
DBM_INSTANCE_INFO_STATS_DENIED		= "Отклонили запрос: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Отошли от компьютера: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Установлена устаревшая версия DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Результаты сканирования сохранений. Обратите внимание, что инстансы могут появляться более одного раза, если в вашем рейде есть игроки с локализованными клиентами WoW."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Не все игроки ещё ответили: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Показать текущие результаты]|r|h"

DBM_CORE_LAG_CHECKING				= "Проверка задержки у рейда..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Результаты проверки задержки"
DBM_CORE_LAG_ENTRY					= "%s: глобальная задержка [%d ms] / локальная задержка [%d ms]"
DBM_CORE_LAG_FOOTER					= "Нет ответа: %s"
