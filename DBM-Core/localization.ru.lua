if GetLocale() ~= "ruRU" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD					= "Добро пожаловать в " .. L.DBM .. ". Наберите /dbm help, чтобы получить список поддерживаемых команд. Для доступа к настройкам наберите /dbm в чате. Загрузите конкретные зоны вручную, чтобы настроить определённых боссов на свой вкус. " .. L.DBM .. " установит настройки по умолчанию для Вашей специализации, но Вы, возможно, захотите настроить их более тонко."
L.SILENT_REMINDER					= "Напоминание: " .. L.DBM .. " всё ещё в тихом режиме."
L.NEWS_UPDATE						= "|h|c11ff1111Новости|r|h: DBM был обновлен с изменениями в структуре модов, поэтому Классическая и Актуальная версии теперь могут использовать унифицированные (одинаковые) модули. Это означает, что рейдовые модули Vanilla (включая Сезон открытий), TBC, Wrath и Cata теперь необходимо загружать отдельно, используя те же пакеты, что и Актуальные. Подробнее об этом |Hgarrmission:DBM:news|h|cff3588ff[нажмите здесь]|r|h"
L.NEWS_UPDATE_REPEAT				= "|h|c11ff1111Новости|r|h: DBM был обновлен с изменениями в структуре модов, поэтому Классическая и Актуальная версии теперь могут использовать унифицированные (одинаковые) модули. Это означает, что рейдовые модули Vanilla (включая Сезон открытий), TBC, Wrath и Cata теперь необходимо загружать отдельно, используя те же пакеты, что и Актуальные. В данный момент Вы находитесь в рейде, в котором отсутствует модуль. Это сообщение будет отображаться (и у Вас не будет функциональных оповещений для этой зоны), пока Вы не установите отсутствующий модуль рейда."

L.COPY_URL_DIALOG_NEWS				= "Чтобы прочитать последние новости, перейдите по ссылке ниже"

L.LOAD_MOD_ERROR					= "Ошибка при загрузке босс модуля для %s: %s"
L.LOAD_MOD_SUCCESS					= "Загружен модуль для '%s'. Для дополнительных настроек введите /dbm или /dbm help в чате."
L.LOAD_MOD_COMBAT					= "Загрузка '%s' отложена до выхода из боя"
L.LOAD_GUI_ERROR					= "Не удалось загрузить GUI: %s"
L.LOAD_GUI_COMBAT					= "GUI не может быть изначально загружено в бою. GUI будет загружено после боя. После загрузки GUI Вы сможете загружать его в бою."
L.BAD_LOAD							= L.DBM .. " не удалось полностью загрузить модуль для этого подземелья, т.к. Вы находитесь в режиме боя. Как только Вы выйдете из боя, пожалуйста, сделайте /console reloadui как можно скорее."
L.LOAD_MOD_VER_MISMATCH				= "%s не может быть загружен, потому что Ваш DBM-Core не соответствует требованиям. Требуется обновлённая версия."
L.LOAD_MOD_EXP_MISMATCH				= "%s не может быть загружен, потому что он создан для дополнения WoW, которое в данный момент недоступно. Когда дополнение станет доступно, модуль заработает автоматически."
L.LOAD_MOD_TOC_MISMATCH				= "%s не может быть загружен, потому что он создан для патча WoW (%s), который в данный момент недоступен. Когда патч станет доступен, модуль заработает автоматически."
L.LOAD_MOD_DISABLED					= "%s установлен, но в данный момент отключён. Этот модуль не будет загружен, пока Вы его не включите."
L.LOAD_MOD_DISABLED_PLURAL			= "%s установлены, но в данный момент отключены. Эти модули не будут загружены, пока Вы их не включите."

L.COPY_URL_DIALOG					= "Копировать ссылку"
L.COPY_WA_DIALOG					= "Копировать ключ WA"

--Post Patch 7.1
L.TEXT_ONLY_RANGE					= "Радар ограничен только текстом, поскольку Blizzard отключила эту функцию в этой зоне."
L.NO_RANGE							= "Радар не может быть использован, поскольку Blizzard отключила некоторые функции в этой зоне."
L.NO_ARROW							= "Стрелка не может быть использована в подземельях"
L.NO_HUD							= "HUDMap не может быть использован в подземельях"

L.DYNAMIC_DIFFICULTY_CLUMP			= L.DBM .. " отключил динамическое окно проверки дистанции на этом боссе, т.к. нет точной информации о необходимом количестве игроков в одном скоплении для рейда Вашего размера."
L.DYNAMIC_ADD_COUNT					= L.DBM .. " отключил предупреждения о появлении помощников на этом боссе, т.к. нет точной информации о количестве помощников, которые появляются в рейде Вашего размера."
L.DYNAMIC_MULTIPLE					= L.DBM .. " отключил несколько таймеров и предупреждений на этом боссе, т.к. нет точной информации о том, как работают механики энкаунтера для рейда Вашего размера."

L.LOOT_SPEC_REMINDER				= "Ваша текущая специализация %s. Вы выбрали добычу для специализации %s."

L.BIGWIGS_ICON_CONFLICT				= L.DBM .. " обнаружил, что у Вас включена установка меток в BigWigs и " .. L.DBM .. " одновременно. Пожалуйста, отключите метки в одном из них, чтобы избежать конфликтов."

L.MOD_AVAILABLE						= "Для этого контента доступен дополнительный модуль %s, но он не установлен. Вы можете скачать его с Curse, Wago, WoWI или со страницы релизов на GitHub."
L.MOD_MISSING						= "Модуль рейдов отсутствует"

L.COMBAT_STARTED					= "%s вступает в бой. Удачи! :)"
L.COMBAT_STARTED_IN_PROGRESS		= "%s вступает в бой (в процессе). Удачи! :)"
L.GUILD_COMBAT_STARTED				= "%s вступает в бой с группой гильдии %s"
L.SCENARIO_STARTED					= "%s начат. Удачи! :)"
L.SCENARIO_STARTED_IN_PROGRESS		= "Вы зашли в сценарий %s (в процессе). Удачи! :)"
L.BOSS_DOWN							= "%s погибает спустя %s!"
L.BOSS_DOWN_I						= "%s погибает! Общее количество побед у Вас %d."
L.BOSS_DOWN_L						= "%s погибает спустя %s! Ваш последний бой длился %s, а лучший бой длился %s. Общее количество побед у Вас %d."
L.BOSS_DOWN_NR						= "%s погибает спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество побед у Вас %d."
L.RAID_DOWN							= "%s зачищен за %s!"
L.RAID_DOWN_L						= "%s зачищен за %s! Текущий рекорд %s."
L.RAID_DOWN_NR						= "%s зачищен за %s! Это новый рекорд! (Предыдущий рекорд был %s)."
L.GUILD_BOSS_DOWN					= "%s потерпел поражение от группы гильдии %s спустя %s!"
L.SCENARIO_COMPLETE					= "%s завершён спустя %s!"
L.SCENARIO_COMPLETE_I				= "%s завершён! Общее количество прохождений у Вас %d."
L.SCENARIO_COMPLETE_L				= "%s завершён спустя %s! Ваше последнее прохождение заняло %s, а лучшее прохождение заняло %s. Общее количество прохождений у Вас %d."
L.SCENARIO_COMPLETE_NR				= "%s завершён спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество прохождений у Вас %d."
L.COMBAT_ENDED_AT					= "Бой с %s (%s) закончился спустя %s."
L.COMBAT_ENDED_AT_LONG				= "Бой с %s (%s) закончился спустя %s. На этом уровне сложности Вы вайпнулись уже %d раз."
L.GUILD_COMBAT_ENDED_AT				= "Группа гильдии %s вайпнулась на %s (%s) спустя %s."
L.SCENARIO_ENDED_AT					= "%s закончился спустя %s."
L.SCENARIO_ENDED_AT_LONG			= "%s закончился спустя %s. На этом уровне сложности Вы не завершили сценарий уже %d раз."
L.COMBAT_STATE_RECOVERED			= "%s был атакован %s назад, восстанавливаю таймеры..."
L.TRANSCRIPTOR_LOG_START			= "Логирование с помощью Transcriptor начато."
L.TRANSCRIPTOR_LOG_END				= "Логирование с помощью Transcriptor окончено."

L.MOVIE_SKIPPED						= L.DBM .. " автоматически попытался пропустить ролик."
L.MOVIE_NOTSKIPPED					= L.DBM .. " обнаружил ролик, который можно пропустить, но НЕ пропустил его из-за ошибки Blizzard. Когда эта ошибка будет исправлена, пропуск ролика будет снова включен."
L.BONUS_SKIPPED						= L.DBM .. " автоматически закрыл окно бонусного броска. Если Вам нужно вернуть это окно, введите /dbmbonusroll в течение 3 минут."

L.AFK_WARNING						= "Вы АФК и в бою (осталось %d процентов здоровья), запуск звукового сигнала. Если Вы не АФК, отключите АФК режим или эту опцию в 'Дополнительные возможности'."

L.COMBAT_STARTED_AI_TIMER			= "Мой ЦП - это процессор нейронной сети, обучающий компьютер. (Этот бой будет использовать новую функцию таймера AI для генерации приближений таймера)"

L.PROFILE_NOT_FOUND					= "<" .. L.DBM .. "> Ваш текущий профиль повреждён. " .. L.DBM .. " загрузит профиль 'По умолчанию'."
L.PROFILE_CREATED					= "Профиль '%s' создан."
L.PROFILE_CREATE_ERROR				= "Не удалось создать профиль. Некорректное имя профиля."
L.PROFILE_CREATE_ERROR_D			= "Не удалось создать профиль. Профиль '%s' уже существует."
L.PROFILE_APPLIED					= "Профиль '%s' применён."
L.PROFILE_APPLY_ERROR				= "Не удалось применить профиль. Профиль '%s' не существует."
L.PROFILE_COPIED					= "Профиль '%s' скопирован."
L.PROFILE_COPY_ERROR				= "Не удалось скопировать профиль. Профиль '%s' не существует."
L.PROFILE_COPY_ERROR_SELF			= "Невозможно скопировать профиль сам в себя."
L.PROFILE_DELETED					= "Профиль '%s' удалён. Профиль 'По умолчанию' будет применён."
L.PROFILE_DELETE_ERROR				= "Не удалось удалить профиль. Профиль '%s' не существует."
L.PROFILE_CANNOT_DELETE				= "Невозможно удалить профиль 'По умолчанию'."
L.MPROFILE_COPY_SUCCESS				= "Настройки модуля от %s (специализация %d) были скопированы."
L.MPROFILE_COPY_SELF_ERROR			= "Невозможно скопировать настройки персонажа сами в себя."
L.MPROFILE_COPY_S_ERROR				= "Источник повреждён. Настройки не скопированы или скопированы частично. Скопировать не удалось."
L.MPROFILE_COPYS_SUCCESS			= "Звуковые настройки модуля от %s (специализация %d) были скопированы."
L.MPROFILE_COPYS_SELF_ERROR			= "Невозможно скопировать звуковые настройки персонажа сами в себя."
L.MPROFILE_COPYS_S_ERROR			= "Источник повреждён. Звуковые настройки не скопированы или скопированы частично. Скопировать не удалось."
L.MPROFILE_DELETE_SUCCESS			= "Настройки модуля от %s (специализация %d) были удалены."
L.MPROFILE_DELETE_SELF_ERROR		= "Невозможно удалить настройки модуля, используемого в данный момент."
L.MPROFILE_DELETE_S_ERROR			= "Источник повреждён. Настройки не удалены или удалены частично. Удалить не удалось."

L.NOTE_SHARE_SUCCESS				= "%s поделился своей заметкой для %s"
L.NOTE_SHARE_LINK					= "Нажмите здесь, чтобы открыть заметку"
L.NOTE_SHARE_FAIL					= "%s попытался поделиться с Вами заметкой для %s. Однако модуль, связанный с этой способностью, не установлен или не загружен. Если Вам нужна эта заметка, убедитесь, что модуль, для которого они делятся заметкой, загружен и попросите поделиться снова"

L.NOTEHEADER						= "Вставьте текст вашей заметки для %s здесь. Поместив имя игрока между >< , окрасит его в цвет класса. Для предупреждений с несколькими заметками разделите их с помощью '/'"
L.NOTEFOOTER						= "Когда заметка обновлена, просто нажмите 'ОК', чтобы сохранить"
L.NOTESHAREDHEADER					= "%s поделился заметкой для %s. Если Вы примете её, она перезапишет Вашу текущую заметку"
L.NOTESHARED						= "Ваша заметка была отправлена группе"
L.NOTESHAREERRORSOLO				= "Одиноко? Вы не должны передавать заметки самому себе"
L.NOTESHAREERRORBLANK				= "Нельзя поделиться пустой заметкой"
L.NOTESHAREERRORGROUPFINDER			= "Нельзя поделиться заметкой на БГ, в поиске рейда или подземелья"
L.NOTESHAREERRORALREADYOPEN			= "Нельзя открыть ссылку заметки, пока открыт редактор заметок, чтобы предотвратить потерю заметки, которую Вы в данный момент редактируете"

L.ALLMOD_DEFAULT_LOADED				= "Настройки 'По умолчанию' для всех модулей в этом подземелье были загружены."
L.ALLMOD_STATS_RESETED				= "Вся статистика модуля была сброшена."
L.MOD_DEFAULT_LOADED				= "Настройки 'По умолчанию' для этого боя были загружены."

L.WORLDBOSS_ENGAGED					= "В Вашем игровом мире возможно начался бой с %s (%s процентов здоровья, отправил %s)."
L.WORLDBOSS_DEFEATED				= "%s возможно был побеждён в Вашем игровом мире (отправил %s)."
L.WORLDBUFF_STARTED         		= "В Вашем игровом мире начался мировой бафф %s для фракции %s (отправил %s)."

L.TIMER_FORMAT_SECS					= "%.2f сек"
L.TIMER_FORMAT_MINS					= "%d мин"
L.TIMER_FORMAT						= "%d мин %.2f сек"

L.MIN								= "мин"
L.MIN_FMT							= "%d мин"
L.SEC								= "сек"
L.SEC_FMT							= "%s сек"

L.GENERIC_WARNING_OTHERS			= "и ещё один"
L.GENERIC_WARNING_OTHERS2			= "и %d других"
L.GENERIC_WARNING_BERSERK			= "Берсерк через %s %s"
L.GENERIC_TIMER_BERSERK				= "Берсерк"
L.OPTION_TIMER_BERSERK				= "Отсчёт времени до $spell:26662"
L.BAD								= "Плохой"

L.OPTION_CATEGORY_TIMERS			= "Индикаторы"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "Общие предупреждения"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Персональные предупреждения"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Предупреждения для цели"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Предупреждения для роли"
L.OPTION_CATEGORY_SPECWARNINGS		= "Специальные предупреждения"

L.OPTION_CATEGORY_SOUNDS			= "Звуки"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Выпадающие списки"
L.OPTION_CATEGORY_YELLS				= "Крики"
L.OPTION_CATEGORY_NAMEPLATES		= "Индикаторы"
L.OPTION_CATEGORY_ICONS				= "Метки"
L.OPTION_CATEGORY_PAURAS			= "Приватные Ауры"

L.AUTO_RESPONDED					= "Автоответ."
L.STATUS_WHISPER					= "%s: %s, %d/%d человек живые"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s сейчас занят, в бою против %s (%s, %d/%d человек живые)"
L.WHISPER_COMBAT_END_KILL			= "%s одержал победу над %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s одержал победу над %s! Общее количество побед у них - %d."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s потерпел поражение от %s на %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s потерпел поражение от %s на %s. Общее количество вайпов у них - %d."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s сейчас занят в %s (%d/%d человек живые)"
L.WHISPER_SCENARIO_END_KILL			= "%s завершил %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s завершил %s! Общее количество побед у них - %d."
L.WHISPER_SCENARIO_END_WIPE			= "%s не завершил %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s не завершил %s. Общее количество незавершённых у них - %d."

L.VERSIONCHECK_HEADER				= "Boss Mod - Версии"
L.VERSIONCHECK_ENTRY				= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO			= "%s: %s (%s) & %s (%s)"--Два Босс мода
L.VERSIONCHECK_ENTRY_NO_DBM			= "%s: Boss Mod не установлен"
L.VERSIONCHECK_FOOTER				= "Найдено %d |4игрок:игрока:игроков; с " .. L.DBM .. " и %d |4игрок:игрока:игроков; с BigWigs"
L.VERSIONCHECK_OUTDATED				= "Следующие %d игрок(и) имеют устаревшую версию: %s"
L.YOUR_VERSION_OUTDATED      		= "Ваша версия " .. L.DEADLY_BOSS_MODS .. " устарела! Пожалуйста, загрузите последнюю версию с Curse, Wago, WoWI или со страницы релизов на GitHub."
L.VOICE_PACK_OUTDATED				= "В Вашем голосовом пакете " .. L.DBM .. " отсутствуют звуки, поддерживаемые этой версией " .. L.DBM .. ". Фильтр звуков спецпредупреждений был отключён. Пожалуйста, скачайте обновлённую версию голосового пакета или свяжитесь с автором для обновления, которое содержит отсутствующие звуковые файлы."
L.VOICE_MISSING						= "Выбранный Вами голосовой пакет " .. L.DBM .. " не найден. Если это ошибка, убедитесь, что Ваш голосовой пакет правильно установлен и включен в модификациях."
L.VOICE_DISABLED					= "У Вас установлен по крайней мере один голосовой пакет " .. L.DBM .. ", но ни один не включён. Если Вы собираетесь использовать голосовой пакет, убедитесь, что он выбран в 'Spoken Alerts', иначе удалите неиспользуемые голосовые пакеты, чтобы скрыть это сообщение."
L.VOICE_COUNT_MISSING				= "Голос отсчёта %d использует голосовой пакет, который не был найден. Он был сброшен на настройки по умолчанию: %s."
L.BIG_WIGS							= "BigWigs"
L.WEAKAURA_KEY						= " (|cff308530Ключ WA:|r %s)"

L.UPDATEREMINDER_HEADER				= "Ваша версия " .. L.DEADLY_BOSS_MODS .. " устарела.\n Версия %s (%s) доступна для загрузки через Curse, Wago, WoWI или со страницы релизов GitHub."
L.UPDATEREMINDER_HEADER_SUBMODULE	= "Ваш модуль %s устарел.\n Версию %s можно загрузить через Curse, Wago, WoWI или со страницы релизов GitHub."
L.UPDATEREMINDER_FOOTER				= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку для скачивания в буфер обмена."
L.UPDATEREMINDER_FOOTER_GENERIC		= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать в буфер обмена."
L.UPDATEREMINDER_DISABLE			= "ПРЕДУПРЕЖДЕНИЕ: В связи с тем, что Ваш " .. L.DEADLY_BOSS_MODS.. " устарел и несовместим с актуальной версией игры или более новыми версиями "..L.DBM..", он был принудительно отключен и не может использоваться до тех пор, пока не будет обновлен. Это делается для того, чтобы несовместимые моды не мешали игре ни Вам, ни другим участникам группы."
L.UPDATEREMINDER_DISABLETEST		= "ПРЕДУПРЕЖДЕНИЕ: В связи с тем, что Ваш " .. L.DEADLY_BOSS_MODS.. " устарел, а это тестовый/бета игровой мир, он был принудительно отключен и не может использоваться до тех пор, пока не будет обновлен. Это делается для того, чтобы устаревшие моды не использовались для создания отзывов о тестировании."
L.UPDATEREMINDER_HOTFIX				= "Ваша версия " .. L.DBM .. " будет иметь некорректные таймеры или предупреждения во время этого сражения. Это исправлено в новой версии."
L.UPDATEREMINDER_HOTFIX_ALPHA		= "Ваша версия " .. L.DBM .. " будет иметь некорректные таймеры или предупреждения во время этого сражения. Это исправлено в следующей версии (или альфа-версии)."
L.UPDATEREMINDER_MAJORPATCH			= "ПРЕДУПРЕЖДЕНИЕ: Из-за того, что Ваш " .. L.DEADLY_BOSS_MODS .. " устарел, он был отключён до обновления, т.к. это большой игровой патч. Это необходимо для того, чтобы старый и несовместимый код не приводил к ухудшению игрового опыта для Вас и членов Вашей группы. Убедитесь, что Вы скачали новую версию с Curse, Wago, WoWI или со страницы релизов GitHub."
L.VEM								= "ПРЕДУПРЕЖДЕНИЕ: Вы используете " .. L.DEADLY_BOSS_MODS .. " и Voice Encounter Mods одновременно. "..L.DBM.." не был загружен, т.к. эти два аддона не могут работать вместе."
L.OUTDATEDPROFILES					= "ПРЕДУПРЕЖДЕНИЕ: DBM-Profiles несовместим с этой версией " .. L.DBM .. ". Он должен быть удалён, прежде чем "..L.DBM.." сможет продолжить, чтобы избежать конфликтов."
L.OUTDATEDSPELLTIMERS				= "ПРЕДУПРЕЖДЕНИЕ: DBM-SpellTimers несовместим с " .. L.DBM .. " и должен быть выключен для корректной работы " .. L.DBM .. "."
L.OUTDATEDRLT						= "ПРЕДУПРЕЖДЕНИЕ: DBM-RaidLeadTools несовместим с " .. L.DBM .. ". DBM-RaidLeadTools больше не поддерживается и должен быть удалён для корректной работы " .. L.DBM .. "."
L.VICTORYSOUND						= "ПРЕДУПРЕЖДЕНИЕ: DBM-VictorySound несовместим с этой версией " .. L.DBM .. ". Он должен быть удалён, чтобы " .. L.DBM .. " мог продолжить работу без конфликтов."
L.DPMCORE							= "ПРЕДУПРЕЖДЕНИЕ: Deadly PvP mods несовместимы с этой версией " .. L.DBM .. ". Чтобы избежать конфликтов, удалите их."
L.DBMLDB							= "ПРЕДУПРЕЖДЕНИЕ: DBM-LDB теперь встроен в DBM-Core. Рекомендуется удалить 'DBM-LDB' из папки с Вашими аддонами."
L.DBMLOOTREMINDER					= "ПРЕДУПРЕЖДЕНИЕ: Обнаружен установленный DBM-LootReminder. Этот аддон больше не совместим с клиентом WoW Retail и приводит к поломке пулл таймеров " .. L.DBM .. ". Рекомендуется удалить этот аддон."
L.UPDATE_REQUIRES_RELAUNCH			= "ПРЕДУПРЕЖДЕНИЕ: Это обновление " .. L.DBM .. " не будет работать корректно, если Вы не перезапустите игровой клиент. Это обновление содержит новые файлы или изменения в .toc файле, которые не могут быть загружены через ReloadUI. Вы можете столкнуться со сломанной функциональностью или ошибками, если продолжите без перезапуска клиента."
L.OUT_OF_DATE_NAG					= "Ваша версия " .. L.DBM .. " устарела и этот энкаунтер имеет новые фичи и багфиксы в новой версии. Рекомендуется обновиться, чтобы не было отсутствующих важных предупреждений, или таймеров, или крика от Вас, на который рассчитывает остальная группа."
L.PLATER_NP_AURAS_MSG				= L.DBM .. "включает в себя расширенную функцию, позволяющую отображать таймеры восстановления противника с помощью иконок на индикаторах здоровья. Эта функция включена по умолчанию для большинства пользователей, но для пользователей Plater она по умолчанию отключена в настройках Plater, если Вы не включите её. Чтобы получить максимальную отдачу от DBM (и Plater), рекомендуется включить эту функцию в Plater в разделе 'Специальные баффы'. Если не хотите видеть это сообщение снова, Вы также можете просто полностью отключить опцию 'Иконки перезарядки на индикаторах здоровья' в настройках Глобальных отключений или настройках Индикаторов здоровья DBM"

L.MOVABLE_BAR						= "Перетащите!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует Вам таймер " .. L.DBM .. ": '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот таймер]|r|h  |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать таймеры от %1$s]|r|h"
--L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует Вам таймер " .. L.DBM .. ""
L.PIZZA_CONFIRM_IGNORE				= "Игнорировать таймеры " .. L.DBM .. " от %s на время текущего сеанса?"
L.PIZZA_ERROR_USAGE					= "Использование: /dbm [broadcast] timer <time> <text>. <time> должно быть больше 3."

--L.MINIMAP_TOOLTIP_HEADER (Same as English locales)
L.MINIMAP_TOOLTIP_FOOTER			= "[Shift+ЛКМ] - переместить значок " .. L.DBM

L.RANGECHECK_HEADER					= "Проверка дистанции (%dм)"
L.RANGECHECK_HEADERT				= "Проверка дистанции (%dм-%dP)"
L.RANGECHECK_RHEADER				= "R-Проверка дистанции (%dм)"
L.RANGECHECK_RHEADERT				= "R-Проверка дистанции (%dм-%dP)"
L.RANGECHECK_SETRANGE				= "Настройка дистанции"
L.RANGECHECK_SETTHRESHOLD			= "Настройка порога игроков"
L.RANGECHECK_SOUNDS					= "Звуковой сигнал"
L.RANGECHECK_SOUND_OPTION_1			= "Один из игроков подошёл к Вам слишком близко"
L.RANGECHECK_SOUND_OPTION_2			= "Несколько человек находятся около Вас"
L.RANGECHECK_SOUND_0				= "Без звука"
L.RANGECHECK_SOUND_1				= "По умолчанию"
L.RANGECHECK_SOUND_2				= "Раздражающий звуковой сигнал"
L.RANGECHECK_SETRANGE_TO			= "%d м"
L.RANGECHECK_OPTION_FRAMES			= "Фреймы"
L.RANGECHECK_OPTION_RADAR			= "Показывать радар"
L.RANGECHECK_OPTION_TEXT			= "Показывать текстовый фрейм"
L.RANGECHECK_OPTION_BOTH			= "Показывать оба фрейма"
L.RANGERADAR_HEADER					= "Радар:%d Игроков:%d"
L.RANGERADAR_RHEADER				= "R-Радар:%d Игроков:%d"
L.RANGERADAR_IN_RANGE_TEXT			= "%d в радиусе (%0.1fм)"
L.RANGECHECK_IN_RANGE_TEXT			= "%d в радиусе"
L.RANGERADAR_IN_RANGE_TEXTONE		= "%s (%0.1fм)"

L.INFOFRAME_TITLE					= "Инфофрейм DBM"
L.INFOFRAME_SHOW_SELF				= "Всегда показывать свою энергию"
L.INFOFRAME_SETLINES				= "Максимальное число строк"
L.INFOFRAME_SETCOLS					= "Максимальное число столбцов"
L.INFOFRAME_LINESDEFAULT			= "По умолчанию"
L.INFOFRAME_LINES_TO				= "%d строк"
L.INFOFRAME_COLS_TO					= "%d столбцов"
L.INFOFRAME_POWER					= "Сила"
L.INFOFRAME_AGGRO					= "Угроза"
L.INFOFRAME_MAIN					= "Главная:"--Главная мощь
L.INFOFRAME_ALT						= "Альтернативная:"--Альтернативная мощь

L.LFG_INVITE						= "Приглашение в подземелье"

L.SLASHCMD_HELP = {
	"Доступные команды:",
	"-----------------",
	"/dbm unlock: Отображает перемещаемый индикатор таймера (псевдоним: move).",
	"/range <число> or /distance <число>: Показать окно проверки дистанции. /rrange или /rdistance для изменения цветов.",
	"/hudar <число>: Проверка дистанции, использующая HUD.",
	"/dbm timer: Запускает пользовательский отсчёт времени, для доп. информации введите '/dbm timer'.",
	"/dbm arrow: Показывает стрелку " .. L.DBM .. ", для доп. информации введите '/dbm arrow help'.",
	"/dbm hud: Показывает " .. L.DBM .. " HUD, для доп. информации введите '/dbm hud'.",
	"/dbm help2: Показывает команды управления рейдом"
}
L.SLASHCMD_HELP2 = {
	"Доступные команды:",
	"-----------------",
	"/dbm pull <сек>: Транслирует отсчёт времени до атаки всем членам рейда (требуются права лидера или помощника).",
	"/dbm break <мин>: Транслирует отсчёт времени отдыха всем членам рейда (требуются права лидера или помощника).",
	"/dbm version: Выполняет проверку используемой рейдом версии босс мода (псевдоним: ver).",
	"/dbm version2: Выполняет проверку используемой рейдом версии босс мода и отправляет сообщение шёпотом членам рейда с устаревшей версией (псевдоним: ver2).",
	"/dbm lag: Выполняет проверку задержки у всего рейда.",
	"/dbm durability: Выполняет проверку прочности у всего рейда."
}
L.TIMER_USAGE = {
	L.DBM .. " команды таймера:",
	"-----------------",
	"/dbm timer <сек> <текст>: Запускает таймер с указанным текстом.",
	"/dbm ltimer <сек> <текст>: Запускает таймер, который автоматически повторяется до отмены.",
	"Добавьте 'broadcast' перед типом таймера, чтобы поделиться им с рейдом (требуются права лидера или помощника).",
	"/dbm timer endloop: Останавливает любой повторяющийся ltimer."
}

L.ERROR_NO_PERMISSION				= "У Вас недостаточно прав для отправки таймера пулла/перерыва."
L.ERROR_NO_PERMISSION_COMBAT		= "Таймер пулла/перерыва не может быть отправлен во время боя."
L.PULL_TIME_TOO_SHORT				= "Таймер атаки должен быть больше 3 секунд."
L.PULL_TIME_TOO_LONG				= "Таймер атаки не может быть дольше 60 секунд."

L.BREAK_USAGE						= "Перерыв не может быть дольше 60 минут. Убедитесь, что Вы вводите время в минутах, а не секундах."
L.BREAK_START						= "Перерыв начинается -- у Вас есть %s! (отправил %s)"
L.BREAK_MIN							= "Перерыв заканчивается через %s мин.!"
L.BREAK_SEC							= "Перерыв заканчивается через %s сек.!"
L.TIMER_BREAK						= "Перерыв!"
L.ANNOUNCE_BREAK_OVER				= "Перерыв закончился в %s"

L.TIMER_PULL						= "Атака"
L.ANNOUNCE_PULL						= "Атака через %d сек. (отправил %s)"
L.ANNOUNCE_PULL_NOW					= "Атака!"
L.ANNOUNCE_PULL_TARGET				= "Атакуем %s через %d сек. (отправил %s)"
L.ANNOUNCE_PULL_NOW_TARGET			= "Атакуем %s!"
L.GEAR_WARNING						= "Внимание: Проверка экипировки. Уровень надетых предметов на %d ниже, чем максимальный"
L.GEAR_WARNING_WEAPON				= "Внимание: Проверьте, надето ли у Вас корректное оружие."
L.GEAR_FISHING_POLE					= "Удочка"

L.ACHIEVEMENT_TIMER_SPEED_KILL 		= "Достижение"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you 			= "%s на тебе"
L.AUTO_ANNOUNCE_TEXTS.target 		= "%s на |3-5(>%%s<)"
L.AUTO_ANNOUNCE_TEXTS.targetsource  = ">%%s< применяется %s на >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) на |3-5(>%%s<)"
L.AUTO_ANNOUNCE_TEXTS.spell 		= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming		= "%s входящий дебафф"
L.AUTO_ANNOUNCE_TEXTS.incomingcount	= "%s входящий дебафф (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends			= "%s заканчивается"
L.AUTO_ANNOUNCE_TEXTS.endtarget		= "%s заканчивается: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades			= "%s спадает"
L.AUTO_ANNOUNCE_TEXTS.addsleft		= "Осталось %s: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast 			= "Применение заклинания %s: %.1f сек"
L.AUTO_ANNOUNCE_TEXTS.soon 			= "Скоро %s"
L.AUTO_ANNOUNCE_TEXTS.sooncount		= "Скоро %s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.countdown		= "%s через %%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s через %s"
L.AUTO_ANNOUNCE_TEXTS.bait			= "Скоро %s - байти"
L.AUTO_ANNOUNCE_TEXTS.stage			= "Фаза %s"
L.AUTO_ANNOUNCE_TEXTS.prestage		= "Скоро фаза %s"
L.AUTO_ANNOUNCE_TEXTS.count 		= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack 		= "%s на |3-5(>%%s<) (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto 		= "%s - бегите к >%%s<"

local prewarnOption 					= "Предупреждать заранее о $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you 			= "Объявлять когда $spell:%s на тебе"
L.AUTO_ANNOUNCE_OPTIONS.target 			= "Объявлять цели заклинания $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetNF		= "Объявлять цели заклинания $spell:%s (игнорирует глобальные фильтры целей)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource	= "Объявлять цели заклинания $spell:%s (с источником)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount		= "Объявлять цели заклинания $spell:%s (со счётчиком)"
L.AUTO_ANNOUNCE_OPTIONS.spell 			= "Предупреждение для $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.incoming		= "Объявлять, когда $spell:%s получает отрицательные эффекты"
L.AUTO_ANNOUNCE_OPTIONS.incomingcount	= "Объявлять (со счётчиком), когда $spell:%s получает отрицательные эффекты"
L.AUTO_ANNOUNCE_OPTIONS.ends			= "Предупреждать об окончании $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.endtarget		= "Предупреждать об окончании $spell:%s (цель)"
L.AUTO_ANNOUNCE_OPTIONS.fades			= "Предупреждать о спадении $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.addsleft		= "Объявлять сколько осталось $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.cast 			= "Предупреждать о применении заклинания $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.soon 			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown		= "Спамить заранее отсчёт до заклинания $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait			= "Предупреждать заранее (чтобы байтить) для $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage 			= "Объявлять фазу %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange		= "Объявлять смены фаз"
L.AUTO_ANNOUNCE_OPTIONS.prestage 		= "Предупреждать заранее о фазе %s"
L.AUTO_ANNOUNCE_OPTIONS.count 			= "Предупреждение для $spell:%s (со счётчиком)"
L.AUTO_ANNOUNCE_OPTIONS.stack 			= "Объявлять количество стаков $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.moveto			= "Объявлять, когда нужно переместиться к кому-то или куда-то для $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell			= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends				= "%s заканчивается"
L.AUTO_SPEC_WARN_TEXTS.fades			= "%s спадает"
L.AUTO_SPEC_WARN_TEXTS.soon				= "Скоро %s"
L.AUTO_SPEC_WARN_TEXTS.sooncount		= "Скоро %s (%%s)"
L.AUTO_SPEC_WARN_TEXTS.bait				= "Скоро %s - байти"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s через %s"
L.AUTO_SPEC_WARN_TEXTS.dispel 			= "%s на |3-5(>%%s<) - рассейте заклинание"
L.AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - прервите >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - прервите >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you 				= "%s на Вас"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) на Вас"
L.AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Позиция: %%s) на Вас"
L.AUTO_SPEC_WARN_TEXTS.youposcount		= "%s (%%s) (Позиция: %%s) на Вас"
L.AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Позиция погл.: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target 			= "%s на |3-5(>%%s<)"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) на >%%s< "
L.AUTO_SPEC_WARN_TEXTS.defensive		= "%s - защититесь"
L.AUTO_SPEC_WARN_TEXTS.taunt			= "%s на >%%s< - затаунти"
L.AUTO_SPEC_WARN_TEXTS.close 			= "%s на |3-5(>%%s<) около Вас"
L.AUTO_SPEC_WARN_TEXTS.move 			= "%s - отбегите"
L.AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - продолжайте двигаться"
L.AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - остановитесь"
L.AUTO_SPEC_WARN_TEXTS.dodge			= "%s - избегайте"
L.AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - избегайте"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s - избегайте от %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - отбегите от остальных"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount	= "%s (%%s) - отбегите от остальных"
L.AUTO_SPEC_WARN_TEXTS.moveawaytarget	= "%s - отбегите от %%s"
L.AUTO_SPEC_WARN_TEXTS.moveto			= "%s - бегите к >%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak				= "%s - перекройте"
L.AUTO_SPEC_WARN_TEXTS.soakcount		= "%s - перекройте (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - подпрыгните"
L.AUTO_SPEC_WARN_TEXTS.run 				= "%s - убегайте"
L.AUTO_SPEC_WARN_TEXTS.runcount 		= "%s - убегайте (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast 			= "%s - прекратите чтение заклинаний"
L.AUTO_SPEC_WARN_TEXTS.lookaway			= "%s на %%s - отвернитесь"
L.AUTO_SPEC_WARN_TEXTS.reflect 			= "%s на |3-5(>%%s<) - прекратите атаку"
L.AUTO_SPEC_WARN_TEXTS.count 			= "%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack 			= "На Вас %%d стаков от %s"
L.AUTO_SPEC_WARN_TEXTS.switch 			= "%s - переключитесь"
L.AUTO_SPEC_WARN_TEXTS.switchcount 		= "%s - переключитесь (%%s)"
L.AUTO_SPEC_WARN_TEXTS.switchcustom 	= "%s - переключитесь (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo				= "Под вами %%s - выбегите"
L.AUTO_SPEC_WARN_TEXTS.adds				= "Прибыли адды - смените цель"
L.AUTO_SPEC_WARN_TEXTS.addscount		= "Прибыли адды - смените цель (%%s)"
L.AUTO_SPEC_WARN_TEXTS.addscustom		= "Прибыли адды - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange		= "Смена цели - переключитесь на %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Спецпредупреждение для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Спецпредупреждение об окончании $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Спецпредупреждение о спадении $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Спецпредупреждение, что скоро $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Спецпредупреждение (со счётчиком) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "Спецпредупреждение (для байта) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Спецпредупреждение за %s сек. до $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 		= "Спецпредупреждение для рассеивания заклинания $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Спецпредупреждение для прерывания заклинания $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Спецпредупреждение (со счётчиком) для прерывания заклинания $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Спецпредупреждение, когда на Вас $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Спецпредупреждение (со счётчиком), когда на Вас $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "Спецпредупреждение (с позицией), когда на Вас $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youposcount	= "Спецпредупреждение (с позицией и счётчиком), когда на Вас $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakpos		= "Спецпредупреждение (с позицией) для помощи с поглощением $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.target 		= "Спецпредупреждение, когда на ком-то $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.targetcount	= "Спецпредупреждение (со счётчиком), когда на ком-то $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Спецпредупреждение для использования защитных способностей от $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Спецпредупреждение \"затаунти\", когда на другом танке $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Спецпредупреждение, когда на ком-то рядом с вами $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Спецпредупреждение \"отбегите\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Спецпредупреждение \"продолжайте двигаться\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Спецпредупреждение \"остановитесь\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Спецпредупреждение \"избегайте\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Спецпредупреждение \"избегайте\" (со счётчиком) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Спецпредупреждение \"избегайте\" (с местом) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Спецпредупреждение \"отбегите от остальных\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Спецпредупреждение \"отбегите от остальных\" (со счётчиком) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaytarget	= "Спецпредупреждение \"отбегите от остальных\" (с целью) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "Спецпредупреждение \"бегите к кому-то\", на ком $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak			= "Спецпредупреждение \"перекройте\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakcount		= "Спецпредупреждение \"перекройте\" (со счётчиком) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "Спецпредупреждение \"подпрыгните\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Спецпредупреждение \"убегайте\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.runcount 		= "Спецпредупреждение (со счётчиком) \"убегайте\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Спецпредупреждение \"прекратите чтение заклинаний\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Спецпредупреждение \"отвернитесь\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Спецпредупреждение \"прекратите атаку\" для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Спецпредупреждение (со счётчиком) для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Спецпредупреждение, когда на Вас >=%d стаков $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Спецпредупреждение о смене цели для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount 	= "Спецпредупреждение (со счётчиком) о смене цели для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcustom 	= "Спецпредупреждение (с информацией) о смене цели для $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Спецпредупреждение о выбегании из войды на земле"
L.AUTO_SPEC_WARN_OPTIONS.adds			= "Спецпредупреждение о смене цели для прибывающих аддов"
L.AUTO_SPEC_WARN_OPTIONS.addscount		= "Спецпредупреждение (со счётчиком) о смене цели для прибывающих аддов"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "Спецпредупреждение для прибывающих аддов"
L.AUTO_SPEC_WARN_OPTIONS.targetchange	= "Спецпредупреждение для смены приоритетной цели"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target 			= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.targetcount 		= "%s (%%2$s): %%1$s"
L.AUTO_TIMER_TEXTS.cast 			= "%s"
L.AUTO_TIMER_TEXTS.castcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.castsource		= "%s: %%s"
L.AUTO_TIMER_TEXTS.active			= "%s заканчивается"
L.AUTO_TIMER_TEXTS.fades			= "%s спадает"
L.AUTO_TIMER_TEXTS.ai				= "%s ИИ"

L.AUTO_TIMER_TEXTS.cd 				= "%s"
L.AUTO_TIMER_TEXTS.cdcount			= "%s (%%s)"
L.AUTO_TIMER_TEXTS.cdsource			= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial		= "Восст. спецспособности"
L.AUTO_TIMER_TEXTS.cdcombo			= "%%1$s + %%2$s"

L.AUTO_TIMER_TEXTS.next 			= "%s"
L.AUTO_TIMER_TEXTS.nextcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource		= "%s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial		= "Спецспособность"
L.AUTO_TIMER_TEXTS.nextcombo		= "%%1$s + %%2$s"

L.AUTO_TIMER_TEXTS.achievement		= "%s"
L.AUTO_TIMER_TEXTS.stage			= "Фаза"
L.AUTO_TIMER_TEXTS.stagecount		= "Фаза %%s"
L.AUTO_TIMER_TEXTS.stagecountcycle	= "Фаза %%s (%%s)"
L.AUTO_TIMER_TEXTS.stagecontext		= "%s"
L.AUTO_TIMER_TEXTS.stagecontextcount	= "%s (%%s)"
L.AUTO_TIMER_TEXTS.intermission		= "Переходная фаза"
L.AUTO_TIMER_TEXTS.intermissioncount	= "Переходная фаза %%s"
L.AUTO_TIMER_TEXTS.adds				= "Адды"
L.AUTO_TIMER_TEXTS.addscustom		= "Адды (%%s)"
L.AUTO_TIMER_TEXTS.roleplay			= GUILD_INTEREST_RP or "Ролевая игра"
L.AUTO_TIMER_TEXTS.combat			= "Бой начинается"

--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp = L.AUTO_TIMER_TEXTS.cd
L.AUTO_TIMER_TEXTS.nextnp = L.AUTO_TIMER_TEXTS.next
L.AUTO_TIMER_TEXTS.cdcountnp = L.AUTO_TIMER_TEXTS.cdcount
L.AUTO_TIMER_TEXTS.nextcountnp = L.AUTO_TIMER_TEXTS.nextcount

L.AUTO_TIMER_OPTIONS.target 		= "Отсчёт времени действия дебаффа $spell:%s"
L.AUTO_TIMER_OPTIONS.targetcount 	= "Отсчёт времени действия дебаффа (со счётчиком) $spell:%s"
L.AUTO_TIMER_OPTIONS.cast 			= "Отсчёт времени применения заклинания $spell:%s"
L.AUTO_TIMER_OPTIONS.castcount		= "Отсчёт времени применения заклинания (со счётчиком) для $spell:%s"
L.AUTO_TIMER_OPTIONS.castsource		= "Отсчёт времени применения заклинания (с источником) для $spell:%s"
L.AUTO_TIMER_OPTIONS.active 		= "Отсчёт времени действия $spell:%s"
L.AUTO_TIMER_OPTIONS.fades			= "Отсчёт времени до спадения $spell:%s с игроков"
L.AUTO_TIMER_OPTIONS.ai				= "Отсчёт времени до восстановления $spell:%s (ИИ)"
L.AUTO_TIMER_OPTIONS.cd 			= "Отсчёт времени до восстановления $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount 		= "Отсчёт времени до восстановления $spell:%s"
L.AUTO_TIMER_OPTIONS.cdnp 			= "Отсчёт времени до восстановления $spell:%s (только индикатор)"
L.AUTO_TIMER_OPTIONS.cdnpcount 		= "Отсчёт времени до восстановления $spell:%s (только индикатор, со счётчиком)"
L.AUTO_TIMER_OPTIONS.cdsource		= "Отсчёт времени до восстановления $spell:%s (с источником)"
L.AUTO_TIMER_OPTIONS.cdspecial		= "Отсчёт времени до восстановления спецспособности"
L.AUTO_TIMER_OPTIONS.cdcombo		= "Отсчёт времени до восстановления комбо способности"--Используется для объединения двух способностей в один таймер
L.AUTO_TIMER_OPTIONS.next 			= "Отсчёт времени до следующего $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount 		= "Отсчёт времени до следующего $spell:%s"
L.AUTO_TIMER_OPTIONS.nextnp 		= "Отсчёт времени до следующего $spell:%s (только индикатор)"
L.AUTO_TIMER_OPTIONS.nextnpcount 	= "Отсчёт времени до следующего $spell:%s (только индикатор, со счётчиком)"
L.AUTO_TIMER_OPTIONS.nextsource		= "Отсчёт времени до следующего $spell:%s (с источником)"
L.AUTO_TIMER_OPTIONS.nextspecial	= "Отсчёт времени до следующей спецспособности"
L.AUTO_TIMER_OPTIONS.nextcombo		= "Отсчёт времени до следующей комбо способности"--Используется для объединения двух способностей в один таймер
L.AUTO_TIMER_OPTIONS.achievement 	= "Отсчёт времени для %s"
L.AUTO_TIMER_OPTIONS.stage			= "Отсчёт времени до следующей фазы"
L.AUTO_TIMER_OPTIONS.stagecount		= "Отсчёт времени (со счетчиком) до следующей фазы"
L.AUTO_TIMER_OPTIONS.stagecountcycle	= "Отсчёт времени (со счетчиком фаз и циклов) до следующей фазы"
L.AUTO_TIMER_OPTIONS.stagecontext		= "Отсчёт времени до следующего этапа $spell:%s"
L.AUTO_TIMER_OPTIONS.stagecontextcount	= "Отсчёт времени (со счетчиком) до следующего этапа $spell:%s"
L.AUTO_TIMER_OPTIONS.intermission	= "Отсчёт времени до следующей переходной фазы"
L.AUTO_TIMER_OPTIONS.intermissioncount	= "Отсчёт времени (со счетчиком) до следующей переходной фазы"
L.AUTO_TIMER_OPTIONS.adds			= "Отсчёт времени до прибытия аддов"
L.AUTO_TIMER_OPTIONS.addscustom		= "Отсчёт времени до прибытия аддов"
L.AUTO_TIMER_OPTIONS.roleplay		= "Отсчёт времени для ролевой игры"
L.AUTO_TIMER_OPTIONS.combat			= "Отсчёт времени до начала боя"

L.AUTO_ICONS_OPTION_TARGETS			= "Устанавливать метки на цели $spell:%s"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A		= "Устанавливать метки на цели $spell:%s с приоритетом танка над ближним боем, над дальним и по алфавиту"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R		= "Устанавливать метки на цели $spell:%s с приоритетом танка над ближним боем, над дальним и рейдового состава"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Устанавливать метки на цели $spell:%s с приоритетом ближнего боя и в алфавитном порядке"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Устанавливать метки на цели $spell:%s с приоритетом ближнего боя и рейдового состава"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Устанавливать метки на цели $spell:%s с приоритетом дальнего боя и в алфавитном порядке"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Устанавливать метки на цели $spell:%s с приоритетом дальнего боя и рейдового состава"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Устанавливать метки на цели $spell:%s в алфавитном порядке"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Устанавливать метки на цели $spell:%s с приоритетом рейдового состава"
L.AUTO_ICONS_OPTION_NPCS			= "Устанавливать метки на $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT		= " (Может конфликтовать с другими параметрами)"
L.AUTO_ARROW_OPTION_TEXT			= "Показывать стрелку " .. L.DBM .. " к цели, на которой $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2			= "Показывать стрелку " .. L.DBM .. " от цели, на которой $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3			= "Показывать стрелку " .. L.DBM .. " к определённому месту для $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell	= "Кричать, когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell		= "Кричать (с именем игрока), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count		= "Кричать (со счетчиком), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade		= "Кричать (с обратным отсчетом), когда $spell:%s спадает"
L.AUTO_YELL_OPTION_TEXT.shortfade	= "Кричать (с обратным отсчетом), когда $spell:%s спадает"
L.AUTO_YELL_OPTION_TEXT.iconfade	= "Кричать (с обратным отсчетом и меткой), когда $spell:%s спадает"
L.AUTO_YELL_OPTION_TEXT.position	= "Кричать (с позицией и именем игрока), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.shortposition	= "Кричать (с позицией), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.combo		= "Кричать (с пользовательским текстом), когда на Вас $spell:%s и в тоже время другие заклинания"
L.AUTO_YELL_OPTION_TEXT.repeatplayer	= "Кричать повторно (с именем игрока), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.repeaticon	= "Кричать повторно (с меткой), когда на Вас $spell:%s"
L.AUTO_YELL_OPTION_TEXT.icontarget	= "Кричать значками, когда на Вас $spell:%s, чтобы предупредить других"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s на " .. UnitName("player") .. "!"
L.AUTO_YELL_ANNOUNCE_TEXT.count		= "%s на " .. UnitName("player") .. "! (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s спадает через %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade	= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position 	= "%s %%s на {rt%%d}"..UnitName("player").."{rt%%d}"
L.AUTO_YELL_ANNOUNCE_TEXT.shortposition 	= "{rt%%1$d}%s %%2$d"
L.AUTO_YELL_ANNOUNCE_TEXT.combo		= "%s и %%s"
L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer				= UnitName("player")
L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon	= "{rt%%1$d}"
L.AUTO_YELL_ANNOUNCE_TEXT.icontarget	= "{rt%%1$d}{rt%%1$d}{rt%%1$d}{rt%%1$d}{rt%%1$d}"

L.AUTO_YELL_CUSTOM_POSITION				= "{rt%d}%s"--Перевод не требуется
L.AUTO_YELL_CUSTOM_FADE				= "%s спал"
L.AUTO_HUD_OPTION_TEXT				= "Показывать HudMap для $spell:%s"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Показывать HudMap для различных механик"
L.AUTO_NAMEPLATE_OPTION_TEXT			= "Показывать ауры индикаторов для $spell:%s, используя совместимый аддон индикаторов или "..L.DBM..""
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "Показывать ауры индикаторов для $spell:%s, используя только "..L.DBM..""
L.AUTO_RANGE_OPTION_TEXT			= "Показывать окно проверки дистанции (%s м) для $spell:%s"
L.AUTO_RANGE_OPTION_TEXT_SHORT		= "Показывать окно проверки дистанции (%s м)"
L.AUTO_RRANGE_OPTION_TEXT			= "Показывать обратное окно проверки дистанции (%s) для $spell:%s"
L.AUTO_RRANGE_OPTION_TEXT_SHORT		= "Показывать обратное окно проверки дистанции (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT		= "Показывать информационное окно для $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2		= "Показывать информационное окно для обзора боя"
L.AUTO_INFO_FRAME_OPTION_TEXT3		= "Показывать информационный фрейм для $spell:%s (при достижении порогового значения %%s)"
L.AUTO_READY_CHECK_OPTION_TEXT		= "Воспроизводить звук проверки готовности, когда пуллят босса (даже если он не является целью)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT		= "Показывать таймер для быстрой зачистки %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT		= "Воспроизводить звуковые оповещения DBM для приватных аур $spell:%s в этом бою."

L.AUTO_GOSSIP_BUFFS						= "Автоматический выбор вариантов диалогов для NPC или профессий"
L.AUTO_GOSSIP_PERFORM_ACTION			= "Автоматический выбор вариантов диалогов для выполнения действий (например, использование транспорта)"
L.AUTO_GOSSIP_START_ENCOUNTER			= "Автоматический выбор диалогов для начала боя"--Это никогда не должно быть во множественном числе, поскольку оно не будет в трэш-моде, как два других

-- New special warnings
L.MOVE_WARNING_BAR					= "Индикатор предупреждения"
L.MOVE_WARNING_MESSAGE				= "Спасибо за использование " .. L.DEADLY_BOSS_MODS
L.MOVE_SPECIAL_WARNING_BAR			= "Индикатор спецпредупреждения"
L.MOVE_SPECIAL_WARNING_TEXT			= "Специальное предупреждение"

L.HUD_INVALID_TYPE					= "Задан неверный тип HUD"
L.HUD_INVALID_TARGET				= "Не задана допустимая цель для HUD"
L.HUD_INVALID_SELF					= "Невозможно использовать себя в качестве цели для HUD"
L.HUD_INVALID_ICON					= "Невозможно использовать метод иконки для HUD на цели, у которой нет метки"
L.HUD_SUCCESS						= "HUD запущен с Вашими параметрами. Он будет отключён через %s или с помощью '/dbm hud hide'."
L.HUD_USAGE	= {
	"Использование " .. L.DBM .. "-HudMap:",
	"-----------------",
	"/dbm hud <тип> <цель> <длительность>: создаёт HUD, который указывает на игрока в течение желаемого времени",
	"Возможные типы: arrow, dot, red, blue, green, yellow, icon (требуется цель с рейдовой меткой)",
	"Возможные цели: target, focus, <имя игрока>",
	"Длительность: любое число (в секундах). Если не задано, то используется 20 мин.",
	"/dbm hud hide: отключает и скрывает HUD"
}

L.ARROW_MOVABLE						= "Индикатор стрелки"
L.ARROW_WAY_USAGE					= "/dway <x> <y>: Создаёт стрелку, которая указывает в определенное место (используя координаты текущей зоны)"
L.ARROW_WAY_SUCCESS					= "Чтобы скрыть стрелку, введите '/dbm arrow hide' или достигните указанного места"
L.ARROW_ERROR_USAGE	= {
	"Использование " .. L.DBM .. "-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: создаёт стрелку, указывающую в определенную точку (используя координаты мира)",
	"/dbm arrow map <x> <y>: создает стрелку, указывающую в определенную точку (используя координаты зоны)",
	"/dbm arrow <player>: создаёт стрелку, указывающую на определенного игрока в Вашей группе или рейде (с учётом регистра!)",
	"/dbm arrow hide: скрывает стрелку",
	"/dbm arrow move: делает стрелку подвижной"
}

L.SPEED_KILL_TIMER_TEXT				= "Рекордная победа"
L.SPEED_CLEAR_TIMER_TEXT			= "Лучшее прохождение"
L.COMBAT_RES_TIMER_TEXT				= "След. заряд БР"
L.TIMER_RESPAWN						= "Появление %s"

L.LAG_CHECKING						= "Проверка задержки у рейда..."
L.LAG_HEADER						= L.DEADLY_BOSS_MODS.. " - Результаты проверки задержки"
L.LAG_ENTRY							= "%s: глобальная задержка [%d ms] / локальная задержка [%d ms]"
L.LAG_FOOTER						= "Нет ответа: %s"

L.DUR_CHECKING						= "Проверка прочности у рейда..."
L.DUR_HEADER						= L.DEADLY_BOSS_MODS.. " - результаты проверки прочности"
L.DUR_ENTRY							= "%s: прочность [%d процентов] / экипировка сломана [%s]"
L.LAG_FOOTER						= "Нет ответа: %s"

L.OVERRIDE_ACTIVATED					= "Для этого сражения Рейд лидер активировал перезапись конфигурации."

--LDB
L.LDB_TOOLTIP_HELP1					= "[ЛКМ] - открыть " .. L.DBM
L.LDB_TOOLTIP_HELP2					= "[Alt+ПКМ] - переключить в беззвучный режим"
L.SILENTMODE_IS						= "Тихий режим "

L.WORLD_BUFFS.hordeOny			= "Народы Орды, жители Оргриммара! Приходите, собирайтесь и поздравляйте героя Орды"
L.WORLD_BUFFS.allianceOny		= "Граждане и союзники Штормграда, в этот день вершилась история."
L.WORLD_BUFFS.hordeNef			= "НЕФАРИАН УБИТ! Жители Оргриммара"
L.WORLD_BUFFS.allianceNef		= "Граждане Альянса! Владыка Черной горы повержен!"
L.WORLD_BUFFS.zgHeart			= "Теперь остался лишь один шаг до избавления от Свежевателя Душ"
L.WORLD_BUFFS.zgHeartBooty		= "Кровавый Свежеватель Душ побежден! Теперь нам ничто не угрожает!"
L.WORLD_BUFFS.zgHeartYojamba	= "Начинайте ритуал, слуги мои. Мы должны отправить сердце Хаккара обратно в Пустоту!"
L.WORLD_BUFFS.rendHead			= "Самозванец Ренд Чернорук мертв!"
L.WORLD_BUFFS.blackfathomBoon	= "Дар Непроглядной Пучины"

-- Раздражающее всплывающее окно, особенно для классических игроков
L.DBM_INSTALL_REMINDER_HEADER	= "Обнаружена неполная установка DBM!"
L.DBM_INSTALL_REMINDER_EXPLAIN	= "Добро пожаловать в %s. DBM моды для боссов находятся в %s, которые у Вас не установлены. DBM не будет показывать таймеры или предупреждения в этой зоне, пока Вы не установите %s!"
L.DBM_INSTALL_REMINDER_DISABLE	= "Отключить все предупреждения и таймеры DBM в этой зоне." -- Используется, когда мы считаем, что мод не установлен по ошибке пользователя (т.е. текущие рейды)
L.DBM_INSTALL_REMINDER_DISABLE2 = "Больше не показывать это сообщение для этого пакета." -- Используется для неважных модов, например, подземелий
L.DBM_INSTALL_REMINDER_DL_WAGO	= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку Wago.io в буфер обмена."
L.DBM_INSTALL_REMINDER_DL_CURSE	= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку Curseforge в буфер обмена."
L.DBM_INSTALL_PACKAGE_VANILLA	= "Пакет 'Классика и Сезон Открытий'"
L.DBM_INSTALL_PACKAGE_WRATH		= "Пакет 'Гнев Короля-лича'"
L.DBM_INSTALL_PACKAGE_CATA		= "Пакет 'Катаклизм'"
L.DBM_INSTALL_PACKAGE_DUNGEON	= "Пакет 'Подземелья, вылазки и события'"
