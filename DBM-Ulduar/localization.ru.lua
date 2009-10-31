if GetLocale() ~= "ruRU" then return end

local L


-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Огненный Левиафан"
}

L:SetTimerLocalization{
	timerPursued			= "Преследование: %s",
	timerFlameVents			= "Огненное дыхание",
	timerSystemOverload		= "Отключение системы"
}
	
L:SetMiscLocalization{
	YellPull			= "Обнаружены противники. Запуск протокола оценки угрозы. Главная цель выявлена. Повторный анализ через 30 секунд.",
	Emote				= "%%s наводится на (%S+)%"
}

L:SetWarningLocalization{
	pursueWarn			= "Преследуется >%s<",
	warnNextPursueSoon		= "Смена цели через 5 секунд",
	SpecialPursueWarnYou		= "Преследует вас",
	SystemOverload			= "Отключение системы",
	warnWardofLife			= "Призыв Защитника жизни",
	warnWrithingLasher		= "Призыв Змеящегося плеточника"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Отсчет времени до Отключения системы",
	timerFlameVents			= "Отсчет времени до Огненного дыхания",
	timerPursued			= "Отсчет времени до Преследования",
	SystemOverload			= "Спец-предупреждение для Отключения системы",
	SpecialPursueWarnYou		= "Спец-предупреждение для Преследования",
	PursueWarn			= "Предупреждение для преследуемого игрока",
	warnNextPursueSoon		= "Предупреждать перед следующим преследованием",
	warnWardofLife			= "Спец-предупреждение для призыва Защитника жизни",
	warnWrithingLasher		= "Спец-предупреждение для призыва Змеящегося плеточника"
}


--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Повелитель Горнов Игнис"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Огненная струя",
	TimerFlameJetsCooldown		= "Огненная струя через",
	TimerScorch			= "Ожог через",
	TimerScorchCast			= "Ожог",
	TimerSlagPot			= "Шлаковый ковш: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= ">%s< в шлаковом ковше",
	SpecWarnJetsCast		= "Огненная струя - прекратите чтение заклинаний"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Спец-предупреждение для Огненной струи",
	TimerFlameJetsCast		= "Время действия заклинания Огненная струя",
	TimerFlameJetsCooldown		= "Отсчет времени до восстановления Огненной струи",
	TimerScorch			= "Отсчет времени до восстановления Ожога",
	TimerScorchCast			= "Время действия заклинания Ожог",
	WarningSlagPot			= "Объявлять цель помещенную в шлаковый ковш",
	TimerSlagPot			= "Отображать время действия шлакового ковша",
	SlagPotIcon			= "Установить метку на цель в шлаковом ковше"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Острокрылая"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Лавовая бомба - бегите",
	warnTurretsReadySoon		= "Через 20 секунд гарпунные пушки будут собраны",
	warnTurretsReady		= "Гарпунные пушки собраны",
	SpecWarnDevouringFlameCast	= "Вы в лавовой бомбе",
	WarnDevouringFlameCast		= "В лавовой бомбе >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Следующее Огненное дыхание через",
	timerDeepBreathCast		= "Огненное дыхание",
	timerAllTurretsReady		= "Гарпунные пушки",
	timerTurret1			= "Гарпунная пушка 1",
	timerTurret2			= "Гарпунная пушка 2",
	timerTurret3			= "Гарпунная пушка 3",
	timerTurret4			= "Гарпунная пушка 4",
	timerGroundedTemp		= "на земле"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Отсчет времени до перезарядки Огненного дыхани",
	timerDeepBreathCast		= "Время действия заклинания Огненное дыхание",
	SpecWarnDevouringFlame		= "Спец-предупреждение ноходящемуся в Лавовой бомбе",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда вы под воздействием Лавовой бомбы",
	timerAllTurretsReady		= "Отсчет времени до пушек",
	warnTurretsReadySoon		= "Отображать пред-предупреждение для пушек",
	warnTurretsReady		= "Предупреждение для пушек",
	SpecWarnDevouringFlameCast	= "Спец-предупреждение, когда вы в лавовой бомбе",
	timerTurret1			= "Отсчет времени до пушки 1",
	timerTurret2			= "Отсчет времени до пушки 2",
	timerTurret3			= "Отсчет времени до пушки 3 (Героический)",
	timerTurret4			= "Отсчет времени до пушки 4 (Героический)",
	OptionDevouringFlame		= "Объявлять цель под воздействием лавовой бомбы (неточно)",
	timerGroundedTemp		= "Отсчет времени до наземной фазы"
}

L:SetMiscLocalization{
	YellAir			= "Дайте время подготовить пушки.",
	YellAir2		= "Fires out! Let's rebuild those turrets!",
	YellGroundTemp		= "Быстрее! Сейчас она снова взлетит!",
	EmotePhase2		= "%%s обессилела и больше не может летать!",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}


----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Разрушитель XT-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Светлый взрыв на вас",
	WarningLightBomb		= ">%s< под воздействием Светлого взрыва",
	SpecialWarningGravityBomb	= "Гравитационная бомба на вас",
	WarningGravityBomb		= ">%s< под воздействием Гравитационной бомбы",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Спец-предупреждение, когда Светлый взрыв на вас",
	WarningLightBomb		= "Объявлять Светлый взрыв",
	SpecialWarningGravityBomb	= "Спец-предупреждение, когда вы под воздействием эффекта Гравитационной бомбы",
	WarningGravityBomb		= "Объявлять Гравитационная бомба",
	PlaySoundOnGravityBomb		= "Звуковой сигнал, когда вы под воздействием эффекта Гравитационной бомбы",
	PlaySoundOnTympanicTantrum	= "Звуковой сигнал во время Раскаты ярости",
	SetIconOnLightBombTarget	= "Установить метку на цель под Светлым взрывом",
	SetIconOnGravityBombTarget	= "Установить метку на цель под Гравитационной бомбой",
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Железное Собрание"
}

L:SetWarningLocalization{
	WarningSupercharge		= "Суперзаряд",
	WarningChainlight		= "Цепная молния",
	WarningFusionPunch		= "Энергетический удар",
	WarningOverwhelmingPower	= ">%s< под воздействием Переполняющей энергии",
	WarningRuneofPower		= "Руна мощи",
	WarningRuneofDeath		= "Руна смерти",
	RuneofDeath			= "Руна смерти - бегите",
	LightningTendrils		= "Светящиеся придатки - бегите",
	WarningRuneofSummoning		= "Руна призыва",
	Overload			= "Перегрузка - бегите",
	WarningStaticDisruption		= ">%s< под воздействием Статического сбоя",
	PlaySoundDeathRune		= "Руна смерти"
}

L:SetTimerLocalization{
	TimerSupercharge	= "Суперзаряд",
	TimerOverload		= "Перегрузка",
	TimerLightningWhirl	= "Вихрь молний",
	TimerLightningTendrils	= "Светящиеся придатки",
	timerFusionPunchCast	= "Энергетический удар",
	timerFusionPunchActive	= "Энергетический удар: %s",
	timerOverwhelmingPower	= "Переполняющая энергия: %s",
	timerRunicBarrier	= "Руническая преграда",
	timerRuneofDeath	= "Руна смерти",
}

L:SetOptionLocalization{
	TimerSupercharge		= "Отображать время действия Суперзаряда",
	WarningSupercharge		= "Предупреждение для заклинания Суперзаряд",
	WarningChainlight		= "Объявлять Цепную молнию",
	TimerOverload			= "Отсчет времени до Перегрузки",
	TimerLightningWhirl		= "Отсчет времени до Вихря молний",
	LightningTendrils		= "Спец-предупреждение для Светящихся придатков",
	TimerLightningTendrils		= "Отображать время действия Светящихся придатков",
	PlaySoundLightningTendrils	= "Звуковой сигнал при Светящихся придатках",
	WarningFusionPunch		= "Объявлять Энергетический удар",
	timerFusionPunchCast		= "Отображать индикатор для Энергетического удара",
	timerFusionPunchActive		= "Отображать время действия Энергетический удар",
	WarningOverwhelmingPower	= "Объявлять Переполняющую энергию",
	timerOverwhelmingPower		= "Отсчет времени до Переполняющей энергии",
	SetIconOnOverwhelmingPower	= "Установить метку на цель под Переполняющей энергией",
	timerRunicBarrier		= "Отображать время действия Руническая преграда",
	WarningRuneofPower		= "Объявлять Руну мощи",
	WarningRuneofDeath		= "Объявлять Руну смерти",
	WarningRuneofSummoning		= "Объявлять Руну призыва",
	RuneofDeath			= "Спец-предупреждение для Руны смерти",
	timerRuneofDeath		= "Отображать время действия Руны смерти",
	SetIconOnStaticDisruption	= "Установить метку на цель под Статическим сбоем",
	Overload			= "Спец-предупреждение для Перегрузки",
	AllwaysWarnOnOverload		= "Объявлять когда Перегрузка (иначе, когда нацеливание)",
	PlaySoundOnOverload		= "Звуковой сигнал при Перегрузке",
	WarningStaticDisruption		= "Объявлять Статический сбой",
	PlaySoundDeathRune		= "Звуковой сигнал при Рунах смерти"
}

L:SetMiscLocalization{
	Steelbreaker		= "Сталелом",
	RunemasterMolgeim	= "Мастер рун Молгейм",
	StormcallerBrundir 	= "Буревестник Брундир",
}


----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Алгалон Наблюдатель"
}

L:SetTimerLocalization{
	NextCollapsingStar	= "Вспыхивающая звезда",
	PossibleNextCosmicSmash = "Кара небесная"
}

L:SetWarningLocalization{
	WarningPhasePunch	= ">%s< под воздействием Фазового удара",
	WarningBlackHole	= "Черная дыра",
	WarningBigBang		= "Суровый удар",
	SpecWarnBigBang		= "Суровый удар",
	PreWarningBigBang	= "Суровый удар через ~10 секунд",
	WarningCosmicSmash 	= "Кара небесная - взрыв через 4 секунд",
	SpecWarnCosmicSmash 	= "Кара небесная"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch	= "Спец-предупреждение, когда Фазовый удар на вас",
	WarningBigBang		= "Объявлять чтение заклинания Суровый удар",
	PreWarningBigBang	= "Объявлять Суровый удар",
	SpecWarnBigBang		= "Спец-предупреждение для Сурового удара",
	WarningPhasePunch	= "Объявлять цель под воздействием Фазовый удар",
	WarningBlackHole	= "Объявлять Черную дыру",
	NextCollapsingStar	= "Отсчет времени до Свернувшейся звезды",
	WarningCosmicSmash 	= "Объявлять цель под воздействием Кары небесной",
	SpecWarnCosmicSmash 	= "Спец-предупреждение для Кары небесной",
	PossibleNextCosmicSmash	= "Отсчет времени до Кара небесная"
}

L:SetMiscLocalization{		
	YellPull		 = "Ваши действия нелогичны. Все возможные исходы этой схватки просчитаны. Пантеон получит сообщение от Наблюдателя в любом случае.",
	YellPullFirst		 = "",
	Emote_CollapsingStars	 = "%s призывает вспыхивающие звезды!",
	Emote_CosmicSmash	 = "%s начинает читать заклинание Кара небесная!"
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Кологарн"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "Сосредоточенный взгляд на вас - бегите",
	WarningEyebeam			= ">%s< под сосредоточенным взглядом",
	WarnGrip			= ">%s< под воздействием Каменной хватки"
}

L:SetTimerLocalization{
	timerEyebeam			= "Сосредоточенный взгляд: %s",
	timerPetrifyingBreath		= "Каменящее дыхание",
	timerNextShockwave		= "Следующая Ударная волна",
	timerLeftArm			= "Возрождение левой руки",
	timerRightArm			= "Возрождение правой руки",
	achievementDisarmed		= "Разоружение"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Спец-предупреждение, когда Сосредоточенный взгляд на вас",
	WarningEyeBeam			= "Объявлять цель под воздействием Сосредоточенный взгляд",
	timerEyebeam			= "Отсчет времени до Сосредоточенного взгляда",
	timerPetrifyingBreath		= "Отсчет времени до Каменящего дыхания",
	timerNextShockwave		= "Отсчет времени до Ударной волны",
	timerLeftArm			= "Отсчет времени до Возрождения левой руки",
	timerRightArm			= "Отсчет времени до Возрождения правой руки",
	achievementDisarmed		= "Отсчет времени до приминения Разоружения",
	WarnGrip			= "Объявлять цели под воздействием Хватки смерти",
	WarnEyeBeam			= "Объявлять цель под воздействием Луча ока",
	SetIconOnGripTarget		= "Установить метку на цели под воздействием Хватки смерти"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Царапина...",
	Yell_Trigger_arm_right	= "Всего лишь плоть!",
	Health_Body		= "Кологарн",
	Health_Right_Arm	= "Правая рука",
	Health_Left_Arm		= "Левая рука",
	FocusedEyebeam		= "%s устремляет на вас свой взгляд!"
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
	SpecWarnVoid	= "Портал бездны - бегите",
	WarnCatDied 	= "Дикий эащитник погибает (Осталось живых: %d)",
	WarnCatDiedOne 	= "Дикий эащитник погибает (Это последний!)",
	WarnFear	= "Ужасающий вопль",
	WarnFearSoon 	= "Скоро следующий Ужасающий вопль",
	WarnSonic	= "Ультразвуковой визг",
	WarnSwarm	= "Крадущийся страж на >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Спец-предупреждение когда применяет Удар часового",
	SpecWarnVoid	= "Спец-предупреждение под воздействием Дикая сущность",
	WarnFear	= "Предупреждение для Ужасающнго вопля",
	WarnFearSoon	= "Предупреждение о следующем Ужасающем вопле",
	WarnCatDied	= "Предупреждение, когда погибает дикий защитник",
	WarnSwarm	= "Предупреждение для крадущегося стража",
	WarnSonic	= "Предупреждение для Ультразвукового визга",
	WarnCatDiedOne	= "Предупреждение, когда погибает кошка"
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
	TimerFlashFreeze	= "Мгновенная заморозка",
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
	YellKill	= "Наконец-то я... свободен от его оков…",
	YellCloud	= "На мне Грозовая Туча!"
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
	WarningBomb		= ">%s< под воздействием Взрыва руны",
	LightningOrb		= "Поражение громом на вас - бегите"
}

L:SetTimerLocalization{
	TimerHardmode		= "Высокая сложность"
}

L:SetOptionLocalization{
	TimerHardmode		= "Отсчет времени для высокой сложности",
	WarningStormhammer	= "Объявлять Молот бури",
	WarningLightningCharge	= "Объявлять Разряд молнии",
	WarningPhase2		= "Объявлять фазу 2",
	UnbalancingStrike	= "Объявлять Дисбалансирующий удар",
	WarningBomb		= "Объявлять Взрыв руны",
	RangeFrame		= "Отображать окно допустимой дистанции",
	AnnounceFails		= "Объявлять игрока под разрядом молнии в рейд-чат (требуются права лидера или помощника)",
	LightningOrb		= "Спец-предупреждение для Поражения громом" 
}

L:SetMiscLocalization{
	YellPhase1	 = "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2	 = "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!",
	YellKill	 = "Придержите мечи! Я сдаюсь.",
	ChargeOn	 = "Разряд молнии: %s",
	Charge		 = "Разряд не достал (в этот раз): %s"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Фрейя"
}

L:SetMiscLocalization{
	SpawnYell	= "Помогите мне, дети мои!",
	WaterSpirit	= "Древний дух воды",
	Snaplasher	= "Хватоплет",
	StormLasher	= "Грозовой плеточник",
	YellKill	= "Он больше не властен надо мной. Мой взор снова ясен. Благодарю вас, герои."
}

L:SetWarningLocalization{
	WarnPhase2	= "Фаза 2",
	WarnSimulKill	= "Первый союзник погибает - воскрешение через 1 минуту",
	WarnFury	= ">%s< под воздействием Гнев природы",
	SpecWarnFury	= "Гнев природы на вас",
	WarningTremor   = "Дрожание земли - остановите чтение заклинаний",
	WarnRoots	= ">%s< в корнях",
	UnstableEnergy	= "Нестабильная энергия - бегите"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Луч солнца: %s",
	TimerSimulKill		= "Воскрешение",
	TimerFuryYou		= "Гнев природы на вас",
	TrashRespawnTimer	= "Фрейя возрождает Мусор"
}

L:SetOptionLocalization{
	WarnPhase2		= "Объявлять фазу 2",
	WarnSimulKill		= "Объявлять, когда первый монстр погибает",
	WarnFury		= "Объявлять цель под воздействием Гнева природы",
	WarnRoots		= "Объявлять цель под воздействием Железных корней",
	SpecWarnFury		= "Спец-предупреждение для Гнева природы",
	WarningTremor		= "Спец-предупреждение для Дрожания земли (высокая сложность)",
	PlaySoundOnFury 	= "Звуковой сигнал, когда вы под воздействем Гнева природы",
	TimerSimulKill		= "Отсчет времени до воскрешения монстров",
	UnstableEnergy		= "Спец-предупреждение для Нестабильной энергии"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Древни Фреи"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Фрейя возрождает Мусор"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Дрожание земли - остановите чтение заклинаний!",
	SpecWarnFistOfStone	= "Каменные кулаки"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Спец-предупреждение для Каменных кулаков",
	SpecWarnGroundTremor	= "Спец-предупреждение для Дрожания земли",
	PlaySoundOnFistOfStone	= "Звуковой сигнал при Каменных кулакав",
	TrashRespawnTimer	= "Отсчет времени до повторного Дрожания земли"
}


---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Мимирон"
}

L:SetWarningLocalization{
	DarkGlare		= "Лазерное заграждение",
	WarningPlasmaBlast	= "%s под воздействием Взрыва плазмы - лечите",
	WarnShell		= ">%s< под зарядом напалма",
	WarnBlast		= ">%s< под взрывом плазмы",
	MagneticCore		= ">%s< под воздействием Магнитного ядра",
	WarningShockBlast	= "Шоковый удар - бегите",
	WarnBombSpawn		= "Бомбот",
	WarnFrostBomb		= "Ледяная бомба",
	WarnFlamesSoon		= "Метание пламени через ~5 секунд"
}

L:SetTimerLocalization{
	ProximityMines		= "Мины ближнего действия",
	TimerHardmode		= "Высокая сложность - Самоуничтожение",
	TimeToPhase2		= "Фаза 2",
	TimeToPhase3		= "Фаза 3",
	TimeToPhase4		= "Фаза 4",
	TimerNewFlames		= "Метание пламени"
}

L:SetOptionLocalization{
	DarkGlare		= "Отсчет времени для Лазерного заграждения",
	WarnBlast		= "Объявлять цель под воздействием Взрыва плазмы",
	WarnShell		= "Объявлять цель под воздействием Заряда напалма",
	TimeToPhase2		= "Отсчет времени для фазы 2",
	TimeToPhase3		= "Отсчет времени для фазы 3",
	TimeToPhase4		= "Отсчет времени для фазы 4",
	MagneticCore		= "Объявлять Магнитное ядро",
	HealthFramePhase4	= "Отображать индикатор здоровъя в фазе 4",
	AutoChangeLootToFFA	= "Автоподсветка добычи доступной для всех в фазе 3",
	WarnBombSpawn		= "Объявлять Бомботов",
	TimerHardmode		= "Отсчет времени для высокой сложности",
	PlaySoundOnShockBlast	= "Звуковой сигнал при Взрыве плазмы",
	PlaySoundOnDarkGlare	= "Звуковой сигнал при Лазерном заграждении",
	ShockBlastWarningInP1	= "Спец-предупреждение для Взрыва плазмы в фазе 1",
	ShockBlastWarningInP4	= "Спец-предупреждение для Взрыва плазмы в фазе 2",
	WarnFrostBomb		= "Объявлять цель под воздействием Ледяной бомбы"
}

L:SetMiscLocalization{
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
	YellPull		= "У нас мало времени, друзья!",
	YellHardPull		= "Так, зачем вы это сделали? Разве вы не видели надпись \"НЕ НАЖИМАЙТЕ ЭТУ КНОПКУ!\"? Ну как мы сумеем завершить испытания при включенном механизме самоликвидации, а?",
	YellPhase2		= "ПРЕВОСХОДНО! Просто восхитительный результат! Целостность обшивки – 98,9 процента! Почти что ни царапинки! Продолжаем!",
	YellPhase3		= "Спасибо, друзья! Благодаря вам я получил ценнейшие сведения! Так, а куда же я дел... – ах, вот куда.",
	YellPhase4		= "Фаза предварительной проверки завершена. Пора начать главный тест!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Генерал Везакс"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Саронитовые враги"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Темное сокрушение на вас - бегите",
	SpecialWarningSurgeDarkness	= "Наплыв Тьмы",
	WarningShadowCrash		= ">%s< под воздействием Темного сокрушения",
	SpecialWarningShadowCrashNear	= "Темное сокрушение около вас - бегите",
	WarningLeechLife		= ">%s< под воздействием Вытягивание жизни",
	SpecialWarningLLYou		= "Вытягивание жизни на вас",
	SpecialWarningLLNear		= "%s около вас, под воздействием Вытягивание жизни"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "Предупреждение для Темного сокрушения",
	SetIconOnShadowCrash		= "Установить метку на цель под Темным сокрушением (череп)",
	SetIconOnLifeLeach		= "Установить метку на цель под Вытягиванием жизни (крест)",
	SpecialWarningSurgeDarkness	= "Спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash	= "Спец-предупреждение для Темное сокрушение",
	SpecialWarningShadowCrashNear	= "Спец-предупреждение о Темном сокрушении, около вас",
	SpecialWarningLLYou		= "Спец-предупреждение, когда вы под воздействием эффекта Вытягивание жизни",
	SpecialWarningLLNear		= "Спец-предупреждение о Вытягивании жизни, около вас",
	CrashWhisper			= "Сообщить цели, под воздействием Темного сокрушения",
	YellOnLifeLeech			= "Крикнуть о воздействии Вытягивания жизни",
	YellOnShadowCrash		= "Крикнуть о воздействии Темного сокрушения",
	WarningLeechLife		= "Объявлять цель под воздействием Вытягивание жизни",
	hardmodeSpawn			= "Отсчет времени до появления Саронитовых врагов (высокая сложность)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "Облако саронитовых паров образовывается поблизости!",
	CrashWhisper			= "Темное сокрушение на вас - бегите",
	YellLeech			= "Вытягивание жизни на мне!",
	YellCrash			= "Темное сокрушение на мне!"
}


------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Йогг-Сарон"
}

L:SetMiscLocalization{
	YellPull		= "Скоро мы сразимся с главарем этих извергов! Обратите гнев и ненависть против его прислужников!",
	YellPhase2		= "Я – это сон наяву.",
	Sara 			= "Сара",
	WhisperBrainLink	= "Схожее мышление на вас - бегите к %s",
	WarningYellSqueeze	= "Выдавливание на мне! Помогите!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "Страж",
	WarningCrusherTentacleSpawned	= "Тяжелое щупальце",
	WarningP2 			= "Фаза 2",
	WarningP3 			= "Фаза 3",
	WarningBrainLink 		= ">%s< и >%s< под воздествием Схожего мышления!",
	SpecWarnBrainLink 		= "Вы и %s под воздествием Схожего мышления!",
	WarningSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnSanity 			= "Эффект Здравомыслия: %d",
	SpecWarnGuardianLow 		= "Прекратить нападение на Стражей!",
	WarnMadness			= "Доведение до помешательства",
	SpecWarnMadnessOutNow		= "Помешательство заканчивается - бегите",
	WarnBrainPortalSoon		= "Портал через 3 секунды",	
	WarnSqueeze 			= "Выдавливание: >%s<",
	WarnFavor			= ">%s< под Рвением Сары",
	SpecWarnFavor			= "Рвение Сары на вас!",
	WarnEmpowerSoon			= "Приближается Сгущение тьмы!",
	SpecWarnMaladyNear		= "Душевная болезнь около вас, на >%s<",
	SpecWarnDeafeningRoar		= "Оглушающий рев",
	specWarnBrainPortalSoon		= "Портал"	
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
	WarnMadness			= "Объявлять о Доведении до помешательства",
	WarnBrainPortalSoon		= "Объявлять о Портале разума",
	SpecWarnMadnessOutNow		= "Спец-предупреждение до окончания Доведения до помешательства",
	SetIconOnFearTarget		= "Установить метку на цель под воздействием болезни",
	WarnFavor			= "Объявлять цель под Рвением Сары",
	SpecWarnFavor			= "Спец-предупреждение для Рвения Сары",
	WarnSqueeze			= "Объявлять цель под воздействием Выдавливание",
	specWarnBrainPortalSoon		= "Объявлять Портал",
	WarningSqueeze			= "Объявлять цели Выдавливание",
	NextPortal			= "Отсчет времени до следующего портала",
	WhisperBrainLink		= "Сообщить цели, под воздействием Схожее мышление",
	SetIconOnFavorTarget		= "Установить метку на цель под воздействием Рвения Сары",
	SetIconOnMCTarget		= "Установить метку на цель под контролем над разумом",
	ShowSaraHealth			= "Показать здоровье Сары в фазе 1 (должна быть под прицелом)",
	WarnEmpowerSoon			= "Предупреждать о приближении Сгущения тьмы",
	SpecWarnMaladyNear		= "Спец-предупреждение если кто-либо около вас получает Душевную болезнь",
	SpecWarnDeafeningRoar		= "Спец-предупреждение, когда применяется Оглушающий рев"
}


