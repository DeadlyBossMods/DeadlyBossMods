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
	SpecialLocust				= "Показать спец-предупреждение для Жуков-трупоедов",
	WarningLocustSoon			= "Показать пред-предупреждение для Жуков-трупоедов",
	WarningLocustNow			= "Показать предупреждение для Жуков-трупоедов",
	WarningLocustFaded			= "Показать предупреждение исчезновения Жуков-трупоедов",
	TimerLocustIn				= "Показать отсчет времени до Жуков-трупоедов", 
	TimerLocustFade 			= "Показать отсчет времени до исчезновения Жуков-трупоедов"
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
	WarningEnrageSoon			= "Исступление через 15 секунд",
	WarningEnrageNow			= "Исступление!"
})
L:SetTimerLocalization({
	TimerEmbrace				= "Объятие Вдовы активно",
	TimerEnrage					= "Исступление",
})
L:SetOptionLocalization({
	TimerEmbrace				= "Показать отсчет времени до Объятия Вдовы",
	WarningEmbraceActive		= "Показать предупреждение для Объятия Вдовы",
	WarningEmbraceExpire		= "Показать предупреждение когда Объятие Вдовы исчезает",
	WarningEmbraceExpired		= "Показать предупреждение когда Объятие Вдовы закончится"
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
	WarningWebSprayNow			= "Летящая паутина!",
	WarningSpidersSoon			= "Паученыши Мексны через 5 секунд",
	WarningSpidersNow			= "Призвала Паученышей Мексны!"
})
L:SetTimerLocalization({
	TimerWebSpray				= "Летящая паутина",
	TimerSpider					= "Паученыши Мексны"
})
L:SetOptionLocalization({
	WarningWebWrap				= "Показать спец-предупреждение для Опутывания паутиной",
	WarningWebSpraySoon			= "Показать пред-предупреждение Летящей паутины",
	WarningWebSprayNow			= "Показать предупреждение для Летящей паутины",
	WarningSpidersSoon			= "Показать пред-предупреждение призыва Паученышей Мексны",
	WarningSpidersNow			= "Показать предупреждение для призыва Паученышей Мексны",
	TimerWebSpray				= "Показать отсчет времени до Летящей паутины",
	TimerSpider					= "Показать отсчет времени до призыва Паученышей Мексны"
})
L:SetMiscLocalization({
	YellWebWrap					= "I'm wrapped! Help me!"
})
------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Нот Чумной"
})
L:SetWarningLocalization({
	WarningTeleportNow			= "Телепортирует!",
	WarningTeleportSoon			= "Телепортация через 20 секунд",
	WarningCurse				= "Проклятие Чумного!"
})
L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
	TimerTeleportBack			= "Телепортация обратно"
})
L:SetOptionLocalization({
	WarningTeleportNow			= "Показать предупреждение для Телепортации",
	WarningTeleportSoon			= "Показать пред-предупреждение Телепортации",
	WarningCurse				= "Показать предупреждение для Проклятия Чумного",
	TimerTeleport				= "Показать отсчет времени до Телепортации",
	TimerTeleportBack			= "Показать отсчет времени до обратной Телепортации"
})
--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Хейган Нечестивый"
})
L:SetWarningLocalization({
	WarningTeleportNow			= "Телепортирует!",
	WarningTeleportSoon			= "Телепортация через %d сек.",
})
L:SetTimerLocalization({
	TimerTeleport				= "Телепортация",
})
L:SetOptionLocalization({
	WarningTeleportNow			= "Показать предупреждение для Телепортации",
	WarningTeleportSoon			= "Показать пред-предупреждение Телепортации",
	WarningCurse				= "Показать предупреждение для Проклятия", --?
	TimerTeleport				= "Показать отсчет времени до Телепортации",
	TimerTeleportBack			= "Показать отсчет времени до обратной Телепортации" --?
})
----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Мерзот"
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
	WarningSporeNow				= "Показать предупреждение для Вызова споры",
	WarningSporeSoon			= "Показать пред-предупреждение Вызова споры",
	WarningDoomNow				= "Показать предупреждение для Неотвратимого рока",
	WarningHealSoon				= "Показать пред-предупреждение Исцеления",
	WarningHealNow				= "Показать предупреждение для Исцеления",
	TimerDoom					= "Показать отсчет времени до Неотвратимого рока",
	TimerSpore					= "Показать отсчет времени до Вызова споры",
	TimerAura					= "Показать отсчет времени до Мертвенной ауры"
})
-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Лоскутик"
})
L:SetOptionLocalization({
	WarningHateful				= "Показать предупреждение для Удара ненависти в рейд-чат\n(требуются права лидера или помощника)"
})
L:SetMiscLocalization({
	yell1 = "Лоскутик хочет поиграть!",
	yell2 = "Кел'Тузад создает Лоскутика, его воплощение войны!", -- correct this
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
	WarningInjection			= "Показать предупреждение для Мутагенного укола",
	SpecialWarningInjection		= "Показать спец-предупреждение для Мутагенного укола"
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
	WarningDecimateNow			= "Показать предупреждение для Истребления",
	WarningDecimateSoon			= "Показать пред-предупреждение Истребления",
	TimerDecimate				= "Показать отсчет времени до Истребления"
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
	Yell = "Сталагг раздавит тебя!", -- correct this
	Emote = "%s overloads!", -- ?
	Emote2 = "Tesla Coil overloads!", -- ?
})
L:SetOptionLocalization({
	WarningShiftCasting			= "Показать предупреждение для Сдвига полярности",
	WarningChargeChanged		= "Показать предупреждение когда ваша полярность изменена",
	WarningChargeNotChanged		= "Показать предупреждение когда ваша полярность не изменена",
	TimerShiftCast				= "Показать отсчет времени до Сдвига полярности",
	TimerNextShift				= "Показать отсчет времени до перезарядки Сдвига полярности",
	ArrowsEnabled				= "Показать стрелки (обычная \"2 camp\" стратегия)",
	ArrowsRightLeft				= "Показать стрелки влево/вправо для \"4 camp\" стратеги (влево, если полярность изменена, вправо, если нет)",
	ArrowsInverse				= "Обратнная \"4 camp\" стратеги (вправо, если полярность изменена, влево, если нет)",
	WarningThrow				= "Показать предупреждение для Броска",
	WarningThrowSoon			= "Показать пред-предупреждение Бросок",
	TimerThrow					= "Показать отсчет времени до Броска"
})
L:SetWarningLocalization({
	WarningShiftCasting			= "Сдвиг полярности через 5 секунд!",
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
	name = "Инструктор Разувиус"
})
L:SetMiscLocalization({
	Yell1 = "Show them no mercy!", -- correct this
	Yell2 = "The time for practice is over! Show me what you have learned!", -- correct this
	Yell3 = "Do as I taught you!", -- correct this
	Yell4 = "Sweep the leg... Do you have a problem with that?" -- correct this
})
L:SetOptionLocalization({
	WarningShoutNow				= "Показать предупреждение для Разрушительного крика",
	WarningShoutSoon			= "Показать пред-предупреждение Разрушительного крика",
	TimerShout					= "Показать отсчет времени до Разрушительного крика"
})
L:SetWarningLocalization({
	WarningShoutNow				= "Разрушительный крик!",
	WarningShoutSoon			= "Разрушительный крик через 5 секунд"
})
L:SetTimerLocalization({
	TimerShout					= "Разрушительный крик"
})
--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Готик Жнец"
})
L:SetOptionLocalization({
	TimerWave					= "Показать отсчет времени до Волны",
	TimerPhase2					= "Показать отсчет времени до Фазы 2",
	WarningWaveSoon				= "Показать пред-предупреждение Волны",
	WarningWaveSpawned			= "Показать предупреждение Волны призыва",
	WarningRiderDown			= "Показать предупреждение когда Всадник мертв",
	WarningKnightDown			= "Показать предупреждение когда Рыцарь мертв",
	WarningPhase2				= "Показать предупреждение для Фазы 2"
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
	yell						= "Foolishly you have sought your own demise.", -- correct this
	WarningWave1				= "%d %s",
	WarningWave2				= "%d %s и %d %s",
	WarningWave3				= "%d %s, %d %s и %d %s",
	Trainee						= "|4Ученик:Ученики;",
	Knight						= "|4Рыцарь:Рыцари;",
	Rider						= "|4Всадник:Всадники;",
})
----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Четыре Всадника"
})
L:SetOptionLocalization({
	TimerMark					= "Показать отсчет времени до Знака",
	WarningMarkSoon				= "Показать пред-предупреждение Знака",
	WarningMarkNow				= "Показать предупреждение для Знака",
	SpecialWarningMarkOnPlayer	= "Показать предупреждение когда >4 Знака на вас"
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
	WarningDrainLifeNow			= "Показать предупреждение для Похищения жизни",
	WarningDrainLifeSoon		= "Показать пред-предупреждение Похищения жизни",
	WarningAirPhaseSoon			= "Показать пред-предупреждение Воздушной фазы",
	WarningAirPhaseNow			= "Показать предупреждение для Воздушной фазы",
	WarningLanded				= "Показать предупреждение для Наземной фазы",
	TimerDrainLifeCD			= "Показать отсчет времени до Похищения жизни",
	TimerAir					= "Показать отсчет времени до Воздушной фазы",
	TimerLanding				= "Показать отсчет времени до Приземления",
	TimerIceBlast				= "Показать отсчет времени до Ледяное дыхание",
	WarningDeepBreath			= "Показать спец-предупреждение для Ледяное дыхание"
})
L:SetMiscLocalization({
	EmoteBreath = "%s takes a deep breath.", -- correct this
	WarningYellIceblock = "I'm an Ice Block!" -- correct this
})
L:SetWarningLocalization({
	WarningDrainLifeNow			= "Похищение жизни!",
	WarningDrainLifeSoon		= "Скоро Похищение жизни",
	WarningAirPhaseSoon			= "Воздушная фаза через 10 секунд",
	WarningAirPhaseNow			= "Воздушная фаза",
	WarningLanded				= "Сапфирон приземляется",
	WarningDeepBreath			= "Ледяное дыхание!",
})
L:SetTimerLocalization({
	TimerDrainLifeCD			= "Похищение жизни CD",
	TimerAir					= "Воздушная фаза",
	TimerLanding				= "Приземление",
	TimerIceBlast				= "Ледяное дыхание"
})
------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Кел'Тузад"
})
L:SetOptionLocalization({
	TimerPhase2					= "Показать отсчет времени до Фазы 2",
	WarningBlastTargets			= "Показать предупреждение для Ледяного взрыва",
	WarningPhase2				= "Показать предупреждение для Фазы 2",
	WarningFissure				= "Показать предупреждение для Расщелины тьмы",
	WarningMana					= "Показать предупреждение для Взорыва маны"
})
L:SetMiscLocalization({
	Yell = "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!" -- correct this
})
L:SetWarningLocalization({
	WarningBlastTargets			= "Ледяной взрыв: >%s<",
	WarningPhase2				= "Фаза 2",
	WarningFissure				= "Призыв Расщелины тьмы",
	WarningMana					= "Взорвать ману: >%s<"
})
L:SetTimerLocalization({
	TimerPhase2					= "Фаза 2"
})
