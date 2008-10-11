if GetLocale() == "ruRU" then
DBM_HYJAL_TAB		= "HyjalTab"
DBM_MOUNT_HYJAL		= "Вершина Хиджала";


-- Rage Winterchill
DBM_RAGE_NAME							= "Лютый Хлад";
DBM_RAGE_DESCRIPTION					= "Объявляет Морозная стрела, Смерть и разложение.";

DBM_RAGE_OPTION_ICEBOLT					= "Объявить Морозная стрела";
DBM_RAGE_OPTION_DND						= "Объявить Смерть и разложение";
DBM_RAGE_OPTION_ICON					= "Установить метку на цель Морозная стрела";
DBM_RAGE_OPTION_DND_SOON				= "Показать предупреждение \"Скоро Смерть и разложение\"";

DBM_RAGE_YELL_PULL						= "Легион наносит решающий удар! Снова этот мир будет покорен - в пределах нашего разума. Все будет уничтожено!";

DBM_RAGE_DEBUFF_ICEBOLT					= "([^%s]+) (%w+) под воздействием эффекта Морозная стрела.";
DBM_RAGE_SPELL_DEATH_DECAY				= "Смерть и разложение";
DBM_RAGE_CAST_DEATH_DECAY				= "Лютый Хлад начинает читать заклинание Смерть и разложение.";
DBM_RAGE_DEBUFF_DND_YOU					= "Отрицательный эффект Смерть и разложение на вас."

DBM_RAGE_WARN_ICEBOLT					= "*** >%s< под воздействием эффекта Морозная стрела ***";
DBM_RAGE_WARN_DND						= "*** Смерть и разложение ***";
DBM_RAGE_WARN_DND_END					= "*** Смерть и разложение заканчивается ***";
DBM_RAGE_WARN_DND_SOON					= "*** Скоро Смерть и разложение ***";
DBM_RAGE_SPECWARN_DND_YOU				= "Смерть и разложение на тебе! Беги!";

DBM_SBT["Death & Decay"]				= "Смерть и разложение";
DBM_SBT["Next Death & Decay"]			= "Следующая Смерть и разложение";

-- Anetheron
DBM_ANETHERON_NAME						= "Анетерон";
DBM_ANETHERON_DESCRIPTION				= "Объявляет Инфернал и Темная стая.";
DBM_ANEETHERON_OPTION_CARRION			= "Объявить Темная стая";
DBM_ANEETHERON_OPTION_INFERNAL			= "Объявить призыв Инферналов";

DBM_ANETHERON_YELL_PULL					= "Вы защищаете давно обреченный мир! Бегите сейчас – и получите возможность немного продлить свои жалкие жизни!";

DBM_ANETHERON_INFERNO					= "Инфернал";
DBM_ANETHERON_CARRION_SWARM				= "Темная стая";
DBM_ANETHERON_CAST_INFERNO				= "Анетерон начинает призыв Инфернала.";

DBM_ANETHERON_WARN_CARRION				= "*** Темная стая ***";
DBM_ANETHERON_WARN_INFERNO				= "*** >%s< под воздействием эффекта Инфернал ***";
DBM_ANETHERON_WARN_INFERNO_SOON			= "*** Скоро призыв Инферналов ***";

DBM_SBT["Carrion Swarm"]				= "Темная стая";
DBM_SBT["Infernal"]						= "Инфернал";

-- Kaz'rogal
DBM_KAZROGAL_NAME						= "Каз'рогал";
DBM_KAZROGAL_DESCRIPTION				= "Объявляет метки Каз'рогала.";

DBM_KAZROGAL_YELL_PULL					= "Оставьте надежду! Легион вернулся довести свое дело до конца. В этот раз не спасется никто!";
DBM_KAZROGAL_DEBUFF_MARK				= "под воздействием эффекта метки Каз'рогала";

DBM_KAZROGAL_WARN_MARK					= "*** %s метка ***";

-- Azgalor
DBM_AZGALOR_NAME						= "Азгалор";
DBM_AZGALOR_DESCRIPTION					= "Объявляет Рок и Молчание.";
DBM_AZGALOR_OPTION_SILENCE				= "Объявить Молчание";
DBM_AZGALOR_OPTION_ICON					= "Установить метку на цель Рок";

DBM_AZGALOR_YELL_PULL					= "Оставьте надежду! Легион вернулся довести свое дело до конца. В этот раз не спасется никто!";

DBM_AZGALOR_DEBUFF_DOOM					= "([^%s]+) (%w+) под воздействием эффекта Рок%.";
DBM_AZGALOR_DEBUFF_SILENCE				= "от отрицательный эффект Молчание des Azgalor betroffen";

DBM_AZGALOR_SPECWARN_DOOM_YOU			= "Рок!";
DBM_AZGALOR_WARN_DOOM					= "*** >%s< под воздействием эффекта Рок ***";
DBM_AZGALOR_WARN_SILENCE				= "*** Молчание ***";
DBM_AZGALOR_WARN_SILENCESOON			= "*** Скоро Молчание ***";

DBM_SBT["Silence"]						= "Вой Азгалора"
DBM_SBT["Azgalor"]						= {
	[1] = {
		"Doom: (.*)",
		"Рок: %1",
	}
}
DBM_SBT["Азгалор"] = DBM_SBT["Azgalor"]

-- Archimonde
DBM_ARCHIMONDE_NAME						= "Архимонд";
DBM_ARCHIMONDE_DESCRIPTION				= "Объявляет Хватка, Страх, Ярость и Воздушный натиск.";
DBM_ARCHIMONDE_OPTION_GRIP				= "Объявить Хватка"
DBM_ARCHIMONDE_OPTION_BURST				= "Объявить Воздушный натиск"
DBM_ARCHIMONDE_OPTION_BURSTICON			= "Установить метку на цель Воздушный натиск"
DBM_ARCHIMONDE_OPTION_BURSTSAY			= "Сообщить в чат, при наложении заклинания Воздушный натиск на вас"
DBM_ARCHIMONDE_OPTION_BURSTSPECWARN		= "Предупреждать, при наложении заклинания Воздушный натиск на вас"

DBM_ARCHIMONDE_YELL_PULL				= "Ваше сопротивление нас не остановит.";

DBM_ARCHIMONDE_DEBUFF_GRIP				= "([^%s]+) (%w+) под воздействием эффекта Хватка.";
DBM_ARCHIMONDE_CAST_FEAR				= "Архимонд начинает читать заклинание Страх."
DBM_ARCHIMONDE_CAST_BURST				= "Архимонд начинает читать заклинание Воздушный натиск."

DBM_ARCHIMONDE_WARN_GRIP				= "*** Хватка: >%s< ****"
DBM_ARCHIMONDE_WARN_ENRAGE				= "*** Ярость через %s %s ***";
DBM_ARCHIMONDE_WARN_FEAR				= "*** Страх ***";
DBM_ARCHIMONDE_WARN_FEARSOON			= "*** Скоро Страх ***";
DBM_ARCHIMONDE_WARN_BURST				= "*** Воздушный натиск: >%s< ***";
DBM_ARCHIMONDE_WARN_BURST_ME			= "Воздушный натиск на подходе!";
DBM_ARCHIMONDE_SPECWARN_BURST			= "Воздушный натиск на вас!";

DBM_SBT["Enrage"]	                    = "Ярость";
DBM_SBT["Fear"]		                    = "Страх";

-- MHTrash
DBM_MHT_NAME					        = "Треш-мобы";
DBM_MHT_DESCRIPTION				        = "Таймер волн, состав волн, Каннибализм";
DBM_MHT_DESCRIPTION1			        = "Объявить какой состав на подходе";
DBM_MHT_DESCRIPTION2			        = "Объявить, когда вурдалаки приступают к каннибализму";
DBM_MHT_OPTION_WAVE				        = "Объявить приближающуюся волну";

DBM_MHT_WAVE_CHECK				        = "Текущая волна = (%d+) из 8";
DBM_MHT_WAVE_SOON				        = "Скоро следующая волна";
DBM_MHT_WAVE_NOW				        = "Началась следующая волна!";
DBM_MHT_BOSS_SOON				        = "Скоро прийдет главарь";
DBM_MHT_BOSS_NOW				        = "Главарь на подходе!";

DBM_MHT_THRALL					        = "Тралл";
DBM_MHT_JAINA					        = "Леди Джайна Праудмур" ;
DBM_MHT_THRALL_DIES				        = "Тралл погибает.";
DBM_MHT_JAINA_DIES				        = "Леди Джайна Праудмур погибает.";
DBM_MHT_RAGE_MSG				        = "Мои спутники и я – с вами, леди Праудмур.";
DBM_MHT_ANETHERON_MSG			        = "Мы готовы встретить любого, кого пошлет Архимонд.";
DBM_MHT_KAZROGAL_MSG			        = "Я с тобой, Тралл.";
DBM_MHT_AZGALOR_MSG				        = "Нам нечего бояться.";
DBM_MHT_BOSS_DIES				        = "%s погибает.";

DBM_MHT_WAVE_INC_WARNING1			    = "*** Волна %s/8 - %s %s  ***";
DBM_MHT_WAVE_INC_WARNING2			    = "*** Волна %s/8 - %s %s и %s %s ***";
DBM_MHT_WAVE_INC_WARNING3			    = "*** Волна %s/8 - %s %s, %s %s и %s %s ***";
DBM_MHT_WAVE_INC_WARNING4			    = "*** Волна %s/8 - %s %s, %s %s, %s %s и %s %s ***";
DBM_MHT_WAVE_INC_WARNING5			    = "*** Волна %s/8 - %s %s, %s %s, %s %s, %s %s и %s %s ***";

DBM_MHT_GHOUL					        = "Вурдалака";
DBM_MHT_ABOMINATION				        = "Поганища";
DBM_MHT_NECROMANCER				        = "Некроманта";
DBM_MHT_BANSHEE					        = "Банши";
DBM_MHT_FIEND					        = "Некрорахнида";
DBM_MHT_GARGOYLE				        = "Горгульи";
DBM_MHT_WYRM					        = "Ледяной змей";
DBM_MHT_STALKER					        = "Ловчих Скверны";
DBM_MHT_INFERNAL				        = "Инфернала";
DBM_MHT_ARCHIMONDE				        = "Удача на Архимонде";

DBM_SBT["Next Wave"]	                = "Следующая волна";

end
