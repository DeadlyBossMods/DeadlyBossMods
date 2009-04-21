if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Огненный Левиафан"
}

L:SetTimerLocalization{
	timerPursued		= "Преследование: %s",
	timerFlameVents		= "Огненное дыхание",
	timerSystemOverload	= "Отключение системы"
}
	
L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s преследуется (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Преследуется >%s<!",
	warnNextPursueSoon	= "Смена цели через 5 сек."
}

L:SetOptionLocalization{
	timerSystemOverload		= "Отображать отсчет времени до Отключения системы",
	timerFlameVents			= "Отображать отсчет времени до Огненного дыхания",
	timerPursued			= "Отображать отсчет времени до Преследования",
	SystemOverload			= "Отображать спец-предупреждение для Отключения системы",
	SpecialPursueWarnYou	= "Отображать спец-предупреждение для Преследования",
	PursueWarn				= "Отображать предупреждение для преследуемого игрока",
	warnNextPursueSoon		= "Предупреждать перед следующим преследованием"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Повелитель Горнов Игнис"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Огненная струя",
	TimerFlameJetsCooldown	= "Следующая Огненная струя через",
	TimerScorch				= "Следующий Ожог через",
	TimerScorchCast			= "Ожог",
	TimerSlagPot			= "Шлаковый ковш: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= ">%s< в шлаковом ковше"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Отображать спец-предупреждение для заклинания Огненная струя (прерывано)",
	TimerFlameJetsCast		= "Отображать время действия заклинания Огненная струя",
	TimerFlameJetsCooldown	= "Отображать отсчет времени до восстановления Огненной струи",
	TimerScorch				= "Отображать отсчет времени до восстановления Ожога",
	TimerScorchCast			= "Отображать время действия заклинания Ожог",
	WarningSlagPot			= "Объявлять цель помещенную в шлаковый ковш",
	TimerSlagPot			= "Отображать время действия заклинания Шлаковый ковш"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Острокрылая"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Лавовая бомба - БЕГИТЕ!"
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Следующее Огненное дыхание через",
	timerDeepBreathCast			= "Огненное дыхание",
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Отображать отсчет времени до следующего Огненного дыхания",
	timerDeepBreathCast			= "Отображать время действия заклинания Огненное дыхание",
	SpecWarnDevouringFlame		= "Отображать спец-предупреждение ноходящемуся под плевком лавовой бомбы",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда под воздействием лавовой бомбы",
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Разрушитель XT-002"
}

L:SetTimerLocalization{
	timerTympanicTantrumCast	= "Раскаты ярости",
	timerTympanicTantrum		= "Раскаты ярости",
	timerLightBomb				= "Светлый взрыв: %s",
	timerGravityBomb			= "Гравитационная бомба: %s",
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Светлый взрыв на ВАС!",
	WarningLightBomb			= ">%s< под воздействием эффекта Светлый взрыв",
	SpecialWarningGravityBomb	= "Гравитационная бомба на ВАС!",
	WarningGravityBomb			= ">%s< под воздействием эффекта Гравитационная бомба",
}

L:SetOptionLocalization{
	timerTympanicTantrumCast	= "Отображать время действия эффекта Раскаты ярости",
	timerTympanicTantrum		= "Отображать радиус действия эффекта Раскаты ярости",
	SpecialWarningLightBomb		= "Отображать спец-предупреждение, когда Светлый взрыв на ВАС",
	WarningLightBomb			= "Объявлять Светлый взрыв",
	timerLightBomb				= "Отображать время действия эффекта Светлый взрыв",
	SpecialWarningGravityBomb	= "Отображать спец-предупреждение, когда Гравитационная бомба на ВАС",
	WarningGravityBomb			= "Объявлять Гравитационная бомба",
	timerGravityBomb			= "Отображать время действия эффекта Гравитационная бомба",
	PlaySoundOnGravityBomb		= "Звуковой сигнал, когда Гравитационная бомба на ВАС",
	PlaySoundOnTympanicTantrum	= "Звуковой сигнал во время эффекта Раскаты ярости",
	SetIconOnLightBombTarget	= "Установить метку на цель под воздействием эффекта Светлый взрыв",
	SetIconOnGravityBombTarget	= "Установить метку на цель под воздействием эффекта Гравитационная бомба",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Железное Собрание"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Суперзаряд",
	WarningChainlight			= "Цепная молния",
	WarningFusionPunch			= "Энергетический удар",
	WarningOverwhelmingPower	= ">%s< под воздействием эффекта Переполняющая энергия",
	WarningRuneofPower			= "Руна мощи",
	WarningRuneofDeath			= "Руна смерти",
	RuneofDeath					= "Руна смерти - БЕГИТЕ!",
	LightningTendrils			= "Светящиеся придатки - БЕГИТЕ!",
}

L:SetTimerLocalization{
	TimerSupercharge		= "Суперзаряд",
	TimerOverload			= "Перегрузка",
	TimerLightningWhirl		= "Вихрь молний",
	TimerLightningTendrils	= "Светящиеся придатки",
	timerFusionPunchCast	= "Энергетический удар cast",
	timerFusionPunchActive	= "Энергетический удар: %s",
	timerOverwhelmingPower	= "Переполняющая энергия: %s",
	timerRunicBarrier		= "Руническая преграда",
	timerRuneofDeath		= "Руна смерти",
}

L:SetOptionLocalization{
	TimerSupercharge			= "Отображать время действия эффекта Суперзаряд",
	WarningSupercharge			= "Отображать предупреждение для Суперзаряда",
	WarningChainlight			= "Объявлять Цепную молнию",
	TimerOverload				= "Отображать отсчет времени до Перегрузки",
	TimerLightningWhirl			= "Отображать отсчет времени до Вихря молний",
	LightningTendrils			= "Отображать спец-предупреждение для Светящихся придатков",
	TimerLightningTendrils		= "Отображать время действия Светящихся придатков",
	PlaySoundLightningTendrils	= "Звуковой сигнал во время эффекта Светящиеся придатки",
	WarningFusionPunch			= "Объявлять Энергетический удар",
	timerFusionPunchCast		= "Отображать индикатор для Энергетического удара",
	timerFusionPunchActive		= "Отображать время действия Энергетический удар",
	WarningOverwhelmingPower	= "Объявлять Переполняющую энергию",
	timerOverwhelmingPower		= "Отображать отсчет времени до Переполняющей энергии",
	SetIconOnOverwhelmingPower	= "Установить метку на цель под воздействием эффекта Переполняющая энергия",
	timerRunicBarrier			= "Отображать время действия Руническая преграда",
	WarningRuneofPower			= "Объявлять Руну мощи",
	WarningRuneofDeath			= "Объявлять Руну смерти",
	RuneofDeath					= "Отображать спец-предупреждение для Руны смерти",
	timerRuneofDeath			= "Отображать время действия Руны смерти",
}

L:SetMiscLocalization{
	Steelbreaker		= "Сталелом",
	RunemasterMolgeim	= "Мастер рун Молгейм",
	StormcallerBrundir 	= "Буревестник Брундир",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Алгалон Наблюдатель"
}

L:SetTimerLocalization{
	TimerBigBangCast	= "Суровый удар",
}
L:SetWarningLocalization{
	WarningPhasePunch	= ">%s< под воздействием эффекта Фазовый удар",
	WarningBlackHole	= "Черная дыра",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Отображать индикатор для Сурового удара",
	SpecWarnPhasePunch	= "Отображать спец-предупреждение, когда Фазовый удар на ВАС",
	WarningPhasePunch	= "Объявлять цель под воздействием эффекта Фазовый удар",
	WarningBlackHole	= "Объявлять Чернаую дыру",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Кологарн"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Сосредоточенный взгляд на ВАС - БЕГИТЕ!",
	WarningEyebeam			= ">%s< под воздействием эффекта Сосредоточенный взгляд"
}

L:SetTimerLocalization{
	timerEyebeam			= "Сосредоточенный взгляд: %s",
	timerPetrifyingBreath	= "Каменящее дыхание",
	timerNextShockwave		= "Следующая Ударная волна",
	timerLeftArm			= "Возрождение левой руки",
	timerRightArm			= "Возрождение правой руки"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Отображать спец-предупреждение, когда Сосредоточенный взгляд на ВАС",
	WarningEyebeam				= "Объявлять цель под воздействием эффекта Сосредоточенный взгляд",
	timerEyebeam				= "Отображать отсчет времени до Сосредоточенного взгляда",
	SetIconOnEyebeamTarget		= "Установить метку на цель под воздействием эффекта Сосредоточенный взгляд",
	timerPetrifyingBreath		= "Отображать отсчет времени до Каменящего дыхания",
	timerNextShockwave			= "Отображать отсчет времени до Ударной волны",
	timerLeftArm				= "Отображать отсчет времени до Возрождения руки (левая)",
	timerRightArm				= "Отображать отсчет времени до Возрождения руки (правая)"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Ауриайа"
}

L:SetMiscLocalization{
	Defender = "Дикий эащитник (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Удар часового - Прерывание!",
	WarnCatDied 	= "Дикий эащитник погибает (Осталось живых: %d)",
	WarnFear		= "Страх!",
	WarnFearSoon 	= "Скоро следующий Страх"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Отображать спец-предупреждение on Удар часового",
	WarnFear		= "Отображать предупреждение Страх",
	WarnFearSoon	= "Отображать предупреждение \"Скоро следующий Страх\"",
	WarnCatDied		= "Отображать предупреждение, когда погибает дикий защитник"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Ходир"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Мгновенная заморозка",
	WarningBitingCold	= "Лютый холод - БЕГИТЕ!"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Мгновенная заморозка",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Отображать отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Отображать предупреждение для Мгновенной заморозки",
}

L:SetMiscLocalization{
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при Мгновенной заморозке",
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Торим"
}

L:SetWarningLocalization{
	WarningStormhammer	= ">%s< под воздействием Молота бури",
	UnbalancingStrike	= ">%s< под воздействием Дисбалансирующего удара",
	WarningPhase2		= "Фаза 2",
	WarningBomb			= ">%s< под воздействием Взрыва руны",
	LightningOrb		= "Поражение громом на ВАС! БЕГИТЕ!!"
}

L:SetTimerLocalization{
	TimerStormhammer		= "Молот бури",
	TimerUnbalancingStrike	= "Дисбалансирующий удар",
	TimerHardmode		= "Сложный режим"
}

L:SetOptionLocalization{
	TimerStormhammer		= "Отображать восстановление Молота бури",
	TimerUnbalancingStrike	= "Отображать отсчет времени до Дисбалансирующий удар",
	TimerHardmode			= "Отображать отсчет времени до сложного режима",
	UnbalancingStrike		= "Объявлять цель под воздействием Дисбалансирующего удара",
	WarningStormhammer		= "Объявлять цель под воздействием Молота бури",
	WarningPhase2			= "Объявлять фазу 2",
	RangeFrame				= "Отображать окно допустимой дистанции"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Фрейа"
}

L:SetMiscLocalization{
	SpawnYell	= "Дети, помогите мне!",
	WaterSpirit	= "Древних духа воды",
	Snaplasher	= "Хватоплета",
	StormLasher	= "Грозовых плеточника",
	EmoteTree	= "???" -- /chatlog does not log messages with color codes...lol
}

L:SetWarningLocalization{
	WarnPhase2		= "Фаза 2",
	WarnSimulKill	= "Первый союзник погибает - воскрешение через 1 мин.",
	WarnFury		= ">%s< под воздействием ярости природы",
	SpecWarnFury	= "Ярость природы на ВАС!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Луч солнца: %s",
	TimerAlliesOfNature		= "Союзники природы",
	TimerSimulKill			= "Воскрешение",
	TimerFuryYou			= "Ярость природы на ВАС!"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Мимирон"
}

L:SetWarningLocalization{
	WarningPlasmaBlast	= "%s под воздействием Взрыва плазмы - лечите",
	Phase2Engaged		= "Фаза 2 - перегруппируйтесь",
	Phase3Engaged		= "Фаза 3 - перегруппируйтесь",
}

L:SetTimerLocalization{
	ProximityMines		= "Мины ближнего действия",
}

L:SetOptionLocalization{
	WarningShockBlast		= "Отображать предупреждение для Шокового удара",
	WarningPlasmaBlast		= "Отображать предупреждение для Взрыва плазмы",
	ProximityMines			= "Отображать отсчет времени до мин ближнего действия",
	PlaySoundOnShockBlast	= "Звуковой сигнал при Шоковом ударе",
}

L:SetMiscLocalization{
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Генерал Везакс"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Темное сокрушение на ВАС!",
	SpecialWarningSurgeDarkness	= "Наплыв Тьмы",
	WarningShadowCrash			= ">%s< под воздействием Темное сокрушение",
	specWarnLifeLeechYou		= "Кровопийца на ВАС!",
	specWarnLifeLeechNear		= "%s около вас, под воздействием Кровопийца!"
}

L:SetTimerLocalization{
	timerSearingFlamesCast		= "Жгучее пламя",
	timerSurgeofDarkness		= "Наплыв Тьмы",
	timerSaroniteVapors			= "Следующие Саронитовые пары"
}

L:SetOptionLocalization{
	WarningShadowCrash			= "Отображать предупреждение для Темное сокрушение",
	timerSearingFlamesCast		= "Отображать отсчет времени до Жгучего пламени",
	timerSurgeofDarkness		= "Отображать отсчет времени до Наплыва Тьмы",
	timerSaroniteVapors			= "Отображать отсчет времени до Саронитовых паров",
	SetIconOnShadowCrash		= "Установить метку на цель под воздействием эффекта Темное сокрушение (череп)",
	SetIconOnLifeLeach			= "Установить метку на цель под воздействием эффекта Кровопийца (крест)",
	SpecialWarningSurgeDarkness	= "Отображать спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash	= "Отображать спец-предупреждение для Темное сокрушение",
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "Облако саронитовых паров образовывается поблизости!",
	CrashWhisper			= "Темное сокрушение на ВАС! БЕГИТЕ!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Йогг-Сарон"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}




