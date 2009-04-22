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
	SpecialLocust				= "Жуки-трупоеды!",
	WarningLocustSoon			= "Жуки-трупоеды через 15 секунд",
	WarningLocustNow			= "Жуки-трупоеды!",
	WarningLocustFaded			= "Жуки-трупоеды исчезают"
})

L:SetTimerLocalization({
	TimerLocustIn				= "Жуки-трупоеды", 
	TimerLocustFade				= "Жуки-трупоеды активны"
})

L:SetOptionLocalization({
	SpecialLocust				= "Отображать спец-предупреждение для Жуков-трупоедов",
	WarningLocustSoon			= "Отображать пред-предупреждение для Жуков-трупоедов",
	WarningLocustNow			= "Отображать предупреждение для Жуков-трупоедов",
	WarningLocustFaded			= "Отображать предупреждение исчезновения Жуков-трупоедов",
	TimerLocustIn				= "Отображать отсчет времени до Жуков-трупоедов", 
	TimerLocustFade 			= "Отображать отсчет времени до исчезновения Жуков-трупоедов"
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
	WarningEnrageSoon			= "Исступление через 5 секунд",
	WarningEnrageNow			= "Исступление!"
})

L:SetTimerLocalization({
	TimerEmbrace				= "Объятие Вдовы активно",
	TimerEnrage					= "Исступление",
})

L:SetOptionLocalization({
	TimerEmbrace				= "Отображать отсчет времени до Объятия Вдовы",
	WarningEmbraceActive		= "Отображать предупреждение для Объятия Вдовы",
	WarningEmbraceExpire		= "Отображать предупреждение когда Объятие Вдовы исчезает",
	WarningEmbraceExpired		= "Отображать предупреждение когда Объятие Вдовы закончится"
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
	WarningWebSprayNow			= "Мексна разбрасывает нити паутины!",
	WarningSpidersSoon			= "Паученыши Мексны через 5 секунд",
	WarningSpidersNow			= "В паутине появляются паучата!"
})

L:SetTimerLocalization({
	TimerWebSpray				= "Летящая паутина",
	TimerSpider					= "Паученыши Мексны"
})

L:SetOptionLocalization({
	WarningWebWrap				= "Отображать спец-предупреждение для Опутывания паутиной",
	WarningWebSpraySoon			= "Отображать пред-предупреждение Летящей паутины",
	WarningWebSprayNow			= "Отображать предупреждение для Летящей паутины",
	WarningSpidersSoon			= "Отображать пред-предупреждение призыва Паученышей Мексны",
	WarningSpidersNow			= "Отображать предупреждение для призыва Паученышей Мексны",
	TimerWebSpray				= "Отображать отсчет времени до Летящей паутины",
	TimerSpider					= "Отображать отсчет времени до призыва Паученышей Мексны"
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
	WarningTeleportNow			= "Телепортируется!",
	WarningTeleportSoon			= "Телепортация через 20 секунд",
	WarningCurse				= "Проклятие Чумного!"
})

L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
	TimerTeleportBack			= "Телепортация обратно"
})

L:SetOptionLocalization({
	WarningTeleportNow			= "Отображать предупреждение для Телепортации",
	WarningTeleportSoon			= "Отображать пред-предупреждение Телепортации",
	WarningCurse				= "Отображать предупреждение для Проклятия Чумного",
	TimerTeleport				= "Отображать отсчет времени до Телепортации",
	TimerTeleportBack			= "Отображать отсчет времени до обратной Телепортации"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Хейган Нечестивый"
})

L:SetWarningLocalization({
	WarningTeleportNow			= "Телепортируется!",
	WarningTeleportSoon			= "Телепортация через %d сек."
})

L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
})

L:SetOptionLocalization({
	WarningTeleportNow			= "Отображать предупреждение для Телепортации",
	WarningTeleportSoon			= "Отображать пред-предупреждение Телепортации",
	WarningCurse				= "Отображать предупреждение для Проклятия",
	TimerTeleport				= "Отображать отсчет времени до Телепортации",
	TimerTeleportBack			= "Отображать отсчет времени до обратной Телепортации"
})

----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Лотхиб"
})

L:SetWarningLocalization({
	WarningSporeNow				= "Призывает спору!",
	WarningSporeSoon			= "Вызов споры через 5 секунд",
	WarningDoomNow				= "Неотвратимый рок #%d",
	WarningHealSoon				= "Исцеление через 3 секунды",
	WarningHealNow				= "Исцеление!"
})

L:SetTimerLocalization({
	TimerDoom					= "Неотвратимый рок #%d",
	TimerSpore					= "Следующий Вызов споры",
	TimerAura					= "Мертвенная аура"
})

L:SetOptionLocalization({
	WarningSporeNow				= "Отображать предупреждение для Вызова споры",
	WarningSporeSoon			= "Отображать пред-предупреждение Вызова споры",
	WarningDoomNow				= "Отображать предупреждение для Неотвратимого рока",
	WarningHealSoon				= "Отображать пред-предупреждение Исцеления",
	WarningHealNow				= "Отображать предупреждение для Исцеления",
	TimerDoom					= "Отображать отсчет времени до Неотвратимого рока",
	TimerSpore					= "Отображать отсчет времени до Вызова споры",
	TimerAura					= "Отображать отсчет времени до Мертвенной ауры"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Лоскутик"
})

L:SetOptionLocalization({
	WarningHateful				= "Отображать предупреждение Удара ненависти\n(требуются права лидера или помощника)"
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
	WarningInjection			= "Отображать предупреждение для Мутагенного укола",
	SpecialWarningInjection		= "Отображать спец-предупреждение для Мутагенного укола"
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
	WarningDecimateNow			= "Отображать предупреждение для Истребления",
	WarningDecimateSoon			= "Отображать пред-предупреждение Истребления",
	TimerDecimate				= "Отображать отсчет времени до Истребления"
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
})

L:SetOptionLocalization({
	WarningShiftCasting			= "Отображать предупреждение для Сдвига полярности",
	WarningChargeChanged		= "Отображать предупреждение когда ваша полярность изменена",
	WarningChargeNotChanged		= "Отображать предупреждение когда ваша полярность не изменена",
	TimerShiftCast				= "Отображать отсчет времени до Сдвига полярности",
	TimerNextShift				= "Отображать отсчет времени до перезарядки Сдвига полярности",
	ArrowsEnabled				= "Отображать стрелки (обычная \"2 camp\" стратегия)",
	ArrowsRightLeft				= "Отображать стрелки влево/вправо для \"4 camp\" стратеги (влево, если полярность изменена, вправо, если нет)",
	ArrowsInverse				= "Обратнная \"4 camp\" стратеги (вправо, если полярность изменена, влево, если нет)",
	WarningThrow				= "Отображать предупреждение для Броска",
	WarningThrowSoon			= "Отображать пред-предупреждение Бросок",
	TimerThrow					= "Отображать отсчет времени до Броска"
})

L:SetWarningLocalization({
	WarningShiftCasting			= "Сдвиг полярности через 3 секунды!",
	WarningChargeChanged		= "%s - полярность изменена",
	WarningChargeNotChanged		= "Полярность не изменена",
	WarningThrow				= "Бросок!",
	WarningThrowSoon			= "Бросок через 3 секунды"
})

L:SetTimerLocalization({
	TimerShiftCast				= "Сдвиг полярности",
	TimerNextShift				= "Следующий Сдвиг полярности",
	TimerThrow					= "Бросок"
})

L:SetOptionCatLocalization({
	Arrows						= "Стрелки",
})

-----------------
--  Razuvious  --
-----------------
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
	WarningShoutNow		= "Объявлять Разрушительный крик",
	WarningShoutSoon	= "Предупреждать о приближении Разрушительного крика",
	TimerShout			= "Отображать отсчет времени до Разрушительного крика",
	WarningShieldWallSoon	= "Предупреждать о скором исчезновении Стены костей",
	TimerShieldWall		= "Отображать отсчет времени до Стены костей",
	TimerTaunt			= "Отображать отсчет времени до Провокации"
})

L:SetWarningLocalization({
	WarningShoutNow		= "Разрушительный крик!",
	WarningShoutSoon	= "Разрушительный крик через 5 секунд",
	WarningShieldWallSoon	= "Стена костей закончится через 5 секунд"
})

L:SetTimerLocalization({
	TimerShout			= "Разрушительный крик",
	TimerTaunt			= "Провокация",
	TimerShieldWall		= "Стена костей"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Готик Жнец"
})

L:SetOptionLocalization({
	TimerWave					= "Отображать отсчет времени до Волны",
	TimerPhase2					= "Отображать отсчет времени до Фазы 2",
	WarningWaveSoon				= "Отображать пред-предупреждение Волны",
	WarningWaveSpawned			= "Отображать предупреждение Волны призыва",
	WarningRiderDown			= "Отображать предупреждение когда Всадник мертв",
	WarningKnightDown			= "Отображать предупреждение когда Рыцарь мертв",
	WarningPhase2				= "Отображать предупреждение для Фазы 2"
})

L:SetTimerLocalization({
	TimerWave					= "Волна %d",
	TimerPhase2					= "Фаза 2"
})

L:SetWarningLocalization({
	WarningWaveSoon				= "Волна %d: %s через 3 секунды",
	WarningWaveSpawned			= "Волна %d: %s призван",
	WarningRiderDown			= "Всадник мертв",
	WarningKnightDown			= "Рыцарь мертв",
	WarningPhase2				= "Фаза 2"
})

L:SetMiscLocalization({
	yell						= "Глупо было искать свою смерть.",
	WarningWave1				= "%d %s",
	WarningWave2				= "%d %s и %d %s",
	WarningWave3				= "%d %s, %d %s и %d %s",
	Trainee						= "|4Ученик:Ученика;",
	Knight						= "|4Рыцарь:Рыцаря;",
	Rider						= "|4Всадник:Всадника;",
--	Trainee			= "|4Ученик:Ученика;",
--	Knight			= "|4Рыцарь:Рыцаря;",
--	Rider			= "|4Всадник:Всадника;",
})

----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Четыре Всадника"
})

L:SetOptionLocalization({
	TimerMark					= "Отображать отсчет времени до Знака",
	WarningMarkSoon				= "Отображать пред-предупреждение Знака",
	WarningMarkNow				= "Отображать предупреждение для Знака",
	SpecialWarningMarkOnPlayer	= "Отображать предупреждение когда >4 Знака на вас"
})

L:SetTimerLocalization({
	TimerMark = "Знак %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Знак %d через 3 секунды",
	WarningMarkNow				= "Знак %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz					= "Тан Кортазз",
	Rivendare					= "Барон Ривендер",
	Blaumeux					= "Леди Бломе",
	Zeliek						= "Сэр Зелиек",
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
	WarningDrainLifeSoon	= "Предупреждать о приближающемся Похищении жизни",
	WarningAirPhaseSoon		= "Предупреждать о приближении Воздушной фазы",
	WarningAirPhaseNow		= "Объявлять Воздушную фазу",
	WarningLanded			= "Объявлять Наземную фазу",
	TimerDrainLifeCD		= "Отображать отсчет времени до перезарядки Похищения жизни",
	TimerAir				= "Отображать отсчет времени до Воздушной фазы",
	TimerLanding			= "Отображать отсчет времени до приземления",
	TimerIceBlast			= "Отображать отсчет времени до Ледяного дыхания",
	WarningDeepBreath		= "Специальное объявление Ледяного Дыхания"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s делает глубокий вдох.",
	WarningYellIceblock	= "Я в Ледяной глыбе!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Похищение Жизни!",
	WarningDrainLifeSoon	= "Скоро Похищение жизни",
	WarningAirPhaseSoon		= "Воздушная фаза через 10 секунд",
	WarningAirPhaseNow		= "Воздушная фаза",
	WarningLanded			= "Сапфирон приземляется",
	WarningDeepBreath		= "Ледяное дыхание!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Перезарядка Похищения жизни",
	TimerAir				= "Воздушная фаза",
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
	TimerPhase2			= "Отображать отсчет времени до второй фазы",
	WarningBlastTargets	= "Объявлять цели Ледяного взрыва",
	WarningPhase2		= "Объявлять наступление второй фазы",
	WarningFissure		= "Объявлять Расщелины тьмы",
	WarningMana			= "Объявлять Взрыв маны"
})

L:SetMiscLocalization({
	Yell = "Соратники, слуги, солдаты холодной тьмы! Повинуйтесь зову Кел-Тузада!"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "Ледяной взрыв: >%s<",
	WarningPhase2		= "Фаза 2",
	WarningFissure		= "Появилась Расщелина тьмы",
	WarningMana			= "Взрыв маны: >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "Фаза 2"
})

