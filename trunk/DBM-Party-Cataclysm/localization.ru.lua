if GetLocale() ~= "ruRU" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "Ром'рогг Костекрушитель"
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
	WarnAdd		= "Предупреждать, когда на Ревнителе истекает эффект $spell:75608"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "Кузнец Карш"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "$spell:75846 (%d)"	-- should work, no need for translation :)
})

L:SetOptionLocalization({
	TimerSuperheated	= "Показывать таймер длительности $spell:75846"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "Красотка"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "Лорд Обсидиус"
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

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name = "Генерал Умбрисс"
})

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "Начальник кузни Тронгус"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "Драгх Горячий Мрак"
})

L:SetMiscLocalization{
	ValionaYell	= "Dragon, you will do as I command! Catch me!",	-- translate -- Yell when Valiona is incoming
	Valiona		= "Valiona"	-- translate
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

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "Анрафет"
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
-------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "Сиамат"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "Верховным пророком Барим"
})

L:SetOptionLocalization{
	BossHealthAdds	= "Show health of adds in the Boss Health Frame"	-- translate
}

L:SetMiscLocalization{
	BlazeHeavens		= "Blaze of the Heavens",	-- translate
	HarbringerDarkness	= "Harbringer of Darkness"	-- translate
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "Зубохлоп"
})

L:SetOptionLocalization{
	RangeFrame	= "Show Range Frame (5 yards)"		-- translate
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"		-- translate
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

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "Лорд Вальден"
})

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "Лорд Годфри"
})

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
	WarnEmerge	= "Появление",
	WarnSubmerge	= "Погружение"
})

L:SetTimerLocalization({
	TimerEmerge	= "Появление",
	TimerSubmerge	= "Погружение"
})

L:SetOptionLocalization({
	WarnEmerge	= "Показывать предупреждения о появлении",
	WarnSubmerge	= "Показывать предупреждения о погружении",
	TimerEmerge	= "Показывать таймер до появления",
	TimerSubmerge	= "Показывать таймер до погружения"
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
	specWarnCrystalStorm		= "Кристальная буря - в укрытие!"
})

L:SetOptionLocalization({
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

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "Альтаирий"
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "Асаад"
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