if GetLocale() ~= "ruRU" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Ром'огг Костекрушитель"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "Корла, глашатай сумрака"
})

L:SetWarningLocalization({
	WarnAdd		= "Помощник освобожден"
})

L:SetOptionLocalization({
	WarnAdd		= "Сообщать когда на помощнике истекает эффект $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Карш Гнущий Сталь"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "Перегретая броня (%d)"	-- not work with $spell:75846 :)
})

L:SetOptionLocalization({
	TimerSuperheated	= "Показывать таймер длительности $spell:75846"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "Красавица"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "Повелитель Перерожденных Обсидий"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "Пометить босса иконкой после $spell:76200 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "Глубток"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "Хеликс Отломчикс"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "Врагорез-5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "Адмирал Терзающий Рев"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"Капитан\" Пирожок"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "Ванесса ван Клиф"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Великое воздаяние"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name		= "Генерал Умбрисс"
})

L:SetOptionLocalization{
	PingBlitz	= "С эмитировать импульс на мини-карте, если Умбрисс собирается применить на вас $spell:74670"
}

L:SetMiscLocalization{
	Blitz		= "останавливает взгяд на |cFFFF0000(%S+)" -- mb need use |3-3(%S+)
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Начальник кузни Тронг"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Драгх Горячий Мрак"
})

L:SetMiscLocalization{
	ValionaYell	= "Дракон, ты будеш делать то, что я прикажу! Подхвати меня!",	-- translate -- Yell when Valiona is incoming
	Add			= "%s призывает",
	Valiona		= "Валиона"
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "Эрудакс"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "Храмовый страж Ануур"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "Пта Ярость Земли"
})

L:SetMiscLocalization{
	Kill		= "Пта... Больше... Нет..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Анрафет"
})

L:SetTimerLocalization({
	achievementGauntlet	= "Скорость Света"
})

L:SetMiscLocalization({
	Brann		= "Ага, ну поехали! Осталось ввести последний код для открывания двери...и..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "Изисет"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "Скоро разделение"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "Показывать предупреждение о надвигающемся разделении"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "Аммунаэ"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "Сетеш"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "Радж"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "Генерал Хусам"
})

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Сиамат"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

L:SetWarningLocalization{
	specWarnPhase2Soon	= "2-ая фаза через 5 сек"
}

L:SetTimerLocalization({
	timerPhase2 	= "Начало 2-ой фазы"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Показывать особое предупреждение перед началом 2-ой фазы (5 сек)",
	timerPhase2 	= "Показывать таймер начала 2-ой фазы"
}

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Верховным пророком Барим"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Показать здоровье прислужников в рамке здоровья босса"
}

L:SetMiscLocalization{
	BlazeHeavens		= "Небесный Огонь",
	HarbringerDarkness	= "Вестник Тьмы"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Зубохлоп"
})

L:SetOptionLocalization{
	RangeFrame	= "Окно проверки дистанции (5 м)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Ауг"
})

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "Барон Эшбери"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "Барон Сребролен"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "Командир Ручьедол"
})

L:SetTimerLocalization({
	TimerAdds		= "След. помощники"
})

L:SetOptionLocalization{
	TimerAdds		= "Показывать таймер для помощников"
}

L:SetMiscLocalization{
	YellAdds		= "Repel the intruders!"
}

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Лорд Вальден"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "Зеленая смесь - двигайтесь!",	-- Green light
	specWarnRedMix		= "Красная смесь - не двигайтесь!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "Сообщать о красной/зеленой очередности движений"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Лорд Годфри"
})

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "Корбор"
})

L:SetWarningLocalization({
	WarnEmerge		= "Появление",
	WarnSubmerge	= "Погружение"
})

L:SetTimerLocalization({
	TimerEmerge		= "Появление",
	TimerSubmerge	= "Погружение"
})

L:SetOptionLocalization({
	WarnEmerge		= "Показывать предупреждения о появлении",
	WarnSubmerge	= "Показывать предупреждения о погружении",
	TimerEmerge		= "Показывать таймер до появления",
	TimerSubmerge	= "Показывать таймер до погружения",
	CrystalArrow	= "Показать стрелку DBM когда $spell:81634 около вас",
	RangeFrame		= "Окно проверки дистанции (5 м)"
})

-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "Озрук"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "Камнешкур"
})

L:SetWarningLocalization({
	WarnAirphase				= "Воздушная фаза",
	WarnGroundphase				= "Наземная фаза",
	specWarnCrystalStorm		= "Кристальная буря - в укрытие!"
})

L:SetTimerLocalization({
	TimerAirphase				= "След. воздушная фаза",
	TimerGroundphase			= "След. наземная фаза"
})

L:SetOptionLocalization({
	WarnAirphase				= "Показывать предупреждения когда Камнешкур взлетает",
	WarnGroundphase				= "Показывать предупреждения когда Камнешкур приземляется",
	TimerAirphase				= "Показывать таймер следующей воздушной фаза",
	TimerGroundphase			= "Показывать таймер следующей наземной фаза",
	specWarnCrystalStorm		= "Показывать особое предупреждение для $spell:92265"
})

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "Верховная жрица Азил"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "Великий визирь Эртан"
})

L:SetMiscLocalization{
	Retract		= "%s притягивает к себе охранный смерч!"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "Альтаирий"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "Асаад"
})

L:SetOptionLocalization({
	SpecWarnStaticCling	= "Показывать особое предупреждение для $spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "Хватка природы - ПРЫГАЙ!"	-- does $spell: work here ?
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "Леди Наз'жар"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "Командир Улток"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "Эрунак Говорящий с Камнем"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "Озумат"
})

----------------
--  Zul'Aman  --
---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "Налоракк"
}

L:SetWarningLocalization{
	WarnBear		= "Облик медведя",
	WarnBearSoon	= "Облик медведя через 5 секунд",
	WarnNormal		= "Обычныый облик",
	WarnNormalSoon	= "Обычный облик через 5 секунд"
}

L:SetTimerLocalization{
	TimerBear		= "Облик медведя",
	TimerNormal		= "Обычный облик"
}

L:SetOptionLocalization{
	WarnBear		= "Показывать предупреждения для облика медведя",
	WarnBearSoon	= "Показывать предупреждение о скорой смене облика на медвежий",
	WarnNormal		= "Показывать предупреждения для обычного облика",
	WarnNormalSoon	= "Показывать предупреждение о скорой смене облика на обычный",
	TimerBear		= "Показывать таймер облика медведя",
	TimerNormal		= "Показывать таймер обычного облика"
}

L:SetMiscLocalization{
	YellBear 	= "Если вызвать чудовище, то мало не покажется, точно говорю!",
	YellNormal	= "Пропустите Налоракка!"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "Акил'зон"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame	= "Окно проверки дистанции (10 м)"
}

L:SetMiscLocalization{
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "Джан'алаи"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "Сгиньте в огне!",
	YellAdds	= "Где мои Наседки? Пора за яйца приниматься!"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "Халаззи"
}

L:SetWarningLocalization{
	WarnSpirit	= "Призывает дух",
	WarnNormal	= "Дух исчезает"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnSpirit	= "Показывать предупреждения для фазы духа",
	WarnNormal	= "Показывать предупреждения для обычной фазы "
}

L:SetMiscLocalization{
	YellSpirit	= "Со мною дикий дух...",
	YellNormal	= "О дух, вернись ко мне!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "Hexlord Malacrass"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "Показывать таймер для $spell:43501"
}

L:SetMiscLocalization{
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "Daakara"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	SetIconOnThrow		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639)
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "High Priest Venoxis"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477)
}

L:SetMiscLocalization{
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "Bloodlord Mandokir"
}

L:SetWarningLocalization{
	WarnRevive		= "Ghost Revive - %d left",
	SpecWarnOhgan	= "Ohgan revived! Attack now!" -- check this, i'm not good at English
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnRevive		= "Announce how many ghost revive remaining",
	SpecWarnOhgan	= "Show warning when Ohgan is revived" -- check this, i'm not good at English
}

L:SetMiscLocalization{
	Ohgan		= "Ohgan"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "Zanzil"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "High Priestess Kilnara"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do the Godbreaker"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "Hakkar's Chains Barrier Down - %d/3 left"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnBarrierDown	= "Announce when Hakkar's Chains barrier down"
}

L:SetMiscLocalization{
	Kill			= "Oh no, Hakkar's spirit is free!" -- temporarily
}