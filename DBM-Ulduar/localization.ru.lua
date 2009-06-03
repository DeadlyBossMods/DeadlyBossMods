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
	SpecWarnDevouringFlame		= "Лавовая бомба - БЕГИТЕ!",
	warnTurretsReadySoon		= "Через 20 сек. гарпунные пушки будут собраны",
	warnTurretsReady		= "Гарпунные пушки собраны",
	SpecWarnDevouringFlameCast	= "Вы в лавовой бомбе",
	WarnDevouringFlameCast		= "В лавовой бомбе >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown	= "Следующее Огненное дыхание через",
	timerDeepBreathCast		= "Огненное дыхание",
	timerAllTurretsReady	= "Гарпунные пушки"
	timerTurret1			= "Гарпунная пушка 1",
	timerTurret2			= "Гарпунная пушка 2",
	timerTurret3			= "Гарпунная пушка 3",
	timerTurret4			= "Гарпунная пушка 4"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Отображать отсчет времени до следующего Огненного дыхани",
	timerDeepBreathCast		= "Отображать время действия заклинания Огненное дыхание",
	SpecWarnDevouringFlame		= "Отображать спец-предупреждение ноходящемуся в лавовой бомбе",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда под воздействием лавовой бомбы",
	timerAllTurretsReady		= "Отображать отсчет времени до пушек",
	warnTurretsReadySoon		= "Отображать пред-предупреждение для пушек",
	warnTurretsReady			= "Отображать предупреждение для пушек",
	SpecWarnDevouringFlameCast	= "Отображать спец-предупреждение, когда вы в лавовой бомбе",
	timerTurret1				= "Отображать отсчет времени до пушки 1",
	timerTurret2				= "Отображать отсчет времени до пушки 2",
	timerTurret3				= "Отображать отсчет времени до пушки 3 (Героический)",
	timerTurret4				= "Отображать отсчет времени до пушки 4 (Героический)",
	OptionDevouringFlame		= "Объявлять цель под воздействием лавовой бомбы (неточно)"
}

L:SetMiscLocalization{
	YellAir				= "Дайте время подготовить пушки.",
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
	WarningRuneofSummoning			= "Руна призыва",
	Overload				= "Перегрузка - БЕГИТЕ!"
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
	WarningRuneofSummoning			= "Объявлять Руну призыва",
	RuneofDeath					= "Отображать спец-предупреждение для Руны смерти",
	timerRuneofDeath			= "Отображать время действия Руны смерти",
	SetIconOnStaticDisruption		= "Установить метку на цель под воздействием эффекта Статический сбой",
	Overload				= "Отображать спец-предупреждение для Перегрузки",
	AllwaysWarnOnOverload			= "Объявлять когда Перегрузка (иначе, только когда нацеливание)"
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
	achievementDisarmed		= "Разоружение"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Отображать спец-предупреждение, когда Сосредоточенный взгляд на ВАС",
	WarningEyebeam				= "Объявлять цель под воздействием эффекта Сосредоточенный взгляд",
	timerEyebeam				= "Отображать отсчет времени до Сосредоточенного взгляда",
	timerPetrifyingBreath		= "Отображать отсчет времени до Каменящего дыхания",
	timerNextShockwave			= "Отображать отсчет времени до Ударной волны",
	timerLeftArm				= "Отображать отсчет времени до Возрождения руки (левая)",
	timerRightArm				= "Отображать отсчет времени до Возрождения руки (правая)"
	achievementDisarmed		= "Отображать отсчет времени до приминения Разоружения"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!",
	Health_Body			= "Кологарн",
	Health_Right_Arm		= "Правая рука",
	Health_Left_Arm			= "Левая рука"
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
	SpecWarnBlast	= "Отображать спец-предупреждение когда применяет Удар часового",
	SpecWarnVoid	= "Отображать спец-предупреждение находящемуся под воздействием Дикая сущность",
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
	WarningStormCloud	= ">%s< под Грозовой тучей", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Мгновенная заморозка",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Отображать отсчет времени до Мгновенной заморозки",
	WarningFlashFreeze	= "Отображать предупреждение для Мгновенной заморозки",
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
	TimerHardmode		= "Сложный режим"
}

L:SetOptionLocalization{
	TimerHardmode			= "Отображать отсчет времени для сложного режима",
	WarningStormhammer		= "Объявлять Молот бури",
	WarningLightningCharge		= "Объявлять Разряд молнии",
	WarningPhase2			= "Объявлять фазу 2",
	UnbalancingStrike		= "Объявлять Дисбалансирующий удар",
	WarningBomb				= "Объявлять Взрыв руны",
	RangeFrame				= "Отображать окно допустимой дистанции"
	AnnounceFails			= "Post player fails for Lightning Charge to the raid chat (requires announce enabled and promoted/leader status)" 
}

L:SetMiscLocalization{
	YellPhase1		= "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2		= "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!"
	YellKill		= "Stay your arms! I yield!",
	ChargeOn		= "Разряд молнии: %s",
	Charge			= "Разряд недостал (в этот раз): %s" 
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
	SpecWarnFury		= "Отображать спец-предупреждение для Гнев природы",
	WarningTremor		= "Отображать спец-предупреждение для Дрожание земли (высокая сложность)",
	TimerSimulKill		= "Отображать отсчет времени до воскрешения монстров",
	UnstableEnergy		= "Отображать спец-предупреждение для Нестабильная энергия"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Древни Фреи"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Отображать спец-предупреждение для Каменный кулак",
	WarnFistofStone		= "Объявлять Каменный кулак"
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
	WarningShockBlast	= "Шоковый удар - БЕГИТЕ!",
	WarnBombSpawn		= "Бомбот"
}

L:SetTimerLocalization{
	ProximityMines		= "Мины ближнего действия",
	TimerHardmode		= "Высокая сложность - Самоуничтожение"
}

L:SetOptionLocalization{
	DarkGlare		= "Отображать отсчет времени для Лазерного заграждения",
	WarningShockBlast	= "Отображать отсчет времени для Шокового удара",
	WarnBlast		= "Объявлять цель под воздействием Взрыва плазмы",
	WarnShell		= "Объявлять цель под воздействием Заряда напалма",
	TimeToPhase2		= "Фаза 2",
	TimeToPhase3		= "Фаза 3",
	MagneticCore		= "Объявлять Магнитное ядро",
	HealthFramePhase4	= "Отображать индикатор здоровъя в фазе 4",
	AutoChangeLootToFFA	= "Автоподсветка добычи доступной для всех в фазе 3",
	WarnBombSpawn		= "Объявлять Бомботов",
	TimerHardmode		= "Отображать отсчет времени для высокой сложности"
}

L:SetMiscLocalization{
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
	YellPull		= "У нас мало времени, друзья!",
	YellHardPull	= "Now why would you go and do something like that? Didn't you see the sign that said 'DO NOT PUSH THIS BUTTON!'? How will we finish testing with the self-destruct mechanism active?",
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
	hardmodeSpawn = "Саронитовын враги"
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
	WarningShadowCrash			= "Отображать предупреждение для Темного сокрушения",
	SetIconOnShadowCrash		= "Установить метку на цель под воздействием эффекта Темное сокрушение (череп)",
	SetIconOnLifeLeach			= "Установить метку на цель под воздействием эффекта Вытягивание жизни (крест)",
	SpecialWarningSurgeDarkness	= "Отображать спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash	= "Отображать спец-предупреждение для Темное сокрушение",
	SpecialWarningLLYou		= "Отображать спец-предупреждение, когда Вытягивание жизни на вас",
	SpecialWarningLLNear		= "Отображать спец-предупреждение о Вытягивании жизни, около вас",
	CrashWhisper			= "Сообщить цели, под воздействием Темного сокрушения",
	YellOnLifeLeech			= "Крикнуть о воздействии Вытягивания жизни",
	YellOnShadowCrash		= "Крикнуть о воздействии Темного сокрушения",
	specWarnShadowCrashNear		= "Отображать спец-предупреждение о Темном сокрушении, около вас"
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
	WarnFavor			= ">%s< под Благосклонностью Сары",
	SpecWarnFavor			= "Благосклонность Сары на вас!"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "Объявлять появление стражей",
	WarningCrusherTentacleSpawned	= "Объявлять появление Тяжелого щупальца",
	WarningP2			= "Объявлять фазу 2",
	WarningP3			= "Объявлять фазу 3",
	WarningBrainLink		= "Объявлять Схожее мышление",
	SpecWarnBrainLink		= "Отображать спец-предупреждение для Схожего мышления",
	WarningSanity			= "Отображать предупреждение, когда Здравомыслие ослаблено",
	SpecWarnSanity			= "Отображать спец-предупреждение, когда Здравомыслие очень ослаблено",
	SpecWarnGuardianLow		= "Отображать спец-предупреждение, когда страж (Ф1) ослаблен (Для ДД)",
	WarnMadness			= "Объявлять Помешательство",
	WarnBrainPortalSoon		= "Объявлять портал",
	SpecWarnMadnessOutNow		= "Отображать спец-предупреждение незадолго до окончания Помешательства"
	SetIconOnFearTarget		= "Установить метку на цель под Благосклонностью Сары",
	WarnFavor			= "Объявлять цель под Благосклонностью Сары",
	SpecWarnFavor			= "Отображать спец-предупреждение для Благосклонности Сары",
	WarnSqueeze			= "Объявлять цель под воздействием Выдавливание",
	specWarnBrainPortalSoon		= "Объявлять Портал"
}



