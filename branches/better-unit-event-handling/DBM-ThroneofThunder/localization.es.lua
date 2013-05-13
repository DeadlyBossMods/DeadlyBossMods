if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s pronto - ¡abandona el Agua conductiva!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Mostrar aviso especial si permaneces en $spell:138470\n(Aviso al comenzar $spell:137313 o si $spell:138732 expirará pronto)",
	RangeFrame			= "Mostrar radar de rango (8/4)"
})


--------------
-- Horridon --
--------------
L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Orbe de control disponible",
	specWarnOrbofControl	= "¡Orbe de crontrol disponible!"
})

L:SetTimerLocalization({
	timerDoor				= "Siguiente puerta tribal",
	timerAdds				= "Siguientes %s"
})

L:SetOptionLocalization({
	warnAdds				= "Anunciar cuando aparecen nuevos adds",
	warnOrbofControl		= "Anunciar cuando un $journal:7092 está disponible",
	specWarnOrbofControl	= "Mostrar aviso especial cuando un $journal:7092 está disponible",
	timerDoor				= "Mostrar temporizador para la siguiente fase de puerta tribal",
	timerAdds				= "Mostrar temporizador cuando aparecen nuevos adds",
	RangeFrame				= "Mostrar distancia (5) para $spell:136480"
})

L:SetMiscLocalization({
	newForces		= "salen en tropel desde",--Farraki forces pour from the Farraki Tribal Door! (needs verified, may be wrong)
	chargeTarget	= "fija la vista"--Horridon sets his eyes on Eraeshio and stamps his tail! (needs verified, may be wrong)
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed		= "%s en %s - cambio de objetivo"
})

L:SetOptionLocalization({
	PHealthFrame		= "Mostrar salud restante para que $spell:136442 desaparezca\n(Requiere barra de vida del boss)",
	RangeFrame			= "Mostrar radar de rango",
	AnnounceCooldowns	= "Mostrar cuenta de $spell:137166 (hasta 3) para uso de cooldowns de banda"
})



------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s usó >%s< (%d restantes)",
	specWarnCrystalShell	= "Obtén %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Mostrar aviso especial cuando te falta $spell:137633",
	InfoFrame				= "Mostrar cuadro de información para los jugadores sin $spell:137633",
	SetIconOnTurtles		= "Poner iconos en $journal:7129",
	ClearIconOnTurtles		= "Quitar iconos en $journal:7129 cuando les afecte $spell:133971",
	AnnounceCooldowns		= "Mostrar cuenta de $spell:134920 para el uso de cooldowns de banda"
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)
