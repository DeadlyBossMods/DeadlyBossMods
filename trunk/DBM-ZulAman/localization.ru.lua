if GetLocale() == "ruRU" then
DBM_ZULAMAN		= "Зул'Аман"
DBM_ZULAMAN_TAB	= "DBM_ZULAMAN_TAB";

-- Nalorakk
DBM_NALO_NAME					= "Налоракк"
DBM_NALO_DESCRIPTION			= "Объявляет и показывает таймеры для форм медведя/обычная и Молчание."
DBM_NALO_OPTION_PHASEPRE		= "Показать 5 секундное предупреждение перед фазами"
DBM_NALO_OPTION_SILENCE			= "Объявить Молчание"

DBM_NALO_YELL_PULL				= "Недолго вам осталось!"
DBM_NALO_YELL_BEAR				= "Если вызвать чудовище, то мало не покажется, точно говорю!"
DBM_NALO_YELL_NORMAL			= "Пропустите Налоракка!"
DBM_NALO_SPELLID_SILENCE		= 42398

DBM_NALO_WARN_NORMAL_SOON		= "Обычная форма через 5 секунд"
DBM_NALO_WARN_BEAR_SOON			= "Форма медведя через 5 секунд"
DBM_NALO_WARN_NORMAL			= "Обычная форма"
DBM_NALO_WARN_BEAR				= "Форма медведя"
DBM_NALO_WARN_SILENCE			= "Молчание"

DBM_SBT["Enrage"] 			    = "Ярость";
DBM_SBT["Bear Form"]	        = "Форма медведя";
DBM_SBT["Normal Form"]	        = "Обычная форма";
    
-- Akil'zon
DBM_AKIL_NAME					= "Акил'зон"
DBM_AKIL_DESCRIPTION			= "Объявляет звонком в мини-карте об Электрическом шторме."
DBM_AKIL_OPTION_RANGE			= "Показать окно контроля диапазона"

DBM_AKIL_YELL_PULL				= "Я хищник! Ты - моя добыча!"
DBM_AKIL_SPELLID_STORM			= 43648

DBM_AKIL_WARN_STORM_SOON		= "Скоро Электрический шторм"
DBM_AKIL_WARN_STORM_ON			= ">%s< под воздействием эффекта Электрический шторм"

DBM_SBT["Enrage"]			    = "Ярость";
DBM_SBT["Electrical Storm"]	    = "Электрический шторм";

-- Jan'alai
DBM_JANALAI_NAME				= "Джан'алаи"
DBM_JANALAI_DESCRIPTION			= "Объявляет телепортацию и вызов смотрителей."

DBM_JANALAI_YELL_PULL			= "Да покарает вас дух ветра!"
DBM_JANALAI_YELL_EXPLOSION		= "Сгиньте в огне!"
DBM_JANALAI_YELL_HATCHER		= "Где мои Наседки? Пора за яйца приниматься!"

DBM_JANALAI_WARN_EXPLOSION		= "Телепортация"
DBM_JANALAI_WARN_EXPLOSION_INC	= "Взрыв через 1 секунду"
DBM_JANALAI_WARN_HATCHER		= "Смотрители"
DBM_JANALAI_WARN_HATCHER_SOON	= "Смотрители через 10 секунд"

DBM_SBT["Enrage"]		        = "Ярость";
DBM_SBT["Hatcher"]		        = "Смотрители";
DBM_SBT["Explosion"]	        = "Взрыв";

-- Halazzi
DBM_HALAZZI_NAME				= "Халаззи"
DBM_HALAZZI_DESCRIPTION			= "Объявляет фазы, тотемы и Бешенство."
DBM_HALAZZI_OPTION_FRENZY		= "Объявить Бешенство"
DBM_HALAZZI_OPTION_TOTEM		= "Объявить Тотем молний"

DBM_HALAZZI_YELL_PULL			= "Встаньте на колени и поклонитесь клыку и когтю!"
DBM_HALAZZI_YELL_SPIRIT			= "Со мною дикий дух..."
DBM_HALAZZI_YELL_SPIRIT_DESP	= "О дух, вернись ко мне!"
DBM_HALAZZI_SPELL_FRENZY		= "Бешенство"
DBM_HALAZZI_SPELLID_TOTEM		= 43302

DBM_HALAZZI_WARN_SPIRIT			= "Призывает дух"
DBM_HALAZZI_WARN_SPIRIT_DESP	= "Дух исчезает"
DBM_HALAZZI_WARN_TOTEM			= "Тотем молний"
DBM_HALAZZI_WARN_FRENZY			= "Бешенство - Усмиряющий выстрел" -- Tranquilizing Shot

-- Malacrass
DBM_MALACRASS_NAME				= "Повелитель проклятий Малакрасс"
DBM_MALACRASS_DESCRIPTION		= "Объявляет Вытягивание души и Духовные молнии."

DBM_MALACRASS_OPTION_MC			= "Объявить Контроль над разумом"

DBM_MALACRASS_YELL_PULL			= "На вас падет тень..."
DBM_MALACRASS_YELL_BOLTS		= "Ваши души истекут кровью!"
DBM_MALACRASS_SPELLID_SIPHON	= 43501

DBM_MALACRASS_WARN_SIPHON		= ">%s< под воздействием эффекта Вытягивание души"
DBM_MALACRASS_WARN_MC			= ">%s< под воздействием эффекта Контроль над разумом"
DBM_MALACRASS_WARN_BOLTS		= "Духовные молнии"
DBM_MALACRASS_WARN_BOLTS_SOON	= "Духовные молнии через 5 секунд"

DBM_SBT["Spirit Bolts"]			= "Духовные молнии"
DBM_SBT["Next Spirit Bolts"]	= "Следующие Духовные молнии"
DBM_SBT["Malacrass"]			= {
	{
		"Siphon Soul: (.*)",
		"Вытягивание души: %1",
	},
}
DBM_SBT["Повелитель проклятий Малакрасс"] = DBM_SBT["Malacrass"]

-- Zul'jin
DBM_ZULJIN_NAME					= "Зул'джин"
DBM_ZULJIN_DESCRIPTION			= "Объявляет фазы, Горестный бросок, Ползучий паралич и Яростные когти."

DBM_ZULJIN_OPTION_PARA			= "Объявить Ползучий паралич"
DBM_ZULJIN_OPTION_LYNX			= "Объявить Яростные когти"

DBM_ZULJIN_YELL_PULL			= "Нет никого сильнее меня!"
DBN_ZULJIN_YELL_PHASE_2			= "Выучил новый фокус… прямо как братишка-медведь..."
DBM_ZULJIN_YELL_PHASE_3			= "От орла нигде не скрыться!"
DBM_ZULJIN_YELL_PHASE_4			= "Позвольте представить моих двух братцев: клык и коготь!"
DBM_ZULJIN_YELL_PHASE_5			= "Для того чтобы увидеть дракондора, в небо смотреть необязательно!"

DBM_ZULJIN_DEBUFF_PARALYSIS		= "находится под воздействием эффекта Ползучий паралич"
DBM_ZULJIN_DEBUFF_DOT			= "([^%s]+) (%w+) под воздействием эффекта Горестный бросок"
DBM_ZULJIN_DEBUFF_LYNX			= "([^%s]+) (%w+) под воздействием эффекта Яростные когти%.$"
DBM_ZULJIN_SPELLID_PARALYSIS	= 43095
DBM_ZULJIN_SPELLID_LYNX			= 43150
DBM_ZULJIN_SPELLID_DOT			= 43093

DBM_ZULJIN_WARN_PHASE_1			= "Фаза 1 - Тролль"
DBM_ZULJIN_WARN_PHASE_2			= "Фаза 2 - Медведь"
DBM_ZULJIN_WARN_PHASE_3			= "Фаза 3 - Орел"
DBM_ZULJIN_WARN_PHASE_4			= "Фаза 4 - Рысь"
DBM_ZULJIN_WARN_PHASE_5			= "Фаза 5 - Дракон"

DBM_ZULJIN_WARN_PARALYSIS		= "Ползучий паралич"
DBM_ZULJIN_WARN_PARALYSIS_SOON	= "Скоро Ползучий паралич"
DBM_ZULJIN_WARN_LYNX			= ">%s< под воздействием эффекта Яростные когти"
DBM_ZULJIN_WARN_DOT				= ">%s< под воздействием эффекта Горестный бросок"

DBM_SBT["Creeping Paralysis"]	= "Ползучий паралич";

end
