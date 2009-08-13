if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Нордскольские звери"
}

L:SetMiscLocalization{
	CombatStart			= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Charge				= "%%s глядит на (%S +) и испускает гортанный вой!"
}

L:SetOptionLocalization{
	WarningImpale			= "Предупреждение для Прокалывание",
	WarningFireBomb			= "Предупреждение для Зажигательная бомба",
	WarningBreath			= "Предупреждение для Арктическое дыхание",
	WarningSpray			= "Предупреждение для Парализующие брызги",
	WarningRage			= "Предупреждение для Бурлящая ярость",
	WarningCharge			= "Предупреждение для цели Рывка",
	WarningToxin			= "Предупреждение для цели Токсина",
	WarningBile			= "Предупреждение для цели Горящей Желчи",
	SpecialWarningImpale3		= "Спец-предупреждение для Прокалывание (>=3 стека)",
	SpecialWarningFireBomb		= "Спец-предупреждение, когда Зажигательная бомба на вас",
	SpecialWarningSlimePool		= "Спец-предупреждение для Лужа жижи",
	SpecialWarningSilence		= "Спец-предупреждение для Блок чар",
	SpecialWarningSpray		= "Спец-предупреждение, когда на Вас Парализующие брызги",
	SpecialWarningToxin		= "Спец-предупреждение, когда на Вас Паралитический токсин",
	SpecialWarningBile		= "Спец-предупреждение, когда на Вас Горящая желчь",
	SpecialWarningCharge		= "Спец-предупреждение, когда Айсхаул набрасываться на Вас",
	SpecialWarningChargeNear	= "Спец-предупреждение, когда Айсхаул набрасываться на кого-то рядом",
	SetIconOnChargeTarget		= "Помечать оконкой цель Рывка (череп)",
	SetIconOnBileTarget		= "Помечать иконкой игроков под Горящей Желчью"

}

L:SetWarningLocalization{
	WarningImpale			= "%s на >%s<",
	WarningFireBomb			= "Зажигательная бомба",
	WarningSpray			= "%s на >%s<",
	WarningBreath			= "Арктическое дыхание",
	WarningRage			= "Бурлящая ярость",
	WarningCharge			= "Рывок к >%s<",
	WarningToxin			= "Токсин на >%s<",
	WarningBile			= "Горящая Желчь на >%s<",
	SpecialWarningImpale3		= "Прокалывание на вас",
	SpecialWarningFireBomb		= "Зажигательная бомба на вас",
	SpecialWarningSlimePool		= "Кислотная Жижа, ОТОЙДИТЕ!",
	SpecialWarningSilence		= "Блок чар через 0.5 сек!",
	SpecialWarningSpray		= "Парализующие брызги на вас",
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
	WarnNetherPower			= "Сила Пустоты на Джараксусе! Рассейте немедленно!",
	WarnPortalSoon			= "Открываются Врата Пустоты!",
	WarnVolcanoSoon			= "Скоро Инфернальное извержение!",
	SpecWarnFlesh			= "Испепеление плоти на Вас!",
	SpecWarnTouch			= "Касание Джараксуса на Вас!",
	SpecWarnKiss			= "Поцелуй Любовницы",
	SpecWarnTouchNear		= ">%s<, около Вас, отмечен Касанием Джараксуса!",
	SpecWarnFlame			= "Пламя Легиона! БЕГИТЕ!",
	SpecWarnNetherPower		= "Рассейте заклинание!",
	SpecWarnFelInferno		= "Fel Inferno! БЕГИТЕ!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Пламя Легиона на Вас!",
}

L:SetOptionLocalization{
	WarnFlame			= "Предупреждение для Пламени Легиона",
	WarnTouch			= "Предупреждение для Касание Джараксуса",
	WarnNetherPower			= "Предупреждать когда Джараксус получает Силу Пустоты (для рассеивания/воровства бафа)",
	WarnPortalSoon			= "Предупреждать о раскрытии Втар Пустоты",
	WarnVolcanoSoon			= "Предупреждение о Инфернальном извержении",
	SpecWarnFlame			= "Спец-предупреждение, когда на Вас Пламя Легиона",
	SpecWarnFlesh			= "Спец-предупреждение, когда на Вас Испепеление плоти",
	SpecWarnTouch			= "Спец-предупреждение, когда на Вас Касание Джараксуса",
	SpecWarnTouchNear		= "Спец-предупреждение, когда на соседе Касание Джараксуса",
	SpecWarnKiss			= "Спец-предупреждение, когда на Вас Поцелуй Любовницы",
	SpecWarnNetherPower		= "Спец-предупреждение для Силы Пустоты (для рассеивания Джараксуса)",
	SpecWarnFelInferno		= "Спец-предупреждение, когда около Вас Fel Inferno",
	TouchJaraxxusIcon		= "Помечать иконкой игрока с Касанием Джараксуса(крест)",
	IncinerateFleshIcon		= "Помечать иконкой игрока с Испепелением плоти(череп)",
	LegionFlameIcon			= "Помечать иконкой игрока с Пламенем Легиона (квадрат)",
	LegionFlameWhisper		= "Посылать личное сообщение цели Пламени Легиона"
}
