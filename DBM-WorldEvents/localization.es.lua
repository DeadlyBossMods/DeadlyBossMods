if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Omen"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive	= "Hummel se activa",
	BaxterActive	= "Baxter se activa",
	FryeActive		= "Frye se activa"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Mostrar tiempo para que los Boticarios se activen"
})

L:SetMiscLocalization({
	SayCombatStart		= "¿Se han molestado en decirte quién soy y por qué estoy haciendo esto?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ahune emerge",
	specWarnAttack	= "Ahune es vulnerable ¡Ataca ahora!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Se sumerge",
	EmergeTimer		= "Emerge"
}

L:SetOptionLocalization({
	Emerged			= "Mostrar aviso cuando Ahune emerge",
	specWarnAttack	= "Mostrar aviso especial cuando Ahune es vulnerable",
	SubmergTimer	= "Mostrar tiempo para sumersión",
	EmergeTimer		= "Mostrar tiempo para emersión"
})

L:SetMiscLocalization({
	Pull			= "¡La piedra de hielo se ha derretido!"
})


----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "¡Bebete la cerveza antes de que lanze otra!",
	specWarnBrewStun		= "SUGERENCIA: ¡Te han dado! ¡Acuerdate de beber la cerveza si te han lanzado!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Mostrar aviso especial para $spell:47376",
	specWarnBrewStun		= "Mostrar aviso especial para $spell:47340",
	YellOnBarrel	= "Avisar si $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel		= "¡Tengo el Barril!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Salen las Calabazas con pulso",
	warnHorsemanHead		= "¡Torbellino! ¡Mata a la cabeza!"
})

L:SetOptionLocalization({
	WarnPhase				= "Mostrar un aviso para cada cambio de fase",
	warnHorsemanSoldiers	= "Mostrar aviso a la llegada de Calabazas con pulso",
	warnHorsemanHead		= "Mostrar un aviso para torbellino (2ª i posteriores apariciones de cabeza)"
})

L:SetMiscLocalization({
	HorsemanSummon				= "Jinete álzate...",
	HorsemanSoldiers			= "Soldados, alzaos y luchad, tomad vuestro acero. Dad la victoria a este deshonrado caballero."
})


------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "The Abominable Greench" --TODO, needs translation
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
