if GetLocale() ~= "ruRU" then return end

local L

local spell		= "%s"				
local debuff		= "%s: >%s<"			
local spellCD		= "Восстановление: %s"
local spellSoon		= "Скоро %s"
local optionWarning	= "Предупреждение для %s"
local optionPreWarning	= "Предупреждать заранее о %s"
local optionSpecWarning	= "Спец-предупреждение для %s"
local optionTimerCD	= "Отсчеть времени до восстановления %s"
local optionTimerDur	= "Отсчет времени до %s"
local optionTimerCast	= "Время чтения заклинания %s"


----------------------------------
--  Ahn’Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Принц Талдарам"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Старейшина Надокс"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Джедога Искательница Теней"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Глашатай Волаж"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Аманитар"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Крик'тир Хранитель Врат"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Хадронокс"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Ануб'арак"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Мясной Крюк"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Салрамм Плоторез"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Хронолорд Эпох"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Мал'Ганис"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Очищение Стратхольма"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Волна %d: призыв %s",
})

L:SetTimerLocalization({
	TimerWaveIn		= "Следующая волна (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("Новая волна"),
	TimerWaveIn		= "Отсчет времени до cледующей волны (только волна 6)",
})


L:SetMiscLocalization({
	Meathook	= "Мясной Крюк",
	Salramm		= "Салрамм Плоторез",
	Devouring	= "Всепожирающий вурдалак",
	Enraged		= "Разъярившийся вурдалак",
	Necro		= "Мастер некромантии",
	Friend		= "Некрорахнид",
	Tomb		= "Кладбищенский ловец",
	Abom		= "Лоскутное создание",
	Acolyte		= "Послушник",
	Wave1		= "%d %s",
	Wave2		= "%d %s и %d %s",
	Wave3		= "%d %s, %d %s и %d %s",
	Wave4		= "%d %s, %d %s, %d %s и %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Волна плети = %d/10"
})


------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
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


--------------------------
--  Novos the Summoner  --
--------------------------
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


-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Король Дред"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Пророк Тарон'джа"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Слад'ран"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Мураби"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Колосс Драккари"
})

L:SetWarningLocalization({
	warningElemental	= "Фаза элементаля",
	WarningStone		= "Фаза колосса"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Предупреждение для фазы элементаля",
	WarningStone		= "Предупреждение для фазы колосса"
})


-----------------
--  Gal'darah  --
-----------------
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

-------------------------
--  Eck the Ferocious  --
-------------------------
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


--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "Генерал Бьярнгрин"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ионар"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "Волхан"
})

L:SetWarningLocalization({
	WarningStomp 	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp 	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD 	= optionTimerCD:format(GetSpellInfo(52237))
})


--------------
--  Kronus  --
--------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Локен"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Дева Скорби"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "Кристаллус"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})


------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Сьоннир Литейщик"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Бранн Бронзобород"
})

L:SetWarningLocalization({
	WarningPhase	= "Фаза %d"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Фаза")
})

L:SetMiscLocalization({
	Pull	= "Теперь будьте внимательны! Не успеете и глазом моргнуть, как...",
	Phase1	= "xxx анти-ошибка xxx",
	Phase2	= "xxx анти-ошибка xxx",
	Phase3	= "xxx анти-ошибка xxx"
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Аномалус"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})


-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Орморок Воспитатель Дерев"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Великая ведунья Телестра"
})

L:SetWarningLocalization({
	WarningMerge		= "Предупредить о Размытии"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningMerge		= optionWarning:format("Размытие"),
})

L:SetMiscLocalization({
	SplitTrigger1 		= "Меня на вас хватит!",
	SplitTrigger2		= "Вы получите больше, чем заслуживаете!",
	MergeTrigger 		= "Ну теперь, покончим с этим!"	
})


-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Керистраза"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Неизвестный"
if UnitFactionGroup("player") == "Альянс" then
	commander = "Командир Колург"
elseif UnitFactionGroup("player") == "Орда" then
	commander = "Командир Пивобород"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
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

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Маг-лорд Уром"
})

L:SetWarningLocalization({
	WarningTimeBomb 	= debuff,
	WarningExplosion 	= spell,
	SpecWarnBombYou 	= "Часовая бомба на вас"
})

L:SetTimerLocalization({
	TimerTimeBomb = debuff,
	TimerExplosion = spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou		= "Спец-предупреждение, когда Часовая бомба на вас"
})


--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Варос Заоблачный Странник"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Хранитель энергии Эрегос"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "Сдвига плоскости заканчивается"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." заканчивается"), 	-- translate the word 'ending'
})



--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Принц Келесет"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Скарвальд и Далронн"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ингвар Расхититель"
})

L:SetWarningLocalization({
	SpecialWarningSpelllock 	= "Запрет чар - прекратите чтение заклинаний!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningSpelllock		= "Спец-предупреждение для запрета чар"
})


------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Скади Безжалостный"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Король Имирон"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})



-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Свала Вечноскорбящая"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Горток Бледное Копыто"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Синигоса"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Эрекем"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
--  Ichoron  --
---------------
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


-----------------
--  Lavanthor  --
-----------------
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


--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Морагг"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


--------------
--  Xevozz  --
--------------
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


-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Зурамат Уничтожитель"
})

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
})


---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Портал Времени"
})

L:SetWarningLocalization({
	WarningPortalSoon		= "Скоро новый портал",
	WarningPortalNow		= "Портал #%d",
	WarningBossNow			= "Прибытие Босса"
})

L:SetTimerLocalization({
	TimerPortalIn			= "Портал %d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Новый портал"),
	WarningPortalSoon		= optionPreWarning:format("Новый портал"),
	WarningBossNow			= optionWarning:format("Босс"),
	TimerPortalIn			= "Отсчет времени до портала",
	ShowAllPortalWarnings		= "Предупреждение для всех волн"
})


L:SetMiscLocalization({
	yell1 				= "Тюремные охранники, уходим! Этих искателей приключений возьму на себя! Уходите быстрей!",
	WavePortal			= "Открыто порталов: (%d+)/18"
})


-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Черный рыцарь"
})

L:SetWarningLocalization({
	specWarnDesecration		= "Осквернение - бегите",
	warnExplode			= "Вурдалак-прислужник готовится к Взрыванию - бегите"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Спец-предупреждение, когда на вас Осквернение",
	warnExplode			= "Предупреждение, когда все вурдалаки-прислужники готовятся к Взрыванию.",
	SetIconOnMarkedTarget		= "Установить метку на цель под воздействием Метка смерти"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Нет! Я не могу... снова... проиграть."
})
-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Абсолютные чемпионы"
})

L:SetWarningLocalization({
	specWarnHaste			= "Ускорение на >%s<! Рассейте заклинание!",
	specWarnPoison			= "Бутыль яда! Отбегите!"
})

L:SetOptionLocalization({
	specWarnHaste			= "Спец-предупреждение, когда маг читает Ускорение (для рассеивания/прерывания)",
	specWarnPoison			= "Спец-предупреждение, когда вы получаете урон от Бутыля яда"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Вы отлично сражались! Следующим испытанием станет битва с одним из членов Авангарда. Вы проверите свои силы в схватке с достойным соперником."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Исповедница Пейлтресс"
})

L:SetWarningLocalization({
	specwarnRenew			= "Исповедница читает заклинаие Обновление на >%s<. Рассейте заклинание!"
})

L:SetOptionLocalization({
	specwarnRenew			= "Спец-предупреждение, когда на цели Обновление (для рассеивания/прерывания)"
})

L:SetMiscLocalization({
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Эдрик Чистый"
})

L:SetWarningLocalization({
	specwarnHammerofJustice		= "Молот правосудия на >%s<. Рассейте заклинание!",
	specwarnRadiance		= "Сияние. Отвернитесь!"
})

L:SetOptionLocalization({
	specwarnHammerofJustice		= "Спец-предупреждение для Молота правосудия (для рассеивания)",
	specwarnRadiance		= "Спец-предупреждение для Сияния",
	SetIconOnHammerTarget		= "Установить метку на цель под воздействием Молота правосудия"
})

L:SetMiscLocalization({
})

--------------------
--  World Events  --
----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Корен Худовар"
})

L:SetWarningLocalization({
	warnBarrel			= "Бочка на >%s<",
	specwarnDisarm			= "Обезвреживание Зловещего Варева. Отбегите!",
	specWarnBrew			= "Избавьтесь от варева прежде, чем она бросит вам другое!",
	specWarnBrewStun		= "СОВЕТ: Вы получили удар, не забудте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	warnBarrel			= "Сообщить цели, под воздействием Бочка",
	DisarmWarning			= "Спец-предупреждение для разоружения",
	specWarnBrew			= "Спец-предупреждение для Пива темной официантки",
	specWarnBrewStun		= "Спец-предупреждение для Оглушения темным пивом официантки",
	PlaySoundOnDisarm		= "Звуковой сигнал, когда разоружение",
	YellOnBarrel			= "Крикнуть, когда на вас Бочка"
})

L:SetMiscLocalization({
	YellBarrel			= "Бочка на мне!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Всадник без головы"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Призыв Пульсирующих тыкв!",
	specWarnHorsemanHead		= "Призыв Головы Всадника! Переключитесь на голову!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Предупреждать о призыве Пульсирующих тыкв",
	specWarnHorsemanHead		= "Спец-предупреждение о призыве Головы Всадника"
})

L:SetMiscLocalization({
	HorsemanHead			= "Не надоело еще убегать?",
	HorsemanSoldiers		= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!",
	SayCombatEnd			= "Со смертью мы давно уже друзья...Что ждет теперь на пустоши меня?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ик и Крик"
})

L:SetWarningLocalization({
	warnPursuit			= "Погоня через 5 секунд",
	specWarnToxic			= "Токсический выброс! Отбегите!",
	specWarnPursuit			= "Вас приследуют. Бегите!"
})

L:SetOptionLocalization({
	warnPursuit			= "Предупреждение о приблежающейся Погоне",
	specWarnToxic			= "Спец-предупреждение, когда вы получаете урон от Токсического выброса",
	specWarnPursuit			= "Спец-предупреждение, когда вас преследуют"
--	SetIconOnPursuitTarget		= "Установить метку на преследуемую цель"
})

L:SetMiscLocalization({
	IckPursuit			= "%s преследует вас!"
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Начальник кузни Гарфрост"
})

L:SetWarningLocalization({
	warnSaroniteRock		= "Саронитовая скала! Линия видимости!",
	specWarnSaroniteRock		= "Саронитовый бросок на вас! Бегите!",
	specWarnPermafrost		= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock		= "Предупреждение для Саронитовой скалы (очистка Вечной мерзлотой)",
	specWarnSaroniteRock		= "Спец-предупреждение, когда Саронитовый бросок на вас",
	specWarnPermafrost		= "Спец-предупреждение, когда превышено суммарное количество эффектов Вечной мерзлоты"
--	SetIconOnSaroniteRockTarget	= "Установить метку на цель под воздействием Саронитовой скалы"
})

L:SetMiscLocalization({
	SaroniteRockThrow		= "%s бросает огромный саронитовый валун в вас!"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Повелитель Плети Тираний"
})

L:SetWarningLocalization({
	specTyrannusEngaged		= "Повелитель Плети Тираний спускается. Приготовтесь!",
	specWarnIcyBlast		= "Ледяной вихр! Бегите!",
	specWarnHoarfrost		= "Hoarfrost на вас! Бегите!",
	specWarnHoarfrostNear		= "Hoarfrost около вас! Бегите!"
})

L:SetOptionLocalization({
	specWarnIcyBlast		= "Спец-предупреждение, когда вы получаете урон от Ледяного вихря",
	specWarnHoarfrost		= "Спец-предупреждение, когда Hoarfrost на вас",
	specWarnHoarfrostNear		= "Спец-предупреждение, когда Hoarfrost около вас",
	SetIconOnHoarfrostTarget	= "Установить метку на цель под воздействием Hoarfrost"
})

L:SetMiscLocalization({
	TyrannusYell			= "Увы, ",
	HoarfrostTarget			= "^%%s пристально смотрит на (%S+) и готовится к ледяной атаке!"
})
----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Броньям"
})

L:SetWarningLocalization({
	specwarnSoulstorm		= "Soulstorm! Приблизьтесь!"
})

L:SetOptionLocalization({
	specwarnSoulstorm		= "Спец-предупреждение, когда Soulstorm (подбежать ближе)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Пожиратель душ"
})

L:SetWarningLocalization({
	specwarnMirroredSoul		= "Прекратите атаку!"
})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "Спец-предупреждение о прикращении атаки, при Mirrored Soul"
})
