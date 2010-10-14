if GetLocale() ~= "ruRU" then return end

local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "Восстановление %s"
local spellSoon			= "Скоро %s"
local optionWarning		= "Предупреждение для %s"
local optionPreWarning	= "Предупреждать заранее о %s"
local optionSpecWarning	= "Спец-предупреждение для %s"
local optionTimerCD		= "Отсчет времени до восстановления %s"
local optionTimerDur	= "Отсчет времени для %s"
local optionTimerCast	= "Отсчет времени применения заклинания %s"

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
	name = "Ануб'арак (группа)"
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
	TimerWaveIn		= "Следующая волна (6)",
	TimerRoleplay	= "Вступительное представление"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("новой волны"),
	TimerWaveIn		= "Отсчет времени до cледующей волны (после босса 5-ой волны)",
	TimerRoleplay	= "Отсчет времени для вступительного представления"
})

L:SetMiscLocalization({
	Meathook	= "Мясной Крюк",
	Salramm		= "Салрамм Плоторез",
	Devouring	= "Всепожирающий вурдалак",
	Enraged		= "Разъярившийся вурдалак",
	Necro		= "Некромант",
	Fiend		= "Некрорахнид",
	Stalker		= "Кладбищенский ловец",
	Abom		= "Лоскутное создание",
	Acolyte		= "Послушник",
	Wave1		= "%d %s",
	Wave2		= "%d %s и %d %s",
	Wave3		= "%d %s, %d %s и %d %s",
	Wave4		= "%d %s, %d %s, %d %s и %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Атаки Плети: (%d+)/10",
	Roleplay	= "Я рад, что ты пришел, Утер!",
	Roleplay2	= "Похоже, все готовы. Помните, эти люди заражены чумой и скоро умрут. Мы должны очистить Стратхольм и защитить Лордерон от Плети. Вперед."
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
	WarnCrystalHandler	= "Хрустальный укротитель (%d осталось)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Хрустальный укротитель"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Предупреждение при появлении Хрустального укротителя",
	timerCrystalHandler	= "Отсчет времени до появления следующего Хрустального укротителя"
})

L:SetMiscLocalization({
	YellPull		= "Вам холодно? Это дыхание скорой смерти.",
	HandlerYell		= "Защищайте меня! Быстрее, будьте вы прокляты!",
	Phase2			= "Неужели вы не понимаете всей бесполезности происходящего?",
	YellKill		= "Ваши усилия… напрасны."
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
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
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
	name = "Эскорт Бранна"
})

L:SetWarningLocalization({
	WarningPhase	= "Фаза %d"
})

L:SetTimerLocalization({
	timerEvent	= "Оставшееся время"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("фазе"),
	timerEvent		= "Отсчет времени продолжительности события"
})

L:SetMiscLocalization({
	Pull	= "Теперь будьте внимательны! Не успеете и глазом моргнуть, как…",
	Phase1	= "Обнаружено вторжение в систему. Приоритетность работ по анализу исторических архивов понижена. Ответные меры инициированы.",
	Phase2	= "Порог допустимой угрозы превышен. Астрономический архив отключен. Уровень безопасности повышен.",
	Phase3	= "Критическое значение уровня угрозы. Перенаправление анализа Бездны. Инициирование протокола очищения.",
	Kill	= "Внимание: меры предосторожности деактивированы. Начинаю стирание памяти и…"
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
	WarningSplitSoon	= "Предупреждать заранее о Разделении",
	WarningSplitNow		= "Предупреждать о Разделении",
	WarningMerge		= "Предупреждать о Слиянии"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarningShiftEnd	= optionWarning:format("окончания "..GetSpellInfo(51162)),
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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

L:SetMiscLocalization({
	CombatStart		= "Что за недоноски осмелились вторгнуться сюда? Поживее, братья мои! Угощение тому, кто принесет мне их головы!",
	Phase2			= "Ничтожные лакеи! Ваши трупы послужат хорошей закуской для моего нового дракона!"
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
	timerRoleplay		= "Начало боя"
})

L:SetOptionLocalization({
	timerRoleplay		= "Отсчет времени для представления перед началом боя"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Мой господин! Я сделала, как вы велели, и теперь молю вас о благословении!"
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
	TimerCombatStart		= "Начало боя"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Отсчет времени до начала боя"
})

L:SetMiscLocalization({
	CyanArrived	= "Вы доблестно обороняетесь, но этот город должен быть стерт с лица земли, и я лично исполню волю Малигоса!"
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
	name = "Таймеры порталов"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Скоро новый портал",
	WarningPortalNow	= "Портал #%d",
	WarningBossNow		= "Прибытие Босса"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Портал #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("нового портала"),
	WarningPortalSoon		= optionPreWarning:format("новом портале"),
	WarningBossNow			= optionWarning:format("прибытия босса"),
	TimerPortalIn			= "Отсчет времени до следующего портала (после босса)",
	ShowAllPortalTimers		= "Отсчет времени для всех порталов (неточный)"
})

L:SetMiscLocalization({
	yell1		= "Эй, стражи! Уходим! Славные герои обо всем позаботятся. За мной!",
	Sealbroken	= "Мы прорвались через тюремные ворота! Дорога в Даларан открыта! Теперь мы наконец прекратим войну Нексуса!",
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
	warnExplode			= "Взрывание вурдалака-прислужника - бегите"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Начало боя"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Отсчет времени до начала боя",
	warnExplode				= "Предупреждение, когда все вурдалаки-прислужники готовятся к разрыву.",
	AchievementCheck		= "Объявлять о провале достижения 'Бывало и хуже' в чат группы",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull				= "Великолепно. Сегодня вы в честной борьбе заслужили…",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил урон от Взрыва вурдалака <<",
	YellCombatEnd		= "Нет! Я не могу... снова... проиграть."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Абсолютные чемпионы"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
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
})

L:SetOptionLocalization({
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
	specwarnRadiance		= "Сияние - отвернитесь"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Спец-предупреждение для $spell:66935",
	SetIconOnHammerTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "Я сдаюсь! Я побежден. Отличная работа. Можно теперь убегать?"
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
	warnPursuit			= "Преследование за |3-4(>%s<)",
	specWarnPursuit		= "Вас преследуют - бегите"
})

L:SetOptionLocalization({
	warnPursuit				= "Объявлять цели Преследования",
	specWarnPursuit			= "Спец-предупреждение, когда вас преследуют",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit	= "%s преследует вас!",
	Barrage	= "%s начинает быстро создавать взрывающиеся снаряды."
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Начальник кузни Гархлад"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Бросок саронита на |3-3(>%s<)",
	specWarnSaroniteRock		= "Бросок саронита на вас - отбегите",
	specWarnSaroniteRockNear	= "Бросок саронита около вас - отбегите",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Объявлять цели заклинания $spell:70851",
	specWarnSaroniteRock		= "Спец-предупреждение, когда вас выбрали целью заклинания \n$spell:70851",
	specWarnSaroniteRockNear	= "Спец-предупреждение, когда вы около цели заклинания \n$spell:70851",
	specWarnPermafrost			= "Спец-предупреждение при слишком большом количестве стаков \nзаклинания $spell:70336 (11 стаков)",
	AchievementCheck			= "Объявлять предупреждения о достижении 'Не жди до одиннадцати!' в чат группы",
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s швыряет в вас глыбой саронита!",
	AchievementWarning	= "Предупреждение: %s получил 5 стаков Вечной мерзлоты",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил %d стаков Вечной мерзлоты <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Повелитель Плети Тираний"
})

L:SetWarningLocalization({
	specWarnHoarfrost		= "Седой мороз на вас",
	specWarnHoarfrostNear	= "Седой мороз около вас - отбегите"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Битва начнется через"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "Спец-предупреждение, когда на вас $spell:69246",
	specWarnHoarfrostNear		= "Спец-предупреждение, когда около вас $spell:69246",
	TimerCombatStart			= "Отсчет времени до начала боя",
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
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
	specwarnSoulstorm	= "Буря душ - приблизьтесь"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "Спец-предупреждение о применении заклинания $spell:68872 \n(для приближения)"
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
	specwarnWailingSouls	= "Стенающие души - отбегите"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Спец-предупреждение для прекращения атаки при \n$spell:69051",
	specwarnWailingSouls	= "Спец-предупреждение о заклинании $spell:68899",
	SetIconOnMirroredTarget	= "Устанавливать метки на цели заклинания $spell:69051"
})


---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Таймеры волн"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Скоро новая волна",
	WarnNewWave		= "%s вступает в бой"
})

L:SetTimerLocalization({
	TimerNextWave	= "Следующая волна"
})

L:SetOptionLocalization({
	WarnNewWave			= "Предупреждение о вступлении босса в бой",
	WarnNewWaveSoon		= "Предупреждать заранее о новой волне (после босса 5-ой волны)",
	ShowAllWaveWarnings	= "Предупреждения для всех волн",
	TimerNextWave		= "Отсчет времени до следующей волны (после босса 5-ой волны)",
	ShowAllWaveTimers	= "Предупреждения и отсчет времени для всех волн (неточный)"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarnWave1		= "6 Гневных вурдалаков, 1 Воскрешенный ведьмак вступают в бой",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "6 Гневных вурдалаков, 2 Воскрешенных ведьмака, 1 Неуклюжее поганище вступают в бой",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "6 Гневных вурдалаков, 2 Воскрешенных ведьмака, 2 Неуклюжих поганища вступают в бой",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "12 Гневных вурдалаков, 4 Воскрешенных ведьмака, 3 Неуклюжих поганища вступают в бой"--12 Ghoul, 3 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "Время для побега"
})

L:SetOptionLocalization({
	ShowWaves	= "Предупреждение для прибывающих волн"
})

L:SetMiscLocalization({
	Ghoul			= "Гневный вурдалак",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Неуклюжее поганище",--creature id 37069
	WitchDoctor		= "Воскрешенный ведьмак",--creature id 36941
	ACombatStart	= "Он слишком силен. Мы должны выбраться отсюда как можно скорее. Моя магия задержит его, но не надолго. Быстрее, герои!",
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",
	Wave1			= "^Бежать некуда.$",
	Wave2			= "Покоритесь леденящей смерти!",
	Wave3			= "Вы в ловушке!",
	Wave4			= "Как долго вы сможете сопротивляться?",
	YellCombatEnd	= "ОГОНЬ! ОГОНЬ!"
})
