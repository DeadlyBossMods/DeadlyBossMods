if GetLocale() ~= "ruRU" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "Варка хмеля (приблиз.)"
}

L:SetOptionLocalization{
	timerEvent			= "Отсчет времени до окончания варки хмеля"
}

L:SetMiscLocalization{
	BrewStart			= "Гроза начинается! Готовьтесь.",
	BorokhulaPull		= "Последний шанс, червяки вы гнилозубые!",
	BorokhulaAdds		= "просит подкрепления."--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "Вы – слабы!"--Not yet in use but could be with more logs and combat start timers
}

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "Зан'весс никогда не падет!"
}

------------------------------
-- Battle on the High Seas ---
------------------------------
L= DBM:GetModLocalization("d652")

-----------------------
-- Blood in the Snow --
-----------------------
L= DBM:GetModLocalization("d646")

-----------------------
-- Brewmoon Festival --
-----------------------
L= DBM:GetModLocalization("d539")

L:SetTimerLocalization{
	timerBossCD		= "Прибытие: %s"
}

L:SetOptionLocalization{
	timerBossCD		= "Отсчет времени до появления следующего босса"
}

L:SetMiscLocalization{
	RatEngage	= "Это же мать логова!",
	BeginAttack	= "Мы должны защитить жителей деревни!",
	Yeti		= "Батаарский боевой йети",
	Qobi		= "Воитель Коби"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

-----------------------
-- Dagger in the Dark --
-----------------------
L= DBM:GetModLocalization("d616")

L:SetTimerLocalization{
	timerAddsCD		= "Восст. Призыв Аддов"
}

L:SetOptionLocalization{
	timerAddsCD		= "Отсчет времени до восстановления призыва аддов у Чешуйчатого повелителя"
}

L:SetMiscLocalization{
	LizardLord		= "Пещеру сторожат сауроки. Займемся ими."
}

----------------------------
-- Dark Heart of Pandaria --
----------------------------
L= DBM:GetModLocalization("d647")

L:SetMiscLocalization{
	summonElemental		= "Прислужники, уничтожьте этих букашек!"
}

------------------------
-- Greenstone Village --
------------------------
L= DBM:GetModLocalization("d492")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

L:SetWarningLocalization{
	WarnAchFiveAlive	= "Достижение \"Неубиваемая пятерка\" провалено"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "Показывать предупреждение, если достижение \"Неубиваемая пятерка\" провалено"
}

----------------------------
-- The Secret of Ragefire --
----------------------------
L= DBM:GetModLocalization("d649")

L:SetMiscLocalization{
	XorenthPull		= "Низшие расы – враги истинной Орды!",
	ElagloPull		= "Глупцы! Истинную Орду такие, как вы, не остановят."
}

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization{
	specWarnLostSouls		= "Заблудшие души!",
	specWarnEnslavePitLord	= "Властитель преисподней - Поработите демона!"
}

L:SetTimerLocalization{
	timerLostSoulsCD		= "Восст. Заблудшие души"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "Спец-предупреждение, когда появляются Заблудшие души",
	specWarnEnslavePitLord	= "Спец-предупреждение поработить демона, когда Властитель преисподней активируется/освобождается",
	timerLostSoulsCD		= "Отсчет времени до появления следующих Заблудших душ"
}

L:SetMiscLocalization{
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!"
}

-------------------------------
-- Finding Secret Ingredient --
-------------------------------
L= DBM:GetModLocalization("d745")

L:SetMiscLocalization{
	Clear		= "Well done!"
}
