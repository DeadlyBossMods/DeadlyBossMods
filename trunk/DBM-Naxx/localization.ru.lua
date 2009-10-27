if GetLocale() ~= "ruRU" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Ануб'Рекан"
})

L:SetWarningLocalization({
	SpecialLocust				= "Жуки-трупоеды",
	WarningLocustSoon			= "Жуки-трупоеды через 15 секунд",
	WarningLocustNow			= "Жуки-трупоеды",
	WarningLocustFaded			= "Жуки-трупоеды исчезают"
})

L:SetTimerLocalization({
	TimerLocustIn				= "Жуки-трупоеды", 
	TimerLocustFade				= "Жуки-трупоеды активны"
})

L:SetOptionLocalization({
	SpecialLocust				= "Cпец-предупреждение для Жуков-трупоедов",
	WarningLocustSoon			= "Предупреждать перед следующими Жуками-трупоедами",
	WarningLocustNow			= "Предупреждение для Жуков-трупоедов",
	WarningLocustFaded			= "Предупреждение для исчезновения Жуков-трупоедов",
	TimerLocustIn				= "Отсчет времени до Жуков-трупоедов", 
	TimerLocustFade 			= "Отсчет времени до исчезновения Жуков-трупоедов"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Великая вдова Фарлина"
})

L:SetWarningLocalization({
	WarningEmbraceActive		= "Объятие Вдовы",
	WarningEmbraceExpire		= "Объятие Вдовы через 5 секунд",
	WarningEmbraceExpired		= "Объятие Вдовы исчезает",
	WarningEnrageSoon			= "Скоро Исступление",
	WarningEnrageNow			= "Исступление!"
})

L:SetTimerLocalization({
	TimerEmbrace				= "Объятие Вдовы активно",
	TimerEnrage					= "Исступление"
})

L:SetOptionLocalization({
	TimerEmbrace				= "Отсчет времени до Объятия Вдовы",
	WarningEmbraceActive		= "Предупреждение для Объятия Вдовы",
	WarningEmbraceExpire		= "Предупреждение, когда Объятие Вдовы исчезает",
	WarningEmbraceExpired		= "Предупреждение, когда Объятие Вдовы закончится",
	WarningEnrageSoon			= "Предупреждать о скором Исступлении",
	WarningEnrageNow			= "Предупреждение для Исступления",
	TimerEnrage					= "Отсчет времени до Исступления"
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Мексна"
})

L:SetWarningLocalization({
	WarningWebWrap				= "Опутывание паутиной: >%s<",
	WarningWebSpraySoon			= "Летящая паутина через 5 секунд",
	WarningWebSprayNow			= "Мексна разбрасывает нити паутины",
	WarningSpidersSoon			= "Паученыши Мексны через 5 секунд",
	WarningSpidersNow			= "В паутине появляются паучата"
})

L:SetTimerLocalization({
	TimerWebSpray				= "Летящая паутина",
	TimerSpider					= "Паученыши Мексны"
})

L:SetOptionLocalization({
	WarningWebWrap				= "Cпец-предупреждение для Опутывания паутиной",
	WarningWebSpraySoon			= "Предупреждать перед следующей Летящей паутиной",
	WarningWebSprayNow			= "Предупреждение для Летящей паутины",
	WarningSpidersSoon			= "Предупреждать перед следующим призывом Паученышей Мексны",
	WarningSpidersNow			= "Предупреждение для призыва Паученышей Мексны",
	TimerWebSpray				= "Отсчет времени до Летящей паутины",
	TimerSpider					= "Отсчет времени до призыва Паученышей Мексны"
})

L:SetMiscLocalization({
	YellWebWrap			= "Я в коконе! Помогите!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Нот Чумной"
})

L:SetWarningLocalization({
	WarningTeleportNow			= "Телепортация",
	WarningTeleportSoon			= "Телепортация через 20 секунд",
	WarningCurse				= "Проклятие Чумного"
})

L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
	TimerTeleportBack			= "Телепортация обратно"
})

L:SetOptionLocalization({
	WarningTeleportNow			= "Предупреждение о телепортации",
	WarningTeleportSoon			= "Предупреждать перед следующей телепортацией",
	WarningCurse				= "Предупреждение для Проклятия Чумного",
	TimerTeleport				= "Отсчет времени до телепортации",
	TimerTeleportBack			= "Отсчет времени до обратной телепортации"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Хейган Нечестивый"
})

L:SetWarningLocalization({
	WarningTeleportNow			= "Телепортация",
	WarningTeleportSoon			= "Телепортация через %d сек."
})

L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
})

L:SetOptionLocalization({
	WarningTeleportNow			= "Предупреждение о телепортации",
	WarningTeleportSoon			= "Предупреждать перед следующей телепортацией",
	WarningCurse				= "Предупреждение о проклятии",
	TimerTeleport				= "Отсчет времени до телепортации",
	TimerTeleportBack			= "Отсчет времени до обратной телепортации"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Лотхиб"
})

L:SetWarningLocalization({
	WarningSporeNow				= "Призывает спору",
	WarningSporeSoon			= "Вызов споры через 5 секунд",
	WarningDoomNow				= "Неотвратимый рок #%d",
	WarningHealSoon				= "Исцеление через 3 секунды",
	WarningHealNow				= "Исцеление"
})

L:SetTimerLocalization({
	TimerDoom					= "Неотвратимый рок #%d",
	TimerSpore					= "Следующий Вызов споры",
	TimerAura					= "Мертвенная аура"
})

L:SetOptionLocalization({
	WarningSporeNow				= "Предупреждение для вызова спор",
	WarningSporeSoon			= "Предупреждать перед следующим вызовом спор",
	WarningDoomNow				= "Предупреждение для Неотвратимого рока",
	WarningHealSoon				= "Предупреждать перед следующим исцелением",
	WarningHealNow				= "Предупреждение для исцеления",
	TimerDoom					= "Отсчет времени до Неотвратимого рока",
	TimerSpore					= "Отсчет времени до вызова спор",
	TimerAura					= "Отсчет времени до Мертвенной ауры"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Лоскутик"
})

L:SetOptionLocalization({
	WarningHateful				= "Предупреждение для Удара ненависти\n(требуются права лидера или помощника)"
})

L:SetMiscLocalization({
	yell1 = "Лоскутик хочет поиграть!",
	yell2 = "Кел'Тузад объявил Лоскутика воплощением войны!",
	HatefulStrike = "Удар ненависти --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Гроббулус"
})

L:SetOptionLocalization({
	WarningInjection			= "Предупреждение для Мутагенного укола",
	SpecialWarningInjection		= "Cпец-предупреждение для Мутагенного укола"
})

L:SetWarningLocalization({
	WarningInjection			= "Мутагенный укол: >%s<",
	SpecialWarningInjection		= "Вам сделали мутагенный укол."
})

L:SetTimerLocalization({
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Глут"
})

L:SetOptionLocalization({
	WarningDecimateNow			= "Предупреждение для Истребления",
	WarningDecimateSoon			= "Предупреждать перед следующим Истреблением",
	TimerDecimate				= "Отсчет времени до Истребления"
})

L:SetWarningLocalization({
	WarningDecimateNow			= "Истребление!",
	WarningDecimateSoon			= "Истребление через 10 секунд"
})

L:SetTimerLocalization({
	TimerDecimate				= "Истребление"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Таддиус"
})

L:SetMiscLocalization({
	Yell	= "Сталагг сокрушит вас!",
	Emote	= "Катушка Теслы перезагружается!",
	Emote2	= "Катушка Теслы теряет связь!",
	Boss1	= "Фойген",
	Boss2	= "Сталагг",
	Charge1	= "Отрицательный",
	Charge2	= "Положительный",
})

L:SetOptionLocalization({
	WarningShiftCasting			= "Предупреждение для Сдвига полярности",
	WarningChargeChanged		= "Предупреждение, когда ваша полярность изменена",
	WarningChargeNotChanged		= "Предупреждение, когда ваша полярность не изменена",
	TimerShiftCast				= "Отсчет времени до Сдвига полярности",
	TimerNextShift				= "Отсчет времени до перезарядки Сдвига полярности",
	ArrowsEnabled				= "Отображать стрелки (обычная \"2-сторонняя\" стратегия)",
	ArrowsRightLeft				= "Стрелки влево/вправо для \"4-сторонней\" стратегии",
	ArrowsInverse				= "Обратная \"4-сторонняя\" стратегия (вправо, если полярность изменена, влево, если нет)",
	WarningThrow				= "Предупреждение для Броска",
	WarningThrowSoon			= "Предупреждать перед следующим Броском",
	TimerThrow					= "Отсчет времени до Броска"
})

L:SetWarningLocalization({
	WarningShiftCasting			= "Сдвиг полярности через 3 секунды",
	WarningChargeChanged		= "%s - полярность изменена",
	WarningChargeNotChanged		= "Полярность не изменена",
	WarningThrow				= "Бросок",
	WarningThrowSoon			= "Бросок через 3 секунды"
})

L:SetTimerLocalization({
	TimerShiftCast				= "Сдвиг полярности",
	TimerNextShift				= "Следующий Сдвиг полярности",
	TimerThrow					= "Бросок"
})

L:SetOptionCatLocalization({
	Arrows					= "Стрелки",
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Инструктор Разувий"
})

L:SetMiscLocalization({
	Yell1 = "Покажите мне, на что способны!",
	Yell2 = "Обучение окончено! Покажите мне, что вы усвоили!",
	Yell3 = "Вспомните, чему я вас учил!",
	Yell4 = "Выше ногу! Или у тебя с этим проблемы?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "Объявлять Разрушительный крик",
	WarningShoutSoon		= "Предупреждать о приближении Разрушительного крика",
	TimerShout			= "Отсчет времени до Разрушительного крика",
	WarningShieldWallSoon		= "Предупреждать о скором исчезновении Стены костей",
	TimerShieldWall			= "Отсчет времени до Стены костей",
	TimerTaunt			= "Отсчет времени до Провокации"
})

L:SetWarningLocalization({
	WarningShoutNow			= "Разрушительный крик",
	WarningShoutSoon		= "Разрушительный крик через 5 секунд",
	WarningShieldWallSoon		= "Стена костей закончится через 5 секунд"
})

L:SetTimerLocalization({
	TimerShout			= "Разрушительный крик",
	TimerTaunt			= "Провокация",
	TimerShieldWall			= "Стена костей"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Готик Жнец"
})

L:SetOptionLocalization({
	TimerWave			= "Отсчет времени до волны",
	TimerPhase2			= "Отсчет времени до фазы 2",
	WarningWaveSoon			= "Предупреждать перед следующей волной",
	WarningWaveSpawned		= "Предупреждение для волны призыва",
	WarningRiderDown		= "Предупреждение, когда всадник мертв",
	WarningKnightDown		= "Предупреждение, когда рыцарь мертв",
	WarningPhase2			= "Предупреждение для фазы 2"
})

L:SetTimerLocalization({
	TimerWave			= "Волна %d",
	TimerPhase2			= "Фаза 2"
})

L:SetWarningLocalization({
	WarningWaveSoon			= "Волна %d: %s через 3 секунды",
	WarningWaveSpawned		= "Волна %d: %s призван",
	WarningRiderDown		= "Всадник мертв",
	WarningKnightDown		= "Рыцарь мертв",
	WarningPhase2			= "Фаза 2"
})

L:SetMiscLocalization({
	yell				= "Глупо было искать свою смерть.",
	WarningWave1			= "%d %s",
	WarningWave2			= "%d %s и %d %s",
	WarningWave3			= "%d %s, %d %s и %d %s",
	Trainee				= "Ученика",
	Knight				= "Рыцаря",
	Rider				= "Всадника",
--	Trainee				= "|4Ученик:Ученика;",
--	Knight				= "|4Рыцарь:Рыцаря;",
--	Rider				= "|4Всадник:Всадника;",
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Четыре Всадника"
})

L:SetOptionLocalization({
	TimerMark			= "Отсчет времени до знака",
	WarningMarkSoon			= "Предупреждать перед следующими знаками",
	WarningMarkNow			= "Предупреждение для знаков",
	SpecialWarningMarkOnPlayer	= "Предупреждение, когда >4 знаков на вас"
})

L:SetTimerLocalization({
	TimerMark = "Знак %d"
})

L:SetWarningLocalization({
	WarningMarkSoon			= "Знак %d через 3 секунды",
	WarningMarkNow			= "Знак %d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz			= "Тан Кортазз",
	Rivendare			= "Барон Ривендер",
	Blaumeux			= "Леди Бломе",
	Zeliek				= "Сэр Зелиек"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Сапфирон"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "Объявлять Похищение жизни",
	WarningDrainLifeSoon		= "Предупреждать о приближающемся Похищении жизни",
	WarningAirPhaseSoon		= "Предупреждать о приближении Воздушной фазы",
	WarningAirPhaseNow		= "Объявлять Воздушную фазу",
	WarningLanded			= "Объявлять Наземную фазу",
	TimerDrainLifeCD		= "Отсчет времени до перезарядки Похищения жизни",
	TimerAir			= "Отсчет времени до Воздушной фазы",
	TimerLanding			= "Отсчет времени до приземления",
	TimerIceBlast			= "Отсчет времени до Ледяного дыхания",
	WarningDeepBreath		= "Специальное объявление Ледяного Дыхания",
	WarningIceblock			= "Прелупредить о Ледяной глыбе"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s делает глубокий вдох.",
	WarningYellIceblock		= "Я в Ледяной глыбе"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Похищение Жизни!",
	WarningDrainLifeSoon		= "Скоро Похищение жизни",
	WarningAirPhaseSoon		= "Воздушная фаза через 10 секунд",
	WarningAirPhaseNow		= "Воздушная фаза",
	WarningLanded			= "Сапфирон приземляется",
	WarningDeepBreath		= "Ледяное дыхание"
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Перезарядка Похищения жизни",
	TimerAir			= "Воздушная фаза",
	TimerLanding			= "Приземление",
	TimerIceBlast			= "Ледяное дыхание"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Кел'Тузад"
})

L:SetOptionLocalization({
	BlastTimer			= "Отсчет времени до Ледяного взрыва (4-секундный отсчет до смерти цели)",
	TimerPhase2			= "Отсчет времени до второй фазы",
	WarningBlastTargets		= "Предупреждать о Ледяном взрыве",
	WarningPhase2			= "Объявлять наступление второй фазы",
	WarningFissure			= "Объявлять Расщелины тьмы",
	WarningMana			= "Объявлять Взрыв маны",
    	WarningChainsTargets		= "Предупреждение для цепей Кел'Тузада",
	specwarnP2Soon 			= "Спец-предупреждение за 10 секунд до начала фазы Кел'Тузад",
	ShowRange			= "Показать окно допустимой дистанции, когда начинается фаза 2"
})

L:SetMiscLocalization({
	Yell = "Соратники, слуги, солдаты холодной тьмы! Повинуйтесь зову Кел'Тузада!"
})

L:SetWarningLocalization({
	WarningBlastTargets		= "Ледяной взрыв: >%s<",
	WarningPhase2			= "Фаза 2",
	WarningFissure			= "Появилась Расщелина тьмы",
	WarningMana			= "Взрыв маны: >%s<",
    	WarningChainsTargets		= "Цепи Кел'Тузада: >%s<",
	specwarnP2Soon 			= "Кел'Тузад через 10 секунд"
})

L:SetTimerLocalization({
	TimerPhase2			= "Фаза 2",
	BlastTimer			= "Исцеление"
})

