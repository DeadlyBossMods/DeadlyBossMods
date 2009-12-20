if GetLocale() ~= "ruRU" then return end

local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "Восстановление: %s"
local spellSoon			= "Скоро %s"
local optionWarning		= "Предупреждение для %s"
local optionPreWarning	= "Предупреждать заранее о %s"
local optionSpecWarning	= "Спец-предупреждение для %s"
local optionTimerCD		= "Отсчет времени до восстановления %s"
local optionTimerDur	= "Отсчет времени до %s"
local optionTimerCast	= "Время чтения заклинания %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
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

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
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
	name = "Ануб'арак (Группа)"
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

L:SetMiscLocalization({
	Outro	= "Твое путешествие начинается, юный принц. Собирай свои войска и отправляйся в царство вечных снегов, в Нордскол. Там мы и уладим все наши дела, там ты узнаешь свою судьбу."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Волны Стратхольма"
})

L:SetWarningLocalization({
	WarningWaveNow = "Волна %d: призыв %s",
})

L:SetTimerLocalization({
	TimerWaveIn	= "Следующая волна (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("Новая волна"),
	TimerWaveIn		= "Отсчет времени до cледующей волны (после босса из волны 5)",
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
	WarningElemental	= "Фаза элементаля",
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
	WarningStomp	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD	= optionTimerCD:format(GetSpellInfo(52237))
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
	Pull	= "Пора узнать кое-какие ответы! Начнем веселье!",
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
	WarningSplitSoon	= "Скоро Разделение",
	WarningSplitNow		= "Разделение",
	WarningMerge		= "Слияние"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Предупредить заранее о Разделении",
	WarningSplitNow		= "Предупредить о Разделении",
	WarningMerge		= "Предупредить о Слиянии"
})

L:SetMiscLocalization({
	SplitTrigger1		= "Меня на вас хватит!",
	SplitTrigger2		= "Вы получите больше, чем заслуживаете!",
	MergeTrigger		= "Ну а теперь, покончим с этим!"	
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
if UnitFactionGroup("player") == "Alliance" then
	commander = "Командир Колург"
elseif UnitFactionGroup("player") == "Horde" then
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
	MakeitCountTimer	= "Отсчет времени для Вам всем зачтется (достижение)"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Вам всем зачтется"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Маг-лорд Уром"
})

L:SetWarningLocalization({
	WarningTimeBomb		= debuff,
	WarningExplosion	= spell,
	SpecWarnBombYou 	= "Часовая бомба на вас"
})

L:SetTimerLocalization({
	TimerTimeBomb	= debuff,
	TimerExplosion	= spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou		= "Спец-предупреждение, когда Часовая бомба на вас"
})

L:SetMiscLocalization({
	CombatStart		= "Несчастные слепые глупцы!"
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
	WarningShiftEnd	= "Сдвиг плоскости заканчивается"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." заканчивается"), 	-- translate the word 'ending'
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Вам всем зачтется"
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
	SpecialWarningSpelllock = "Запрет чар - прекратите чтение заклинаний"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningSpelllock	= "Спец-предупреждение для запрета чар"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Нет! Я смогу это сделать… я смогу…"
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
	WarningPortalSoon	= "Скоро новый портал",
	WarningPortalNow	= "Портал %d",
	WarningBossNow		= "Прибытие Босса"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Портал %d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Новый портал"),
	WarningPortalSoon		= optionPreWarning:format("Новый портал"),
	WarningBossNow			= optionWarning:format("Босс"),
	TimerPortalIn			= "Отсчет времени до портала",
	ShowAllPortalWarnings	= "Предупреждение для всех порталов"
})

L:SetMiscLocalization({
	yell1		= "Тюремные охранники, уходим! Этих искателей приключений возьму на себя! Уходите быстрей!",
	WavePortal	= "Открыто порталов: (%d+)/18"
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
	specWarnDesecration	= "Осквернение - отбегите",
	warnExplode			= "Взрывание вурдалака-прислужника - бегите"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Спец-предупреждение, когда на вас Осквернение",
	warnExplode				= "Предупреждение, когда все вурдалаки-прислужники готовятся к Взрыванию.",
	SetIconOnMarkedTarget	= "Установить метку на цель под воздействием Метка смерти"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Нет! Я не могу... снова... проиграть."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Абсолютные чемпионы"
})

L:SetWarningLocalization({
	specWarnHaste	= "Ускорение на %s - рассейте заклинание",
	specWarnPoison	= "Бутыль яда - отбегите"
})

L:SetOptionLocalization({
	specWarnHaste	= "Спец-предупреждение, когда маг читает Ускорение (для рассеивания/кражи)",
	specWarnPoison	= "Спец-предупреждение, когда вы получаете урон от Бутыли яда"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Вы отлично сражались! Следующим испытанием станет битва с одним из членов Авангарда. Вы проверите свои силы в схватке с достойным соперником."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Исповедница Пейлтресс"
})

L:SetWarningLocalization({
    specwarnRenew	= "Обновление на %s - рассейте заклинание"
})

L:SetOptionLocalization({
    specwarnRenew	= "Спец-предупреждение, когда на цели Обновление (для рассеивания/кражи)"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Отличная работа!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Эдрик Чистый"
})

L:SetWarningLocalization({
	specwarnHammerofJustice	= "Молот правосудия на |3-5(%s) - рассейте заклинание",
	specwarnRadiance		= "Сияние - отвернитесь"
})

L:SetOptionLocalization({
	specwarnHammerofJustice	= "Спец-предупреждение для Молота правосудия (для рассеивания)",
	specwarnRadiance		= "Спец-предупреждение для Сияния",
	SetIconOnHammerTarget	= "Установить метку на цель под воздействием Молота правосудия"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Я сдаюсь! Я побежден. Отличная работа. Можно теперь убегать?"
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
	warnBarrel			= "Бочка на |3-5(>%s<)",
	specwarnDisarm		= "Обезвреживание Зловещего Варева - отбегите",
	specWarnBrew		= "Избавьтесь от варева прежде, чем она бросит вам другое!",
	specWarnBrewStun	= "СОВЕТ: Вы получили удар, не забудьте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	warnBarrel			= "Сообщить цели, под воздействием Бочка",
	specwarnDisarm		= "Спец-предупреждение для разоружения",
	specWarnBrew		= "Спец-предупреждение для Пива темной официантки",
	specWarnBrewStun	= "Спец-предупреждение для Оглушения темным пивом официантки",
	PlaySoundOnDisarm	= "Звуковой сигнал, когда разоружение",
	YellOnBarrel		= "Крикнуть, когда на вас Бочка"
})

L:SetMiscLocalization({
	YellBarrel	= "Бочка на мне!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Всадник без головы"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "Призыв Пульсирующих тыкв",
	specWarnHorsemanHead	= "Призыв Головы Всадника - переключитесь на голову"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Предупреждать о призыве Пульсирующих тыкв",
	specWarnHorsemanHead	= "Спец-предупреждение о призыве Головы Всадника"
})

L:SetMiscLocalization({
	HorsemanHead		= "Не надоело еще убегать?",
	HorsemanSoldiers	= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!",
	SayCombatEnd		= "Со смертью мы давно уже друзья...Что ждет теперь на пустоши меня?"
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
	warnPursuit			= "Преследование на >%s<",
	specWarnToxic		= "Токсический выброс - отбегите",
	specWarnPursuit		= "Вас преследуют - бегите",
	specWarnPoisonNova	= "Ядовитая звезда - отбегите!",
	specWarnMines		= "Минометный обстрел - двигайтесь!"
})

L:SetOptionLocalization({
	warnPursuit				= "Объявлять преследуемые цели",
	specWarnToxic			= "Спец-предупреждение, когда вы получаете урон от Токсического выброса",
	specWarnPursuit			= "Спец-предупреждение, когда вас преследуют",
	specWarnPoisonNova		= "Спец-предупреждение о $spell:68989 (отбежать)",
	specWarnMines			= "Спец-предупреждение о $spell:69015 (разбежаться)",
	PlaySoundOnPoisonNova	= "Звуковой сигнал при $spell:68989",
	PlaySoundOnPursuit		= "Звуковой сигнал при преследовании",
	SetIconOnPursuitTarget	= "Установить метку на преследуемую цель"
})

L:SetMiscLocalization({
	IckPursuit	= "%s преследует вас!",
	Barrage	= "%s начинает быстро создавать взрывающиеся снаряды.",
--	YellCombatEnd	= ""--in case removing kricks creatureid doesn't fix it thinking we wipe.
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Начальник кузни Гархлад"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Саронитовая глыба на >%s<",
	specWarnSaroniteRock		= "Саронитовый бросок на вас - отбегите",
	specWarnSaroniteRockNear	= "Саронитовый бросок около вас - отбегите",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Объявлять цели Броска саронита",
	specWarnSaroniteRock		= "Спец-предупреждение, когда Саронитовый бросок на вас",
	specWarnSaroniteRockNear	= "Спец-предупреждение, когда вы стоите рядом с целью Саронитового броска",
	specWarnPermafrost			= "Спец-предупреждение, когда превышено суммарное количество эффектов Вечной мерзлоты",
	SetIconOnSaroniteRockTarget	= "Установить метку на цель под воздействием Саронитовой скалы"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s швыряет в вас глыбой саронита!"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Повелитель Плети Тираний"
})

L:SetWarningLocalization({
	specWarnIcyBlast		= "Ледяной вихрь - отбегите",
	specWarnHoarfrost		= "Глыба падает на вас!",
	specWarnHoarfrostNear	= "Глыба падает около вас - бегите",
	specWarnOverlordsBrand	= "Клеймо верховного лорда на вас"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Битва начнется через"
}

L:SetOptionLocalization({
	specWarnIcyBlast			= "Спец-предупреждение, когда вы получаете урон от $spell:69628",
	specWarnHoarfrost			= "Спец-предупреждение, когда на вас $spell:69246",
	specWarnHoarfrostNear		= "Спец-предупреждение, когда около вас $spell:69246",
	specWarnOverlordsBrand		= "Спец-предупреждение, когда на вас $spell:69172",
	TimerCombatStart			= "Отсчет времени до начала боя",
	SetIconOnHoarfrostTarget	= "Устанавливать метки на цели заклинания $spell:69246"
})

L:SetMiscLocalization({
	CombatStart	= "Увы, бесстрашные герои, ваша навязчивость ускорила развязку. Вы слышите громыхание костей и скрежет стали за вашими спинами? Это предвестники скорой погибели.",
	HoarfrostTarget	= "Ледяной змей Иней смотрит на (%S+), готовя морозную атаку!",
	YellCombatEnd	= "Не может быть... Иней… Предупреди…"
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
	warnSoulstormSoon	= "Буря душ скоро",
	specwarnSoulstorm	= "Буря душ - приблизьтесь"
})

L:SetOptionLocalization({
	warnSoulstormSoon	= "Предупреждать заранее о $spell:68872 (на ~40%)",
	specwarnSoulstorm	= "Спец-предупреждение о $spell:68872 (подбежать ближе)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Пожиратель Душ"
})

L:SetWarningLocalization({
	specwarnMirroredSoul	= "Прекратите атаку",
	specwarnWailingSouls	= "Стенающие души - отбегите",
	specwarnPhantomBlast	= "Прерывание!"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Спец-предупреждение о прекращении атаки, при $spell:69051",
	specwarnWailingSouls	= "Спец-предупреждение о заклинании $spell:68899",
	specwarnPhantomBlast	= "Спец-предупреждение о заклинании $spell:68982 (для прерывания)",
	SetIconOnMirroredTarget	= "Устанавливать метки на цели заклинания $spell:69051"
})


---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Wave Timers"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Скоро новая волна",
	WarnNewWave		= "%s вступает в бой"
})

L:SetTimerLocalization({
	TimerNextWave	= "Следующая волна"
})

L:SetOptionLocalization({
	WarnNewWave			= "Предупреждать о вступлении босса в бой",
	WarnNewWaveSoon		= "Заранее предупреждать о новой волне",
	ShowAllWaveWarnings	= "Показывать все предупреждения для всех волн",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Отсчет времени до следующей волны (после босса 5-ой волны)",
	ShowAllWaveTimers	= "Отсчет времени для всех волн"
})

L:SetMiscLocalization({
	Falric		= "Фалрик",
	WaveCheck	= "Отражено атак призраков = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Фалрик"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Марвин"
})

L:SetWarningLocalization({
	SpecWarnWellCorruption	= "Колодец скверны - бегите!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnWellCorruption	= "Спец-предупреждение, когда вы стоите в Колодце скверны"
})

L:SetMiscLocalization({
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Побег от Короля-лича"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "Он слишком силен. Мы должны выбраться отсюда как можно скорее. Моя магия задержит его, но не надолго. Быстрее, герои!",
	YellCombatEnd	= "ОГОНЬ! ОГОНЬ!"
})