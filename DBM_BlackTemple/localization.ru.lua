-- ------------------------------------------------------ --
--             Deadly Boss Mods - BT Module               --
--             русская локализация вер .005               --
--              by Necros ariett@mail.ru                  --
-- Спасибо моей гильдии Хранители http://www.keepers.ru   --
--              за терпение меня в рейде                  --
-- а также всем камрадам с форума http://forum.ixbt.com/  --
--          за ценные советы и моральную поддержку        --
--                                                        --
--                                                        --
-- Все замечания по переводу и локализации этого и других --
--   модулей ДБМ присылайте на email ariett@mail.ru       --
-- ------------------------------------------------------ --






if GetLocale() == "ruRU" then

DBM_BT_TAB			= "TempleTab"
DBM_BLACK_TEMPLE	= "Черный храм";


-- High Warlord Naj'entus
DBM_NAJENTUS_NAME					= "Верховный Полководец Надж'ентус";
DBM_NAJENTUS_DESCRIPTION			= "Анонс спеллов Пронзающий Шип и Щит Прилива.";

DBM_NAJENTUS_OPTION_ICON			= "Вешать метку на цель Пронзающего Шипа";
DBM_NAJENTUS_OPTION_RANGECHECK		= "Показать рамку дистанции";
DBM_NAJENTUS_OPTION_FRAME			= "Показать игроков с менее, чем 8500 хп";

DBM_NAJENTUS_YELL_PULL				= "Вы умрете во имя леди Вайш!";

DBM_NAJENTUS_WARN_SPINE				= "*** Пронзающий шип в >%s< ***";
DBM_NAJENTUS_WARN_ENRAGE			= "*** Озверение через %s %s ***";
DBM_NAJENTUS_WARN_SHIELD			= "*** Щит Прилива ***";
DBM_NAJENTUS_WARN_SHIELD_SOON		= "*** Щит Прилива скоро ***";

DBM_NAJENTUS_FRAME_TITLE			= "Надж'ентус"
DBM_NAJENTUS_FRAME_TEXT				= "Игроки с менее чем 8500 хп:"
DBM_NAJENTUS_SPELL_PWS				= "Слово силы: Щит"
DBM_NAJENTUS_SPELL_FW				= "Защита от магии льда"
DBM_NAJENTUS_SPELL_FB				= "Оскверненный цветок"


-- Supremus
DBM_SUPREMUS_NAME					= "Супремус";
DBM_SUPREMUS_DESCRIPTION			= "Объявлять фазы и цели";
DBM_SUPREMUS_OPTION_TARGETWARN		= "Объявлять цель Супермуса в фазе 2";
DBM_SUPREMUS_OPTION_TARGETICON		= "Вешать метку на цель Супремуса";
DBM_SUPREMUS_OPTION_TARGETWHISPER	= "Шепнуть цели Супремуса";

DBM_SUPREMUS_EMOTE_PHASE1			= "в гневе ударяет по земле!";
DBM_SUPREMUS_EMOTE_PHASE2			= "Земля начинает раскалываться!";
DBM_SUPREMUS_EMOTE_NEWTARGET		= "атакует новую цель!";

DBM_SUPREMUS_WARN_KITE_TARGET		= "Цель: >%s< Беги, Форест, беги!";
DBM_SUPREMUS_WARN_PHASE_1_SOON		= "*** Зерг-фаза через 10 сек ***";
DBM_SUPREMUS_WARN_PHASE_2_SOON		= "*** Фаза убегания через 10 сек ***";
DBM_SUPREMUS_WARN_PHASE_1			= "*** Зерг-фаза ****";
DBM_SUPREMUS_WARN_PHASE_2			= "*** Фаза убегания ***";
DBM_SUPREMUS_SPECWARN_FIRE			= "Расплавленное Пламя";
DBM_SUPREMUS_SPECWARN_VOLCANO		= "Вулкан";
DBM_SUPREMUS_WHISPER_RUN_AWAY		= "Беги, Форест, беги!";

-- Shade of Akama
DBM_AKAMA_NAME						= "Тень Акамы";
DBM_AKAMA_DESCRIPTION				= nil;

DBM_AKAMA_MOB_AKAMA					= "Акама";
DBM_AKAMA_MOB_DEFENDER				= "Пеплоуст-защитник";
DBM_AKAMA_MOB_CHANNELER				= "Пеплоуст-чаротворец";
DBM_AKAMA_MOB_SORCERER				= "Пеплоуст-колдун";
DBM_AKAMA_MOB_DIES					= "%s умирает.";

DBM_AKAMA_WARN_CHANNELER_DOWN		= "**** %s/6 чаротворцев убито ****";
DBM_AKAMA_WARN_SORCERER_DOWN		= "**** %s колдунов убито ****";

-- Teron Gorefiend
DBM_GOREFIEND_NAME					= "Терон Кровожад";
DBM_GOREFIEND_DESCRIPTION			= "Объявлять Тень смерти и Испепеление.";

DBM_GOREFIEND_OPTION_INCINERATE		= "Объявлять Испепеление";

DBM_GOREFIEND_YELL_PULL				= "Мне отмщение!";

DBM_GOREFIEND_WARN_SOD				= "*** Тень смерти: >%s< ***";
DBM_GOREFIEND_WARN_INCINERATE		= "*** Испепеление: >%s< ***";

DBM_GOREFIEND_SPECWARN_SOD			= "Тень смерти";

-- Bloodboil
DBM_BLOODBOIL_NAME					= "Гуртогг Кипящая Кровь";
DBM_BLOODBOIL_DESCRIPTION			= "Объявлять Кипящую Кровь и Ярость Скверны.";
DBM_BLOODBOIL_OPTION_SMASH			= "Объявлять Удар по дуге";

DBM_BLOODBOIL_YELL_PULL				= "Орда тебя… сокрушит.";

DBM_BLOODBOIL_WARN_BLOODBOIL		= "*** Кипящая Кровь #%s ***";
DBM_BLOODBOIL_WARN_ENRAGE			= "*** Озверение через %s %s ***";
DBM_BLOODBOIL_WARN_FELRAGE_SOON		= "*** Ярость Скверны скоро ***";
DBM_BLOODBOIL_WARN_NORMAL_SOON		= "*** Обычная фаза через 5 сек ***";
DBM_BLOODBOIL_WARN_FELRAGE			= "*** Ярость Скверны на >%s< ***";
DBM_BLOODBOIL_WARN_NORMALPHASE		= "*** Обычная фаза ***";
DBM_BLOODBOIL_WARN_SMASH			= "*** Удар По Дуге ***";
DBM_BLOODBOIL_WARN_SMASH_SOON		= "*** Удар По Дуге скоро ***";

-- Essence (Reliquary) of Souls
DBM_SOULS_NAME						= "Воплощение Душ"
DBM_SOULS_DESCRIPTION				= "Объявляет Озверение, Fixate, Истощение Души, Рунный Щит, Deaden и Злобу."
DBM_SOULS_OPTION_DRAIN				= "Объявлять Истощение Души"
DBM_SOULS_OPTION_DRAIN_CAST			= "Объявлять каст Истощения Души (удобно для Массового Рассеивания)"
DBM_SOULS_OPTION_FIXATE				= "Объявлять Fixate"
DBM_SOULS_OPTION_SPITE				= "Объявлять Злобу"
DBM_SOULS_OPTION_SCREAM				= "Объявлять Крик Души"
DBM_SOULS_OPTION_SPECWARN_SPITE		= "Показывать спецпредупреждение, когда Вы поражены Злобой"
DBM_SOULS_OPTION_WHISPER_SPITE		= "Шептать целям Злобы"

DBM_SOULS_BOSS_SUFFERING			= "Воплощение страдания"
DBM_SOULS_BOSS_DESIRE				= "Воплощение желания"
DBM_SOULS_BOSS_KILL_NAME			= "Воплощение гнева"
DBM_SOULS_YELL_PULL					= "Лишь боль и страдания ждут тебя!" -- Essence of Suffering
DBM_SOULS_EMOTE_ENRAGE				= "%s впадает в ярость!"
DBM_SOULS_YELL_DESIRE				= "Можешь взять все, что желаешь… но не даром."
DBM_SOULS_YELL_DESIRE_DEMONIC		= "Shi shi rikk rukadare shi tichar kar x gular"
DBM_SOULS_DEBUFF_SPITE				= "([^%s]+) (%w+) поражен Злобой%."
DBM_SOULS_DEBUFF_SOULDRAIN			= "([^%s]+) (%w+) поражен Истощением Души%."
DBM_SOULS_DEBUFF_FIXATE				= "([^%s]+) (%w+) afflicted by Fixate%."
DBM_SOULS_YELL_ANGER_INC			= "Берегись, я жив!"

DBM_SOULS_WARN_ENRAGE_SOON			= "*** Озверение скоро ***"
DBM_SOULS_WARN_ENRAGE				= "*** Озверение ***"
DBM_SOULS_WARN_ENRAGE_OVER			= "*** Озверение закончилось ***"
DBM_SOULS_WARN_RUNESHIELD			= "*** Рунный Щит ***"
DBM_SOULS_WARN_RUNESHIELD_SOON		= "*** Рунный Щит через 3 сек ***"
DBM_SOULS_WARN_DEADEN				= "*** Deaden ****"
DBM_SOULS_WARN_DEADEN_SOON			= "*** Deaden in 5 sec ***"
DBM_SOULS_WARN_DESIRE_INC			= "*** Воплощение желания - Ноль маны через ~3 минуты ***"
DBM_SOULS_WARN_MANADRAIN			= "*** Ноль маны через 20 сек ***"
DBM_SOULS_WARN_SPITE				= "*** Злоба на %s ***"
DBM_SOULS_WARN_SOULDRAIN			= "*** Истощение Души на %s ***"
DBM_SOULS_WARN_SOULDRAIN_CAST		= "*** Истощение Души кастуется! ***"
DBM_SOULS_WARN_FIXATE				= "*** Fixate: >%s< ***"
DBM_SOULS_SPECWARN_FIXATE			= "Fixate!"
DBM_SOULS_WARN_SCREAM				= "*** Крик Души ***"
DBM_SOULS_SPECWARN_SPITE			= "Злоба"
DBM_SOULS_WARN_ANGER_INC			= "*** Воплощение гнева ***";
DBM_SOULS_WHISPER_SPITE				= "Злоба на Вас!"

-- Mother Shahraz
DBM_SHAHRAZ_NAME					= "Матушка Шахраз"
DBM_SHAHRAZ_DESCRIPTION				= "Обявляет Смертельное Притяжение, вешает метки и шепчет. Объявляет и показывает таймеры Лучей."
DBM_SHAHRAZ_OPTION_BEAM				= "Объявлять Лучи"
DBM_SHAHRAZ_OPTION_BEAM_SOON		= "Показывать предупреждение \"Луч скоро\" "

DBM_SHAHRAZ_YELL_PULL				= "Итак… дела или удовольствие?"

DBM_SHAHRAZ_WARN_ENRAGE				= "*** Озверение через %s %s ***"
DBM_SHAHRAZ_WARN_FA					= "*** Смертельное Притяжение на %s ***"
DBM_SHAHRAZ_SPECWARN_FA				= "Смертельное Притяжение"
DBM_SHAHRAZ_WHISPER_FA				= "Смертельное Притяжение на Вас!"
DBM_SHAHRAZ_WARN_BEAM_VILE			= "*** Ужасный Луч ***"
DBM_SHAHRAZ_WARN_BEAM_SINISTER		= "*** Зловещий Луч ***"
DBM_SHAHRAZ_WARN_BEAM_SINFUL		= "*** Греховный Луч ***"
DBM_SHAHRAZ_WARN_BEAM_WICKED		= "*** Злобный Луч ***"
DBM_SHAHRAZ_WARN_BEAM_SOON			= "*** Луч через 3 сек ***"

-- Illidari Council
DBM_COUNCIL_NAME					= "Совет Иллидари"
DBM_COUNCIL_DESCRIPTION				= "Объявляет Исцеляющий Круг, Смертельный Яд, Божественный Гнев, Исчезновение и Щиты."
DBM_COUNCIL_OPTION_COH				= "Объявлять Исцеляющий круг"
DBM_COUNCIL_OPTION_DP				= "Объявлять Смертельный Яд"
DBM_COUNCIL_OPTION_DW				= "Объявлять Божественный Гнев"
DBM_COUNCIL_OPTION_VANISH			= "Объявлять Исчезновение"
DBM_COUNCIL_OPTION_VANISHFADED		= "Предупреждать о завершении Исчезновения"
DBM_COUNCIL_OPTION_VANISHFADESOON	= "Предупреждать за 5 секунд до завершения Исчезновения"
DBM_COUNCIL_OPTION_SN				= "Объявлять Отражающий Щит"
DBM_COUNCIL_OPTION_SS				= "Объявлять Щит Защиты от магии"
DBM_COUNCIL_OPTION_SM				= "Объявлять Щит Защиты от физатак"
DBM_COUNCIL_OPTION_DEVAURA			= "Объявлять Ауру Благочестия"
DBM_COUNCIL_OPTION_RESAURA			= "Объявлять Ауру Защиты от Магии"

DBM_COUNCIL_MOB_GATHIOS				= "Гатиос Изувер"
DBM_COUNCIL_MOB_MALANDE				= "Леди Маланда"
DBM_COUNCIL_MOB_ZEREVOR				= "Верховный пустомант Зеревор"
DBM_COUNCIL_MOB_VERAS				= "Верас Глубокий Мрак"

DBM_COUNCIL_MOB_GATHIOS_EN			= "Gathios the Shatterer"
DBM_COUNCIL_MOB_MALANDE_EN			= "Lady Malande"
DBM_COUNCIL_MOB_ZEREVOR_EN			= "High Nethermancer Zerevor"
DBM_COUNCIL_MOB_VERAS_EN			= "Veras Darkshadow"

DBM_COUNCIL_YELL_PULL1				= "Общий – такой грубый язык… Вандаль!"
DBM_COUNCIL_YELL_PULL2				= "Желаешь проверить меня?"
DBM_COUNCIL_YELL_PULL3				= "У меня есть дела поважнее…"
DBM_COUNCIL_YELL_PULL4				= "Убегай или умри!"

DBM_COUNCIL_WARN_CAST_COH			= "Исцеляющий Круг"
DBM_COUNCIL_WARN_POISON				= "Смертельный Яд на >%s<"
DBM_COUNCIL_WARN_SHIELD_NORMAL		= "Отражающий Щит"
DBM_COUNCIL_WARN_SHIELD_SPELL		= "Защита от МАГИИ на %s"
DBM_COUNCIL_WARN_SHIELD_MELEE		= "Защита от ФИЗАТАК на %s"
DBM_COUNCIL_WARN_VANISH				= "Исчезновение"
DBM_COUNCIL_WARN_VANISH_FADED		= "Исчезновение закончилось"
DBM_COUNCIL_WARN_WRATH				= "Божественный Гнев на >%s<"
DBM_COUNCIL_WARN_AURA_DEV			= "Аура +20% брони"
DBM_COUNCIL_WARN_AURA_RES			= "Аура +250 защиты от магии"
DBM_COUNCIL_WARN_VANISHFADE_SOON	= "Исчезновение заканчивается через 5 сек"

-- Illidan Stormrage
DBM_ILLIDAN_NAME					= "Иллидан Ярость Бури"
DBM_ILLIDAN_DESCRIPTION				= "Объявление: Фазы, Срез, Паразиты, Барьер, Выжигающий взгляд, Пламенная боль, Теневые Демоны, Flame Burst и Озверение."
DBM_ILLIDAN_OPTION_RANGECHECK		= "Показывать рамку дистанции в фазе 3"
DBM_ILLIDAN_OPTION_PHASES			= "Объявлять фазы"
DBM_ILLIDAN_OPTION_SHEARCAST		= "Объявлять каст Среза"
DBM_ILLIDAN_OPTION_SHEAR			= "Объявлять Срез"
DBM_ILLIDAN_OPTION_SHADOWFIEND		= "Объявлять Тенедемонов"
DBM_ILLIDAN_OPTION_ICONFIEND		= "Вешать метку на цель Тенедемона"
DBM_ILLIDAN_OPTION_BARRAGE			= "Объявлять Темное Заграждение"
DBM_ILLIDAN_OPTION_BARRAGE_SOON		= "Показывать предупреждение \"Темное Заграждение скоро\" "
DBM_ILLIDAN_OPTION_EYEBEAM			= "Объявлять Выжигающий Взгляд"
DBM_ILLIDAN_OPTION_FLAMES			= "Объявлять Пламенная Боль"
DBM_ILLIDAN_OPTION_DEMONFORM		= "Объявлять фазы Демона/Обычную"
DBM_ILLIDAN_OPTION_FLAMEBURST		= "Объявлять Выброс Пламени"
DBM_ILLIDAN_OPTION_SHADOWDEMONS		= "Объявлять Теневых Демонов"
DBM_ILLIDAN_OPTION_EYEBEAMSOON		= "Показывать предупреждение \"Выжигающий Взгляд скоро\" "

DBM_ILLIDAN_YELL_PULL				= "Время пришло! Момент настал!"
DBM_ILLIDAN_YELL_EYEBEAM			= "Посмотри в глаза Предателя!"
DBM_ILLIDAN_YELL_DEMONFORM			= "Узрите мощь демона!"
DBM_ILLIDAN_YELL_PHASE4				= "Это все, смертные? Это и есть вся ваша ярость?"
DBM_ILLIDAN_MOB_FLAME				= "Пламя Аззинота"
DBM_ILLIDAN_SPELL_SHADOWDEMONS		= "Вызов теневых демонов"
DBM_ILLIDAN_SPELL_SHEAR				= "Срез"
DBM_ILLIDAN_YELL_START				= "Акама! Твое двуличие меня не удивляет. Мне давным-давно стоило уничтожить тебя и твоих уродливых собратьев."

DBM_ILLIDAN_WARN_SHEAR				= "Срез на >%s<"
DBM_ILLIDAN_WARN_SHADOWFIEND		= "Тенедемон на >%s<"
DBM_ILLIDAN_WARN_BARRAGE			= "Темное Заграждение на >%s<"
DBM_ILLIDAN_WARN_BARRAGE_SOON		= "Темное Заграждение скоро"
DBM_ILLIDAN_WARN_EYEBEAM			= "Выжигающий взгляд"
DBM_ILLIDAN_WARN_FLAMES				= "Пламенная Боль на %s"
DBM_ILLIDAN_WARN_PHASE2				= "Фаза 2"
DBM_ILLIDAN_WARN_PHASE3				= "Фаза 3"
DBM_ILLIDAN_WARN_PHASE4				= "Фаза 4"
DBM_ILLIDAN_WARN_PHASE_DEMON		= "Фаза Демона"
DBM_ILLIDAN_WARN_FLAMEBURST			= "Выброс Пламени #%s"
DBM_ILLIDAN_WARN_FLAMEBURST_SOON	= "Выброс Пламени скоро"
DBM_ILLIDAN_WARN_SHADOWDEMSSOON		= "Теневые Демоны скоро"
DBM_ILLIDAN_WARN_SHADOWDEMS			= "Теневые Демоны"
DBM_ILLIDAN_WARN_NORMALPHASE_SOON	= "Обычная фаза через 10 сек"
DBM_ILLIDAN_WARN_CASTSHEAR			= "Срез кастуется"
DBM_ILLIDAN_WARN_EYEBEAM_SOON		= "Выжигающий взгляд скоро"
DBM_ILLIDAN_WARN_PHASE_NORMAL		= "Обычная фаза"
DBM_ILLIDAN_WARN_DEMONPHASE_SOON	= "Фаза Демона через 10 сек"
DBM_ILLIDAN_WARN_SHADOWDEMSON		= "Теневые Демоны на %s"
DBM_ILLIDAN_STATUSMSG_PHASE2		= "Фаза 2"
DBM_ILLIDAN_WARN_PRISON				= "Темница Тьмы"
DBM_ILLIDAN_WARN_P4ENRAGE_SOON		= "Озверение через 5 sec"
DBM_ILLIDAN_WARN_P4ENRAGE_NOW		= "Озверение"
DBM_ILLIDAN_WARN_CAGED				= "Заточение"

DBM_ILLIDAN_SELFWARN_SHADOWFIEND	= "Паразитрующий Тенедемон"
DBM_ILLIDAN_SELFWARN_SHADOW			= "Пламенная боль"
DBM_ILLIDAN_SELFWARN_DEMONS			= "Теневой Демон"

DBM_SBT["Enrage2"]					= "Озверение" -- you cannot have two timers with the same id, so the 2nd enrage bar needs a "localization"
end