if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Нордскольские Звери"
}

L:SetMiscLocalization{
	Charge			= "%%s смотрит на (%S+) и испускает гортанный вой!",
	CombatStart		= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Phase3			= "В воздухе повеяло ледяным дыханием следующего бойца: на арену выходит Ледяной Рев! Сражайтесь или погибните, чемпионы!",
	Gormok			= "Гормок Пронзающий Бивень",
	Acidmaw			= "Кислотная Утроба",
	Dreadscale		= "Жуткая Чешуя",
	Icehowl			= "Ледяной Рев"
}

L:SetOptionLocalization{
	WarningImpale			= "Предупреждение для Прокалывания",
	WarningFireBomb			= "Предупреждение для Зажигательной бомбы",
	WarningBreath			= "Предупреждение для Арктического дыхания",
--	WarningSpray			= "Предупреждение для Парализующих брызг",
	WarningRage			= "Предупреждение когда Айсхаул впадает в Бурлящую ярость",
	WarningCharge			= "Предупреждение для цели Топота",
	WarningToxin			= "Спец-предупреждение, для цели Паралитического токсина",
	WarningBile			= "Спец-предупреждение, для цели Горящей Желчи",
	SpecialWarningImpale3		= "Спец-предупреждение для Прокалывания",
	SpecialWarningFireBomb		= "Спец-предупреждение если на вас Зажигательная бомба",
	SpecialWarningSlimePool		= "Спец-предупреждение, если под вами Лужа жижи",
	SpecialWarningSilence		= "Спец-предупреждение для Сотрясающего топота",
	SpecialWarningSpray		= "Спец-предупреждение когда Вы попадаете под Парализующие брызги",
	SpecialWarningToxin		= "Спец-предупреждение, если на вас Паралитический токсин",
	SpecialWarningBile		= "Спец-предупреждение, когда на вас Горящея Желчь",
	SpecialWarningCharge		= "Спец-предупреждение, если Айсхаул хочет вас Растаптать",
	SpecialWarningChargeNear	= "Спец-предупреждение, если Айсхаул хочет кого рядом Растаптать",
	SetIconOnChargeTarget		= "Установить метку на цель Топота",
	SetIconOnBileTarget		= "Установить метку игроков под воздействием Горящей Желчью",
	PingCharge			= "Показать на миникарте место, куда попадает Ледяной Рев, если он избрал вас целью",
	ClearIconsOnIceHowl		= "Снимать все иконки перед Топотом",
	TimerNextBoss			= "Отсчет времени до появления следующего противника"
}

L:SetTimerLocalization{
	TimerNextBoss			= "Прибытие следующего босса"
}

L:SetWarningLocalization{
	WarningImpale			= "%s на >%s<",
	WarningFireBomb			= "Зажигательная бомба",
--	WarningSpray			= "%s на >%s<",
	WarningBreath			= "Арктическое дыхание",
	WarningRage			= "Бурлящая ярость",
	WarningCharge			= "Рывок к >%s<",
	WarningToxin			= "Токсин на >%s<",
	WarningBile			= "Горящая Желчь на >%s<",
	SpecialWarningImpale3		= "Прокалывание >%d< на вас!",
	SpecialWarningFireBomb		= "Зажигательная бомба на вас",
	SpecialWarningBile		= "Горящая Желчь на вас!",
	SpecialWarningSlimePool		= "Кислотная Жижа, Бегите!",
	SpecialWarningSilence		= "Блок чар через 2 сек!",
	SpecialWarningSpray		= "Парализующие брызги на вас",
	SpecialWarningToxin		= "Токсин на вас! Двигайтесь!",
	SpecialWarningCharge		= "Рывок к вам, Бегите!",
	SpecialWarningChargeNear	= "Рывок около вас, Бегите!"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Лорд Джараксус"
}

L:SetWarningLocalization{
	WarnFlame			= ">%s< под воздействием Пламени Легиона",
	WarnTouch			= "Касание Джараксуса на >%s<",
	WarnNetherPower			= "Сила Пустоты на Лорде Джараксусе! Рассейте немедленно!",
	WarnPortalSoon			= "Открываются Врата Пустоты!",
	WarnVolcanoSoon			= "Скоро Инфернальное извержение!",
	SpecWarnFlesh			= "Испепеление плоти на вас!",
	SpecWarnTouch			= "Касание Джараксуса на вас!",
	SpecWarnKiss			= "Поцелуй Госпожи",
	SpecWarnTouchNear		= ">%s<, около вас, отмечен Касанием Джараксуса!",
	SpecWarnFlame			= "Пламя Легиона! Бегите!",
	SpecWarnNetherPower		= "Рассейте заклинание!",
	SpecWarnFelInferno		= "Геенна скверны! Бегите!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Пламя Легиона на вас!",
}

L:SetOptionLocalization{
	WarnFlame			= "Предупреждение для Пламени легиона",
	WarnTouch			= "Предупреждать о Касании Джараксуса",
	WarnNetherPower			= "Предупреждать, когда Джараксус получает Силу пустоты",
	WarnPortalSoon			= "Предупреждать о открытии Врат пустоты",
	WarnVolcanoSoon			= "Предупреждать о Инфернальном извержении",
	SpecWarnFlame			= "Спец-предупреждение, когда на вас Пламя легиона",
	SpecWarnFlesh			= "Спец-предупреждение, когда на вас Испепеление плоти",
	SpecWarnTouch			= "Спец-предупреждение, когда на вас Касание Джараксуса",
	SpecWarnTouchNear		= "Спец-предупреждение, когда рядом с вами Касание Джараксуса",
	SpecWarnKiss			= "Спец-предупреждение, когда на вас Поцелуй Госпожи",
	SpecWarnNetherPower		= "Спец-предупреждение (для рассеивания) о Силе пустоты",
	SpecWarnFelInferno		= "Спец-предупреждение, если около вас Геена скверны",
	TouchJaraxxusIcon		= "Установить метку на цель с Касанием Джараксуса (крест)",
	IncinerateFleshIcon		= "Установить метку на игрока с Испепелением плоти (череп)",
	LegionFlameIcon			= "Установить метку на игрока с Пламенем легиона (квадрат)",
	LegionFlameWhisper		= "Посылать личное сообщение цели Пламени легиона"
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Чемпионы фракций"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnHellfire			= "Адское Пламя",
	SpecWarnHellfire		= "Адское Пламя! ОТОЙДИТЕ!"
}

L:SetMiscLocalization{
	Gorgrim				= "Горгрим Темный Раскол",		-- 34458
	Birana 				= "Бирана Штормовое Копыто",	-- 51
	Erin				= "Эрин Мглистое Копыто",		-- 59
	Rujkah				= "Руж'ка",				-- 48
	Ginselle			= "Гинзелль Отразительница Гнили",	-- 49
	Liandra				= "Лиандра Зовущая Солнце",		-- 45
	Malithas			= "Малитас Сияющий Клинок",		-- 56
	Caiphus				= "Каифа Неумолимый",		-- 47
	Vivienne			= "Вивьен Шепот Тьмы",		-- 41
	Mazdinah			= "Маз'дина",			-- 54
	Thrakgar			= "Тракгар",			-- 44
	Broln				= "Бролн Крепкий Рог",		-- 55
	Harkzog				= "Харкзог",			-- 50
	Narrhok				= "Наррок Крушитель Стали",		-- 53
	YellKill			= "Пустая и горькая победа. После сегодняшних потерь мы стали слабее как целое. Кто еще, кроме Короля-лича, выиграет от подобной глупости? Пали великие воины. И ради чего? Истинная опасность еще впереди – нас ждет битва с  Королем-личом."
} 

L:SetOptionLocalization{
	WarnHellfire			= "Предупреждать, когда Харкзок поддерживает Адское пламя",
	SpecWarnHellfire		= "Спец-предупреждение, когда вы получаете урон от Адского пламени"
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Валь'киры-близнецы"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "Следующая спец-способность"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Скоро спец-способность!",
	SpecWarnSpecial			= "Смена цвета!",
	SpecWarnEmpoweredDarkness	= "Могущественная Тьма",
	SpecWarnEmpoweredLight		= "Могущественный Свет",
	SpecWarnSwitchTarget		= "Смена цели!",
	SpecWarnKickNow			= "Пинок!",
	WarningTouchDebuff		= ">%s< под воздействем отрицательного эффекта",
	WarningPoweroftheTwins		= "Сила близнецов - на: >%s<",
	SpecWarnPoweroftheTwins		= "Сила близнецов!"
}

L:SetMiscLocalization{
	YellPull 			= "Во имя темного повелителя. Во имя Короля-лича. Вы. Умрете.",
	Fjola 				= "Фьола Погибель Света",
	Eydis				= "Эйдис Погибель Тьмы"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "Отсчет времени до перезарядки спец-способности",
	WarnSpecialSpellSoon		= "Предупреждать следующую спец-способность",
	SpecWarnSpecial			= "Спец-предупреждение для смены цветов",
	SpecWarnEmpoweredDarkness	= "Спец-предупреждение, когда на вас Могущественная тьма",
	SpecWarnEmpoweredLight		= "Спец-предупреждение, когда на вас Могущественный свет",
	SpecWarnSwitchTarget		= "Спец-предупреждение для других, когда босс читает заклинание",
	SpecWarnKickNow			= "Спец-предупреждение, когда вы должы прервать заклинание",
	SpecialWarnOnDebuff		= "Спец-предупреждение, когда отрицательный эфект",
	SetIconOnDebuffTarget		= "Установить метку на получившего отрицательный эффект (героический режим)",
	WarningTouchDebuff		= "Объявлять цели получившей отрицательный эффект",
	WarningPoweroftheTwins		= "Объявлять цель под влиянием Силы близнецов",
	SpecWarnPoweroftheTwins		= "Спец-предупреждение, когда на вас Сила близнецов"
}

------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "Ануб'арак"
}

L:SetTimerLocalization{
	TimerEmerge		= "Появление через",
	TimerSubmerge		= "Погружение через"
}

L:SetWarningLocalization{
	WarnEmerge		= "Ануб'арак погружается",
	WarnEmergeSoon		= "Появление через 10 сек",
	WarnSubmerge		= "Появляется Ануб'арак!",
	WarnSubmergeSoon	= "Погружение через 10 сек",
	WarnPursue		= "Шипы Ануб'арака преследуют >%s<",
	SpecWarnPursue		= "Вас приследуют!"
}

L:SetMiscLocalization{
	YellPull		= "Это место станет вашей могилой!",
	Swarm			= "%s выпускает рой жуков-трупоедов, чтобы восстановить здоровье!", -- x3
	Emerge			= "%s вылезает на поверхность!",
	Burrow			= "%s зарывается в землю!"
}

L:SetOptionLocalization{
	WarnEmerge		= "Предупреждение, для появления",
	WarnEmergeSoon		= "Предупреждать заранее о появлении",
	WarnSubmerge		= "Предупреждать о погружении",
	WarnSubmergeSoon	= "Предупреждать заранее о погружении",
	SpecWarnPursue		= "Спец-предупреждение, если вас преследуют",
	TimerEmerge		= "Отсчет времени до Появления",
	TimerSubmerge		= "Отсчет времени до погружения",
	PlaySoundOnPursue	= "Звуковой сигнал, если вас преследуют",
	PursueIcon		= "Установить метку на преследуемого",
	WarnPursue		= "Объявлять Преследуемого"
}






