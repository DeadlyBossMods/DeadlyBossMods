if GetLocale() ~= "ruRU" then return end

DBM_CORE_NEED_SUPPORT				= "Вы - программист или хороший переводчик? Команда разработчиков DBM нуждается в вашей помощи. Присоединяйтесь к нам -  зайдите на www.deadlybossmods.com или отправьте сообщение на tandanu@deadlybossmods.com или nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Добро пожаловать в DBM. Для доступа к настройкам наберите /dbm в чате. При желании, загрузите определенные зоны вручную для изменений специфических настроек для каждого босса. DBM пытается подстраиваться под вас на основе вашей специализации на момент первого запуска, но некоторые могут захотеть включить дополнительные опции. Многие запрошенные пользователями предупреждения уже существуют, но отключены по-умолчанию для определенных специализаций. Особенно те, которые касаются танков."

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке DBM для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен DBM для \"%s\", введите /dbm для вызова настроек!"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)";
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_L				= "%s погибает спустя %s! Последний бой длился %s, лучший бой длился %s."
DBM_CORE_BOSS_DOWN_NR				= "%s погибает спустя %s! Это новый рекорд! (Предыдущий рекорд был %s)"
DBM_CORE_COMBAT_ENDED_AT			= "Бой с %s длился %s"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Бой с %s (%s) длился %s. На этом уровне сложности вы вайпнулись уже %d раз."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s был атакован %s назад, восстанавливаю таймеры..."

DBM_CORE_TIMER_FORMAT_SECS			= "%d сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %d сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%d сек"
DBM_CORE_DEAD						= "мертв"
DBM_CORE_OK							= "ОК"

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
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s одержал победу над %s! Общее количество побед у него - %d."
DBM_CORE_WHISPER_COMBAT_END_WIPE			= "%s потерпел поражение от %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s потерпел поражение на %s от %s. Общее количество вайпов у него - %d."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с установленным Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Ваша версия Deadly Boss Mods устарела! Пожалуйста, посетите www.deadlybossmods.com для загрузки последней версии."

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods устарела.\n Версия %s (r%d) доступна для загрузки здесь:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Нажмите CTRL+C, чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Всплывающее сообщение при наличии новой версии"

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует DBM Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот DBM Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать DBM Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Игнорировать DBM Timer во время текущего сеанса от %s?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods запущен дважды, поскольку установлены DBMv3 и DBMv4 и включены!\nНажмите кнопку \"ОК\" для отключения DBMv3 и перезагрузки интерфейса.\nНаведите порядок в вашей папке AddOns, удалите старые папки DBMv3."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить"

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
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Частота обновления (необх. reloadui)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Медленная (не нагружает CPU)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Средняя"
DBM_CORE_RANGECHECK_OPTION_FAST		= "Быстрая (в реальном времени)"
DBM_CORE_RANGERADAR_HEADER			= "Радар (%d ярдов)"

DBM_CORE_INFOFRAME_HIDE				= "Скрыть"
DBM_CORE_INFOFRAME_LOCK				= "Закрепить окно"
DBM_CORE_INFOFRAME_SHOW_SELF		= "Всегда показывать вашу энергию"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Приглашение в подземелье"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm version: выполняет проверку используемой рейдом версии (псевдоним: ver)",
	"/dbm version2: выполняет проверку используемой рейдом версии и отправляет сообщение шепотом членам рейда с устаревшей версией (псевдоним: ver2).",
	"/dbm unlock: отображает перемещаемую строку состояния таймера (псевдоним: move)",
	"/dbm timer <x> <text>: начинает отсчет <x> сек. Pizza Timer с именем <text>",
	"/dbm broadcast timer <x> <text>: транслирует <x> сек. Pizza Timer с именем <text> в рейд (требуются права лидера или помощника)",
	"/dbm break <min>: начинает отсчет времени отдыха на <min> мин. Транслирует отсчет времени отдыха всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm pull <sec>: начинает отсчет времени до атаки на <sec> сек. Транслирует отсчет времени до атаки всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm arrow: показывает стрелку DBM. Введите /dbm arrow help для получения подробной информации.",
	"/dbm lockout: получает список текущих сохранений подземелий у членов рейда (псведонимы: lockouts, ids) (требуются права лидера или помощника).",
	"/dbm help: вывод этой справки",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав для выполнения этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"

DBM_CORE_UNKNOWN					= "неизвестно"

DBM_CORE_BREAK_START				= "Перерыв начинается -- у вас есть %s мин.!"
DBM_CORE_BREAK_MIN					= "Перерыв заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Перерыв заканчивается через %s сек.!"
DBM_CORE_TIMER_BREAK				= "Перерыв!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Перерыв закончился"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек."
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Быстрое убийство"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target 		= "%s: %%s",
	cast 		= "%s",
	active		= "%s заканчивается",--Buff/Debuff/event on boss
	fades		= "%s рассеивается",--Buff/Debuff on players
	cd 			= "Восст. %s",
	cdcount		= "Восст. %s (%%d)",
	cdsource	= "Восст. %s: %%s",
	next 		= "След. %s",
	nextcount	= "След. %s (%%d)",
	nextsource	= "След. %s: %%s",
	achievement = "%s"
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target 		= "Отсчет времени действия эффекта $spell:%s",
	cast 		= "Отсчет времени применения заклинания $spell:%s",
	active 		= "Отсчет времени действия $spell:%s",
	fades		= "Отсчет времени действия $spell:%s на игроках",
	cd 			= "Отсчет времени до восстановления $spell:%s",
	cdcount 	= "Отсчет времени до восстановления $spell:%s",
	cdsource	= "Отсчет времени до восстановления $spell:%s",
	next 		= "Отсчет времени до следующего $spell:%s",
	nextcount 	= "Отсчет времени до следующего $spell:%s",
	nextsource	= "Отсчет времени до следующего $spell:%s",
	achievement = "Отсчет времени для %s"
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target = "%s на |3-5(>%%s<)",
	targetcount = "%s (%%d) на |3-5(>%%s<)",
	spell = "%s",
	adds		= "%s remaining: %%d",
	cast = "Применение заклинания %s: %.1f сек",
	soon = "Скоро %s",
	prewarn = "%s через %s",
	phase = "Фаза %s",
	prephase = "Скоро фаза %s",
	count = "%s (%%d)",
	stack = "%s на |3-5(>%%s<) (%%d)"
}

local prewarnOption = "Предупреждать заранее о $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target = "Объявлять цели заклинания $spell:%s",
	targetcount = "Объявлять цели заклинания $spell:%s",
	spell = "Предупреждение для $spell:%s",
	adds		= "Announce how many $spell:%s remain",
	cast = "Предупреждать о применении заклинания $spell:%s",
	soon = prewarnOption,
	prewarn = prewarnOption,
	phase = "Объявлять фазу %s",
	prephase = "Предупреждать заранее о фазе %s",
	count = "Предупреждение для $spell:%s",
	stack = "Объявлять количество стаков $spell:%s"
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 		= "Спец-предупреждение для $spell:%s",
	dispel 		= "Спец-предупреждение для рассеивания/похищения заклинания \n $spell:%s",
	interrupt	= "Спец-предупреждение для прерывания заклинания $spell:%s",
	you 		= "Спец-предупреждение, когда на вас $spell:%s",
	target 		= "Спец-предупреждение, когда на ком-то $spell:%s",
	close 		= "Спец-предупреждение, когда на ком-то рядом с вами \n$spell:%s",
	move 		= "Спец-предупреждение, когда на вас $spell:%s",
	run 		= "Спец-предупреждение для $spell:%s",
	cast 		= "Спец-предупреждение о применении заклинания \n$spell:%s",
	stack 		= "Спец-предупреждение для >=%d стаков $spell:%s",
	switch		= "Спец-предупреждение о смене цели для \n $spell:%s"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell = "%s!",
	dispel = "%s на |3-5(%%s) - рассейте заклинание",
	interrupt = "%s - прервите",
	you = "%s на вас",
	target = "%s на |3-5(%%s)",
	close = "%s на |3-5(%%s) около вас",
	move = "%s - отбегите",
	run = "%s - бегите",
	cast = "%s - прекратите чтение заклинаний",
	stack = "%s (%%d)",
	switch = "%s - переключитесь"--Verify?
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Устанавливать метки на цели заклинания $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Звуковой сигнал при $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT	= "Звуковой отсчет для $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT	= "Звуковой отсчет во время действия $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT		= "Кричать, когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT	= "На МНЕ - %s!"


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

DBM_SPEED_KILL_TIMER_TEXT	= "Рекордное убийство"
DBM_SPEED_KILL_TIMER_OPTION	= "Отсчет времени вашего самого быстрого убийства"

DBM_REQ_INSTANCE_ID_PERMISSION		= "%s запрашивает разрешение на просмотр ваших текущих сохранений подземелий.\nВы хотите предоставить ему такое право? Этот игрок получит возможность запрашивать эту информацию без уведомления в течение вашей текущей игровой сессии."
DBM_ERROR_NO_RAID					= "Вы должны состоять в рейдовой группе для использования этой функции."
DBM_INSTANCE_INFO_REQUESTED			= "Отослан запрос на просмотр текущих сохранений подземелий у членов рейда.\nОбратите внимание, что игроки будут уведомлены об этом и могут отклонить ваш запрос."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "На запрос ответили %d игроков из %d пользователей DBM: %d послали данные, %d отклонили запрос. Ожидание ответа продлено на %d секунд..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Получен ответ ото всех членов рейда"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Игрок: %s ТипРезультата: %s Название: %s ID: %s Сложность: %d Размер: %d Прогресс: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s (%d), сложность %d:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, прогресс %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Отклонили запрос: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Отошли от компьютера: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Установлена устаревшая версия DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Результаты сканирования сохранений."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Не все игроки ещё ответили: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Показать текущие результаты]|r|h"