if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s en %s (%d)"
})

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)

-----------------------
-- <<<Stormstout Brewery>>> --
-----------------------
-----------------------
-- Ook-Ook --
-----------------------
L= DBM:GetModLocalization(668)

-----------------------
-- Hoptallus --
-----------------------
L= DBM:GetModLocalization(669)

-----------------------
-- Yan Zhu the Uncasked --
-----------------------
L= DBM:GetModLocalization(670)

L:SetWarningLocalization({
	SpecWarnFizzyBubbles	= "Obtén Burbuja gaseosa y vuela"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "Mostrar aviso especial cuando te falta $spell:114459",
	RangeFrame				= "Mostrar distancia (10) para $spell:106546"
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetWarningLocalization({
	warnRemainingNovice	= "Novicios restantes: %d"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "Anunciar cuantos novicios quedan"
})

L:SetMiscLocalization({
	NovicesPulled	= "¡Vosotros habéis permitido que los sha despierten, después de todos estos años!",
	NovicesDefeated = "Habéis superado a mis pupilos más inexpertos. Ahora os las veréis con dos de los más veteranos.",
--	Defeat			= "I am bested.  Give me a moment and we will venture forth together to face the Sha."--translate
})


-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetMiscLocalization({
	Kill		= "Siempre que la violencia anide en vuestros corazones... volveré..."
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "Mostrar información para $journal:5827"
})

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------
---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization({
	StaffingRun		= "¡Asediador Ga'dok se prepara para un bombardeo!"
})

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

-----------------------
-- <<<Mogu'Shan Palace>>> --
-----------------------
-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Pull		= "¡Inútiles! ¡Todos! Ni los guardias que me ofrecéis como tributo pueden impedir que entren gusanos en mi palacio.",
	Kuai		= "¡El clan Gurthan demostrará al Rey y a los impostores sedientos de poder como vosotros por qué merecemos su confianza!",
	Ming		= "¡El clan Harthak os demostrará por qué somos los más puros de los mogu!",
	Haiyan		= "¡El clan Kargesh os demostrará por qué solo los más fuertes merecen servir al Rey!",
	Defeat		= "¿Quién ha dejado entrar a los forasteros? ¡Solo los clanes Harthak o Kargesh se rebajarían a cometer tal traición!"
})

-----------------------
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

-----------------------
-- <<<Siege of Niuzao Temple>>> --
-----------------------
-----------------------
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

-----------------------
-- Vo'jak --
-----------------------
L= DBM:GetModLocalization(738)

L:SetTimerLocalization({
	TimerWave	= "Empieza a enviar: %s"
})

L:SetOptionLocalization({
	TimerWave	= "Mostrar tiempo para la siguiente oleada de adds"
})

L:SetMiscLocalization({
	WaveStart	= "¡Necios! ¿Atacáis frontalmente al ejército mántide? ¡Vuestras muertes serán rápidas!"
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)

-----------------------
-- <<<Scholomance>>> --
-----------------------
-----------------------
-- Instructor Chillheart --
-----------------------
L= DBM:GetModLocalization(659)

-----------------------
-- Jandice Barov --
-----------------------
L= DBM:GetModLocalization(663)

-----------------------
-- Rattlegore --
-----------------------
L= DBM:GetModLocalization(665)

L:SetWarningLocalization({
	SpecWarnGetBoned	= "Obtén Armadura ósea"
})

L:SetOptionLocalization({
	SpecWarnGetBoned	= "Mostrar aviso especial cuando te falta $spell:113996",
	InfoFrame			= "Mostrar información con jugadores sin $spell:113996"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Sin Armadura ósea"
})

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetMiscLocalization({
	Kill	= "What?!"--translates
})

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

-----------------------
-- <<<Scarlet Halls>>> --
-----------------------
-----------------------
-- Braun --
-----------------------
L= DBM:GetModLocalization(660)

-----------------------
-- Harlan --
-----------------------
L= DBM:GetModLocalization(654)

L:SetMiscLocalization({
	Call		= "¡El maestro de armas Harlan llama a dos de sus aliados para que se unan al combate!"--translate?
})

-----------------------
-- Flameweaver Koegler --
-----------------------
L= DBM:GetModLocalization(656)

-----------------------
-- <<<Scarlet Cathedral>>> --
-----------------------
-----------------------
-- Thalnos Soulrender --
-----------------------
L= DBM:GetModLocalization(688)

-----------------------
-- Korlof --
-----------------------
L= DBM:GetModLocalization(671)

L:SetOptionLocalization({
	KickArrow	= "Mostrar flecha cuando $spell:114487 está cerca de ti"
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)

