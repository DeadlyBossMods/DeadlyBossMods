if GetLocale() ~= "ptBR" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Furacão/Zéfiro/Tempestade de Granizo ativos",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Habilidades especiais ativas!",
	warnSpecialSoon		= "Habilidades especiais em 10 segundos!"
})

L:SetTimerLocalization({
	timerSpecial		= "Habilidades Especiais recarga",
	timerSpecialActive	= "Habilidades Especiais ativas"
})

L:SetOptionLocalization({
	warnSpecial			= "Exibir aviso quando Furacão/Zéfiro/Tempestade de Granizo são lançadas",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Exibir aviso quando habilidades especiais são lançadas",
	timerSpecial		= "Exibir cronógrafo para recarga de habilidades especiais",
	timerSpecialActive	= "Exibir cronógrafo para duração de habilidades especiais",
	warnSpecialSoon		= "Exibit aviso antecipado 10 segundos antes de habilidades especiais",
	OnlyWarnforMyTarget	= "Exibir avisos/cronógrafos apenas para o alvo e foco atuais\n(Esconde o resto. ISSO INCLUI O AVISO PARA PUXAR)"
})

L:SetMiscLocalization({
	gatherstrength	= "begins to gather strength"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 	= "Realimentação (%d)"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Exibir cronógrafo para a duração de $spell:87904",
	RangeFrame		= "Exibir medidor de distância (20), quando afetado por $spell:89668"
})
