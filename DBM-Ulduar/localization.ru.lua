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
	YellPull	= "Обнаружены противники. Запуск протокола оценки угрозы. Главная цель выявлена. Повторный анализ через 30 секунд.",
	Emote		= "%%s преследуется (%S+)%"
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Преследуется >%s<!",
	warnNextPursueSoon	= "Смена цели через 5 сек"
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
	WarningSlagPot			= ">%s< в шлаковом ковше",
	SpecWarnJetsCast		= "Огненная струя - остановите чтение заклинаний!"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Отображать спец-предупреждение для Огненной струи (прерывание заклинаний)",
	TimerFlameJetsCast		= "Отображать время действия заклинания Огненная струя",
	TimerFlameJetsCooldown	= "Отображать отсчет времени до восстановления Огненной струи",
	TimerScorch				= "Отображать отсчет времени до восстановления Ожога",
	TimerScorchCast			= "Отображать время действия заклинания Ожог",
	WarningSlagPot			= "Объявлять цель помещенную в шлаковый ковш",
	TimerSlagPot			= "Отображать время действия шлакового ковша",
	SlagPotIcon				= "Установить метку на цель в шлаковом ковше"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Острокрылая"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame	= "Лавовая бомба - БЕГИТЕ!",
	warnTurretsReadySoon	= "Через 20 сек. турели будут собраны",
	warnTurretsReady		= "Турели собраны",
}
L:SetTimerLocalization{
	timerDeepBreathCooldown	= "Следующее Огненное дыхание через",
	timerDeepBreathCast		= "Огненное дыхание",
	timerAllTurretsReady	= "Турели"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Отображать отсчет времени до следующего Огненного дыхани",
	timerDeepBreathCast			= "Отображать время действия заклинания Огненное дыхание",
	SpecWarnDevouringFlame		= "Отображать спец-предупреждение ноходящемуся под плевком лавовой бомбы",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда под воздействием лавовой бомбы",
	timerAllTurretsReady		= "Отображать отсчет времени до турелей",
	warnTurretsReadySoon		= "Отображать пред-предупреждение для турелей",
	warnTurretsReady			= "Отображать предупреждение для турелей",
}

L:SetMiscLocalization{
	YellAir = "Give us a moment to prepare to build the turrets."
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Разрушитель XT-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Светлый взрыв на ВАС!",
	WarningLightBomb			= ">%s< под воздействием Светлого взрыва",
	SpecialWarningGravityBomb	= "Гравитационная бомба на ВАС!",
	WarningGravityBomb			= ">%s< под воздействием Гравитационной бомбы",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Отображать спец-предупреждение, когда Светлый взрыв на вас",
	WarningLightBomb			= "Объявлять Светлый взрыв",
	SpecialWarningGravityBomb	= "Отображать спец-предупреждение, когда Гравитационная бомба на вас",
	WarningGravityBomb			= "Объявлять Гравитационная бомба",
	PlaySoundOnGravityBomb		= "Звуковой сигнал, когда Гравитационная бомба на вас",
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
	WarningOverwhelmingPower	= ">%s< под воздействием Переполняющей энергии",
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
	timerFusionPunchCast	= "Энергетический удар",
	timerFusionPunchActive	= "Энергетический удар: %s",
	timerOverwhelmingPower	= "Переполняющая энергия: %s",
	timerRunicBarrier		= "Руническая преграда",
	timerRuneofDeath		= "Руна смерти",
}

L:SetOptionLocalization{
	TimerSupercharge			= "Отображать время действия Суперзаряда",
	WarningSupercharge			= "Отображать предупреждение для заклинания Суперзаряд",
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
	WarningPhasePunch	= ">%s< под воздействием Фазового удара",
	WarningBlackHole	= "Черная дыра",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Отображать индикатор для Сурового удара",
	SpecWarnPhasePunch	= "Отображать спец-предупреждение, когда Фазовый удар на вас",
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
	SpecialWarningEyebeam	= "Сосредоточенный взгляд на вас - БЕГИТЕ!",
	WarningEyebeam			= ">%s< под сосредоточенным взглядом",
	WarnGrip				= ">%s< под воздействием Каменной хватки"
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
	Yell_Trigger_arm_left		= "Царапина...",
	Yell_Trigger_arm_right		= "Всего лишь плоть!"
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
	SpecWarnBlast	= "Удар часового - остановите чтение заклинаний!",
	WarnCatDied 	= "Дикий эащитник погибает (Осталось живых: %d)",
	WarnFear		= "Страх!",
	WarnFearSoon 	= "Скоро следующий Страх",
	WarnSonic		= "Звуковой визг!",
	WarnSwarm		= "Крадущийся страж на >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Отображать спец-предупреждение on Удар часового",
	WarnFear		= "Отображать предупреждение Страх",
	WarnFearSoon	= "Отображать предупреждение о следующем Страхе",
	WarnCatDied		= "Отображать предупреждение, когда погибает дикий защитник",
	WarnSwarm		= "Отображать предупреждение для крадущегося стража",
	WarnSonic		= "Отображать предупреждение визга"
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
	WarningBitingCold	= "Отображать предупреждение для Трескучего мороза",
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при Мгновенной заморозке"
}

L:SetMiscLocalization{
	
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
	LightningOrb		= "Поражение громом на вас - БЕГИТЕ!"
}

L:SetTimerLocalization{
	TimerStormhammer		= "Молот бури",
	TimerUnbalancingStrike	= "Дисбалансирующий удар",
	TimerHardmode		= "Сложный режим"
}

L:SetOptionLocalization{
	TimerStormhammer		= "Отображать отсчет времени до восстановления Молота бури",
	TimerUnbalancingStrike	= "Отображать отсчет времени до Дисбалансирующий удар",
	TimerHardmode			= "Отображать отсчет времени для сложного режима",
	UnbalancingStrike		= "Объявлять цель под воздействием Дисбалансирующего удара",
	WarningStormhammer		= "Объявлять цель под воздействием Молота бури",
	WarningPhase2			= "Объявлять фазу 2",
	UnbalancingStrike		= "Объявлять Дисбалансирующий удар",
	WarningBomb				= "Объявлять Взрыв руны",
	RangeFrame				= "Отображать окно допустимой дистанции"
}

L:SetMiscLocalization{
	YellPhase1		= "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2		= "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Фрейа"
}

L:SetMiscLocalization{
	SpawnYell	= "Помогите мне, дети мои!",
	WaterSpirit	= "Древний дух воды",
	Snaplasher	= "Хватоплет",
	StormLasher	= "Грозовой плеточник",
	EmoteTree	= "Дар Хранительницы жизни начинает расти!" -- /chatlog does not log messages with color codes...lol
}

L:SetWarningLocalization{
	WarnPhase2		= "Фаза 2",
	WarnSimulKill	= "Первый союзник погибает - воскрешение через 1 мин.",
	WarnFury		= ">%s< под воздействием ярости природы",
	SpecWarnFury	= "Ярость природы на вас!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Луч солнца: %s",
	TimerAlliesOfNature		= "Союзники природы",
	TimerSimulKill			= "Воскрешение",
	TimerFuryYou			= "Ярость природы на вас!"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Мимирон"
}

L:SetWarningLocalization{
	DarkGlare			= "Лазерное заграждение",
	WarningPlasmaBlast	= "%s под воздействием Взрыва плазмы - лечите!",
	Phase2Engaged		= "Фаза 2 - перегруппируйтесь!",
	Phase3Engaged		= "Фаза 3 - перегруппируйтес!",
	WarnShell			= ">%s< под зарядом напалма",
	WarnBlast			= ">%s< под взрывом плазмы",
	MagneticCore		= ">%s< под воздействием Магнитного ядра",
	WarningShockBlast	= "Шоковый удар - БЕГИТЕ!"
}

L:SetTimerLocalization{
	ProximityMines		= "Мины ближнего действия",
}

L:SetOptionLocalization{
	TimeToPhase2		= "Фаза 2",
	TimeToPhase3		= "Фаза 3",
	MagneticCore		= "Объявлять Магнитное ядро",
	HealthFramePhase4	= "Отображать индикатор здоровъя в фазе 4"
}

L:SetMiscLocalization{
	YellPull		= "У нас мало времени, друзья! Вы поможете испытать новейшее и величайшее из моих изобретений. И учтите: после того, что вы натворили с XT-002, отказываться просто некрасиво.",	
	YellPhase2		= "ПРЕВОСХОДНО! Просто восхитительный результат! Целостность обшивки – 98,9 процента! Почти что ни царапинки! Продолжаем!",
	YellPhase3		= "Спасибо, друзья! Благодаря вам я получил ценнейшие сведения! Так, а куда же я дел... – ах, вот куда.",
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Генерал Везакс"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Темное сокрушение на вас!",
	SpecialWarningSurgeDarkness	= "Наплыв Тьмы",
	WarningShadowCrash			= ">%s< под воздействием Темного сокрушения",
	SpecialWarningLLYou		= "Кровопийца на вас!",
	SpecialWarningLLNear		= "%s около вас, под воздействием Кровопийца!"
}

L:SetOptionLocalization{
	WarningShadowCrash			= "Отображать предупреждение для Темного сокрушения",
	SetIconOnShadowCrash		= "Установить метку на цель под воздействием эффекта Темное сокрушение (череп)",
	SetIconOnLifeLeach			= "Установить метку на цель под воздействием эффекта Кровопийца (крест)",
	SpecialWarningSurgeDarkness	= "Отображать спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash	= "Отображать спец-предупреждение для Темное сокрушение",
	SpecialWarningLLYou		= "Отображать спец-предупреждение, когда Кровопийца на вас",
	SpecialWarningLLNear		= "Отображать спец-предупреждение для Кровопийцы, около вас",
	CrashWhisper			= "Сообщить цели, под воздействием Темного сокрушения"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "Облако саронитовых паров образовывается поблизости!",
	CrashWhisper			= "Темное сокрушение на вас - БЕГИТЕ!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Йогг-Сарон"
}

L:SetMiscLocalization{
	YellPull = "Скоро мы сразимся с главарем этих извергов! Обратите гнев и ненависть против его прислужников!",
	YellPhase2 = "Я – это сон наяву.",
	Sara = "Сара",
	WhisperBrainLink = "Схожее мышление на вас! Бегите к %s!",
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "Страж",
	WarningP2 			= "Фаза 2",
	WarningBrainLink 		= ">%s< и >%s< под воздествием Схожего мышления!",
	SpecWarnBrainLink 		= "Вы и %s под воздествием Схожего мышления!",
	WarningSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnGuardianLow 		= "Прекратить нападение на Стражей!",
	WarnMadness			= "Доведение до помешательства",
	SpecWarnMadnessOutNow		= "Помешательство заканчивается - БЕГИТЕ!"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "Объявлять появление стражей",
	WarningP2			= "Объявлять Phase 2",
	WarningBrainLink		= "Объявлять Схожее мышление",
	SpecWarnBrainLink		= "Отображать спец-предупреждение для Схожего мышления",
	WarningSanity			= "Отображать предупреждение, когда Здравомыслие ослаблено",
	SpecWarnSanity			= "Отображать спец-предупреждение, когда Здравомыслие очень ослаблено",
	SpecWarnGuardianLow		= "Отображать спец-предупреждение, когда страж (Ф1) ослаблен (Для ДД)",
	WarnMadness			= "Объявлять Помешательство",
}	SpecWarnMadnessOutNow		= "Отображать спец-предупреждение незадолго до окончания Помешательства"



