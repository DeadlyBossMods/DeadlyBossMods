if GetLocale() ~= "ptBR" then return end

local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Próx. Tecelãs",
	TimerSpiderlings	= "Próx. Aranitas",
	TimerDrone			= "Próx. Soldado"
})

L:SetOptionLocalization({
	TimerSpinners		= "Exibir cronógrafo para as próximas $journal:2770",
	TimerSpiderlings	= "Exibir cronógrafo para as próximas $journal:2778",
	TimerDrone			= "Exibir cronógrafo para o próximo $journal:2773",
	RangeFrame			= "Exibir medidor de distância (10)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Fase %d",
	WarnNewInitiate		= "Novato do Gadanho Flamejante (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Fase %d",
	TimerHatchEggs		= "Próx. Ovos",
	timerNextInitiate	= "Próx. Novato (%s)",
	TimerCombatStart	= "Combate inicia"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Exibir cronógrafo para o início do combate",
	WarnPhase			= "Exibir aviso para cada mudança de fase",
	WarnNewInitiate		= "Exibir aviso quando Novato do Gadanho Flamejante surge",
	timerNextInitiate	= "Exibir cronógrafo para o próximo Novato do Gadanho Flamejante",
	TimerPhaseChange	= "Exibir cronógrafo para a próxima fase",
	TimerHatchEggs		= "Exibir cronógrafo para quando os próximos ovos chocarem",
	InfoFrame			= "Exibir quadro de informações para Penas Ígneas"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellPhase2		= "These skies are MINE!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Fiery Lava Worms erupt from the ground!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "Penas Ígneas",
	East			= "Leste",
	West			= "Oeste",
	Both			= "Ambos"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
	Riplimb		= "Ranca-membro",
	Rageface	= "Face da Fúria"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	timerStrike			= "Próx. %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Próx. lâmina"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "Reiniciar contagem de $spell:99259 a cada 3s(25 jogadores)/2s(10 jogadores)",
	warnStrike			= "Show warnings for Decimation/Inferno Strike", -- couldn't find corresponding spells on dungeon journal. Has it been removed?
	timerStrike			= "Show timer for next Decimation/Inferno Strike", -- same as above
	TimerBladeActive	= "Exibir cronógrafo de duração para a Lâmina ativa",
	TimerBladeNext		= "Exibir cronógrafo para a próxima Lâmina da Dizimação/Inferno",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "Exibir seta do DBM quando você é afetado por $spell:99516 ",
	InfoFrame			= "Exibir quadro de informações para pilhas de Centelha Vital",
	RangeFrame			= "Exibir medidor de distância (5) para $spell:99404"
})

L:SetMiscLocalization({
	VitalSpark		= "Pilhas de "..GetSpellInfo(99262)
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerNextSpecial	= "Próx. %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial			= "Exibir cronógrafo para a próxima habilidade especial.",
	RangeFrameSeeds				= "Exibir medidor de distância (12) para $spell:98450",
	RangeFrameCat				= "Exibir medidor de distância (10) para $spell:98374",
	LeapArrow					= "Exibir seta do DBM quando $spell:98476 está próximo de você",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "%s em %s em 5 seg",--Spellname on targetname
	warnSplittingBlow		= "%s em %s",--Spellname in Location
	warnEngulfingFlame		= "%s em %s",--Spellname in Location
	warnEmpoweredSulf		= "%s em 5 seg"--The spell has a 5 second channel, but tooltip doesn't reflect it so cannot auto localize
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s em %s",--Spellname on targetname
	TimerPhaseSons			= "Fim da Transição"
})

L:SetOptionLocalization({
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow			= "Exibir avisos para local de $spell:100877",
	warnEngulfingFlame			= "Exibir avisos para local de $spell:99171",
	WarnEngulfingFlameHeroic	= "Exibir avisos para local de $spell:99171 (modo heróico)",
	warnSeedsLand				= "Exibir aviso/cronógrafo para queda de $spell:98520 ao invés do lançamento",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100997, GetSpellInfo(100997)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons				= "Exibir cronógrafo de duração da \"Fase dos Filhos das Chamas\"",
	RangeFrame					= "Exibir medidor de distância",
	InfoHealthFrame				= "Exibir quadro de informações de vida (<100k pv)",
	MeteorFrame					= "Exibir quadro de informações para alvos de $spell:99849",
	AggroFrame					= "Exibir quadro de informações de jogadores que não tem ameaça durante Elementais Derretidos",
	BlazingHeatIcons			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "Leste",
	West				= "Oeste",
	Middle				= "Meio",
	North				= "Frente",
	South				= "Fundo",
	HealthInfo			= "Abaixo de 100k PV",
	HasNoAggro			= "Sem Ameaça",
	MeteorTargets		= "Ó Deus, Meteoros!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Enough! I will finish this.",--More reliable then adds method.
	TransitionEnded2	= "Sulfuras will be your end.",
	TransitionEnded3	= "Fall to your knees, mortals!  This ends now.",
	Defeat				= "Too soon! ... You have come too soon...",
	Phase4				= "Too soon..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Trash de Terras do Fogo"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus" --TODO I have no Idea what's his localized name (not on dungeon journal)
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "Transição termina"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Exibir cronógrafo para a transição de fase"
})

L:SetMiscLocalization({
	StaffEvent			= "The Branch of Nordrassil reacts violently to %S+ touch!",--Reg expression pull match
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "Thyrinar" -- TODO no idea of his name either.
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})