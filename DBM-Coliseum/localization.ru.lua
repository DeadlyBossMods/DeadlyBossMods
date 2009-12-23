if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Чудовища Нордскола"
}

L:SetMiscLocalization{
	Charge		= "^%%s глядит на (%S+) и испускает гортанный вой!",
	CombatStart	= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Phase2		= "Приготовьтесь к схватке с близнецами-чудовищами, Кислотной Утробой и Жуткой Чешуей!",
	Phase3		= "В воздухе повеяло ледяным дыханием следующего бойца: на арену выходит Ледяной Рев! Сражайтесь или погибните, чемпионы!",
	Gormok		= "Гормок Пронзающий Бивень",
	Acidmaw		= "Кислотная Утроба",
	Dreadscale	= "Жуткая Чешуя",
	Icehowl		= "Ледяной Рев"
}

L:SetOptionLocalization{
	WarningSnobold				= "Предупреждение о призыве Снобольда-вассала",
	SpecialWarningImpale3		= "Спец-предупреждение для Прокалывания (>= 3 стаков)",
	SpecialWarningAnger3		= "Спец-предупреждение для Вскипающего гнева (>=3 стаков)",
	SpecialWarningFireBomb		= "Спец-предупреждение если на вас Зажигательная бомба",
	SpecialWarningSlimePool		= "Спец-предупреждение, если под вами Лужа жижи",
	SpecialWarningSilence		= "Спец-предупреждение для Сотрясающего топота (безмолвие)",
	SpecialWarningToxin			= "Спец-предупреждение, если на вас Паралитический токсин",
	SpecialWarningBile			= "Спец-предупреждение, когда на вас Горящая Желчь",
	SpecialWarningCharge		= "Спец-предупреждение, если Ледяной Рев хочет вас Растоптать",
	SpecialWarningTranq			= "Спец-предупреждение, когда Ледяной Рев получает Кипящую ярость (для усмирения)",
	PingCharge					= "Показать на миникарте место, куда попадает Ледяной Рев, если он избрал вас целью",
	SpecialWarningChargeNear	= "Спец-предупреждение, когда Ледяной Рев готовится сделать рывок на цель рядом с вами",
	SetIconOnChargeTarget		= "Установить метку на цель Топота (череп)",
	SetIconOnBileTarget			= "Установить метку на игроков под воздействием Горящей Желчи",
	ClearIconsOnIceHowl			= "Снимать все иконки перед Топотом",
	TimerNextBoss				= "Отсчет времени до появления следующего противника",
	TimerCombatStart			= "Отсчет времени до начала битвы",
	TimerEmerge					= "Show timer for emerge",
	TimerSubmerge				= "Show timer for submerge",
	RangeFrame                  = "Показывать окно допустимой дистанции в фазе 2"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Прибытие следующего босса",
	TimerCombatStart	= "Битва начнется через",
	TimerEmerge			= "Emerge",
	TimerSubmerge		= "Submerge"
}

L:SetWarningLocalization{
	WarningSnobold				= "Призыв снобольда-вассала",
	SpecialWarningImpale3		= "Прокалывание >%d< на вас",
	SpecialWarningAnger3		= "Вскипающий гнев >%d<",
	SpecialWarningFireBomb		= "Зажигательная бомба на вас",
	SpecialWarningSlimePool		= "Кислотная Жижа - отбегите",
	SpecialWarningSilence		= "Безмолвие через ~1.5 секунды!",
	SpecialWarningToxin			= "Паралитический токсин на вас - бегите",
	SpecialWarningCharge		= "Рывок к вам - бегите",
	SpecialWarningChargeNear	= "Рывок около вас - бегите",
	SpecialWarningBile			= "Горящая Желчь на вас",
	SpecialWarningTranq			= "Кипящая ярость - усмирите"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Лорд Джараксус"
}

L:SetWarningLocalization{
	WarnNetherPower				= "Сила Пустоты на Лорде Джараксусе - рассейте заклинание",
	SpecWarnFlesh				= "Испепеление плоти на вас",
	SpecWarnTouch				= "Касание Джараксуса на вас",
	SpecWarnKiss				= "Поцелуй Госпожи",
	SpecWarnTouchNear			= "Касание Джараксуса на |3-5(%s) около вас",
	SpecWarnFlame				= "Пламя Легиона - бегите",
	SpecWarnNetherPower			= "Рассейте заклинание",
	SpecWarnFelInferno			= "Геенна скверны - бегите",
	SpecWarnFelFireball			= "Огненный шар Скверны - прерывание",
	SpecWarnFelFireballDispel	= "Огненный шар Скверны на %s - рассейте заклинание"
}

L:SetMiscLocalization{
	WhisperFlame		= "Пламя Легиона на вас",
	IncinerateTarget	= "Испепеление плоти: %s"
}

L:SetOptionLocalization{
	WarnNetherPower				= "Предупреждение, когда Джараксус получает Силу пустоты",
	SpecWarnFlame				= "Спец-предупреждение, когда на вас Пламя легиона",
	SpecWarnFlesh				= "Спец-предупреждение, когда на вас Испепеление плоти",
	SpecWarnTouch				= "Спец-предупреждение, когда на вас Касание Джараксуса",
	SpecWarnTouchNear			= "Спец-предупреждение, когда рядом с вами Касание Джараксуса",
	SpecWarnKiss				= "Спец-предупреждение, когда на вас Поцелуй Госпожи",
	SpecWarnNetherPower			= "Спец-предупреждение (для рассеивания) о Силе пустоты",
	SpecWarnFelInferno			= "Спец-предупреждение, если около вас Геена скверны",
	SpecWarnFelFireball			= "Спец-предупреждение для Огненного шара Скверны (для прерывания)",
	SpecWarnFelFireballDispel	= "Спец-предупреждение, когда Огненный шар Скверны (для рассеивания)",
	TouchJaraxxusIcon			= "Установить метку на цель с Касанием Джараксуса",
	IncinerateFleshIcon			= "Установить метку на игрока с Испепелением плоти",
	LegionFlameIcon				= "Установить метку на игрока с Пламенем легиона",
	LegionFlameWhisper			= "Сообщить цели, под воздействием Пламени легиона",
	LegionFlameRunSound			= "Звуковой сигнал при Пламени легиона",
	IncinerateShieldFrame		= "Показать здоровье босса с индикатором здоровья для Испепеления плоти"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Чемпионы фракций"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecWarnHellfire		= "Адское Пламя - бегите",
	SpecWarnHandofProt		= "Длань защиты на %s",
	SpecWarnDivineShield	= "Божественный щит на %s",
	specWarnIceBlock       	= "Ледяная глыба на %s"
}

L:SetMiscLocalization{
	Gorgrim				= "Горгрим Темный Раскол <Рыцарь смерти>",	-- 34458
	Birana 				= "Бирана Штормовое Копыто <Друид>",		-- 34451
	Erin				= "Эрин Мглистое Копыто <Друид>",		-- 34459
	Rujkah				= "Руж'ка <Охотница>",				-- 34448
	Ginselle			= "Гинзелль Отразительница Гнили <Маг>",	-- 34449
	Liandra				= "Лиандра Зовущая Солнце <Паладин>",		-- 34445
	Malithas			= "Малитас Сияющий Клинок <Паладин>",		-- 34456
	Caiphus				= "Каифа Неумолимый <Жрец>",			-- 34447
	Vivienne			= "Вивьен Шепот Тьмы <Жрица>",			-- 34441
	Mazdinah			= "Маз'дина <Разбойница>",			-- 34454
	Thrakgar			= "Тракгар <Шаман>",				-- 34444
	Broln				= "Бролн Крепкий Рог <Шаман>",			-- 34455
	Harkzog				= "Харкзог <Чернокнижник>",			-- 34450
	Narrhok				= "Наррок Крушитель Стали <Воин>",		-- 34453
	Tyrius				= "Тирий Клинок Сумерек <Рыцарь смерти>",	-- 34461, Allience
 	Kavina				= "Кавина Песня Рощи <Друид>",			-- 34460, Allience
 	Melador				= "Меладор Дальний Гонец <Друид>",		-- 34469, Allience
 	Alyssia 			= "Алисса Лунопард <Охотница>",			-- 34467, Allience
 	Noozle				= "Нуззл Чудодей <Маг>",			-- 34468, Allience
 	Baelnor 			= "Бельнор Светоносный <Паладин>",		-- 34471, Allience
 	Velanaa				= "Веланаа <Паладин>", 				-- 34465, Allience
 	Anthar				= "Антар Очистительный Горн <Жрец>",		-- 34466, Allience
 	Brienna				= "Бриенна Приход Ночи <Жрица>",		-- 34473, Allience
 	Irieth				= "Ириэт Шаг Сквозь Тень <Разбойница>",		-- 34472, Allience
 	Saamul				= "Саамул <Шаман>", 				-- 34470, Allience
 	Shaabad				= "Шаабад <Шаман>", 				-- 34463, Allience
 	Serissa				= "Серисса Мрачная Кропильщица <Чернокнижница>",-- 34474, Allience
 	Shocuul				= "Шокул <Воин>",				-- 34475, Allience
	AllianceVictory		= "СЛАВА АЛЬЯНСУ!",
	HordeVictory		= "That was just a taste of what the future brings. FOR THE HORDE!",
	YellKill			= "Пустая и горькая победа. После сегодняшних потерь мы стали слабее как целое. Кто еще, кроме Короля-лича, выиграет от подобной глупости? Пали великие воины. И ради чего? Истинная опасность еще впереди – нас ждет битва с  Королем-личом."
} 

L:SetOptionLocalization{
	SpecWarnHellfire		= "Спец-предупреждение, когда вы получаете урон от Адского пламени",
	SpecWarnHandofProt		= "Спец-предупреждение, когда Паладин использует Длань защиты",
	SpecWarnDivineShield	= "Спец-предупреждение, когда Паладин использует Божественный щит",
	specWarnIceBlock		= "Спец-предупреждение, когда маг читает заклинание Ледяная глыба (для рассеивания)",
	PlaySoundOnBladestorm	= "Звуковой сигнал при Вихре клинков"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Валь'киры-близнецы"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Следующая спец-способность"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Скоро спец-способность",
	SpecWarnSpecial				= "Смена цвета",
	SpecWarnEmpoweredDarkness	= "Могущественная Тьма",
	SpecWarnEmpoweredLight		= "Могущественный Свет",
	SpecWarnSwitchTarget		= "Смена цели",
	SpecWarnKickNow				= "Прерывание",
	WarningTouchDebuff			= "Отрицательный эффект на |3-5(>%s<)",
	WarningPoweroftheTwins		= "Сила близнецов - больше исцеления на |3-3(>%s<)",
	SpecWarnPoweroftheTwins		= "Сила близнецов"
}

L:SetMiscLocalization{
	YellPull	= "Во имя темного повелителя. Во имя Короля-лича. Вы. Умрете.",
	Fjola		= "Фьола Погибель Света",
	Eydis		= "Эйдис Погибель Тьмы"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Отсчет времени до перезарядки спец-способности",
	WarnSpecialSpellSoon		= "Предупреждение о следующуюей спец-способность",
	SpecWarnSpecial				= "Спец-предупреждение для смены цветов",
	SpecWarnEmpoweredDarkness	= "Спец-предупреждение, когда на вас Могущественная тьма",
	SpecWarnEmpoweredLight		= "Спец-предупреждение, когда на вас Могущественный свет",
	SpecWarnSwitchTarget		= "Спец-предупреждение для других, когда босс читает заклинание",
	SpecWarnKickNow				= "Спец-предупреждение, когда вы должы прервать заклинание",
	SpecialWarnOnDebuff			= "Спец-предупреждение, когда отрицательный эффект",
	SetIconOnDebuffTarget		= "Установить метку на получившего отрицательный эффект (героический режим)",
	WarningTouchDebuff			= "Объявлять цели, получившие отрицательный эффект",
	WarningPoweroftheTwins		= "Объявлять цель под воздействем Силы близнецов",
	SpecWarnPoweroftheTwins		= "Спец-предупреждение, когда на вас Сила близнецов"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "Ануб'арак"
}

L:SetTimerLocalization{
	TimerEmerge				= "Появление через",
	TimerSubmerge			= "Зарывание через",
	timerAdds				= "Призыв помощников через"
}

L:SetWarningLocalization{
	WarnEmerge				= "Ануб'арак появляется",
	WarnEmergeSoon			= "Появление через 10 сек",
	WarnSubmerge			= "Ануб'арак зарывается",
	WarnSubmergeSoon		= "Зарывание через 10 сек",
	SpecWarnPursue			= "Вас преследуют - бегите",
	warnAdds				= "Помощники",
	SpecWarnShadowStrike	= "Теневой удар - прерывание",
	SpecWarnPCold			= "Пронизывающий холод на вас"	
}

L:SetMiscLocalization{
	YellPull			= "Это место станет вашей могилой!",
	Emerge				= "вылезает на поверхность!",
	Burrow				= "зарывается в землю!",
	PcoldIconSet		= "Метка холода {rt%d} установлена на |3-1(%s)",
	PcoldIconRemoved	= "Метка холода снята с |3-1(%s)"
}

L:SetOptionLocalization{
	WarnEmerge				= "Предупреждение о появлении",
	WarnEmergeSoon			= "Предупреждать заранее о появлении",
	WarnSubmerge			= "Предупреждение о погружении",
	WarnSubmergeSoon		= "Предупреждать заранее о погружении",
	SpecWarnPursue			= "Спец-предупреждение, когда вас преследуют",
	warnAdds				= "Предупреждение о призыве помощников",
	timerAdds				= "Отсчет времени до призыва помощников",
	TimerEmerge				= "Отсчет времени до появления",
	TimerSubmerge			= "Отсчет времени до погружения",
	PlaySoundOnPursue		= "Звуковой сигнал, если вас преследуют",
	PursueIcon				= "Установить метку на преследуемого",
	SpecWarnShadowStrike	= "Спец-предупреждение, когда Теневой удар (для прерывания)",
	SpecWarnPCold			= "Спец-предупреждение, когда на вас Пронизывающий холод",
	RemoveHealthBuffsInP3	= "Удалить усиления здоровья в начале фазы 3", 
	SetIconsOnPCold         = "Установить метки на цели под воздействием Пронизывающего холода",
	AnnouncePColdIcons		= "Объявлять в рейд-чат цели под воздействием Пронизывающего холода (требуются права лидера или помощника)"
}

