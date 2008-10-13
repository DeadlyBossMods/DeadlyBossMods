if GetLocale() == "ruRU" then
DBM_SERPENT_TAB	            = "SCTab"
DBM_COILFANG                = "Змеиное святилище";

-- Hydross the Unstable
DBM_HYDROSS_NAME			= "Гидросс Нестабильный";
DBM_HYDROSS_DESCRIPTION		= "Объявляет фазы, знаки и Водяная гробница.";
DBM_HYDROSS_OPTION_1		= "Показать область границы контроля";
DBM_HYDROSS_OPTION_2		= "Объявить знаки";
DBM_HYDROSS_OPTION_3		= "Показать 5 секундное предупреждение перед Знаком";
DBM_HYDROSS_OPTION_4		= "Объявить фазы";
DBM_HYDROSS_OPTION_5		= "Объявить Водяная гробница";
DBM_HYDROSS_OPTION_NATURE	= "Знак порчи"
DBM_HYDROSS_OPTION_FROST	= "Знак Гидросса"

DBM_HYDROSS_YELL_PULL		= "I cannot allow you to interfere!";
DBM_HYDROSS_YELL_NATURE		= "Aaghh, the poison...";
DBM_HYDROSS_YELL_FROST		= "Better, much better.";

DBM_HYDROSS_MARK_FROST		= "под воздействием эффекта Знак Гидросса";
DBM_HYDROSS_MARK_NATURE		= "под воздействием эффекта Знак порчи";
DBM_HYDROSS_WATER_TOMB		= "([^%s]+) (%w+) под воздействием эффекта Водяная гробница%.";

DBM_HYDROSS_FROST_MARK_NOW	= "*** Знак Гидросса #%s ***";
DBM_HYDROSS_NATURE_MARK_NOW	= "*** Знак порчи #%s ***";
DBM_HYDROSS_FROST_SOON		= "*** Знак Гидросса #%s через 5 секунд ***";
DBM_HYDROSS_NATURE_SOON		= "*** Знак порчи #%s через 5 секунд ***";

DBM_HYDROSS_FROST_PHASE		= "*** Фаза Знак Гидросса ***";
DBM_HYDROSS_NATURE_PHASE	= "*** Фаза порчи ***";

DBM_HYDROSS_TOMB_WARN		= "*** >%s< под воздействием эффекта Водяная гробница ***";

DBM_SBT["Enrage"] 		    = "Ярость";
DBM_SBT["Water Tomb"] 		= "Водяная гробница";

-- Morogrim Tidewalker
DBM_TIDEWALKER_NAME					= "Морогрим Волноступ";
DBM_TIDEWALKER_DESCRIPTION			= "Объявить Мурлоков и Водяная могила.";
DBM_TIDEWALKER_OPTION_1				= "Объявить Мурлоки";
DBM_TIDEWALKER_OPTION_2				= "Объявить Водяная могила";

DBM_TIDEWALKER_YELL_PULL			= "Flood of the deep, take you!";
DBM_TIDEWALKER_EMOTE_MURLOCS		= "The violent earthquake has alerted nearby Murlocs!";
DBM_TIDEWALKER_EMOTE_GLOBES			= "%s summons watery globules!";
DBM_TIDEWALKER_EMOTE_GRAVE			= "%s sends his enemies to their watery graves!";
DBM_TIDEWALKER_DEBUFF_GRAVE			= "([^%s]+) (%w+) под воздействием эффекта Водяная могила.";

DBM_TIDEWALKER_WARN_MURLOCS			= "*** Мурлоки ***";
DBM_TIDEWALKER_WARN_MURLOCS_SOON	= "*** Скоро Мрлоки! ***";
DBM_TIDEWALKER_WARN_GRAVE			= "*** %s под воздействием эффекта Водяная могила ***";
DBM_TIDEWALKER_WARN_GLOBES			= "*** Водяная могила ***";

DBM_SBT["Murlocs"]		            = "Мурлоки";
DBM_SBT["Watery Grave"]	            = "Водяная могила";

-- Fathom-Lord Karathress
DBM_FATHOMLORD_NAME					= "Повелитель глубин Каратресс";
DBM_FATHOMLORD_DESCRIPTION			= "Объявляет тотемы и Волну исцеления.";

DBM_FATHOMLORD_YELL_PULL			= "Guards, attention! We have visitors....";
DBM_FATHOMLORD_OPTION_TOTEM_1		= "Объявить Тотем огненного всполоха Тидалвесса";
DBM_FATHOMLORD_OPTION_TOTEM_2		= "Объявить Тотем огненного всполоха Каратресса";
DBM_FATHOMLORD_OPTION_HEAL			= "Объявить Волна исцеления";

DBM_FATHOMLORD_TIDALVESS_TOTEM		= "Хранитель глубин Волниис ставит тотем огненного всполоха.";
DBM_FATHOMLORD_KARATHRESS_TOTEM		= "Повелитель глубин Каратресс ставит тотем огненного всполоха.";
DBM_FATHOMLORD_CAST_HEAL			= "Хранительница глубин Карибдис читает заклинание Волна исцеления.";

DBM_FATHOMLORD_SFTOTEM1_WARN		= "*** Тотем огненного всполоха Тидалвесса ***";
DBM_FATHOMLORD_SFTOTEM2_WARN		= "*** Тотем огненного всполоха Каратресса ***";
DBM_FATHOMLORD_HEAL_WARN			= "*** Волна исцеления ***";

DBM_SBT["Enrage"]		            = "Ярость";
DBM_SBT["Healing Wave"]	            = "Волна исцеления";

-- The Lurker Below
DBM_LURKER_NAME						= "Скрытень из глубин";
DBM_LURKER_DESCRIPTION				= "Объявляет Погружение, Появление, Водомет и Вихрь";
DBM_LURKER_OPTION_WHIRL				= "Объявить Вихрь";
DBM_LURKER_OPTION_WHIRLSOON			= "Показать предупреждение \"Скоро Вихрь\"";
DBM_LURKER_OPTION_SPOUT				= "Объявить Водомет";

DBM_LURKER_EMOTE_SPOUT				= "Скрытень из глубин глубоко вздыхает!";
DBM_LURKER_CAST_SPOUT				= "The Lurker Below%s*'s Spout";
DBM_LURKER_CAST_WHIRL				= "The Lurker Below%s*'s Whirl";
DBM_LURKER_CAST_GEYSER				= "The Lurker Below%s*'s Geyser hits ([^%s]+) for";

DBM_LURKER_WARN_SPOUT_SOON			= "*** Скоро Водомет ***";
DBM_LURKER_WARN_SPOUT				= "*** Водомет ***";
DBM_LURKER_WARN_SUBMERGE			= "*** Погружение ***";
DBM_LURKER_WARN_EMERGE				= "*** Появление ***";

DBM_LURKER_WARN_WHIRL				= "*** Вихрь ***";
DBM_LURKER_WARN_WHIRL_SOON			= "*** Скоро Вихрь ***";

DBM_LURKER_WARN_SUBMERGE_SOON		= "*** Погружение через %s сек ***";

DBM_SBT["Submerge"]		= "Погружение";
DBM_SBT["Emerge"]		= "Появление";
DBM_SBT["Spout"]		= "Водомет";
DBM_SBT["Next Spout"]	= "Следующий Водомет";
DBM_SBT["Whirl"]		= "Вихрь";

-- Leotheras the Blind
DBM_LEO_NAME						= "Леотерас Слепец";
DBM_LEO_DESCRIPTION					= "Объявляет Вихрь, Коварный шепот и фазы.";
DBM_LEO_OPTION_WHIRL				= "Объявить Вихрь";
DBM_LEO_OPTION_DEMON				= "Объявить Внутренний демон";
DBM_LEO_OPTION_DEMONWARN			= "Сообщить цели Внутренний демон";

DBM_LEO_YELL_PULL					= "Finally, my banishment ends!";
DBM_LEO_YELL_DEMON					= "Be gone, trifling elf%.%s*I am in control now!"; -- stupid spaces...there are 2 spaces at the moment :[
DBM_LEO_YELL_SHADOW					= "No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him.";
DBM_LEO_GAIN_WHIRLWIND				= "Леотерас начинает Вихрь.";
DBM_LEO_FADE_WHIRLWIND				= "Вихрь спадает с Леотераса.";
DBM_LEO_DEBUFF_WHISPER				= "([^%s]+) (%w+) под воздействием эффекта Коварный шепот.";
DBM_LEO_CAST_WHISPER				= "Леотерас начинает читать заклинание Коварный шепот.";
DBM_LEO_YELL_WHISPER				= "We all have our demons";

DBM_LEO_WARN_ENRAGE					= "*** Ярость через %s %s ***";
DBM_LEO_WARN_WHIRL					= "*** Вихрь ***";
DBM_LEO_WARN_WHIRL_SOON				= "*** Вихрь через 5 секунд ***";
DBM_LEO_WARN_WHIRL_SOON_2			= "*** Скоро Вихрь ***";
DBM_LEO_WARN_WHIRL_FADED			= "*** Вихрь закончился ***";
DBM_LEO_WARN_SHADOW					= "*** Тень Леотераса ***";
DBM_LEO_WARN_DEMON_PHASE			= "*** Фаза демона ***";
DBM_LEO_WARN_NORMAL_PHASE			= "*** Обычная фаза ***";
DBM_LEO_WARN_DEMON_PHASE_SOON		= "*** Фаза демона через 5 секунд ***";
DBM_LEO_WARN_NORMAL_PHASE_SOON		= "*** Обычная фаза через 5 секунд ***";
DBM_LEO_SPECWARN_INNER_DEMON		= "Внутренний демон";
DBM_LEO_WHISPER_INNER_DEMON			= "Убей своего Внутреннего демона!"
DBM_LEO_WARN_DEMONS_INC				= "*** Внутренние демоны на подходе ***";
DBM_LEO_WARN_DEMONS_NOW				= "*** Внутренние демоны ***";
DBM_LEO_WARN_DEMON_TARGETS			= "*** Внутренний демон на: %s ***";

DBM_SBT["Enrage"]			= "Ярость";
DBM_SBT["Demon Form"]		= "Фаза демона";
DBM_SBT["Normal Form"]		= "Обычная фаза";
DBM_SBT["Next Whirlwind"]	= "Следующий Вихрь";
DBM_SBT["Inner Demons"]		= "Внутренние демоны";
DBM_SBT["Whirlwind"]		= "Вихрь";

-- Lady Vashj
DBM_VASHJ_NAME						= "Леди Вайш";
DBM_VASHJ_DESCRIPTION				= "Объявляет Статический заряд, возрождения, фазы, Порченая магма, Магический барьер и Ярость."

DBM_VASHJ_OPTION_RANGECHECK			= "Показать область границы контроля";
DBM_VASHJ_OPTION_CHARGE				= "Объявить Статический заряд";
DBM_VASHJ_OPTION_CHARGEICON			= "Установить метку на цель Статический заряд";
DBM_VASHJ_OPTION_SPAWNS				= "Объявить возрождения в фазе 2";
DBM_VASHJ_OPTION_COREWARN			= "Объявить наличие порченой магмы";
DBM_VASHJ_OPTION_COREICON			= "Установить метку на цел у кого Порченая магма";
DBM_VASHJ_OPTION_CORESPECWARN		= "Показать спец-предупреждение если Порченая магма у тебя";


DBM_VASHJ_YELL_PULL1				= "I spit on you, surface filth! ";
DBM_VASHJ_YELL_PULL2				= "Победа владыки Иллидана!";
DBM_VASHJ_YELL_PULL3 				= "Смерть непосвященным!";
DBM_VASHJ_YELL_PULL4				= "I did not wish to low myself by engaging your kind, but you leave me little coice... ";
DBM_VASHJ_CAST_CHARGE				= "([^%s]+) (%w+) под воздействием эффекта Статический заряд%.";
DBM_VASHJ_YELL_PHASE2				= "Время пришло! Не оставляйте никого в живых!";
DBM_VASHJ_ELEMENT_DIES				= "Нечистый элементаль";
DBM_VASHJ_FADE_SHIELD				= "Магический барьер спадает с Леди Вайш.";
DBM_VASHJ_DEBUFF_CORE				= "([^%s]+) (%w+) под воздействием эффекта Парализация%.";
DBM_VASHJ_YELL_PHASE3				= "You may want to take cover.";
DBM_VASHJ_LOOT						= "([^%s]+).*Hitem:(%d+)";

DBM_VASHJ_WARN_CHARGE				= "*** >%s< под воздействием эффекта Статический заряд ***";
DBM_VASHJ_SPECWARN_CHARGE			= "Статический заряд на тебе!";

DBM_VASHJ_WARN_PHASE2				= "*** Фаза 2 ***";
DBM_VASHJ_WARN_ELE_SOON				= "*** Нечистый элементаль через 5 секунд ***";
DBM_VASHJ_WARN_ELE_NOW				= "*** Нечистый элементаль появился ***";
DBM_VASHJ_WARN_STRIDER_SOON			= "*** Долгоног через 5 секунд ***";
DBM_VASHJ_WARN_STRIDER_NOW			= "*** Долгоног появился ***";
DBM_VASHJ_WARN_NAGA_SOON			= "*** Нага через 5 секунд ***";
DBM_VASHJ_WARN_NAGA_NOW				= "*** Нага появилась ***";
DBM_VASHJ_WARN_SHIELD_FADED			= "*** Магический барьер - деактивировано %d/4 ***";
DBM_VASHJ_WARN_CORE_LOOT			= "*** >%s< получил порченую магму ***";
DBM_VASHJ_SPECWARN_CORE				= "У тебя порченая магма!";

DBM_VASHJ_WARN_PHASE3				= "*** Магический барьер снят 4/4 - Фаза 3 ***";
DBM_VASHJ_WARN_ENRAGE				= "*** Ярость через %s %s ***";

DBM_SBT["Enrage"]				= "Ярость";
DBM_SBT["Strider"]				= "Долгоног";
DBM_SBT["Tainted Elemental"]	= "Нечистый элементаль";
DBM_SBT["Naga"]					= "Нага";
DBM_SBT["Vashj"] = {
	   [1] = {
		  [1] = "Static Charge: (.*)",
		  [2] = "Статический заряд: %1",
	   },
	};

end