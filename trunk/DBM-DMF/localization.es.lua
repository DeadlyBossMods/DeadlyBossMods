if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Ultracañón Pimpampum 5000"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Golpea al gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Has ganado %d puntos de %d puntos posibles",
	warnGameOverNoQuest	= "El juego terminó con un total de %d puntos posibles",
	warnGnoll		= "Sale un Gnoll",
	warnHogger		= "Sale Hogger",
	specWarnHogger	= "¡Sale Hogger!"
})

L:SetOptionLocalization({
	warnGameOver	= "Anunciar total de puntos posibles al terminar el juego",
	warnGnoll		= "Anunciar cuando sale un Gnoll",
	warnHogger		= "Anunciar cuando sale un Hogger",
	specWarnHogger	= "Mostrar aviso especial cuando sale un Hogger"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Galería de tiro"
})

L:SetOptionLocalization({
	SetBubbles			= "Desactiva los bocadillos de chat durante $spell:101871<br/>(se restauran una vez finalizada la partida)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Combate de tonques"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Conejo de la Luna Negra"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Moonfang" --TODO, needs translation
})

L:SetWarningLocalization({
	specWarnCallPack		= "Call the Pack - Run > 40 yards from Moonfang!", --TODO, needs translation
	specWarnMoonfangCurse	= "Moonfang's Curse - Run > 10 yards from Moonfang!" --TODO, needs translation
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Flores de paz vs Necrófagos"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Total de zombies que han salido des de la ultima oleada masiva: %d",
	specWarnWave	= "¡Oleada masiva!"
})

L:SetTimerLocalization{
	timerWave		= "Siguiente oleada masiva"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Anunciar total de zombies que han salido entre cada oleada masiva",
	specWarnWave	= "Mostrar aviso especial cuando una empieza una Oleada Masiva",
	timerWave		= "Mostrar tiempo para la siguiente Oleada Masiva"
})

L:SetMiscLocalization({
	MassiveWave		= "A Massive Wave of Zombies is Approaching!" --TODO, needs translation
})
