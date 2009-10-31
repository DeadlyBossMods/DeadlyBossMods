if GetLocale() ~= "ruRU" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Игорь Бутвин <bootwin@gmail.com>"

L.TabCategory_Options			= "Общие параметры"
L.TabCategory_WOTLK			= "Wrath of the Lich King"
L.TabCategory_BC			= "The Burning Crusade"
L.TabCategory_CLASSIC			= "Классическая игра"
L.TabCategory_OTHER			= "Другие боссы"

L.BossModLoaded				= "%s - статистика"
L.BossModLoad_now			= [[База данных для этих боссов не загружена. 
Она будет загружена сразу после входа в подземелье. 
Можно также нажать кнопку, чтобы загрузить вручную.]]

L.PosX 					= 'Положение X'
L.PosY 					= 'Положение Y'

L.MoveMe				= 'Действие'
L.Button_OK				= 'OK'
L.Button_Cancel				= 'Отмена'
L.Button_LoadMod			= 'Загрузить надстройку'
L.Mod_Enabled				= "Включить DBM"
L.Mod_EnableAnnounce			= "Объявлять рейду"
L.Reset					= "Сброс"

L.Enable				= "вкл."
L.Disable				= "откл."

L.NoSound				= "Без звука"

L.IconsInUse				= "Используемые метки"

-- Tab: Boss Statistics
L.BossStatistics			= "Статистика для босса"
L.Statistic_Kills			= "Убийств:"
L.Statistic_Wipes			= "Поражений:"
L.Statistic_BestKill			= "Лучший бой:"
L.Statistic_Heroic			= "Героического уровня"

-- Tab: General Options
L.General				= "Общие параметры DBM"
L.EnableDBM				= "Включить DBM"
L.EnableStatus				= "Ответить шепотом сообщив \"статус\" боя"
L.AutoRespond				= "Включить авто-ответ в бою"
L.EnableMiniMapIcon			= "Отображать кнопку на мини-карте"

L.Button_RangeFrame			= "Окно допустимой дистанции"
L.Button_TestBars			= "Запустить проверку"

L.PizzaTimer_Headline			= 'Создать "Pizza Timer"'
L.PizzaTimer_Title			= 'Название (например, "Pizza!")'
L.PizzaTimer_Hours			= "час."
L.PizzaTimer_Mins			= "мин."
L.PizzaTimer_Secs			= "сек."
L.PizzaTimer_ButtonStart		= "Начать отсчет"
L.PizzaTimer_BroadCast			= "Транслировать рейду"

-- Tab: Raidwarning
L.Tab_RaidWarning			= "Предупреждения для рейда"
L.RaidWarning_Header			= "Параметры рейд-предупреждений"
L.RaidWarnColors			= "Цвета предупреждений для рейда"
L.RaidWarnColor_1			= "Цвет 1"
L.RaidWarnColor_2			= "Цвет 2"
L.RaidWarnColor_3			= "Цвет 3"
L.RaidWarnColor_4			= "Цвет 4"
L.InfoRaidWarning			= [[Можно указать положение и цвет отображаемой информации. 
Используется для сообщений подобно "Игрок X под воздействием Y"]]
L.ColorResetted				= "Цветовые параметры для этого поля восстановлены"
L.ShowWarningsInChat			= "Показывать предупреждения в окне чата"
L.ShowFakedRaidWarnings			= "Показывать предупреждения в качестве \"Объявление рейду\""
L.WarningIconLeft			= "Отображать значок с левой стороны"
L.WarningIconRight			= "Отображать значок с правой стороны"
L.RaidWarnMessage			= "Спасибо за использование Deadly Boss Mods"
L.BarWhileMove 				= "Действие рейд-предупреждения"
L.RaidWarnSound				= "Звук рейд-предупреждения"
L.SpecialWarnSound			= "Звук спец-предупреждения"

-- Tab: Barsetup
L.BarSetup				= "Стиль индикатора"
L.BarTexture				= "Текстура индикатора"
L.BarStartColor				= "Цвет в начале"
L.BarEndColor				= "Цвет в конце"
L.ExpandUpwards				= "Выровнять по верху"
L.Bar_Font				= "Шпифт для индикатора"
L.Bar_FontSize				= "Размер шрифта"
L.Slider_BarOffSetX			= "Сдвиг X: %d"
L.Slider_BarOffSetY			= "Сдвиг Y: %d"
L.Slider_BarWidth			= "Ширина: %d"
L.Slider_BarScale			= "Масштаб: %0.2f"
L.AreaTitle_BarSetup			= "Параметры основного индикатора"
L.AreaTitle_BarSetupSmall		= "Параметры уменшенного индикатора"
L.AreaTitle_BarSetupHuge		= "Параметры увеличенного индикатора"
L.BarIconLeft				= "Значок слева"
L.BarIconRight				= "Значок справа"
L.EnableHugeBar				= "Включить увеличенный индикатор (Полоса 2)"
L.FillUpBars				= "Наполняющая заливка полос"
L.ClickThrough				= "Отключить события мыши (позволяет вам щелкать мышью скозь полосы индикаторов)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame			= "Специальные предупреждения"
L.Area_SpecWarn				= "Настройка специальных предупреждений"
L.SpecWarn_Enabled			= "Отображать специальные предупреждения\nдля способностей босса"
L.SpecWarn_Font				= "Выбор шрифта для специальных предупреждений"
L.SpecWarn_DemoButton			= "Показать пример"
L.SpecWarn_MoveMe			= "Расположение"
L.SpecWarn_FontSize			= "Размер шрифта"
L.SpecWarn_FontColor			= "Цвет шрифта"
L.SpecWarn_FontType			= "Выбор шрифта"
L.SpecWarn_ResetMe			= "Восстановить умолчания"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Здоровье босса"
L.Area_HPFrame				= "Настройка Здоровья"
L.HP_Enabled				= "Всегда отображать количество очков здоровья босса\n(Заменяет определенный параметр для босса)"
L.HP_GrowUpwards			= "Выровнять индикатор здоровья по верху"
L.HP_ShowDemo				= "Индикатор здоровья"
L.BarWidth				= "Ширина индикатора: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter			= "Фильтрация сообщений"
L.Area_SpamFilter			= "Общие параметры фильтра навязчивых сообщений"
L.HideBossEmoteFrame			= "Скрывать сообщения эмоций рейдового босса"
L.SpamBlockRaidWarning			= "Фильтрация предупреждения от других DBM" 
L.SpamBlockBossWhispers			= "Фильтрация <DBM> предупреждения шепотом в бою"
L.BlockVersionUpdatePopup		= "Всплывающее сообщение, если версия устарела"
L.ShowBigBrotherOnCombatStart		= "Выполнять проверку \"BigBrother \" положительных эффектов, перед началом боевых действий"

