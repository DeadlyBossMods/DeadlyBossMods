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
	specWarnBrew		= "Matar a la hija antes de que lanze otra cerveza!",
	specWarnBrewStun		= "SUGERENCIA: Bebe la cerveza si te ha lanzado!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Mostrar aviso especial para Dark Brewmaiden's Brew",
	specWarnBrewStun		= "Mostrar aviso especial para Dark Brewmaiden's Stun",
	YellOnBarrel	= "Avisar si tienes el Barril"
})

L:SetMiscLocalization({
	YellBarrel		= "Tengo el Barril!"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "El Jinete decapitado"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Vienen las Calabazas con pulso!",
	specWarnHorsemanHead		= "Sale la cabeza - cambia de objetivo"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Mostrar aviso a la llegada de Calabazas con pulso",
	specWarnHorsemanHead		= "Mostrar un aviso especial cuando salga la cabeza"
})

L:SetMiscLocalization({
	HorsemanHead				= "¡Ven aquí, idiota!",  -- Attention, espace avant la virgule
	HorsemanSoldiers			= "¡Soldados alzáos soldados, tomad vuestro acero! Dad la victoria a este deshonrado caballero!",
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