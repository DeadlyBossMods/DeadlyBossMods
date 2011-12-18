if GetLocale() ~= "ptBR" then return end

local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom imita %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Exibir avisos quando Kohcrom imita habilidades.",
	KohcromCD		= "Exibir cronógrafo para a próxima imitação de habilidade de Kohcrom.",
	RangeFrame		= "Exibir medidor de distância (5) para conquista."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "Exibir medidor de distância (10) para $spell:104601\n(Modo Heróico)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "Glóbulos atacáveis"
})

L:SetOptionLocalization({
	timerOozesActive	= "Exibir cronógrafo para quando os Glóbulos se tornam atacáveis",
	RangeFrame			= "Exibir medidor de distância (4) para $spell:104898\n(Modo Normal+)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242negro|r",
	Purple			= "|cFF9932CDroxo|r",
	Red				= "|cFFFF0404vermelho|r",
	Green			= "|cFF088A08verde|r",
	Blue			= "|cFF0080FFazul|r",
	Yellow			= "|cFFFFA901amarelo|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s em 8 seg"
})

L:SetTimerLocalization({
	TimerSpecial			= "Primeiro especial"
})

L:SetOptionLocalization({
	TimerSpecial			= "Exibir cronógrafo para lançamento da primeira habilidade",
	RangeFrame				= "Exibir medidor de distância (3) para $spell:105269",
	AnnounceFrostTombIcons	= "Anunciar no chat da raide, ícones para alvos de $spell:104451\n(requer liderança)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})

L:SetMiscLocalization({
	TombIconSet				= "Ícone de Tumba de Gelo {rt%d} colocado em %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion pousa"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Exibir cronógrafo para início do combate."
})

L:SetMiscLocalization({
	Trash				= "It is good to see you again, Alexstrasza. I have been busy in my absence.",
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Início do combate",
	TimerSapper			= "Próximo Sapador do Crepúsculo"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Exibir cronógrafo para o início do combate",
	TimerSapper			= "Exibir cronógrafo para surgir o próximo Sapador do Crepúsculo"--npc=56923
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Get Secured!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Exibir aviso especial quando você não tem $spell:109454",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Exibir quadro de informações para jogadores sem $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Exibir vida do chefe, com uma barra de vida para $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff	= "Sem %s",
	PlasmaTarget	= "Searing Plasma: %s",
	DRoll		= "about to roll"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Tentáculo Pustuloso"--Msg too long? maybe just "Blistering Tentacles!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Exibir aviso especial quando Tentáculos Pustulosos surgem (e Alexstrasza não está ativa)"--http://ptr.wowhead.com/npc=56188
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})
