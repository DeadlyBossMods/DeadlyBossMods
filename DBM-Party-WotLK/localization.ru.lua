if GetLocale() ~= "ruRU" then return end

local L
--------------------------------
-- Ahn’Kahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Принц Талдарам"
})
L:SetWarningLocalization({
	WarningFlame				= "Огненная сфера",
	WarningEmbrace				= "Объятия вампира: >%s<"
})
L:SetTimerLocalization({
	TimerEmbrace				= "Объятия вампира: %s"
})
L:SetOptionLocalization({
	WarningFlame				= "Показать предупреждение для Огненной сферы",
	WarningEmbrace				= "Показать предупреждение для Объятий вампира",
	TimerEmbrace				= "Показать отсчет времени до Объятий вампира"
})
-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Старейшина Надокс"
})
L:SetWarningLocalization({
	WarningPlague				= "Родовой мор: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningPlague				= "Показать предупреждение для Родового мора"
})
-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Джедога Искательница Теней"
})
L:SetWarningLocalization({
	WarningThundershock			= "Громовой удар"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningThundershock			= "Показать предупреждение для Громового удара"
})
-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Глашатай Волаж"
})
L:SetWarningLocalization({
	WarningInsanity				= "Безумие",
	WarningShiver				= "Трепет: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningInsanity				= "Показать предупреждение для Безумия",
	WarningShiver				= "Показать предупреждение для Трепета"
})
--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Аманитар"
})
L:SetWarningLocalization({
	WarningMini					= "Мини",
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningMini					= "Показать предупреждение для ауры Мини",
})
-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Крик'тир Хранитель Врат"
})
L:SetWarningLocalization({
	WarningCurse				= "Проклятие усталости: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningCurse				= "Показать предупреждение для Проклятия усталости"
})
--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Хадронокс"
})
L:SetWarningLocalization({
	WarningLeech				= "Яд пиявки",
	WarningCloud				= "Едкое облако"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningLeech				= "Показать предупреждение для Яда пиявки",
	WarningCloud				= "Показать предупреждение для Едкого облака"
})
---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Ануб'арак"
})
L:SetWarningLocalization({
	WarningPound				= "Удар",
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningPound				= "Показать предупреждение для Удара",
})
--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Мясной Крюк"
})
L:SetWarningLocalization({
	WarningChains				= "Удушающие оковы: >%s<"
})
L:SetTimerLocalization({
	TimerChains					= "Удушающие оковы: %s"
})
L:SetOptionLocalization({
	WarningChains				= "Показать предупреждение для Удушающих оков",
	TimerChains					= "Показать отсчет времени до Удушающих оков",
})
------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Салрамм Плоторез"
})
L:SetWarningLocalization({
	WarningCurse				= "Проклятие искаженной плоти: >%s<",
	WarningSteal				= "Похищение плоти: >%s<",
	WarningGhoul				= "Призывание вурдалаков"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningCurse				= "Показать предупреждение для Проклятия искаженной плоти",
	WarningSteal				= "Показать предупреждение для Похищения плоти",
	WarningGhoul				= "Показать предупреждение для Призывания вурдалаков"
})
-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Хронолорд Эпох"
})
L:SetWarningLocalization({
	WarningStrike				= "Ранящий удар: >%s<",
	WarningTime					= "Время >%s<",
	WarningCurse				= "Проклятье усталости: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningStrike				= "Показать предупреждение для Ранящего удара",
	WarningTime					= "Показать предупреждение для Искажения/Остановки времени",
	WarningCurse				= "Показать предупреждение для Проклятия усталости"
})
---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Мал'Ганис"
})
L:SetWarningLocalization({
	WarningSleep				= "Сон: >%s<"
})
L:SetTimerLocalization({
	TimerSleep					= "Сон: %s"
})
L:SetOptionLocalization({
	WarningSleep				= "Показать предупреждение для Сна",
	TimerSleep					= "Показать отсчет времени до Сна"
})
----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Кровотролль"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Новос Призыватель"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Король Дред"
})
L:SetWarningLocalization({
	WarningFear					= "Страх",
	WarningBite					= "Болезненный укус: >%s<",
	WarningSlash				= "%s рана"
})
L:SetTimerLocalization({
	TimerFear					= "Восстановление Страха",
	TimerSlash					= "%s рана: %s"
})
L:SetOptionLocalization({
	WarningSlash				= "Показать предупреждение для Калечащей/Проникающей раны",
	WarningFear					= "Показать предупреждение для Страха",
	WarningBite					= "Показать предупреждение для Болезненного укуса",
	TimerFear					= "Показать отсчет времени до Страха",
	TimerSlash					= "Показать время действия Калечащей/Проникающей раны"
})
---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Пророк Тарон'джа"
})
L:SetWarningLocalization({
	WarningCloud				= "Ядовитое облако"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningCloud				= "Показать предупреждение для Ядовитого облака"
})
--------------
-- Gun'Drak --
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Слад'ран"
})
L:SetWarningLocalization({
	WarningNova					= "Ядовитая звезда",
	WarningBite					= "Мощный укус: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningNova					= "Показать предупреждение для Ядовитой звезды",
	WarningBite					= "Показать предупреждение для Мощного укуса"
})
-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Мураби"
})
L:SetWarningLocalization({
	WarningMojo					= "Колдовское бешенство"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningMojo					= "Показать предупреждение для Колдовского бешенства"
})
-----------------------
-- Drakkari Colossus --
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Колосс Драккари"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Гал'дара"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
-----------------------
-- Eck the Ferocious --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Эк Свирепый"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
------------------------
-- Halls of Lightning --
------------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "Генерал Бьярнгрин"
})
L:SetWarningLocalization({
	WarningWhirlwind	= "Вихрь"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningWhirlwind	= "Показать предупреждение для Вихря"
})
-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ионар"
})
L:SetWarningLocalization({
	WarningOverload				= "Статический заряд: >%s<",
	WarningSplit				= "Рассеяние/Разделение"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningOverload				= "Показать предупреждение для Статического заряда",
	WarningSplit				= "Показать предупреждение для Рассеяния"
})
-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "Волхан"
})
L:SetWarningLocalization({
	WarningStomp = "Раскатистый топот"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningStomp				= "Показать предупреждение для Раскатистого топота"
})
------------
-- Loken --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Локен"
})
L:SetWarningLocalization({
	WarningNova					= "Вспышка молнии"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningNova					= "Показать предупреждение для Вспышки молнии"
})
--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Дева Скорби"
})
L:SetWarningLocalization({
	WarningWoe					= "Столп скорбей: >%s<",
	WarningSorrow				= "Шок от горя",
	WarningStorm				= "Буря Скорби"
})
L:SetTimerLocalization({
	TimerWoe					= "Столп скорбей: %s",
	TimerSorrow					= "Шок от горя"
})
L:SetOptionLocalization({
	WarningWoe					= "Показать предупреждение для Столпа скорбей",
	WarningSorrow				= "Показать предупреждение для Шока от горя",
	WarningStorm				= "Показать предупреждение для Бури Скорби",
	TimerWoe					= "Показать отсчет времени до Столпа скорбей",
	TimerSorrow					= "Показать отсчет времени до Шока от горя"
})
----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "Кристаллус"
})
L:SetWarningLocalization({
	WarningShatter				= "Скоро Обледенение"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningShatter				= "Показать пред-предупреждение Обледенения"
})
----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Сьоннир Литейщик"
})
L:SetWarningLocalization({
	WarningCharge				= "Статический заряд: >%s<",
	WarningRing					= "Щит молний"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningCharge				= "Показать предупреждение для Статического заряда",
	WarningRing					= "Показать предупреждение для Щита молний"
})
------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Бранн Бронзобород" -- Escort Event
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Аномалус"
})
L:SetWarningLocalization({
	WarningRiftSoon				= "Скоро Щит расселины",
	WarningRiftNow				= "Невосприимчив к урону!"
})
L:SetOptionLocalization({
	WarningRiftSoon				= "Показать пред-предупреждение Щита расселины",
	WarningRiftNow				= "Показать предупреждение для Щита расселины"
})
-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Орморок Воспитатель Дерев"
})
L:SetWarningLocalization({
	WarningSpikes				= "Кристальные шипы",
	WarningReflection			= "Отражение заклинания",
	WarningFrenzy				= "Бешенство",
	WarningAdd					= "Призыв кристаллического ветвеплета"
})
L:SetTimerLocalization({
	TimerReflection				= "Отражение заклинания"
})
L:SetOptionLocalization({
	WarningSpikes				= "Показать предупреждение для Кристальных шипов",
	WarningReflection			= "Показать предупреждение для Отражения заклинания",
	WarningFrenzy				= "Показать предупреждение для Бешенства",
	WarningAdd					= "Показать предупреждение, когда призван ветвеплет",
	TimerReflection				= "Показать отсчет времени до Отражения заклинания"
})
--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Великая ведунья Телестра"
})
L:SetWarningLocalization({
	WarningSplitSoon			= "Скоро Разделение",
	WarningSplitNow				= "Разделение",
	WarningMerge				= "Размытие"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningSplitSoon			= "Показать пред-предупреждение Разделения",
	WarningSplitNow				= "Показать предупреждение для Разделения",
	WarningMerge				= "Показать предупреждение для Размытия"
})
L:SetMiscLocalization({
	SplitTrigger1				= "There's plenty of me to go around.", -- correct this
	SplitTrigger2				= "I'll give you more than you can handle.", -- correct this
	MergeTrigger				= "Now to finish the job!" -- correct this
})
-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Керистраза"
})
L:SetWarningLocalization({
	WarningChains				= "Хрустальные цепи: >%s<",
	WarningEnrage				= "Исступление"
})
L:SetTimerLocalization({
	TimerChains					= "Хрустальные цепи: %s"
})
L:SetOptionLocalization({
	WarningChains				= "Показать предупреждение для Хрустальных цепей",
	WarningEnrage				= "Показать предупреждение для Исступления",
	TimerChains					= "Показать отсчет времени до Хрустальных цепей"
})
---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local faction = UnitFactionGroup("player")
local commander = "Квестовый"
if faction == "Альянс" then
	commander = "Командир Колург"
elseif faction == "Орда" then
	commander = "Командир Пивобород"
end

L:SetGeneralLocalization({
	name = commander
})
L:SetWarningLocalization({
	WarningFear 				= "Страх",
	WarningWhirlwind			= "Вихрь"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningFear					= "Показать предупреждение для Страха",
	WarningWhirlwind			= "Показать предупреждение для Вихря"
})
----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Дракос Дознаватель"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Маг-лорд Уром"
})
L:SetWarningLocalization({
	WarningTimeBomb				= "Часовая бомба",
	WarningExplosion			= "Чародейский взрыв"
})
L:SetTimerLocalization({
	TimerTimeBomb				= "Часовая бомба: %s",
	TimerExplosion				= "Чародейский взрыв"
})
L:SetOptionLocalization({
	WarningTimeBomb				= "Показать предупреждение для Часовой бомбы",
	WarningExplosion			= "Показать предупреждение для Чародейского взрыва",
	TimerTimeBomb				= "Показать отсчет времени до Часовой бомбы",
	TimerExplosion				= "Показать отсчет времени до Чародейского взрыва",
	SpecWarnBombYou				= "Показать спец-предупреждение для Часовой бомбы"
})
------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Варос Заоблачный Странник"
})
L:SetWarningLocalization({
	WarningAmplify				= "Усиление магии: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningAmplify				= "Показать предупреждение для Усиления магии"
})
-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Хранитель энергии Эрегос"
})
L:SetWarningLocalization({
	WarningShift				= "Сдвиг плоскости",
	WarningShiftEnd				= "Окончание Сдвига плоскости",
	WarningEnrage				= "Яростный натиск"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningShift				= "Показать предупреждение для Сдвига плоскости",
	WarningShiftEnd				= "Показать предупреждение \"Окончание Сдвига плоскости\"",
	WarningEnrage				= "Показать предупреждение для Яростного натиска"
})
------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Принц Келесет"
})
L:SetWarningLocalization({
	WarningTomb					= "Ледяная могила: >%s<",
})
L:SetTimerLocalization({
	TimerTomb					= "Ледяная могила: %s",
})
L:SetOptionLocalization({
	WarningTomb					= "Показать предупреждение для Ледяной могилы",
	TimerTomb					= "Показать отсчет времени до Ледяной могилы",
})
------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Скарвальд и Далронн"
})
L:SetWarningLocalization({
	WarningEnfeeble				= "Изнурение: >%s<",
	WarningSummon				= "Призыв скелетов"
})
L:SetTimerLocalization({
	TimerEnfeeble				= "Изнурение: %s",
})
L:SetOptionLocalization({
	WarningEnfeeble				= "Показать предупреждение для Изнурения",
	WarningSummon				= "Показать предупреждение для призывания скелетов",
	TimerEnfeeble				= "Показать отсчет времени до Изнурения"
})
--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ингвар Расхититель"
})
L:SetWarningLocalization({
	WarningSmash				= "%s",
	WarningGrowl				= "%s",
	WarningWoeStrike			= "Удар скорби: >%s<",
	SpecialWarningSpelllock		= "Запрет чар - остановите чтение заклинаний!"
})
L:SetTimerLocalization({
	TimerSmash					= "%s",
	TimerWoeStrike				= "Удар скорби: %s"
})
L:SetOptionLocalization({
	WarningSmash				= "Показать предупреждение для Мощного удара",
	WarningGrowl				= "Показать предупреждение для Ошеломляющего рева",
	WarningWoeStrike			= "Показать предупреждение для Удара скорби", -- written Woe Stike, need Woe Strike
	TimerSmash					= "Показать отсчет времени до Мощного удара",
	TimerWoeStrike				= "Показать отсчет времени до Удара скорби",
})
----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Скади Безжалостный"
})
L:SetWarningLocalization({
	WarningWhirlwind			= "Вихрь",
	WarningPoison				= "Отравленный дротик: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningWhirlwind			= "Показать предупреждение для Вихря",
	WarningPoison				= "Показать предупреждение для Отравленного дротика"
})
------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Король Имирон"
})
L:SetWarningLocalization({
	WarningBane					= "Погибель"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningBane					= "Показать предупреждение для Погибели"
})
-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Свала Вечноскорбящая"
})
L:SetWarningLocalization({
	WarningSword				= "Ритуал меча: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningSword				= "Показать предупреждение для Жертвоприношения"
})
---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Горток Бледное Копыто"
})
L:SetWarningLocalization({
	WarningImpale				= "Прокалывание: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningImpale				= "Показать предупреждение для Прокалывания"
})
---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Синигоса"
})
L:SetWarningLocalization({
	WarningVacuum				= "Чародейский вакуум",
	WarningBlizzard				= "Снежная буря",
	WarningMana					= "Захват маны: >%s<"
})
L:SetTimerLocalization({
	TimerVacuum					= "Следующий Чародейский вакуум"
})
L:SetOptionLocalization({
	WarningVacuum				= "Показать предупреждение для Чародейского вакуума",
	WarningBlizzard				= "Показать предупреждение для Снежной бури",
	WarningMana					= "Показать предупреждение для Захвата маны",
	TimerVacuum					= "Показать отсчет времени до Чародейского вакуума"
})
------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Эрекем"
})
L:SetWarningLocalization({
	WarningES					= "Щит Земли"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningES					= "Показать предупреждение для Щита Земли"
})
-------------
-- Ichoron --
-------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Гнойрон"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Лавантор"
})
L:SetWarningLocalization({
})
L:SetTimerLocalization({
})

L:SetOptionLocalization({
})
------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Морагг"
})
L:SetWarningLocalization({
	WarningLink					= "Оптическая связь: >%s<"
})
L:SetTimerLocalization({
})
L:SetOptionLocalization({
	WarningLink					= "Показать предупреждение для Оптической связи"
})
------------
-- Xevoss --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Ксевозз"
})
L:SetWarningLocalization({
})

L:SetTimerLocalization({
})
L:SetOptionLocalization({
})
-----------------------------
-- Zuramat the Obliterator --
-----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Зурамат Уничтожитель"
})
L:SetWarningLocalization({
	WarningVoidShift			= "Вхождение в Бездну: >%s<",
	WarningVoidShifted			= ">%s< бьется с призваным караульным Бездны",
	WarningShroudOfDarkness		= "Покров Тьмы - остановите урон",
	SpecialWarningVoidShifted	= "Вы отброшены в Бездну!",
	SpecialShroudofDarkness		= "Покров Тьмы - остановите урон",
})
L:SetTimerLocalization({
	TimerVoidShift				= "Вхождение в Бездну: %s",
	TimerVoidShifted			= "В Бездне: %s",
})
L:SetOptionLocalization({
	WarningVoidShift			= "Показать предупреждение для Вхождения в Бездну",
	WarningVoidShifted			= "Показать предупреждение для отброса игрока в Бездну",
	WarningShroudOfDarkness		= "Показать предупреждение для Покрова Тьмы",
	SpecialWarningVoidShifted	= "Показать спец-предупреждение для Вхождения в Бездну",
	SpecialShroudofDarkness		= "Показать спец-предупреждение для Покрова Тьмы",
	TimerVoidShift				= "Показать отсчет времени до Вхождения в Бездну",
	TimerVoidShifted			= "Показать отсчет времени игрока в Бездне",
})
-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Таймер Портала"
})
L:SetWarningLocalization({
	WarningPortalSoon			= "Скоро новый портал",
	WarningPortalNow			= "Портал %d",
	WarningBossNow				= "Босс приближается"
})
L:SetTimerLocalization({
	TimerPortalIn				= "Портал %d" , 
})
L:SetOptionLocalization({
	WarningPortalNow			= "Показать предупреждение для Нового Портала",
	WarningPortalSoon			= "Показать пред-предупреждение Нового Портала",
	WarningBossNow				= "Показать предупреждение для Босса",
	TimerPortalIn				= "Показать отсчет времени до Портала",
	ShowAllPortalWarnings		= "Показать предупреждение для всех волн"
})
L:SetMiscLocalization({
	yell1 = "Prison guards, we are leaving! These adventurers are taking over! Go go go!", -- correct this
})
