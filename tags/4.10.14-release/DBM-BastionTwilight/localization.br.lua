if GetLocale() ~= "ptBR" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization(156)

L:SetOptionLocalization({
	ShowDrakeHealth		= "Mostrar vida dos dragonetes soltos.\n(Requer quadro de vida habilitado)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Exibir aviso para $spell:92898 quando $spell:86788 estiver ativo",
	TwilightBlastArrow		= "Exibir seta do DBM quando $spell:92898 estiver próximo a você",
	RangeFrame				= "Mostrar medidor de distância (10m)",
	BlackoutShieldFrame		= "Usar uma barra de vida para mostrar a vida do chefe durante $spell:92878",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Respiração profunda!",
	BlackoutTarget			= "Apagão: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s abaixo de 30%% - próxima fase em breve!",
	SpecWarnGrounded		= "Pegue Aterrado",
	SpecWarnSearingWinds	= "Pegue Ventos Revoltos"
})

L:SetTimerLocalization({
	timerTransition			= "Transição de fase"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Ebibir aviso especial quando os chefes tiverem menos de 30% de vida",
	SpecWarnGrounded		= "Exibir aviso especial quando você estiver sem o efeito de $spell:83581\n(~10seg antes do lançamento)",
	SpecWarnSearingWinds	= "Exibir aviso especial quando você estiver sem o efeito de $spell:83500\n(~10seg antes do lançamento)",
	timerTransition			= "Exibir cronógrafo de transição de fase",
	RangeFrame				= "Exibir medidor de distância automaticamente, quando necessário",
	yellScrewed				= "Gritar quando você tiver $spell:83099 e $spell:92307 ao mesmo tempo",
	InfoFrame				= "Mostrar quadro de informações para jogadores sem $spell:83581 ou $spell:83500",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "The ground beneath you rumbles ominously....",
	Thundershock	= "The surrounding air crackles with energy....",
	Switch			= "Enough of this foolishness!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "An impressive display...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Kill			= "Impossible....",
	blizzHatesMe	= "Pára-raios e Sinalizador Gélido em mim! Abram espaço!",--You're probably fucked, and gonna kill half your raid if this happens, but worth a try anyways :).
	WrongDebuff	= "Sem %s"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization(167)

L:SetOptionLocalization({
	CorruptingCrashArrow	= "Exibir seta do DBM quando $spell:93178 for cair próximo a você",
	InfoFrame				= "Mostrar quadro de informações para $journal:3165",
	RangeFrame				= "Mostrar medidor de distância (5) para $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "Colocar ícones nas Criações Sombrias"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "Orbes em %d seg!",
	SpecWarnOrbs		= "Orbes chegando! Atenção!",
	warnWrackJump		= "%s pulou para >%s<",
	warnAggro			= "Jogadores com ameaça (Sujeitos a orbes): >%s< ",
	SpecWarnAggroOnYou	= "Você tem ameaça! Atenção aos Orbes!"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "Carapaça Crepuscular desvanece",
	TimerEggWeaken		= "Carapaça Crepuscular regenera-se",
	TimerOrbs			= "Recarga de Orbes Sombrios"
})

L:SetOptionLocalization({
	WarnOrbSoon			= "Exibir aviso antecipado para orbes ( 5s antes, a cada 1s)\n(Pode não ser correto. Pode causar spam.)",
	warnWrackJump		= "Anunciar quando $spell:92955 saltar de alvo",
	warnAggro			= "Anunciar jogadores que tem Ameaça quando os orbes surgirem (podem ser alvo dos orbes)",
	SpecWarnAggroOnYou	= "Exibir aviso especial se você tiver Ameaça quando os orbes surgirem\n(você pode ser o alvo dos orbes)",
	SpecWarnOrbs		= "Exibir aviso especial quando orbes surgirem (Aviso esperado)",
	TimerEggWeakening	= "Exibir cronógrafo para quando $spell:87654 desvanescer",
	TimerEggWeaken		= "Exibir cronógrafo para regeneração de $spell:87654",
	TimerOrbs			= "Exibir cronógrafo para os próximos orbes (Tempo esperado, Pode não ser correto)",
	SetIconOnOrbs		= "Colocar ícones em jogadores que tenham Ameaça quando Orbes surgirem\n(possíveis alvos dos Orbes)",
	OrbsCountdown		= "Tocar som de contagem regressiva para Orbes",
	InfoFrame			= "Exibir quadro de informações para jogadores que tem ameaça"
})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",
	YellEgg				= "You mistake this for weakness?  Fool!",
	HasAggro			= "Has Aggro"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Trash de Bastião do Crepúsculo"
})
