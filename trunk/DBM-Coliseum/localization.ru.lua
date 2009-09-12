-- The localizations are written by Мегерка, Гордунни EU
-- Перевод и адаптация - Мегерка, Гордунни EU

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
	Charge			= "%%s глядит на (%S+) и испускает гортанный вой!",
	CombatStart		= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Phase3			= "В воздухе повеяло ледяным дыханием следующего бойца: на арену выходит Ледяной Рев! Сражайтесь или погибните, чемпионы!",
	Gormok			= "Гормок Пронзающий Бивень",
	Acidmaw			= "Кислотная Утроба",
	Dreadscale		= "Жуткая Чешуя",
	Icehowl			= "Ледяной Рев"
}

L:SetOptionLocalization{
	WarningImpale			= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(67479, "Прокалывания"),
	WarningFireBomb			= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(66313, "Зажигательной бомбы"),
	WarningBreath			= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(66689, "Арктического дыхания"),
--	WarningSpray			= "Show warning for Paralytic Spray",
	WarningRage			= ("Предупреждение когда Айсхаул впадает в |cff71d5ff|Hspell:%d|h%s|h|r"):format(66759, "Бурлящую ярость"),
	WarningCharge			= ("Предупреждение для цели |cff71d5ff|Hspell:%d|h%s|h|r"):format(66734, "Топота"),
	WarningToxin			= ("Спец-предупреждение, для цели |cff71d5ff|Hspell:%d|h%s|h|r"):format(66823, "Паралитического токсина"),
	WarningBile			= ("Спец-предупреждение, для цели |cff71d5ff|Hspell:%d|h%s|h|r"):format(66869, "Горящей Желчи"),
	SpecialWarningImpale3		= ("Спец-предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(67479, "Прокалывания"),
	SpecialWarningFireBomb		= ("Спец-предупреждение если на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66313, "Зажигательная бомба"),
	SpecialWarningSlimePool		= ("Спец-предупреждение, если под Вами |cff71d5ff|Hspell:%d|h%s|h|r"):format(66883, "Лужа жижи"),
	SpecialWarningSilence		= ("Спец-предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(66330, "Сотрясающего топота"),
	SpecialWarningSpray		= ("Спец-предупреждение когда Вы попадаете под |cff71d5ff|Hspell:%d|h%s|h|r"):format(66901, "Парализующие брызги"),
	SpecialWarningToxin		= ("Спец-предупреждение, если на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66823, "Паралитический токсин"),
	SpecialWarningBile		= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66869, "Горящея Желчь"),
	SpecialWarningCharge		= ("Спец-предупреждение, если Айсхаул хочет Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66734, "Растаптать"),
	SpecialWarningChargeNear	= ("Спец-предупреждение, если Айсхаул хочет кого рядом |cff71d5ff|Hspell:%d|h%s|h|r"):format(66734, "Растаптать"),
	SetIconOnChargeTarget		= ("Помечать иконкой (череп) цель |cff71d5ff|Hspell:%d|h%s|h|r"):format(66734, "Топота"),
	SetIconOnBileTarget		= ("Помечать иконкой игроков под |cff71d5ff|Hspell:%d|h%s|h|r"):format(66869, "Горящей Желчью"),
	PingCharge			= "Показать на миникарте место, куда попадает Ледяной Рев, если он избрал Вас целью",
	ClearIconsOnIceHowl		= ("Снимать все иконки перед |cff71d5ff|Hspell:%d|h%s|h|r"):format(66734, "Топотом"),
	TimerNextBoss			= "Показать таймер появления следующего противника"
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
	SpecialWarningImpale3		= "Прокалывание >%d< на Вас!",
	SpecialWarningFireBomb		= "Зажигательная бомба на Вас",
	SpecialWarningBile		= "Горящая Желчь на Вас!",
	SpecialWarningSlimePool		= "Кислотная Жижа, ОТОЙДИТЕ!",
	SpecialWarningSilence		= "Блок чар через 2 сек!",
	SpecialWarningSpray		= "Парализующие брызги на Вас",
	SpecialWarningToxin		= "Токсин на Вас! Двигайтесь!",
	SpecialWarningCharge		= "Рывок к вам, БЕГИТЕ!",
	SpecialWarningChargeNear	= "Рывок около Вас, БЕГИТЕ!"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Лорд Джараксус"
}

L:SetWarningLocalization{
	WarnFlame			= "Пламя Легиона на >%s<",
	WarnTouch			= "Касание Джараксуса на >%s<",
	WarnNetherPower			= "Сила Пустоты на Лорде Джараксусе! Рассейте немедленно!",
	WarnPortalSoon			= "Открываются Врата Пустоты!",
	WarnVolcanoSoon			= "Скоро Инфернальное извержение!",
	SpecWarnFlesh			= "Испепеление плоти на Вас!",
	SpecWarnTouch			= "Касание Джараксуса на Вас!",
	SpecWarnKiss			= "Поцелуй Госпожи",
	SpecWarnTouchNear		= ">%s<, около Вас, отмечен Касанием Джараксуса!",
	SpecWarnFlame			= "Пламя Легиона! БЕГИТЕ!",
	SpecWarnNetherPower		= "Рассейте заклинание!",
	SpecWarnFelInferno		= "Геенна скверны! ОТОЙДИТЕ!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Пламя Легиона на Вас!",
}

L:SetOptionLocalization{
	WarnFlame			= ("Предупреждение для |cff71d5ff|Hspell:%d|h%s|h|r"):format(68124, "Пламени легиона"),
	WarnTouch			= ("Предупреждать о |cff71d5ff|Hspell:%d|h%s|h|r"):format(66209, "Касании Джараксуса"),
	WarnNetherPower			= ("Предупреждать, когда Джараксус получает |cff71d5ff|Hspell:%d|h%s|h|r"):format(67108, "Силу пустоты"),
	WarnPortalSoon			= ("Предупреждать о раскрытии |cff71d5ff|Hspell:%d|h%s|h|r"):format(66264, "Врат пустоты"),
	WarnVolcanoSoon			= ("Предупреждать о |cff71d5ff|Hspell:%d|h%s|h|r"):format(66258, "Инфернальном извержении"),
	SpecWarnFlame			= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(68124, "Пламя легиона"),
	SpecWarnFlesh			= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66237, "Испепеление плоти"),
	SpecWarnTouch			= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(66209, "Касание Джараксуса"),
	SpecWarnTouchNear		= ("Спец-предупреждение, когда рядом с Вами |cff71d5ff|Hspell:%d|h%s|h|r"):format(66209, "Касание Джараксуса"),
	SpecWarnKiss			= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(67075, "Поцелуй Госпожи"),
	SpecWarnNetherPower		= ("Спец-предупреждение (для рассеивания) о |cff71d5ff|Hspell:%d|h%s|h|r"):format(67108, "Силе пустоты"),
	SpecWarnFelInferno		= ("Спец-предупреждение, если около Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(67047, "Геена скверны"),
	TouchJaraxxusIcon		= ("Помечать иконкой (крест) игрока с |cff71d5ff|Hspell:%d|h%s|h|r"):format(66209, "Касанием Джараксуса"),
	IncinerateFleshIcon		= ("Помечать иконкой (череп) игрока с |cff71d5ff|Hspell:%d|h%s|h|r"):format(66237, "Испепелением плоти"),
	LegionFlameIcon			= ("Помечать иконкой (квадрат) игрока с |cff71d5ff|Hspell:%d|h%s|h|r"):format(68124, "Пламенем легиона"),
	LegionFlameWhisper		= ("Посылать личное сообщение цели |cff71d5ff|Hspell:%d|h%s|h|r"):format(68124, "Пламени легиона")
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
	WarnHellfire			= ("Предупреждать, когда Харкзок поддерживает |cff71d5ff|Hspell:%d|h%s|h|r"):format(65816, "Адское пламя"),
	SpecWarnHellfire		= ("Спец-предупреждение, когда Вы получаете урон от |cff71d5ff|Hspell:%d|h%s|h|r"):format(65816, "Адского пламени")
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
	SpecWarnEmpoweredLight		= "Могущественный Свет"
}

L:SetMiscLocalization{
	YellPull 			= "Во имя темного повелителя. Во имя Короля-лича. Вы. Умрете.",
	Fjola 				= "Фьола Погибель Света",
	Eydis				= "Эйдис Погибель Тьмы"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "Показать таймер перезарядки спец-способности",
	WarnSpecialSpellSoon		= "Предупреждать следующую спец-способность",
	SpecWarnSpecial			= "Спецпредупреждение для смены цветов",
	SpecWarnEmpoweredDarkness	= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(65724, "Могущественная тьма"),
	SpecWarnEmpoweredLight		= ("Спец-предупреждение, когда на Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(65748, "Могущественный свет"),
--Плеть не остановить...
}

------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "Ануб'арак"
}

L:SetTimerLocalization{
	TimerEmerge		= "Появление",
	TimerSubmerge		= "Погружение"
}

L:SetWarningLocalization{
	WarnEmerge		= "Ануб'арак погружается",
	WarnEmergeSoon		= "Появление через 10 сек",
	WarnSubmerge		= "Появляется Ануб'арак!",
	WarnSubmergeSoon	= "Погружение через 10 сек",
	WarnPursue		= "Шипы Ануб'арака преследуют >%s<",
	SpecWarnPursue		= "ВАС ПРЕСЛЕДУЮТ!"
}

L:SetMiscLocalization{
	YellPull		= "Это место станет вашей могилой!",
	Swarm			= "%s выпускает рой жуков-трупоедов, чтобы восстановить здоровье!", -- x3
	Emerge			= "%s вылезает на поверхность!",
	Burrow			= "%s зарывается в землю!"
}

L:SetOptionLocalization{
	WarnEmerge		= "Спецпредупреждение, для Появления",
	WarnEmergeSoon		= "Предупреждать о Появлении заранее",
	WarnSubmerge		= ("Предупреждать о |cff71d5ff|Hspell:%d|h%s|h|r"):format(67322, "Погружении"),
	WarnSubmergeSoon	= ("Предупреждать заранее о |cff71d5ff|Hspell:%d|h%s|h|r"):format(67322, "Погружении"),
	SpecWarnPursue		= ("Спец-предупреждение, если Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(67574, "Преследуют"),
	TimerEmerge		= "Показать таймер для Появления",
	TimerSubmerge		= ("Показать таймер до |cff71d5ff|Hspell:%d|h%s|h|r"):format(67322, "Погружения"),
	PlaySoundOnPursue	= ("Проиграть звук, если Вас |cff71d5ff|Hspell:%d|h%s|h|r"):format(67574, "Преследуют"),
	PursueIcon		= ("Помечать иконкой |cff71d5ff|Hspell:%d|h%s|h|r"):format(67574, "Преследуемого"),
	WarnPursue		= ("Объявлять |cff71d5ff|Hspell:%d|h%s|h|r"):format(67574, "Преследуемого")
}

--Ануб'арак выпускает рой жуков-трупоедов, чтобы восстановить здоровье!

--Ануб'арак кричит: Я подвел тебя, господин...
--Верховный лорд Тирион Фордринг кричит: Чемпионы, вы выстояли в этом поединке! Вы не только прошли все испытания, но и бросили вызов самому Артасу, расстроив его зловещие планы! Ваши умения и сила послужат нам отличным подспорьем в бою против Плети! Отличная работа! Позвольте одному из магов Авангарда отправить вас обратно на поверхность.
--Ануб'арак кричит: Ауум на-л ак-к-к-к, ишшш. Вставайте, слуги мои. Время пожирать...
