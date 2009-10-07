if GetLocale() ~= "ruRU" then return end

local L

local spell		= "%s"				
local debuff		= "%s: >%s<"			
local spellCD		= "Восстановление: %s"				-- translate
local spellSoon		= "Скоро %s"					-- translate
local optionWarning	= "Отображать предупреждение \"%s\""		-- translate
local optionPreWarning	= "Отображать пред-предупреждение \"%s\""	-- translate
local optionSpecWarning	= "Отображать спец-предупреждение \"%s\""	-- translate
local optionTimerCD	= "Отображать время до восстановления \"%s\""	-- translate
local optionTimerDur	= "Отображать отсчет времени до \"%s\""		-- translate
local optionTimerCast	= "Отображать время чтения заклинания \"%s\""	-- translate


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
	WarningFlame		= spell,
	WarningEmbrace		= debuff
})

L:SetTimerLocalization({
	TimerEmbrace		= debuff,
	TimerFlameCD		= spellCD
})

L:SetOptionLocalization({
	WarningFlame		= optionWarning:format(GetSpellInfo(55931)),
	WarningEmbrace		= optionWarning:format(GetSpellInfo(55959)),
	TimerEmbrace		= optionTimerDur:format(GetSpellInfo(55959)),
	TimerFlameCD		= optionTimerCD:format(GetSpellInfo(55931))
})


-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Старейшина Надокс"
})

L:SetWarningLocalization({
	WarningPlague	= debuff
})

L:SetTimerLocalization({
	TimerPlague	= debuff,
})

L:SetOptionLocalization({
	WarningPlague	= optionWarning:format(GetSpellInfo(56130)),
	TimerPlague	= optionTimerDur:format(GetSpellInfo(56130))
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Джедога Искательница Теней"
})

L:SetWarningLocalization({
	WarningThundershock	= spell,
    WarningCycloneStrike	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock	= optionWarning:format(GetSpellInfo(56926)),
    WarningCycloneStrike	= optionWarning:format(GetSpellInfo(60030))
})


-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Глашатай Волаж"
})

L:SetWarningLocalization({
	WarningInsanity	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningInsanity	= optionWarning:format(GetSpellInfo(57496))
})


--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Аманитар"
})

L:SetWarningLocalization({
	WarningMini	= spell
})

L:SetTimerLocalization({
	TimerMiniCD	= spellCD
})

L:SetOptionLocalization({
	WarningMini	= optionWarning:format(GetSpellInfo(57055)),
	TimerMiniCD	= optionTimerCD:format(GetSpellInfo(57055))
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
	WarningCurse	= spell
})

L:SetTimerLocalization({
	TimerCurseCD	= spellCD
})

L:SetOptionLocalization({
	WarningCurse 	= optionWarning:format(GetSpellInfo(52592)),
	TimerCurseCD	= optionTimerCD:format(GetSpellInfo(52592))
})


--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Хадронокс"
})

L:SetWarningLocalization({
	WarningLeech	= spell,
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningLeech	= optionWarning:format(GetSpellInfo(53030)),
	WarningCloud	= optionWarning:format(GetSpellInfo(53400))
})


---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Ануб'арак"
})

L:SetWarningLocalization({
	WarningPound	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPound	= optionWarning:format(GetSpellInfo(53472)),
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
	WarningChains	= debuff
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerChainsCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(52696)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(52696)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(52696))
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Салрамм Плоторез"
})

L:SetWarningLocalization({
	WarningCurse	= debuff,
	WarningSteal	= debuff,
	WarningGhoul	= spell
})

L:SetTimerLocalization({
	TimerGhoulCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningCurse	= optionWarning:format(GetSpellInfo(58845)),
	WarningSteal	= optionWarning:format(GetSpellInfo(52709)),
	WarningGhoul	= optionWarning:format(GetSpellInfo(52451)),
	TimerGhoulCD	= optionTimerCD:format(GetSpellInfo(52451)),
	TimerCurse	= optionTimerDur:format(GetSpellInfo(58845))
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Хронолорд Эпох"
})

L:SetWarningLocalization({
	WarningTime	= spell,
	WarningCurse	= debuff
})

L:SetTimerLocalization({
	TimerTimeCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningTime	= optionWarning:format("Искажение/Остановка времени"),	-- requires translation
	WarningCurse	= optionWarning:format(GetSpellInfo(52772)),
	TimerTimeCD	= optionTimerCD:format("Искажение/Остановка времени"),	-- translate
	TimerCurse	= optionTimerDur:format(GetSpellInfo(52772))
})


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Мал'Ганис"
})

L:SetWarningLocalization({
	WarningSleep	= debuff
})

L:SetTimerLocalization({
	TimerSleep	= debuff,
	TimerSleepCD	= spellCD
})

L:SetOptionLocalization({
	WarningSleep	= optionWarning:format(GetSpellInfo(52721)),
	TimerSleep	= optionTimerDur:format(GetSpellInfo(52721)),
	TimerSleepCD	= optionTimerCD:format(GetSpellInfo(52721))
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Очищение Стратхольма"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Волна %d: призыв %s",
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"Следующая волна (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("Новая волна"),
	TimerWaveIn		= "Отображать время до \"Следующая волна\" (только волна 6)",
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
	WarningFear	= spell,
	WarningBite	= debuff,
	WarningSlash	= spell
})

L:SetTimerLocalization({
	TimerFearCD	= spellCD,
	TimerSlash	= debuff,
	TimerSlashCD	= spellCD
})

L:SetOptionLocalization({
	WarningSlash	= optionWarning:format("Калечащая/Проникающая рана"), 	-- needs translation
	WarningFear	= optionWarning:format(GetSpellInfo(22686)),
	WarningBite	= optionWarning:format(GetSpellInfo(48920)),
	TimerFearCD	= optionTimerCD:format(GetSpellInfo(22686)),
	TimerSlash	= optionTimerDur:format("Калечащая/Проникающая рана"), 	-- needs translation
	TimerSlashCD	= optionTimerCD:format("Калечащая/Проникающая рана") 	-- needs translation
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Пророк Тарон'джа"
})

L:SetWarningLocalization({
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCloud	= optionWarning:format(GetSpellInfo(49548))
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
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(55081)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(55081))
})


-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Мураби"
})

L:SetWarningLocalization({
	WarningTransform	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningTransform	= optionWarning:format(GetSpellInfo(55098))
})


-----------------------
-- Drakkari Colossus --		
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Колосс Драккари"
})

L:SetWarningLocalization({
	warningElemental	= "Фаза элементаля",		-- translate :)
	WarningStone		= "Фаза колосса"		-- translate :)
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Отображать предупреждение фазы элементаля",	-- translate ;)
	WarningStone		= "Отображать предупреждение фазы колосса"		-- translate :)
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
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(52027))
})


-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ионар"
})

L:SetWarningLocalization({
	WarningOverload	= debuff,
	WarningSplit	= spell
})

L:SetTimerLocalization({
	TimerOverload	= debuff
})

L:SetOptionLocalization({
	WarningOverload = optionWarning:format(GetSpellInfo(52658)),
	WarningSplit	= optionWarning:format(GetSpellInfo(52770)),
	TimerOverload	= optionTimerDur:format(GetSpellInfo(52658))
})


-------------
-- Volkhan --
-------------
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


------------
-- Kronus --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Локен"
})

L:SetWarningLocalization({
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(53960)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(53960))
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
	WarningWoe	= debuff,
	WarningSorrow	= spell,
	WarningStorm	= spell
})

L:SetTimerLocalization({
	TimerWoe	= debuff,
	TimerSorrow	= spell,
	TimerSorrowCD	= spellCD,
	TimerStormCD	= spellCD
})

L:SetOptionLocalization({
	WarningWoe	= optionWarning:format(GetSpellInfo(50761)),
	WarningSorrow	= optionWarning:format(GetSpellInfo(50760)),
	WarningStorm	= optionWarning:format(GetSpellInfo(50752)),
	TimerWoe	= optionTimerDur:format(GetSpellInfo(50761)),
	TimerSorrow	= optionTimerDur:format(GetSpellInfo(50760)),
	TimerSorrowCD	= optionTimerCD:format(GetSpellInfo(50760)),
	TimerStormCD	= optionTimerCD:format(GetSpellInfo(50752)),
})


----------------
-- Krystallus --
----------------
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


----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Сьоннир Литейщик"
})

L:SetWarningLocalization({
	WarningCharge	= debuff,
	WarningRing	= spell
})

L:SetTimerLocalization({
	TimerCharge	= debuff,
	TimerChargeCD	= spellCD,
	TimerRingCD	= spellCD
})

L:SetOptionLocalization({
	WarningCharge	= optionWarning:format(GetSpellInfo(50834)),
	WarningRing	= optionWarning:format(GetSpellInfo(50840)),
	TimerCharge	= optionTimerDur:format(GetSpellInfo(50834)),
	TimerChargeCD	= optionTimerCD:format(GetSpellInfo(50834)),
	TimerRingCD	= optionTimerCD:format(GetSpellInfo(50840))
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
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
	WarningPhase	= optionWarning:format("Фаза #")
})

L:SetMiscLocalization({
	Pull	= "Теперь будьте внимательны! Не успеете и глазом моргнуть, как...",
	Phase1	= "xxx анти-ошибка xxx",
	Phase2	= "xxx анти-ошибка xxx",
	Phase3	= "xxx анти-ошибка xxx"
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
	WarningRiftSoon		= spellSoon,
	WarningRiftNow		= spell,
})

L:SetOptionLocalization({
	WarningRiftSoon		= optionPreWarning:format(GetSpellInfo(47743)),
	WarningRiftNow		= optionWarning:format(GetSpellInfo(47743))
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Орморок Воспитатель Дерев"
})

L:SetWarningLocalization({
	WarningSpikes		= spell,
	WarningReflection	= spell,
	WarningFrenzy		= spell,
	WarningAdd		= spell
})

L:SetTimerLocalization({
	TimerReflection		= spell,
	TimerReflectionCD	= spellCD
})

L:SetOptionLocalization({
	WarningSpikes		= optionWarning:format(GetSpellInfo(47958)),
	WarningReflection	= optionWarning:format(GetSpellInfo(47981)),
	WarningFrenzy		= optionWarning:format(GetSpellInfo(48017)),
	WarningAdd		= optionWarning:format(GetSpellInfo(61564)),
	TimerReflection		= optionTimerDur:format(GetSpellInfo(47981)),
	TimerReflectionCD	= optionTimerCD:format(GetSpellInfo(47981))
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Великая ведунья Телестра"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Скоро Разделение",		-- translate
	WarningSplitNow		= "Разделение",		-- translate
	WarningMerge		= "Размытие"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Разделение"),	-- translate
	WarningSplitNow		= optionWarning:format("Разделение"),	-- translate
	WarningMerge		= optionWarning:format("Размытие"),	-- translate
})

L:SetMiscLocalization({
	SplitTrigger1 = "Меня на вас хватит!",		-- translate
	SplitTrigger2 = "Вы получите больше, чем заслуживаете!",	-- translate
	MergeTrigger = "Ну теперь, покончим с этим!"				-- translate
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Керистраза"
})

L:SetWarningLocalization({
	WarningChains 	= debuff,
	WarningEnrage	= spell,
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerNova	= spell,
	TimerChainsCD	= spellCD,
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(50997)),
	WarningNova	= optionWarning:format(GetSpellInfo(48179)),
	WarningEnrage	= optionWarning:format(GetSpellInfo(8599)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(50997)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(50997)),
	TimerNova	= optionTimerDur:format(GetSpellInfo(48179)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(48179))
})


---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
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
	WarningFear 		= spell,
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
	TimerFearCD		= spellCD,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningFear		= optionWarning:format(GetSpellInfo(19134)),
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(38619)),
	TimerFearCD		= optionTimerCD:format(GetSpellInfo(19134)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(38619))
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
	WarningTimeBomb = debuff,
	WarningExplosion = spell
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
	SpecWarnBombYou 	= optionSpecWarning:format(GetSpellInfo(51121))
})


------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Варос Заоблачный Странник"
})

L:SetWarningLocalization({
	WarningAmplify	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningAmplify	= optionWarning:format(GetSpellInfo(51054))
})


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Хранитель энергии Эрегос"
})

L:SetWarningLocalization({
	WarningShift	= spell,
	WarningEnrage	= spell,
	WarningShiftEnd	= "Сдвига плоскости заканчивается"		-- translate
})

L:SetTimerLocalization({
	TimerShift	= spell,
	TimerEnrage	= spell
})

L:SetOptionLocalization({
	WarningShift	= optionWarning:format(GetSpellInfo(51162)),
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." заканчивается"), 	-- translate the word 'ending'
	WarningEnrage	= optionWarning:format(GetSpellInfo(51170)),
	TimerShift	= optionTimerDur:format(GetSpellInfo(51162)),
	TimerEnrage	= optionTimerDur:format(GetSpellInfo(51170))
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
	WarningTomb	= debuff
})

L:SetTimerLocalization({
	TimerTomb	= debuff
})

L:SetOptionLocalization({
	WarningTomb	= optionWarning:format(GetSpellInfo(48400)),
	TimerTomb	= optionTimerDur:format(GetSpellInfo(48400))
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
	WarningEnfeeble		= debuff,
	WarningSummon		= spell
})

L:SetTimerLocalization({
	TimerEnfeeble		= debuff
})

L:SetOptionLocalization({
	WarningEnfeeble		= optionWarning:format(GetSpellInfo(43650)),
	WarningSummon		= optionWarning:format(GetSpellInfo(52611)),
	TimerEnfeeble		= optionTimerDur:format(GetSpellInfo(43650))
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ингвар Расхититель"
})

L:SetWarningLocalization({
	WarningSmash			= spell,
	WarningGrowl			= spell,
	WarningWoeStrike		= debuff,
	SpecialWarningSpelllock 	= "Запрет чар - прекратите чтение заклинаний!"  -- translate
})

L:SetTimerLocalization({
	TimerSmash	= spell,
	TimerWoeStrike	= debuff
})

L:SetOptionLocalization({
	WarningSmash		= optionWarning:format(GetSpellInfo(42723)),
	WarningGrowl		= optionWarning:format(GetSpellInfo(42708)),
	WarningWoeStrike	= optionWarning:format(GetSpellInfo(42730)),
	TimerSmash		= optionTimerCast:format(GetSpellInfo(42723)),
	TimerWoeStrike		= optionTimerDur:format(GetSpellInfo(42730))
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
	WarningWhirlwind	= spell,
	WarningPoison		= debuff
})

L:SetTimerLocalization({
	TimerPoison		= debuff,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(59332)),
	WarningPoison		= optionWarning:format(GetSpellInfo(59331)),
	TimerPoison		= optionTimerDur:format(GetSpellInfo(59331)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(59332))
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Король Имирон"
})

L:SetWarningLocalization({
	WarningBane	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= optionWarning:format(GetSpellInfo(48294))
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Свала Вечноскорбящая"
})

L:SetWarningLocalization({
	WarningSword	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSword	= optionWarning:format(GetSpellInfo(48276))
})


---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Горток Бледное Копыто"
})

L:SetWarningLocalization({
	WarningImpale	= debuff
})

L:SetTimerLocalization({
	TimerImpale	= debuff
})

L:SetOptionLocalization({
	WarningImpale	= optionWarning:format(GetSpellInfo(48261)),
	TimerImpale	= optionTimerDur:format(GetSpellInfo(48261))
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
	WarningVacuum	= spell,
	WarningBlizzard	= spell,
	WarningMana	= debuff
})

L:SetTimerLocalization({
	TimerVacuumCD	= spellCD,
	TimerMana	= debuff
})

L:SetOptionLocalization({
	WarningVacuum	= optionWarning:format(GetSpellInfo(58694)),
	WarningBlizzard	= optionWarning:format(GetSpellInfo(58693)),
	WarningMana	= optionWarning:format(GetSpellInfo(59374)),
	TimerMana	= optionTimerDur:format(GetSpellInfo(59374)),
	TimerVacuumCD	= optionTimerCD:format(GetSpellInfo(58694))
})


------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Эрекем"
})

L:SetWarningLocalization({
	WarningES	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningES	= optionWarning:format(GetSpellInfo(54479))
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
	WarningLink	= debuff
})

L:SetTimerLocalization({
	TimerLink	= debuff,
	TimerLinkCD	= spellCD
})

L:SetOptionLocalization({
	WarningLink	= optionWarning:format(GetSpellInfo(54396)),
	TimerLink	= optionTimerDur:format(GetSpellInfo(54396)),
	TimerLinkCD	= optionTimerCD:format(GetSpellInfo(54396))
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
	WarningVoidShift		= debuff,
	WarningVoidShifted		= debuff,
	WarningShroudOfDarkness		= spell,
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
	TimerVoidShift			= debuff,
	TimerVoidShifted		= debuff
})

L:SetOptionLocalization({
	WarningVoidShift			= optionWarning:format(GetSpellInfo(59743)),
	WarningVoidShifted			= optionWarning:format(GetSpellInfo(59343)),
	WarningShroudOfDarkness			= optionWarning:format(GetSpellInfo(59745)),
	SpecialWarningVoidShifted		= optionSpecWarning:format(GetSpellInfo(59343)),
	SpecialShroudofDarkness			= optionSpecWarning:format(GetSpellInfo(59745)),
	TimerVoidShift				= optionTimerDur:format(GetSpellInfo(59743)),
	TimerVoidShifted			= optionTimerDur:format(GetSpellInfo(59343))
})


-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Портал Времени"
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
	WarningPortalNow		= optionWarning:format("Новый портал"),
	WarningPortalSoon		= optionPreWarning:format("Новый портал"),
	WarningBossNow			= optionWarning:format("Босс"),
	TimerPortalIn			= "Отображать отсчет времени до \"Портал: #\"",
	ShowAllPortalWarnings		= "Отображать предупреждение для всех волн"
})


L:SetMiscLocalization({
	yell1 = "Тюремные охранники, уходим! Этих искателей приключений возьму на себя! Уходите быстрей!", -- Аметистовая крепость
	WavePortal		= "Открыто порталов: (%d+)/18"
})


---------------------
-- Trial of the Champion --
---------------------
-------------------
-- The Black Knight --
-------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Черный рыцарь"
})

L:SetWarningLocalization({
	specWarnDesecration		= "Осквернение! Отбегите!",
	warnExplode			= "Вурдалак-прислужник собирается взорваться. Отбегите!"
})

L:SetOptionLocalization({
	specWarnDesecration		= "Спец-предупреждение, когда на вас \"Осквернение\"",
	warnExplode			= "Предупреждение, когда все вурдалаки-прислужники собираются взорваться.",
	SetIconOnMarkedTarget		= "Установить метку на цель под воздействием \"Метки смерти\""
})

L:SetMiscLocalization({
	YellCombatEnd			= "My congratulations, champions. Through trials both planned and unexpected, you have triumphed."	-- can also be "No! I must not fail... again ..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Абсолютные чемпионы"
})

L:SetWarningLocalization({
	specWarnHaste			= "Ускорение на >%s<! Рассейте заклинание!",
	specWarnPoison			= "Бутыль яда! Отбегите!",
	warnHealingWave			= "Шаман читает заклинаие Волна исцеления. Прерывание!"
})

L:SetOptionLocalization({
	warnHealingWave			= "Предупреждение, когда шаман читает заклинаие \"Волна исцеления\".",
	specWarnHaste			= "Спец-предупреждение, когда маг читает \"Ускорение\" (для рассеивания/прерывания)",
	specWarnPoison			= "Спец-предупреждение, когда вы получаете урон от яда"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Исповедница Серебряного Авангарда Пейлтресс"
})

L:SetWarningLocalization({
	specwarnRenew			= "Исповедница читает заклинаие Обновление на >%s< Рассейте заклинание!",
	warnReflectiveShield		= "Исповедница применяет Отражающий щит"
})

L:SetOptionLocalization({
	specwarnRenew			= "Спец-предупреждение, когда на цели \"Обновление\" (для рассеивания/прерывания)",
	warnReflectiveShield		= "Предупреждение, когда Исповедница применяет \"Отражающий щит\""
})

L:SetMiscLocalization({
--	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Эдрик Чистый"
})

L:SetWarningLocalization({
	warnHammerofRighteous		= "Эдрик бросает Молот праведника!",
	specwarnHammerofJustice		= "Молот правосудия на >%s<. Рассейте заклинание!",
	specwarnRadiance		= "Сияние. Отвернитесь!"
})

L:SetOptionLocalization({
	warnHammerofRighteous		= "Спец-предупреждение, когда Эдрик бросает Молот праведника",
	specwarnHammerofJustice		= "Спец-предупреждение для \"Молота правосудия\" (для рассеивания)",
	specwarnRadiance		= "Спец-предупреждение для \"Сияния\".",
	SetIconOnHammerTarget		= "Установить метку на цель под воздействием \"Молота правосудия\""
})

L:SetMiscLocalization({
--	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

---------------------
-- Holiday --
---------------------
-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Корен Худовар"
})

L:SetWarningLocalization({
	warnBarrel			= "Бочка на >%s<", 
--	specwarnDaughters		= "Daughter Spawned!",
	specwarnDisarm			= "Обезвреживание Зловещего Варева. Отбегите!",
	specWarnBrew			= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun		= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	warnBarrel				= "Announce the Target of Barrel.",
--	specwarnDaughters		= "Announce Spawns of Ursula/Ilsa",
	DisarmWarning			= "Show Special Warning for Disarm",
	specWarnBrew			= "Show Special Warning for Dark Brewmaiden's Brew",
	specWarnBrewStun		= "Show Special Warning for Dark Brewmaiden's Stun",
	PlaySoundOnDisarm		= "Звуковой сигнал, когда \"Обезвреживание Зловещего Варева\"",
	YellOnBarrel			= "Крикнуть, когда на вас \"Бочка\""
})

L:SetMiscLocalization({
	YellBarrel				= "Бочка на мне!"
})


---------------------
-- Pit of Saron --
---------------------
-------------------
-- Ick --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Плут"
})

L:SetWarningLocalization({
	specWarnToxic		= "Токсический выброс! Отбегите!"
})

L:SetOptionLocalization({
	specWarnToxic		= "Спец-предупреждение, когда вы получаете урон от \"Токсического выброса\""
})

-------------------
-- Forgemaster Garfrost --
-------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Начальник кузни Гарфрост"
})

L:SetWarningLocalization({
	warnSaroniteRock				= "Saronite Rock! Line of Sight now!",
	specWarnPermafrost		= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock				= "Show warning for Saronite Rock (to clear Permafrost)",
	specWarnPermafrost		= "Special Warning when Permafrost stacks get to high (value not set in stone)"
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Повелитель Плети Тираний"
})

L:SetWarningLocalization({
	warnUnholyPower				= "Scourgelord Tyrannus is casting Unholy Power.",
	warnHoarfrost				= "Rimefangs is casting Hoarfrost.",
	specWarnIcyBlast		= "Icy Blast! Move Away!"
})

L:SetOptionLocalization({
	warnUnholyPower				= "Show warning when Scourgelord Tyrannus casts Unholy Power.",
	warnHoarfrost				= "Show warning when Rimefangs casts Hoarfrost.",
	specWarnIcyBlast		= "Special Warning when you take damage from Icy Blast"
})