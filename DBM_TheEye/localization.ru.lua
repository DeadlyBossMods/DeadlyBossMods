if (GetLocale() == "ruRU") then
DBM_EYE_TAB			= "EyeTab"
DBM_TEMPEST_KEEP	= "Крепость Бурь";

-- Void Reaver
DBM_VOIDREAVER_NAME						= "Страж Бездны";
DBM_VOIDREAVER_DESCRIPTION				= "Объявляет Чародейский шар и Тяжкий удар.";
DBM_VOIDREAVER_OPTION_WARN_ORB			= "Объявить цель Чародейский шар";
DBM_VOIDREAVER_OPTION_YELL_ORB			= "Отправить сообщение в чат, если бросается Чародейский шар на вас";
DBM_VOIDREAVER_OPTION_ORB_ICON			= "Установить метку на цель Чародейский шар";
DBM_VOIDREAVER_OPTION_WARN_POUNDING		= "Объявить Тяжкий удар";
DBM_VOIDREAVER_OPTION_WARN_POUNDINGSOON	= "Показать предупреждение \"Скоро Тяжкий удар\"";
DBM_VOIDREAVER_OPTION_SOUND				= "Звуковое уведомление, если бросается Чародейский шар на вас"

DBM_VOIDREAVER_POUNDING					= "Тяжкий удар";

DBM_VOIDREAVER_WARN_ORB					= "*** Чародейский шар на >%s< ***";
DBM_VOIDREAVER_YELL_ORB					= "Чародейский шар приближается! Бегите от меня!";
DBM_VOIDREAVER_WARN_ENRAGE				= "*** Ярость через %s %s ***";
DBM_VOIDREAVER_WARN_POUNDING			= "*** Тяжкий удар ***";
DBM_VOIDREAVER_WARN_POUNDING_SOON		= "*** Скоро Тяжкий удар ***";
DBM_VOIDREAVER_SPECWARN_ORB				= "Чародейский шар на вас!";

DBM_VOIDREAVER_R_FURY					= "Праведное неистовство"

DBM_SBT["Enrage"]			= "Ярость";
DBM_SBT["Next Pounding"]	= "Следующий Тяжкий удар";
DBM_SBT["Pounding"]			= "Тяжкий удар";

-- Solarian
DBM_SOLARIAN_NAME						= "Верховный звездочет Солариан";
DBM_SOLARIAN_DESCRIPTION				= "Объявляет Гнев и призыв приспешников.";
DBM_SOLARIAN_OPTION_WARN_WRATH			= "Объявить Гнев";
DBM_SOLARIAN_OPTION_ICON_WRATH			= "Установить метку на цель Гнев";
DBM_SOLARIAN_OPTION_SPECWARN_WRATH		= "Показать спец-предупреждение, когда на вас Гнев";
DBM_SOLARIAN_OPTION_WARN_PHASE			= "Объявить призыв приспешников";
DBM_SOLARIAN_OPTION_WHISPER_WRATH		= "Сообщить шепотом цели, если Гнев на нем"
DBM_SOLARIAN_OPTION_SOUND				= "Звуковое уведомление, если Гнев на вас"

DBM_SOLARIAN_YELL_ENRAGE				= "Enough of this!%s*Now I call upon the fury of the cosmos itself."

DBM_SOLARIAN_SPECWARN_WRATH				= "Гнев на вас!";
DBM_SOLARIAN_ANNOUNCE_WRATH				= "*** Гнев на >%s< ***";
DBM_SOLARIAN_ANNOUNCE_SPLIT				= "*** Приспешники на подходе ***";
DBM_SOLARIAN_ANNOUNCE_PRIESTS_SOON		= "*** Жрецы и Солариан через 5 секунд ***";
DBM_SOLARIAN_ANNOUNCE_PRIESTS_NOW		= "*** Жрецы и Солариан появились ***";
DBM_SOLARIAN_ANNOUNCE_AGENTS_NOW		= "*** Пособники появились ***";
DBM_SOLARIAN_ANNOUNCE_SPLIT_SOON		= "*** Разделение через 5 секунд ***";
DBM_SOLARIAN_ANNOUNCE_ENRAGE_PHASE		= "*** Фаза демона Бездны ***";

DBM_SBT["Split"] 				= "Разделение";
DBM_SBT["Priests & Solarian"] 	= "Жрецы и Солариан";
DBM_SBT["Agents"] 				= "Пособники";
DBM_SBT["Solarian"] = {
	[1] = {
	"Wrath: (.*)",
	"Гнев: %1",
	}
}

-- Al'ar
DBM_ALAR_NAME							= "Ал'ар";
DBM_ALAR_DESCRIPTION					= "Объявляет и показывает таймеры для Ал'ар.";
DBM_ALAR_OPTION_MELTARMOR				= "Объявить Расплавленная броня";
DBM_ALAR_OPTION_METEOR					= "Объявить Метеор";

DBM_ALAR_FLAME_BUFFET					= "Удар пламенем";

DBM_ALAR_WARN_MELTARMOR					= "*** >%s< под воздействием эффекта Расплавленная броня ***";
DBM_ALAR_WARN_REBIRTH					= "*** Фаза 2 ***";
DBM_ALAR_WARN_FIRE						= "Язык огня";
DBM_ALAR_WARN_ADD						= "*** Следующая платформа - приспешник на подходе ***";
DBM_ALAR_WARN_METEOR					= "*** Метеор ***";
DBM_ALAR_WARN_METEOR_SOON				= "*** Скоро Метеор ***";
DBM_ALAR_WARN_ENRAGE					= "*** Ярость через %s %s ***";

DBM_SBT["Next Platform"]				= "Следующая платформа";
DBM_SBT["Meteor"]			= "Метеор";
DBM_SBT["Enrage"]			= "Ярость";
DBM_SBT["Alar"]							= {
		[1] = {
			"Melt Armor: (.*)",
			"Расплавленная броня: %1",
		}
	}

-- Kael'thas
DBM_KAEL_NAME							= "Кель'тас Солнечный Скиталец";
DBM_KAEL_DESCRIPTION					= "Показывает таймеры для Кель'тас.";

DBM_KAEL_OPTION_PHASE					= "Объявить фазы";
DBM_KAEL_OPTION_ICON_P1					= "Установить метку на цель Таладред";
DBM_KAEL_OPTION_WHISPER_P1				= "Сообщить шепотом цели, если Таладред на нем";
DBM_KAEL_OPTION_RANGECHECK				= "Контрольное окно придельной дистанции";
DBM_KAEL_OPTION_CONFLAG					= "Объявить Воспламенение";
DBM_KAEL_OPTION_CONFLAG2				= "Объявить Воспламенение в Фазе 3";
DBM_KAEL_OPTION_CONFLAGTIMER2			= "Показать таймер Воспламенения в фазе 3";
DBM_KAEL_OPTION_FEAR					= "Объявить Страх";
DBM_KAEL_OPTION_FEARSOON				= "Показать предупреждение \"Скоро Страх\"";
DBM_KAEL_OPTION_TOY						= "Объявить Игрушка с дистанционным управлением в фазе 1";
DBM_KAEL_OPTION_FRAME					= "Показать здоровье Орудий";
DBM_KAEL_OPTION_ADDFRAME				= "Показать здоровье советников";
DBM_KAEL_OPTION_PYRO					= "Объявить Огненная глыба";
DBM_KAEL_OPTION_BARRIER					= "Объявить Шоковая преграда";
DBM_KAEL_OPTION_BARRIER2				= "Объявить Шоковая преграда в фазе 5";
DBM_KAEL_OPTION_PHOENIX					= "Объявить появление фениксов";
DBM_KAEL_OPTION_WARNMC					= "Объявить Контроль над разумом";
DBM_KAEL_OPTION_ICONMC					= "Устанавить метку на цель Контроль над разумом";
DBM_KAEL_OPTION_GRAVITY					= "Объявить Искажение гравитации";

DBM_KAEL_YELL_PHASE1					= "Energy. Power. My people are addicted to it... a dependence made manifest after the Sunwell was destroyed. Welcome... to the future. A pity you are too late to stop it. No one can stop me now! Selama ashal'anore!";
DBM_KAEL_EMOTE_THALADRED_TARGET			= "sets eyes on ([^%s]+)!";
DBM_KAEL_YELL_PHASE1_SANGUINAR			= "You have persevered against some of my best advisors... but none can withstand the might of the Blood Hammer. Behold, Lord Sanguinar!";
DBM_KAEL_YELL_PHASE1_CAPERNIAN			= "Capernian will see to it that your stay here is a short one.";
DBM_KAEL_YELL_PHASE1_TELONICUS			= "Well done, you have proven worthy to test your skills against my master engineer, Telonicus.";
DBM_KAEL_CAST_FEAR						= "Lord Sanguinar begins to cast Bellowing Roar.";
DBM_KAEL_DEBUFF_FEAR1					= "находится под воздействием эффекта Раскатистый рев";
DBM_KAEL_DEBUFF_FEAR2					= "Lord Sanguinar%s?'s Bellowing Roar";
DBM_KAEL_DEBUFF_CONFLAGRATION			= "([^%s]+) (%w+) под воздействием эффекта Воспламенение%.";
DBM_KAEL_DEBUFF_REMOTETOY				= "([^%s]+) (%w+) под воздействием эффекта Игрушка с дистанционным управлением%.";
DBM_KAEL_YELL_THALA_DOWN				= "Forgive me, my prince! I have... failed.";
DBM_KAEL_YELL_CAPERNIAN_DOWN			= "This is not over!";

DBM_KAEL_YELL_PHASE2					= "As you see, I have many weapons in my arsenal....";
DBM_KAEL_YELL_PHASE3					= "Perhaps I underestimated you. It would be unfair to make you fight all four advisors at once, but... fair treatment was never shown to my people. I'm just returning the favor.";
DBM_KAEL_YELL_PHASE4					= "Alas, sometimes one must take matters into one's own hands. Balamore shanal!";
DBM_KAEL_YELL_PHASE5					= "I have not come this far to be stopped! The future I have planned will not be jeopardized! Now you will taste true power!!";

DBM_KAEL_WEAPONS = {
	["Staff of Disintegration"] = 1,
	["Infinity Blades"] = 2,
	["Cosmic Infuser"] = 3,
	["Warp Slicer"] = 4,
	["Devastation"] = 5,
	["Netherstrand Longbow"] = 6,
	["Phaseshift Bulwark"] = 7
};
DBM_KAEL_WEAPONS_NAMES = {
	"Staff",
	"Dagger",
	"Mace",
	"Sword",
	"Axe",
	"Bow",
	"Shield"
};


DBM_KAEL_ADVISORS = {
	["Таладред Светокрад"] = 1,
	["Лорд Сангвинар"] = 2,
	["Великий Звездочет Каперниан"] = 3,
	["Старший инженер Телоникус"] = 4,
};

DBM_KAEL_ADVISORS_NAMES = {
	"Таладред",
	"Сангвинар",
	"Каперниан",
	"Телоникус"
};

DBM_KAEL_INFOFRAME_TITLE				= "Орудия";
DBM_KAEL_INFOFRAME_ADDS_TITLE			= "Советники";

DBM_KAEL_CAST_PHOENIX_REBIRTH			= "Феникс начинает читать заклинание Возрождение.";
DBM_KAEL_EMOTE_PYROBLAST				= "начинает читать заклинание Огненная глыба";
DBM_KAEL_EGG							= "Яйцо феникса";
DBM_KAEL_YELL_GRAVITY_LAPSE				= "Having trouble staying grounded?";
DBM_KAEL_YELL_GRAVITY_LAPSE2			= "Let us see how you fare when your world is turned upside down.";


DBM_KAEL_SPECWARN_THALADRED_TARGET		= "Бегите!";
DBM_KAEL_WARN_THALADRED_TARGET			= "*** Таладред бросает взор на >%s< ***";
DBM_KAEL_WHISPER_THALADRED_TARGET		= "Таладред бросает взор на ВАС! Бегите!";
DBM_KAEL_WARN_INC						= "*** %s на подходе ***";
DBM_KAEL_SANGUINAR						= "Лорд Сангвинар";
DBM_KAEL_CAPERNIAN						= "Каперниан";
DBM_KAEL_TELONICUS						= "Телоникус";
DBM_KAEL_WARN_FEAR						= "*** Страх через 1.5 секунды ***";
DBM_KAEL_WARN_FEAR_SOON					= "*** Скоро Страх ***";
DBM_KAEL_WARN_CONFLAGRATION				= "*** >%s< под воздействием эффекта Воспламенение ***";
DBM_KAEL_WARN_REMOTETOY					= "*** >%s< под воздействием эффекта Игрушка с дистанционным управлением ***";

DBM_KAEL_WARN_PHASE1					= "*** Фаза 1 - Таладред на подходе ***";
DBM_KAEL_WARN_PHASE2					= "*** Фаза 2 - Орудия на подходе ***";
DBM_KAEL_WARN_PHASE3					= "*** Фаза 3 - Приспешники на подходе ***";
DBM_KAEL_WARN_PHASE4					= "*** Фаза 4 - Кель'тас на подходе ***";
DBM_KAEL_WARN_PHASE5					= "*** Фаза 5 ***";

DBM_KAEL_WARN_PYRO						= "*** Огненная глыба ***";
DBM_KAEL_WARN_BARRIER_SOON				= "*** Шоковая преграда через 5 секунд ***";
DBM_KAEL_WARN_BARRIER_NOW				= "*** Шоковая преграда ***";
DBM_KAEL_WARN_BARRIER_DOWN				= "*** Шоковая преграда исчезла! ***";
DBM_KAEL_WARN_PHOENIX					= "*** Появился феникс ***";
DBM_KAEL_WARN_MC_TARGETS				= "*** Контроль над разумом: %s ***";
DBM_KAEL_WARN_REBIRTH					= "*** Феникс убит - появляется яйцо ***";
DBM_KAEL_WARN_GRAVITY_LAPSE				= "*** Искажение гравитации ***";
DBM_KAEL_GRAVITY_SOON					= "*** Скоро Искажение гравитации ***";
DBM_KAEL_GRAVITY_END_SOON				= "*** Искажение гравитации закончится через 5 секунд ***";

DBM_SBT["Thaladred"] 				    = "Таладред";
DBM_SBT["Lord Sanguinar"] 			    = "Лорд Сангвинар";
DBM_SBT["Capernian"] 				    = "Каперниан";
DBM_SBT["Telonicus"] 				    = "Телоникус";
DBM_SBT["Next Gravity Lapse"] 			= "Следующее Искажение гравитации";
DBM_SBT["Gravity Lapse"] 			    = "Искажение гравитации";
DBM_SBT["Next Shock Barrier"] 			= "Следующая Шоковая преграда";
DBM_SBT["Shock Barrier"] 			    = "Шоковая преграда";
DBM_SBT["Phoenix"] 				        = "Феникс";
DBM_SBT["Next Fear"] 				    = "Следующий вызов феникса";
DBM_SBT["Fear"] 				        = "Страх";
DBM_SBT["Pyroblast"] 				    = "Огненная глыба";
DBM_SBT["Rebirth"] 				        = "Возрождение";
DBM_SBT["Phase 3"] 				        = "Фаза 3";
DBM_SBT["Phase 4"] 				        = "Фаза 4";
DBM_SBT["Gaze Cooldown"] 				= "Восстановление взгляда";
DBM_SBT["KaelThas"] = {
	{"Conflagration: (.*)","Воспламенение: %1"},
	{"Remote Toy: (.*)","Игрушка с дистанционным управлением: %1"},
};

end
