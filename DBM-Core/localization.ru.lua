if GetLocale() ~= "ruRU" then return end

DBM_CORE_NEED_SUPPORT				= "Вы - программист или хороший переводчик? Команда разработчиков DBM нуждается в вашей помощи. Присоединяйтесь к нам -  зайдите на www.deadlybossmods.com или отправьте сообщение на tandanu@deadlybossmods.com или nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Добро пожаловать в DBM. Для доступа к настройкам наберите /dbm в чате. При желании, загрузите определенные зоны вручную для изменений специфических настроек для каждого босса. DBM пытается подстраиваться под вас на основе вашей специализации на момент первого запуска, но некоторые могут захотеть включить дополнительные опции. Многие запрошенные пользователями предупреждения уже существуют, но отключены по-умолчанию для определенных специализаций. Особенно те, которые касаются танков."

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке босс модуля для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен модуль для '%s'. Для дополнительных настроек введите /dbm или /dbm help в чате."
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "GUI не может быть изначально загружено в бою. GUI будет загружено вне боя. После загрузки GUI вы сможете загружать его в бою."

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "%s вступает в бой (в процессе). Удачи! :)"
DBM_CORE_SCENARIO_STARTED			= "%s начат. Удачи! :)"
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_I				= "%s погибает! Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_L				= "%s погибает спустя %s! Ваш последний бой длился %s, а лучший бой длился %s. Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_NR				= "%s погибает спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество побед у Вас %d."
DBM_CORE_SCENARIO_COMPLETE			= "%s завершен спустя %s!"
DBM_CORE_SCENARIO_COMPLETE_L		= "%s завершен спустя %s! Ваше последнее прохождение заняло %s, а лучшее прохождение заняло %s. Общее количество прохождений у Вас %d."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s завершен спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество прохождений у Вас %d."
DBM_CORE_COMBAT_ENDED_AT			= "Бой с %s (%s) закончился спустя %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Бой с %s (%s) закончился спустя %s. На этом уровне сложности вы вайпнулись уже %d раз."
DBM_CORE_SCENARIO_ENDED_AT			= "%s закончился спустя %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s закончился спустя %s. На этом уровне сложности вы не прошли до конца уже %d раз."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s был атакован %s назад, восстанавливаю таймеры..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Логирование с помощью Transcriptor начато."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Логирование с помощью Transcriptor окончено."

DBM_CORE_TIMER_FORMAT_SECS			= "%d сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %d сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%d сек"
DBM_CORE_DEAD						= "мертв"
DBM_CORE_OK							= "ОК"

DBM_CORE_GENERIC_WARNING_DUPLICATE	= "Один из %s"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Берсерк через %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Берсерк"
DBM_CORE_OPTION_TIMER_BERSERK		= "Отсчет времени до $spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Предупреждения"
DBM_CORE_OPTION_CATEGORY_MISC		= "Прочее"

DBM_CORE_AUTO_RESPONDED				= "Авто-ответ."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d человек живые"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s сейчас не может ответить, в бою с %s (%s, %d/%d человек живые)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s одержал победу над %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s одержал победу над %s! Общее количество побед у них - %d."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s потерпел поражение от %s на %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s потерпел поражение от %s на %s. Общее количество вайпов у них - %d."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с установленным Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Ваша версия Deadly Boss Mods устарела! Пожалуйста, посетите http://dev.deadlybossmods.com для загрузки последней версии."

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods устарела.\n Версия %s (r%d) доступна для загрузки здесь:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Всплывающее сообщение при наличии новой версии"

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует DBM Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот DBM Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать DBM Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Игнорировать DBM таймеры от %s на время текущего сеанса?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods запущен дважды, поскольку у Вас установлены и включены DBMv3 и DBMv4!\nНажмите кнопку \"ОК\" для отключения DBMv3 и перезагрузки интерфейса.\nНаведите порядок в вашей папке AddOns, удалив старые папки DBMv3."

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить\nAlt+shift+щелчок для свободного перетаскивания"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_SOUNDS			= "Звуковой сигнал"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Один из игроков подошел к вам слишком близко"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Несколько человек находятся около вас"
DBM_CORE_RANGECHECK_SOUND_0			= "Без звука"
DBM_CORE_RANGECHECK_SOUND_1			= "По умолчанию"
DBM_CORE_RANGECHECK_SOUND_2			= "Раздражающий звуковой сигнал"
DBM_CORE_RANGECHECK_HIDE			= "Скрыть"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"
DBM_CORE_RANGECHECK_LOCK			= "Закрепить окно"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Фреймы"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Показывать радар"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Показывать текстовый фрейм"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Показывать оба фрейма"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Частота обновления (необх. /reload)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Медленная (не нагружает CPU)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Средняя"
DBM_CORE_RANGECHECK_OPTION_FAST		= "Быстрая (в реальном времени)"
DBM_CORE_RANGERADAR_HEADER			= "Радар (%d ярдов)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d игроков в радиусе"

DBM_CORE_INFOFRAME_LOCK				= "Закрепить окно"
DBM_CORE_INFOFRAME_HIDE				= "Скрыть"
DBM_CORE_INFOFRAME_SHOW_SELF		= "Всегда показывать вашу энергию"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Приглашение в подземелье"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm version: выполняет проверку используемой рейдом версии (псевдоним: ver).",
	"/dbm version2: выполняет проверку используемой рейдом версии и отправляет сообщение шепотом членам рейда с устаревшей версией (псевдоним: ver2).",
	"/dbm unlock: отображает перемещаемую строку состояния таймера (псевдоним: move).",
	"/dbm timer <x> <text>: начинает отсчет <x> сек. Pizza Timer с именем <text>.",
	"/dbm broadcast timer <x> <text>: транслирует <x> сек. Pizza Timer с именем <text> в рейд (требуются права лидера или помощника).",
	"/dbm break <min>: начинает отсчет времени отдыха на <min> мин. Транслирует отсчет времени отдыха всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm pull <sec>: начинает отсчет времени до атаки на <sec> сек. Транслирует отсчет времени до атаки всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm arrow: показывает стрелку DBM. Введите /dbm arrow help для получения подробной информации.",
	"/dbm lockout: получает список текущих сохранений подземелий у членов рейда (псведонимы: lockouts, ids) (требуются права лидера или помощника).",
	"/dbm help: вывод этой справки.",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав для выполнения этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"

DBM_CORE_WORLD_BOSS					= "Мировой босс"
DBM_CORE_UNKNOWN					= "неизвестно"
DBM_CORE_LEFT						= "Налево"
DBM_CORE_RIGHT						= "Направо"
DBM_CORE_BACK						= "Назад"
DBM_CORE_FRONT						= "Вперед"

DBM_CORE_BREAK_START				= "Перерыв начинается -- у вас есть %s мин.!"
DBM_CORE_BREAK_MIN					= "Перерыв заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Перерыв заканчивается через %s сек.!"
DBM_CORE_TIMER_BREAK				= "Перерыв!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Перерыв закончился"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек."
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Достижение"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target 		= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell 			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends			= "%s заканчивается"
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
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Предупреждать о спадении $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Объявлять сколько осталось $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast 		= "Предупреждать о применении заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase 		= "Объявлять фазу %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase 	= "Предупреждать заранее о фазе %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count 		= "Предупреждение для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack 		= "Объявлять количество стаков $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends		= "%s заканчивается"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades		= "%s спадает"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon		= "Скоро %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel 	= "%s на |3-5(>%%s<) - рассейте заклинание"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - прервите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you 		= "%s на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target 	= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close 	= "%s на |3-5(>%%s<) около вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move 		= "%s - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run 		= "%s - бегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast 		= "%s - прекратите чтение заклинаний"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count 	= "%s! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack 	= "На вас %%d стаков от %s" --too long?	
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch 	= ">%s< - переключитесь"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "Спец-предупреждение об окончании $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "Спец-предупреждение о спадении $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "Спец-предупреждение что скоро $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Спец-предупреждение для рассеивания/похищения заклинания \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Спец-предупреждение для прерывания заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Спец-предупреждение, когда на вас \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Спец-предупреждение, когда на ком-то \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Спец-предупреждение, когда на ком-то рядом с вами \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Спец-предупреждение, когда на вас \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Спец-предупреждение о применении заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Спец-предупреждение, когда на вас >=%d стаков \n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Спец-предупреждение о смене цели для \n $spell:%s"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target 		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s заканчивается" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s спадает" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "Восст. %s"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Восст. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "Восст. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "След. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "След. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "След. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target 		= "Отсчет времени действия дебаффа $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "Отсчет времени применения заклинания $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Отсчет времени действия $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Отсчет времени до спадения $spell:%s с игроков"
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount 	= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount 	= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Отсчет времени для %s"


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Устанавливать метки на цели заклинания $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Звуковой сигнал \"бегите\" для $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT	= "Звуковой отсчет для $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT	= "Звуковой отсчет во время действия $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT		= "Кричать, когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT	= "%s на " .. UnitName("player") .. "!"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Индикатор спец-предупреждения"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Специальное предупреждение"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Проверка дистанции %d м. недоступна в этой зоне.\nДоступные дистанции - 10, 11, 15 и 28 м."

DBM_ARROW_MOVABLE					= "Индикатор стрелки"
DBM_ARROW_NO_RAIDGROUP				= "Данная функция работает только в рейд-группах и внутри рейдовых подземелий."
DBM_ARROW_ERROR_USAGE	= {
	"Использование DBM-Arrow:",
	"/dbm arrow <x> <y>: создает стрелку, указывающую в определенную точку (0 < x/y < 100)",
	"/dbm arrow <player>: создает стрелку, указывающую на определенного игрока в вашей группе или рейде",
	"/dbm arrow hide: скрывает стрелку",
	"/dbm arrow move: разрешает перемещение стрелки",
}

DBM_SPEED_KILL_TIMER_TEXT	= "Рекордная победа"
DBM_SPEED_KILL_TIMER_OPTION	= "Отсчет времени вашей самой быстрой победы"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s запрашивает разрешение на просмотр ваших текущих сохранений подземелий.\nВы хотите предоставить %s такое право? Этот игрок получит возможность запрашивать эту информацию без уведомления в течение вашей текущей игровой сессии."
DBM_ERROR_NO_RAID					= "Вы должны состоять в рейдовой группе для использования этой функции."
DBM_INSTANCE_INFO_REQUESTED			= "Отослан запрос на просмотр текущих сохранений подземелий у членов рейда.\nОбратите внимание, что игроки будут уведомлены об этом и могут отклонить ваш запрос."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "На запрос ответили %d игроков из %d пользователей DBM: %d послали данные, %d отклонили запрос. Ожидание ответа продлено на %d секунд..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Получен ответ ото всех членов рейда"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Игрок: %s ТипРезультата: %s Инстанс: %s ID: %s Сложность: %d Размер: %d Прогресс: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s (%d), сложность %d:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, прогресс %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Отклонили запрос: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Отошли от компьютера: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Установлена устаревшая версия DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Результаты сканирования сохранений. Обратите внимание, что инстансы могут появляться более одного раза, если в вашем рейде есть игроки с локализованными клиентами WoW."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Не все игроки ещё ответили: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Показать текущие результаты]|r|h"
