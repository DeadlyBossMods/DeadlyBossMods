if GetLocale() ~= "ruRU" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Триггеры и события"
L.AreaHead_CreateBossMod = "Основная информация нового BossMod"
L.BossName = "Название BossMod - например, 'Дробитель'"
L.BossID = "ID существа"
L.BossLookup = "Взять ID с цели"

L.AreaHead_Pull = "Атака / Определение начала боя"
L.CombatFromYell = "Бой начинается с Крика"
L.CombatAutoDetect = "Авто-определение боя"
L.BossPullYell = "Что кричит босс перед началом атаки"
L.BossEnrages = "Исступление босса"
L.BossEnrageBar = "Полоса Исступления"
L.BossEnrageAnnounce = "Объявить \"Исступление\" рейду"

L.Min = "мин."
L.Sec = "сек."

L.AreaHead_TriggerCreate = "Создание триггера события босса"
L.Describe_TriggerCreate = [[Триггеры служат, для обработки событий во время боя. Если босс кричит, или применяет любые дуругие способности вы должны перехватить и использовать их. К примеру, босс применяет Глухая оборона, вы хотите создать индикатор для этого события, тогда вам необходимо выбрать Эффекты и ввести название триггера "Глухая оборона"]]

L.Trigger_Typ = "Вызываемое событие"
L.Trigger_Name = "Название триггера (описание)"
L.Trigger_Typ_Spell = "Заклинание"
L.Trigger_Typ_Buff = "Эффекты"
L.Trigger_Typ_Yell = "Крик или эмоция"
L.Trigger_Typ_Time = "Временной базис"
L.Trigger_Typ_Hp = "Базис здоровья"
L.Trigger_Create_Bttn = "Создать триггер"
L.Trigger_Delete_Bttn = "Удалить триггер"

L.EventYellText = "Крик/Сообщение/Эмоция вызывает событие"
L.EventTimeBased = "Запуск через X сек."
L.EventHpBased = "Запуск при X процентах здоровья"
L.EventSpellID = "ID заклинания"
L.EventAnnounce = "Объявление"
L.EventAnnounceText = "Текст объявления"
L.EventSpecialWarn = "Спец-предупреждение"
L.EventSpecialWarn_OnlyMe = "если эффект на мне"
L.EventStartBar = "Запускать отсчет времени"
L.EventWarnEnd = "Предупр. до окончания отсчета"
L.EventWarnMsg = "Текст предупреждения"
L.EventSetIcon = "Установить метку на цель (при крике %t текста)"