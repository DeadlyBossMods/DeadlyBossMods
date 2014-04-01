if GetLocale() ~= "ruRU" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Перевод на русский язык - "
L.TranslationBy 			= "Swix, TOM_RUS"
L.Website					= "Посетите наши новые форумы обсуждения и поддержки на |cFF73C2FBwww.deadlybossmods.com|r (организовано Elitist Jerks!)"
L.WebsiteButton				= "Форумы"

L.OTabBosses				= "Боссы"
L.OTabOptions				= "Настройки"

L.TabCategory_Options	 	= "Общие параметры"
L.TabCategory_MOP	 		= "Туманы Пандарии"
L.TabCategory_CATA	 		= "Катаклизм"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "Классическая игра"
L.TabCategory_PVP 			= "PvP"
L.TabCategory_OTHER    		= "Другие боссы"

L.BossModLoaded 			= "%s - статистика"
L.BossModLoad_now 			= [[Модуль для этих боссов не загружен. 
Он будет загружен сразу после входа в подземелье. 
Также вы можете нажать кнопку, чтобы загрузить модуль вручную.]]

L.PosX						= 'Позиция X'
L.PosY						= 'Позиция Y'

L.MoveMe 					= 'Передвинь меня'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Отмена'
L.Button_LoadMod			= 'Загрузить модуль'
L.Mod_Enabled				= "Включить модуль"
L.Mod_Reset					= "Восстановить настройки по умолчанию"
L.Reset 					= "Сброс"

L.Enable  					= "Вкл."
L.Disable					= "Откл."

L.NoSound					= "Без звука"

L.IconsInUse				= "Используемые метки"

-- Tab: Boss Statistics
L.BossStatistics			= "Статистика босса"
L.Statistic_Kills			= "Убийства:"
L.Statistic_Wipes			= "Поражения:"
L.Statistic_Incompletes		= "Не завершено:"
L.Statistic_BestKill		= "Лучший бой:"

-- Tab: General Core Options
L.General 					= "Общие параметры DBM"
L.EnableDBM 				= "Включить DBM"
L.EnableMiniMapIcon			= "Отображать кнопку на мини-карте"
L.UseMasterVolume			= "Использовать основной аудио канал для проигрывания звуковых предупреждений"
L.LFDEnhance				= "Проигрывать звук проверки готовности для проверки ролей и приглашений на БГ/ЛФГ через основной аудио канал"
L.AutologBosses				= "Автоматически записывать бои с боссами используя журнал боя Blizzard"
L.AdvancedAutologBosses		= "Автоматически записывать бои с боссами используя Transcriptor"
L.LogOnlyRaidBosses			= "Записывать только бои с рейдовыми боссами (искл. Поиск Рейдов/5 ппл/сценарии)"
L.Latency_Text				= "Макс. задержка для синхронизации: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "Общие параметры таймера"
L.SKT_Enabled				= "Всегда отображать таймер быстрого убийства (переопределяет настройку для конкретного босса)"
L.ChallengeTimerOptions		= "Отображать таймер лучшего прохождения для режима испытаний"
L.ChallengeTimerPersonal	= "Персональный"
L.ChallengeTimerGuild		= "Гильдия"
L.ChallengeTimerRealm		= "Сервер"

L.ModelOptions				= "Настройки 3D моделей на странице боссов"
L.EnableModels				= "Показывать 3D модели боссов"
L.ModelSoundOptions			= "Выбор голосового приветствия"
L.ModelSoundShort			= "Короткое"
L.ModelSoundLong			= "Длинное"

L.Button_RangeFrame			= "Окно проверки дистанции"
L.Button_RangeRadar			= "Показать/скрыть радар"
L.Button_InfoFrame			= "Показать/скрыть окно информации"
L.Button_TestBars			= "Запустить проверку"

L.PizzaTimer_Headline 		= 'Создать "Pizza Timer"'
L.PizzaTimer_Title			= 'Название (например, "Pizza!")'
L.PizzaTimer_Hours 			= "час."
L.PizzaTimer_Mins 			= "мин."
L.PizzaTimer_Secs 			= "сек."
L.PizzaTimer_ButtonStart 	= "Начать отсчет"
L.PizzaTimer_BroadCast		= "Транслировать рейду"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Предупреждения для рейда"
L.RaidWarning_Header		= "Параметры рейд-предупреждений"
L.RaidWarnColors 			= "Цвета предупреждений для рейда"
L.RaidWarnColor_1 			= "Цвет 1"
L.RaidWarnColor_2 			= "Цвет 2"
L.RaidWarnColor_3		 	= "Цвет 3"
L.RaidWarnColor_4 			= "Цвет 4"
L.InfoRaidWarning			= [[Вы можете указать расположение и цвет предупреждений для рейда. 
Используется для сообщений вроде "Игрок X под воздействием Y"]]
L.ColorResetted 			= "Цветовые параметры для этого поля восстановлены."
L.ShowWarningsInChat 		= "Показывать предупреждения в окне чата"
L.ShowSWarningsInChat 		= "Показывать спец-предупреждения в окне чата"
L.ShowFakedRaidWarnings 	= "Показывать предупреждения в виде объявлений рейду"
L.WarningIconLeft 			= "Отображать значок с левой стороны"
L.WarningIconRight 			= "Отображать значок с правой стороны"
L.WarningIconChat 			= "Отображать значки в окне чата"
L.ShowCountdownText			= "Отображать текст отсчета"
L.RaidWarnMessage 			= "Спасибо за использование Deadly Boss Mods"
L.BarWhileMove 				= "Действие рейд-предупреждения"
L.RaidWarnSound				= "Звук рейд-предупреждения"
L.CountdownVoice			= "Основной голос для звуков отсчета"
L.CountdownVoice2			= "Вторичный голос для звуков отсчета"
L.SpecialWarnSound			= "Звук спец-предупреждения для вас или для вашей роли"
L.SpecialWarnSound2			= "Звук спец-предупреждения для всех"
L.SpecialWarnSound3			= "Звук очень важного спец-предупреждения"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Общие сообщения"
L.CoreMessages				= "Параметры общих сообщений"
L.ShowLoadMessage 			= "Показывать сообщения о загрузке модулей в окне чата"
L.ShowPizzaMessage 			= "Показывать сообщения транслируемых таймеров в окне чата"
L.ShowCombatLogMessage 		= "Показывать сообщение DBM о записи лога боя в окне чата"
L.ShowTranscriptorMessage	= "Показывать сообщение DBM о записи лога боя с помощью Transcriptor в окне чата"
L.CombatMessages			= "Параметры сообщений в бою"
L.ShowEngageMessage 		= "Показывать сообщения о вступлении в бой в окне чата"
L.ShowKillMessage 			= "Показывать сообщения об убийстве босса в окне чата"
L.ShowWipeMessage 			= "Показывать сообщения при вайпе в окне чата"
L.ShowRecoveryMessage 		= "Показывать сообщения о восстановлении таймеров в окне чата"
L.WhisperMessages			= "Параметры приватных сообщений"
L.AutoRespond 				= "Включить авто-ответ в бою"
L.EnableStatus 				= "Отвечать на запрос статуса боя шепотом"
L.WhisperStats 				= "Добавлять статистику убийств/вайпов в авто-ответ"

-- Tab: Barsetup
L.BarSetup   				= "Настройки индикатора"
L.BarTexture 				= "Текстура индикатора"
L.BarStyle					= "Стиль индикатора"
L.BarDBM					= "DBM"
L.BarBigWigs				= "BigWigs (без анимации)"
L.BarStartColor				= "Цвет в начале"
L.BarEndColor 				= "Цвет в конце"
L.Bar_Font					= "Шрифт для индикаторов"
L.Bar_FontSize				= "Размер шрифта: %d"
L.Bar_Height				= "Высота индикатора: %d"
L.Slider_BarOffSetX 		= "Сдвиг X: %d"
L.Slider_BarOffSetY 		= "Сдвиг Y: %d"
L.Slider_BarWidth 			= "Ширина: %d"
L.Slider_BarScale 			= "Масштаб: %0.2f"
L.AreaTitle_BarSetup		= "Параметры основного индикатора"
L.AreaTitle_BarSetupSmall 	= "Параметры уменьшенного индикатора"
L.AreaTitle_BarSetupHuge	= "Параметры увеличенного индикатора"
L.EnableHugeBar 			= "Включить увеличенный индикатор (Полоса 2)"
L.BarIconLeft 				= "Значок слева"
L.BarIconRight 				= "Значок справа"
L.ExpandUpwards				= "Выровнять по верху"
L.FillUpBars				= "Наполняющая заливка"
L.ClickThrough				= "Отключить события мыши (щелчок сквозь)"
L.Bar_DBMOnly				= "Настройки ниже работают только со стилем индикатора \"DBM\"."
L.Bar_EnlargeTime			= "Увеличивать, когда время меньше: %d"
L.Bar_EnlargePercent		= "Увеличивать, когда процент меньше: %0.1f%%"
L.BarSpark					= "Искрение индикатора"
L.BarFlash					= "Мигание когда индикатор скоро исчезнет"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Специальные предупреждения"
L.Area_SpecWarn				= "Настройка специальных предупреждений"
L.SpecWarn_Enabled			= "Отображать спец-предупреждения для способностей босса"
L.SpecWarn_FlashFrame		= "Мигать экраном во время специальных предупреждений"
L.SpecWarn_AdSound			= "Включить расширенные настройки звука для спец-предупреждений (требуется перезагрузка UI)"
L.SpecWarn_Font				= "Выбор шрифта для специальных предупреждений"
L.SpecWarn_FontSize			= "Размер шрифта: %d"
L.SpecWarn_FontColor		= "Цвет шрифта"
L.SpecWarn_FontType			= "Выбор шрифта"
L.SpecWarn_FlashColor		= "Цвет мигания"
L.SpecWarn_FlashDur			= "Длительности мигания: %0.1f"
L.SpecWarn_FlashAlpha		= "Прозрачность мигания: %0.1f"
L.SpecWarn_DemoButton		= "Показать пример"
L.SpecWarn_MoveMe			= "Расположение"
L.SpecWarn_ResetMe			= "Восстановить умолчания"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Здоровье босса"
L.Area_HPFrame				= "Настройка здоровья босса"
L.HP_Enabled				= "Всегда отображать здоровье босса (переопределяет настройку для конкретного босса)"
L.HP_GrowUpwards			= "Выровнять индикатор здоровья по верху"
L.HP_ShowDemo				= "Индикатор здоровья"
L.BarWidth					= "Ширина индикатора: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Общие и спам-фильтры"
L.Area_SpamFilter				= "Параметры спам-фильтра"
L.StripServerName				= "Удалять имя сервера в предупреждениях и таймерах"
L.SpamBlockBossWhispers			= "Фильтрация &lt;DBM&gt; предупреждений шепотом в бою"
L.BlockVersionUpdateNotice		= "Отключить уведомление о доступном обновлении (не рекомендуется)"
L.ShowBBOnCombatStart			= "Выполнять проверку положительных эффектов Big Brother в начале боя"
L.BigBrotherAnnounceToRaid		= "Объявлять результаты проверки Big Brother в рейд"

L.Area_SpamFilter_Outgoing		= "Параметры общего фильтра"
L.SpamBlockNoShowAnnounce		= "Не объявлять или предупреждать звуком игрока"
L.DontShowFarWarnings			= "Не отображать предупреждения/таймеры для событий, которые далеко"
L.SpamBlockNoSendWhisper		= "Не отправлять предупреждения шепотом другим игрокам"
L.SpamBlockNoSetIcon			= "Не устанавливать метки на цели"
L.SpamBlockNoRangeFrame			= "Не отображать окно проверки дистанции"
L.SpamBlockNoInfoFrame			= "Не отображать информационное окно"
L.SpamBlockNoHealthFrame		= "Не отображать окно здоровья"

L.Area_PullTimer				= "Параметры фильтра таймера пулла"
L.DontShowPTNoID				= "Блокировать таймеры пулла, отправленные из другой зоны"
L.DontShowPT					= "Не отображать таймер пулла"
L.DontShowPTText				= "Не отображать текст объявления для таймера пулла/боя"
L.DontPlayPTCountdown			= "Не воспроизводить звук отсчета таймера пулла/боя"
L.DontShowPTCountdownText		= "Не отображать текст отсчета таймера пулла/боя"
L.PT_Threshold					= "Не отображать текст отсчета таймера пулла/боя больше: %d"

L.Panel_HideBlizzard			= "Скрыть Blizzard"
L.Area_HideBlizzard				= "Настройки скрытия Blizzard"
L.HideBossEmoteFrame			= "Скрывать окно эмоций рейдового босса во время боя с боссом"
L.HideWatchFrame				= "Скрывать окно отслеживания заданий во время боя с боссом"
L.HideTooltips					= "Скрывать подсказки во время боя с боссом"
L.SpamBlockSayYell				= "Скрыть текст оповещений в облачках из окна чата"
L.DisableCinematics				= "Отключить внутриигровые ролики"
L.AfterFirst					= "После одного просмотра"
L.Always						= "Всегда"

-- Misc
L.FontHeight	= 16
