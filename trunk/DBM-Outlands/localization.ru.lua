if (GetLocale() == "ruRU") then

-- Maulgar
DBM_MAULGAR_NAME			= "Король Молгар";
DBM_MAULGAR_DESCRIPTION		= "Объявляет щит и исцеление и показывает таймеры для Удар по дуге, Вихрь и Охотник Скверны spawn.";
DBM_MAULGAR_OPTION_1		= "Объявить Большее слово силы: щит";
DBM_MAULGAR_OPTION_2		= "Объявить Щит заклятий";
DBM_MAULGAR_OPTION_3		= "Объявить Молитва исцеления";
DBM_MAULGAR_OPTION_4		= "Объявить Исцеление";
DBM_MAULGAR_OPTION_5		= "Объявить Вихрь";
DBM_MAULGAR_OPTION_6		= "Объявить Удар по дуге";
DBM_MAULGAR_OPTION_7		= "Объявить Охотник Скверны";

DBM_MAULGAR_WARN_GPWS		= "*** Щит заклятий на Слепоглазе Ясновидце ***";
DBM_MAULGAR_WARN_SHIELD		= "*** Щит заклятий на Кроше Огненная Рука ***";
DBM_MAULGAR_WARN_SMASH		= "Удар по дуге на >%s<: %s";
DBM_MAULGAR_WARN_POH		= "*** Слепоглаз Ясновидец читает Молитва исцеления ***";
DBM_MAULGAR_WARN_HEAL		= "*** Слепоглаз Ясновидец читает Исцеление ***";

DBM_MAULGAR_WARN_WHIRLWIND	= "*** Вихрь ***";
DBM_MAULGAR_WARN_WW_SOON	= "*** Скоро Вихрь ***";
DBM_MAULGAR_WARN_FELHUNTER	= "*** Охотник Скверны ***";


DBM_MAULGAR_DODGED	= "уклоняется";
DBM_MAULGAR_PARRIED	= "отражает";
DBM_MAULGAR_MISSED	= "промахивается";

DBM_SBT["Arcing Smash"]			= "Удар по дуге";
DBM_SBT["Next Whirlwind"]		= "Следующий Вихрь";
DBM_SBT["Whirlwind"]			= "Вихрь";
DBM_SBT["Prayer of Healing"]	= "Молитва исцеления";
DBM_SBT["Heal"]					= "Исцеление";
DBM_SBT["Felhunter"]			= "Охотник Скверны";
DBM_SBT["Maulgar"]				= {
		[1]	= {
			[1]	= "Spell Shield: (.*)",
			[2]	= "Щит заклятий: %1",
		},
	};

-- Gruul
DBM_GRUUL_NAME				= "Груул Драконобой";
DBM_GRUUL_DESCRIPTION		= "Объявляет Обледенение, Рык, Отзвук и Завал.";

DBM_GRUUL_RANGE_OPTION		= "Показать область границы контроля";
DBM_GRUUL_GROW_OPTION		= "Объявить Рык";
DBM_GRUUL_SHATTER_OPTION	= "Объявить Прах земной и Обледенение";
DBM_GRUUL_SILENCE_OPT		= "Объявить Молчание";
DBM_GRUUL_CAVE_OPTION		= "Показать спец-предупреждение для Завал";
DBM_GRUUL_OPTION_GROWBAR	= "Рык"

DBM_GRUUL_SAY_PULL			= "Иди… и умри."
DBM_GRUUL_GROW_EMOTE		= "%s увеличивается!";
DBM_GRUUL_EMOTE_SHATTER		= "%s ревет!";
DBM_GRUUL_SILENCE			= "Отзвук";

DBM_GRUUL_GROW_ANNOUNCE		= "*** Рык #%s ***";
DBM_GRUUL_SHATTER_WARN		= "*** Обледенение ***";
DBM_GRUUL_SHATTER_20WARN	= "*** Скоро Прах земной ***";
DBM_GRUUL_SHATTER_10WARN	= "*** Прах земной - Обледенение через 10 секунд ***";
DBM_GRUUL_SHATTER_SOON		= "*** Скоро Обледенение ***";
DBM_GRUUL_SILENCE_WARN		= "*** Молчание ***";
DBM_GRUUL_SILENCE_SOON_WARN	= "*** Скоро Молчание ***";
DBM_GRUUL_CAVE_IN_WARN		= "Завал";

DBM_SBT["Shatter"]			= "Обледенение";
DBM_SBT["Ground Slam"]		= "Прах земной"
DBM_SBT["Silence"]			= "Молчание";
DBM_SBT["Gruul"] = {
		[1] = {
			"Grow #",
			"Рык #"
		},
	}

-- LordKazzak
DBM_KAZZAK_NAME				= "Владыка Судеб Каззак";
DBM_KAZZAK_DESCRIPTION		= "Объявляет впадение в ярость, Метка Каззака и Кривое зеркало.";
DBM_KAZZAK_OPTION_1			= "Объявить впадение в ярость";
DBM_KAZZAK_OPTION_2			= "Объявить Кривое зеркало";
DBM_KAZZAK_OPTION_3			= "Объявить Метка Каззака";
DBM_KAZZAK_OPTION_4			= "Установить метку";
DBM_KAZZAK_OPTION_5			= "Сообщить шепотом";

DBM_KAZZAK_YELL_PULL		= "Все смертные умрут!";
DBM_KAZZAK_YELL_PULL2		= "Легион завоюет всех!";
DBM_KAZZAK_EMOTE_ENRAGE		= "%s впадает в ярость!";

DBM_KAZZAK_SUP_SEC			= "*** Ярость через %s сек ***";
DBM_KAZZAK_SUP_SOON			= "*** Скоро Ярость ***";
DBM_KAZZAK_TWISTED_WARN		= "*** >%s< под воздействием эффекта Кривое зеркало ***";
DBM_KAZZAK_MARK_WARN		= "*** >%s< под воздействием эффекта Метка Каззака ***";
DBM_KAZZAK_WARN_ENRAGE		= "*** Владыка Судеб Каззак впадает в Ярость ***";
DBM_KAZZAK_MARK_SPEC_WARN	= "You are the bomb!";

DBM_SBT["Enrage"]			= "Ярость";
DBM_SBT["Mark of Kazzak"]	= "Метка Каззака";

-- Magtheridon
DBM_MAG_NAME			= "Магтеридон";
DBM_MAG_DESCRIPTION		= "Объявляет и показывает таймеры для Инферналов, Исцеление тьмой и Вспышка Огненной звезды в фазе 2.";
DBM_MAG_OPTION_1		= "Объявить Инферналов";
DBM_MAG_OPTION_2		= "Объявить Исцеление";
DBM_MAG_OPTION_3		= "Объявить Вспышка Огненной звезды";

DBM_MAG_EMOTE_PULL		= "начинает ослабевать!";
DBM_MAG_YELL_PHASE2		= "Я… освобожден!"
DBM_MAG_EMOTE_NOVA		= "%s начинает читать заклинание Вспышка Огненной звезды!";

DBM_MAG_PHASE2_WARN		= "*** Фаза 2 через %s сек ***";
DBM_MAG_WARN_P2			= "*** Магтеридон свободен ***";
DBM_MAG_WARN_INFERNAL	= "*** Инфернал ***";
DBM_MAG_WARN_HEAL		= "*** Исцеление ***";
DBM_MAG_WARN_NOVA_NOW	= "*** Вспышка Огненной звезды ***";
DBM_MAG_WARN_NOVA_SOON	= "Готовы к Вспышке Огненной звезды!";

DBM_SBT["Blast Nova"]	= "Вспышка Огненной звезды";
DBM_SBT["Phase 2"]		= "Фаза 2";

-- Doomwalker
DBM_DOOMW_NAME			= "Судьболом";
DBM_DOOMW_DESCRIPTION	= "Показывает таймер для Землетрясение.";
DBM_DOOMW_OPTION_1		= "Показать область границы контроля";
DBM_DOOMW_OPTION_2		= "Объявить Землетрясение";
DBM_DOOMW_OPTION_3		= "Объявить Затопление";

DBM_DOOMW_EMOTE_ENRAGE	= "%s впадает в ярость!";

DBM_DOOMW_QUAKE_WARN	= "***  Землетрясение ***";
DBM_DOOMW_QUAKE_SOON	= "*** Скоро Землетрясение ***";
DBM_DOOMW_CHARGE		= "*** Затопление ***";
DBM_DOOMW_CHARGE_SOON	= "*** Скоро Затопление ***";
DBM_DOOMW_WARN_ENRAGE	= "*** Впадает в Ярость ***";

DBM_SBT["Overrun Cooldown"]		= "Восстановление Затопления";
DBM_SBT["Earthquake Cooldown"]	= "Восстановление Землетрясения";
DBM_SBT["Earthquake"]			= "Землетрясение";

end
