if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "Fermentación (Aprox)"
}

L:SetOptionLocalization{
   timerEvent			= "Mostrar temporizador para la fermentación (aproximada)"
}

L:SetMiscLocalization{
	BrewStart			= "¡Ya empieza la tormenta! Preparaos.",
	BorokhulaPull		= "¡Último aviso, reptiles de lengua bífida!",
	BorokhulaAdds		= "solicita refuerzos!"--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "Your Alliance is WEAK!"--Not yet in use but could be with more logs and combat start timers, TODO needs translation
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
	TelvrakPull			= "Zan'vess will never fall!" -- TODO needs translation
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
	timerBossCD		= "%s llegando"
}

L:SetOptionLocalization{
	timerBossCD		= "Mostrar temporizador para el siguiente jefe"
}

L:SetMiscLocalization{
	RatEngage	= "It's the Den Mother! Look out", -- TODO needs translation
	BeginAttack	= "We must defend the villagers!", -- TODO needs translation
	Yeti		= "Bataari War Yeti", -- TODO needs translation
	Qobi		= "Warbringer Qobi" -- TODO needs translation
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
	timerAddsCD		= "Invocar adds"
}

L:SetOptionLocalization{
	timerAddsCD		= "Mostrar temporizador para la invocación de adds"
}

L:SetMiscLocalization{
	LizardLord		= "Dem Saurok be guardin de cave.  Let's take care of 'em." -- TODO needs translation
}

----------------------------
-- Dark Heart of Pandaria --
----------------------------
L= DBM:GetModLocalization("d647")

L:SetMiscLocalization{
	summonElemental		= "Minions, destroy these insects!" --TODO, needs translation
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
	WarnAchFiveAlive	= "Logro fallado: \"Los cinco en el Desembarco del León\""
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "Mostrar aviso si se ha fallado el logro \"Los cinco en el Desembarco del León\""
}

----------------------------
-- The Secret of Ragefire --
----------------------------
L= DBM:GetModLocalization("d649")

L:SetMiscLocalization{
	XorenthPull		= "All lesser races are enemies of the true Horde!", -- TODO needs translation
	ElagloPull		= "Fools! The true horde cannot be stopped by the likes of you." -- TODO needs translation
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
	specWarnLostSouls		= "Almas perdidas!",
	specWarnEnslavePitLord	= "Señor del foso - ¡Esclavízalo ahora!"
}

L:SetTimerLocalization{
	timerLostSoulsCD		= "Siguientes Almas perdidas"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "Mostrar aviso especial cuando aparezcan Almas Perdidas",
	specWarnEnslavePitLord	= "Mostrar aviso especial para escalvizar a los Señores del foso cuando se activen o se liberen",
	timerLostSoulsCD		= "Mostrar temporizador para las siguientes Almas perdidas"
}

L:SetMiscLocalization{
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!" -- TODO needs translation
}

-------------------------------
-- Finding Secret Ingredient --
-------------------------------
L= DBM:GetModLocalization("d745")

L:SetMiscLocalization{
	Clear		= "Well done!" -- TODO needs translation
}
