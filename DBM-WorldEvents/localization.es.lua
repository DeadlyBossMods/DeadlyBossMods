if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Cerveza Temible"
})

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

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "El Jinete decapitado"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "Salen las Calabazas con pulso",
	warnHorsemanHead		= "¡Torbellino! ¡Mata a la cabeza!"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Empieza el combate"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Mostrar tiempo para inicio del combate",	
	warnHorsemanSoldiers	= "Mostrar aviso a la llegada de Calabazas con pulso",
	warnHorsemanHead		= "Mostrar un aviso para torbellino (2ª i posteriores apariciones de cabeza)"
})

L:SetMiscLocalization({
	HorsemanSummon				= "Jinete álzate...",
	HorsemanHead				= "¡Ven aquí, idiota!",
	HorsemanSoldiers			= "Soldados, alzaos y luchad, tomad vuestro acero. Dad la victoria a este deshonrado caballero.",
	SayCombatEnd				= "Este final a mí me suena. Veamos qué nueva me espera."
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Los Tres Boticarios"
})

L:SetWarningLocalization({
})

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

-----------------------
--  Lord Ahune  --
-----------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune se sumerge",
	Emerged			= "Ahune emerge",
	specWarnAttack	= "Ahune es vulnerable ¡Ataca ahora!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Se sumerge",
	EmergeTimer		= "Emerge",
	TimerCombat		= "Inicio del combate"
}

L:SetOptionLocalization({
	Submerged		= "Mostrar aviso cuando Ahune se sumerge",
	Emerged			= "Mostrar aviso cuando Ahune emerge",
	specWarnAttack	= "Mostrar aviso especial cuando Ahune es vulnerable",
	SubmergTimer	= "Mostrar tiempo para sumersión",
	EmergeTimer		= "Mostrar tiempo para emersión",
	TimerCombat		= "Mostrar tiempo para inicio del combate",
})

L:SetMiscLocalization({
	Pull			= "¡La piedra de hielo se ha derretido!"
})