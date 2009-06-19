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
	YellPull	= "Обнаружены противники.",
	Emote		= "%%s преследуется (%S+)%"
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Преследуется >%s<!",
	warnNextPursueSoon	= "Смена цели через 5 сек"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Отсчет времени до Отключения системы",
	timerFlameVents			= "Отсчет времени до Огненного дыхания",
	timerPursued			= "Отсчет времени до Преследования",
	SystemOverload			= "Спец-предупреждение для Отключения системы",
	SpecialPursueWarnYou	= "Спец-предупреждение для Преследования",
	PursueWarn				= "Предупреждение для преследуемого игрока",
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
	SpecWarnJetsCast		= "Спец-предупреждение для Огненной струи (прерывание заклинаний)",
	TimerFlameJetsCast		= "Время действия заклинания Огненная струя",
	TimerFlameJetsCooldown	= "Отсчет времени до восстановления Огненной струи",
	TimerScorch				= "Отсчет времени до восстановления Ожога",
	TimerScorchCast			= "Время действия заклинания Ожог",
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
	SpecWarnDevouringFlame		= "Лавовая бомба - БЕГИТЕ!",
	warnTurretsReadySoon		= "Через 20 сек. гарпунные пушки будут собраны",
	warnTurretsReady		= "Гарпунные пушки собраны",
	SpecWarnDevouringFlameCast	= "Вы в лавовой бомбе",
	WarnDevouringFlameCast		= "В лавовой бомбе >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown	= "Следующее Огненное дыхание через",
	timerDeepBreathCast		= "Огненное дыхание",
	timerAllTurretsReady	= "Гарпунные пушки",
	timerTurret1			= "Гарпунная пушка 1",
	timerTurret2			= "Гарпунная пушка 2",
	timerTurret3			= "Гарпунная пушка 3",
	timerTurret4			= "Гарпунная пушка 4",
    timerGroundedTemp		= "на Земле"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Отсчет времени до следующего Огненного дыхани",
	timerDeepBreathCast		= "Время действия заклинания Огненное дыхание",
	SpecWarnDevouringFlame		= "Спец-предупреждение ноходящемуся в лавовой бомбе",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда под воздействием лавовой бомбы",
	timerAllTurretsReady		= "Отсчет времени до пушек",
	warnTurretsReadySoon		= "Отображать пред-предупреждение для пушек",
	warnTurretsReady			= "Предупреждение для пушек",
	SpecWarnDevouringFlameCast	= "Спец-предупреждение, когда вы в лавовой бомбе",
	timerTurret1				= "Отсчет времени до пушки 1",
	timerTurret2				= "Отсчет времени до пушки 2",
	timerTurret3				= "Отсчет времени до пушки 3 (Героический)",
	timerTurret4				= "Отсчет времени до пушки 4 (Героический)",
	OptionDevouringFlame		= "Объявлять цель под воздействием лавовой бомбы (неточно)",
    timerGroundedTemp		= "Отсчет времени до наземной фазы"
}

L:SetMiscLocalization{
	YellAir				= "Дайте время подготовить пушки.",
    YellAir2			= "Fires out! Let's rebuild those turrets!",
	YellGroundTemp			= "Быстрее! Сейчас она снова взлетит!",
	EmotePhase2			= "%%s обессилела и больше не может летать!",
	FlamecastUnknown		= "НЕИЗВЕСТНО"
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
	SpecialWarningLightBomb		= "Спец-предупреждение, когда Светлый взрыв на вас",
	WarningLightBomb			= "Объявлять Светлый взрыв",
	SpecialWarningGravityBomb	= "Спец-предупреждение, когда Гравитационная бомба на вас",
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
	WarningRuneofSummoning			= "Руна призыва",
	Overload				= "Перегрузка - БЕГИТЕ!",
    WarningStaticDisruption			= ">%s< под воздействием Статического сбоя"
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
	WarningSupercharge			= "Предупреждение для заклинания Суперзаряд",
	WarningChainlight			= "Объявлять Цепную молнию",
	TimerOverload				= "Отсчет времени до Перегрузки",
	TimerLightningWhirl			= "Отсчет времени до Вихря молний",
	LightningTendrils			= "Спец-предупреждение для Светящихся придатков",
	TimerLightningTendrils		= "Отображать время действия Светящихся придатков",
	PlaySoundLightningTendrils	= "Звуковой сигнал во время эффекта Светящиеся придатки",
	WarningFusionPunch			= "Объявлять Энергетический удар",
	timerFusionPunchCast		= "Отображать индикатор для Энергетического удара",
	timerFusionPunchActive		= "Отображать время действия Энергетический удар",
	WarningOverwhelmingPower	= "Объявлять Переполняющую энергию",
	timerOverwhelmingPower		= "Отсчет времени до Переполняющей энергии",
	SetIconOnOverwhelmingPower	= "Установить метку на цель под воздействием эффекта Переполняющая энергия",
	timerRunicBarrier			= "Отображать время действия Руническая преграда",
	WarningRuneofPower			= "Объявлять Руну мощи",
	WarningRuneofDeath			= "Объявлять Руну смерти",
	WarningRuneofSummoning			= "Объявлять Руну призыва",
	RuneofDeath					= "Спец-предупреждение для Руны смерти",
	timerRuneofDeath			= "Отображать время действия Руны смерти",
	SetIconOnStaticDisruption		= "Установить метку на цель под воздействием эффекта Статический сбой",
	Overload				= "Спец-предупреждение для Перегрузки",
	AllwaysWarnOnOverload			= "Объявлять когда Перегрузка (иначе, только когда нацеливание)",
    PlaySoundOnOverload			= "Звуковой сигнал во время Перегрузки",
	WarningStaticDisruption			= "Объявлять Статический сбой"
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
	NextCollapsingStar	= "Свернувшейся звезды"
}
L:SetWarningLocalization{
	WarningPhasePunch	= ">%s< под воздействием Фазового удара",
	WarningBlackHole	= "Черная дыра",
    WarningBigBang		= "Суровый удар",
	PreWarningBigBang	= "Суровый удар через ~10 сек",
}

L:SetOptionLocalization{
	SpecWarnPhasePunch	= "Спец-предупреждение, когда Фазовый удар на вас",
    WarningBigBang		= "Объявлять чтение заклинания Суровый удар",
	PreWarningBigBang	= "Объявлять Суровый удар",
	WarningPhasePunch	= "Объявлять цель под воздействием эффекта Фазовый удар",
	WarningBlackHole	= "Объявлять Чернаую дыру",
    NextCollapsingStar	= "Отсчет времени до Свернувшейся звезды"
}

L:SetMiscLocalization{
	YellPull		= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	Emote_CollapsingStars	= "%s призывает Свернувшуюся звезду!",
	Emote_CosmicSmash	= "%s читает заклинание Кара небесная!"
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
	timerRightArm			= "Возрождение правой руки",
	achievementDisarmed		= "Разоружение"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Спец-предупреждение, когда Сосредоточенный взгляд на ВАС",
	WarningEyebeam				= "Объявлять цель под воздействием эффекта Сосредоточенный взгляд",
	timerEyebeam				= "Отсчет времени до Сосредоточенного взгляда",
	timerPetrifyingBreath		= "Отсчет времени до Каменящего дыхания",
	timerNextShockwave			= "Отсчет времени до Ударной волны",
	timerLeftArm				= "Отсчет времени до Возрождения руки (левая)",
	timerRightArm				= "Отсчет времени до Возрождения руки (правая)",
	achievementDisarmed		= "Отсчет времени до приминения Разоружения",
    WarnGrip				= "Объявлять цели под воздействием Хватки смерти",
	WarnEyeBeam				= "Объявлять цель под воздействием Луча ока",
	SetIconOnGripTarget		= "Установить метку на цели под воздействием Хватки смерти"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!",
	Health_Body			= "Кологарн",
	Health_Right_Arm		= "Правая рука",
	Health_Left_Arm			= "Левая рука",
    FocusedEyebeam			= "%s сосредотачивает взгляд на вас!"
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
	SpecWarnVoid	= "Портал бездны - БЕГИТЕ!",
	WarnCatDied 	= "Дикий эащитник погибает (Осталось живых: %d)",
	WarnCatDiedOne 	= "Дикий эащитник погибает (Остался в живых 1)",
	WarnFear		= "Страх!",
	WarnFearSoon 	= "Скоро следующий Страх",
	WarnSonic		= "Звуковой визг!",
	WarnSwarm		= "Крадущийся страж на >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Спец-предупреждение когда применяет Удар часового",
	SpecWarnVoid	= "Спец-предупреждение находящемуся под воздействием Дикая сущность",
	WarnFear		= "Отображать предупреждение Страх",
	WarnFearSoon	= "Отображать предупреждение о следующем Страхе",
	WarnCatDied		= "Предупреждение, когда погибает дикий защитник",
	WarnSwarm		= "Предупреждение для крадущегося стража",
	WarnSonic		= "Отображать предупреждение визга",
    WarnCatDiedOne		= "Предупреждение, когда погибает кошка"
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
	WarningStormCloud	= ">%s< под Грозовой тучей", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Мгновенная заморозка",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Предупреждение для Мгновенной заморозки",
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при Мгновенной заморозке",
	WarningStormCloud	= "Объявлять цель под Грозовой тучей",
	YellOnStormCloud	= "Крикнуть, когда Грозовой туче активны",
	SetIconOnStormCloud	= "Установить метку на цель под Грозовой тучей"
}

L:SetMiscLocalization{
	YellKill		= "I... I am released from his grasp... at last.",
	YellCloud		= "Storm Cloud on me!"
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
	WarningLightningCharge	= "Разряд молнии",
	WarningBomb			= ">%s< под воздействием Взрыва руны",
	LightningOrb		= "Поражение громом на вас - БЕГИТЕ!"
}

L:SetTimerLocalization{
	TimerHardmode		= "Высокая сложность"
}

L:SetOptionLocalization{
	TimerHardmode			= "Отсчет времени для высокой сложности",
	WarningStormhammer		= "Объявлять Молот бури",
	WarningLightningCharge		= "Объявлять Разряд молнии",
	WarningPhase2			= "Объявлять фазу 2",
	UnbalancingStrike		= "Объявлять Дисбалансирующий удар",
	WarningBomb				= "Объявлять Взрыв руны",
	RangeFrame				= "Отображать окно допустимой дистанции",
	AnnounceFails			= "Объявлять игрока под разрядом молнии в рейд-чат (требуются права лидера или помощника)" 
}

L:SetMiscLocalization{
	YellPhase1		= "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2		= "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!",
	YellKill		= "Stay your arms! I yield!",
	ChargeOn		= "Разряд молнии: %s",
	Charge			= "Разряд не достал (в этот раз): %s" 
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
	YellKill	= "Он больше не властен надо мной. Мой взор снова ясен. Благодарю вас, герои."
}

L:SetWarningLocalization{
	WarnPhase2		= "Фаза 2",
	WarnSimulKill	= "Первый союзник погибает - воскрешение через 1 мин.",
	WarnFury		= ">%s< под воздействием Гнев природы",
	SpecWarnFury	= "Гнев природы на вас!",
	WarningTremor   = "Дрожание земли - остановите чтение заклинаний!",
	WarnRoots	= ">%s< в корнях",
	UnstableEnergy	= "Нестабильная энергия - БЕГИТЕ!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Луч солнца: %s",
	TimerSimulKill			= "Воскрешение",
	TimerFuryYou			= "Гнев природы на вас!"
}

L:SetOptionLocalization{
	WarnPhase2		= "Объявлять фазу 2",
	WarnSimulKill		= "Объявлять, когда первый монстр погибает",
	WarnFury		= "Объявлять цель под воздействием Гнев природы",
	WarnRoots		= "Объявлять цель под воздействием Железные корни",
	SpecWarnFury		= "Спец-предупреждение для Гнев природы",
	WarningTremor		= "Спец-предупреждение для Дрожание земли (высокая сложность)",
	TimerSimulKill		= "Отсчет времени до воскрешения монстров",
	UnstableEnergy		= "Спец-предупреждение для Нестабильная энергия"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Древни Фреи"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Спец-предупреждение для Каменного кулака",
    SpecWarnGroundTremor	= "Спец-предупреждение для Дрожания земли",
	PlaySoundOnFistOfStone	= "Воспроизводить звук для Каменного кулака",
	TrashRespawnTimer	= "Отсчет времени до повторного Дрожания земли"
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
	WarnShell			= ">%s< под зарядом напалма",
	WarnBlast			= ">%s< под взрывом плазмы",
	MagneticCore		= ">%s< под воздействием Магнитного ядра",
	WarningShockBlast	= "Шоковый удар - БЕГИТЕ!",
	WarnBombSpawn		= "Бомбот"
}

L:SetTimerLocalization{
	ProximityMines		= "Мины ближнего действия",
	TimerHardmode		= "Высокая сложность - Самоуничтожение",
    TimeToPhase2		= "Фаза 2",
	TimeToPhase3		= "Фаза 3",
	TimeToPhase4		= "Фаза 4"
}

L:SetOptionLocalization{
	DarkGlare		= "Отсчет времени для Лазерного заграждения",
	WarnBlast		= "Объявлять цель под воздействием Взрыва плазмы",
	WarnShell		= "Объявлять цель под воздействием Заряда напалма",
	TimeToPhase2		= "Отсчет времени для фазы 2",
	TimeToPhase3		= "Отсчет времени для фазы 3",
    TimeToPhase4			= "Отсчет времени для фазы 4",
	MagneticCore		= "Объявлять Магнитное ядро",
	HealthFramePhase4	= "Отображать индикатор здоровъя в фазе 4",
	AutoChangeLootToFFA	= "Автоподсветка добычи доступной для всех в фазе 3",
	WarnBombSpawn		= "Объявлять Бомботов",
	TimerHardmode		= "Отсчет времени для высокой сложности",
    PlaySoundOnShockBlast	= "Воспроизводить звук для Взрыва плазмы",
	PlaySoundOnDarkGlare	= "Воспроизводить звук для Лазерного заграждения",
	ShockBlastWarningInP1	= "Спец-предупреждение для Взрыва плазмы в фазе 1",
	ShockBlastWarningInP4	= "Спец-предупреждение для Взрыва плазмы в фазе 2"
}

L:SetMiscLocalization{
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
	YellPull		= "У нас мало времени, друзья!",
	YellHardPull	= "Now, why would you go and do something like that? Didn't you see the sign that said 'DO NOT PUSH THIS BUTTON!'? How will we finish testing with the self-destruct mechanism active?",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Генерал Везакс"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Саронитовые враги"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Темное сокрушение на вас!",
	SpecialWarningSurgeDarkness	= "Наплыв Тьмы",
	WarningShadowCrash			= ">%s< под воздействием Темного сокрушения",
	SpecialWarningShadowCrashNear	= "Темное сокрушение около вас!",
	WarningLeechLife		= ">%s< под воздействием Вытягивание жизни",
	SpecialWarningLLYou		= "Вытягивание жизни на вас!",
	SpecialWarningLLNear		= "%s около вас, под воздействием Вытягивание жизни!"
}

L:SetOptionLocalization{
	WarningShadowCrash			= "Предупреждение для Темного сокрушения",
	SetIconOnShadowCrash		= "Установить метку на цель под воздействием эффекта Темное сокрушение (череп)",
	SetIconOnLifeLeach			= "Установить метку на цель под воздействием эффекта Вытягивание жизни (крест)",
	SpecialWarningSurgeDarkness	= "Спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash	= "Спец-предупреждение для Темное сокрушение",
    SpecialWarningShadowCrashNear	= "Спец-предупреждение о Темном сокрушении, около вас",
	SpecialWarningLLYou		= "Спец-предупреждение, когда Вытягивание жизни на вас",
	SpecialWarningLLNear		= "Спец-предупреждение о Вытягивании жизни, около вас",
	CrashWhisper			= "Сообщить цели, под воздействием Темного сокрушения",
	YellOnLifeLeech			= "Крикнуть о воздействии Вытягивания жизни",
	YellOnShadowCrash		= "Крикнуть о воздействии Темного сокрушения",
	specWarnShadowCrashNear		= "Спец-предупреждение о Темном сокрушении, около вас",
    WarningLeechLife		= "Объявлять цель под воздействием Вытягивание жизни",
	hardmodeSpawn			= "Отсчет времени до появления Саронитовых врагов (высокая сложность)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "Облако саронитовых паров образовывается поблизости!",
	CrashWhisper			= "Темное сокрушение на вас - БЕГИТЕ!",
	YellLeech			= "Вытягивание жизни на мне!",
	YellCrash			= "Темное сокрушение на мне!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Йогг-Сарон"
}

L:SetMiscLocalization{
	YellPull = "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 = "I am the lucid dream.",
	Sara = "Сара",
	WhisperBrainLink = "Схожее мышление на вас! Бегите к %s!",
	WarningYellSqueeze	= "Выдавливание на мне! Помогите!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "Страж",
	WarningCrusherTentacleSpawned	= "Тяжелое щупальце",
	WarningP2 			= "Фаза 2",
	WarningBrainLink 		= ">%s< и >%s< под воздествием Схожего мышления!",
	SpecWarnBrainLink 		= "Вы и %s под воздествием Схожего мышления!",
	WarningSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnGuardianLow 		= "Прекратить нападение на Стражей!",
	WarnMadness			= "Доведение до помешательства",
	SpecWarnMadnessOutNow		= "Помешательство заканчивается - БЕГИТЕ!",
	WarnBrainPortalSoon		= "Портал через 3 сек.",	
	WarnSqueeze 			= "Выдавливание: >%s<",
	WarnFavor			= ">%s< под Рвением Сары",
	SpecWarnFavor			= "Рвение Сары на вас!"
}

L:SetTimerLocalization{
	NextPortal			= "Следующий портал"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "Объявлять появление стражей",
	WarningCrusherTentacleSpawned	= "Объявлять появление Тяжелого щупальца",
	WarningP2			= "Объявлять фазу 2",
	WarningP3			= "Объявлять фазу 3",
	WarningBrainLink		= "Объявлять Схожее мышление",
	SpecWarnBrainLink		= "Спец-предупреждение для Схожего мышления",
	WarningSanity			= "Предупреждение, когда Здравомыслие ослаблено",
	SpecWarnSanity			= "Спец-предупреждение, когда Здравомыслие очень ослаблено",
	SpecWarnGuardianLow		= "Спец-предупреждение, когда страж (Ф1) ослаблен (Для ДД)",
	WarnMadness			= "Объявлять Помешательство",
	WarnBrainPortalSoon		= "Объявлять портал",
	SpecWarnMadnessOutNow		= "Спец-предупреждение незадолго до окончания Помешательства",
	SetIconOnFearTarget		= "Установить метку на цель под Рвением Сары",
	WarnFavor			= "Объявлять цель под Рвением Сары",
	SpecWarnFavor			= "Спец-предупреждение для Рвения Сары",
	WarnSqueeze			= "Объявлять цель под воздействием Выдавливание",
	specWarnBrainPortalSoon		= "Объявлять Портал",
    WarningSqueeze			= "Объявлять цели Выдавливание",
	NextPortal			= "Отсчет времени до следующего портала",
	WhisperBrainLink		= "Сообщить цели, под воздействием Схожее мышление",
	SetIconOnFavorTarget		= "Установить метку на цель под воздействием Рвения Сары",
	SetIconOnMCTarget		= "Установить метку на цель под контролем над разумом",
	ShowSaraHealth			= "Показать здоровье Сары в фазе 1 (должна быть под прицелом хотябы одного игрока)"
}



