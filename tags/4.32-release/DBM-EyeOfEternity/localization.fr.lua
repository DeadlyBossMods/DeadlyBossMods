if GetLocale() ~= "frFR" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetWarningLocalization({
	WarningSpark		= "Etincelle de puissance viens de d'arriver",
	WarningBreathSoon	= "Inspiration profonde Bientôt",
	WarningBreath		= "Inspiration profonde!",
	WarningSurgeYou		= "Vague de puissance sur VOUS!"
})

L:SetTimerLocalization({
	TimerSpark		= "Prochaine Etincelle de puissance",
	TimerBreath		= "Inspiration profonde"
})

L:SetOptionLocalization({
	WarningSpark		= "Montre une alerte pour les Etincelles de puissance",
	WarningBreathSoon	= "Montre une Pré-Alerte pour l'Inspiration profonde",
	WarningBreath		= "Montre une alerte pour l'Inspiration profonde",
	TimerSpark			= "Montre le timer pour les Etincelles de puissance",
	TimerBreath			= "Montre le timer pour l'Inspiration profonde",
	WarningSurgeYou		= "Montre une alerte spéciale quand vous êtes affecté par la Vague de puissance"
})

L:SetMiscLocalization({
	YellPull		= "Ma patience a ses limites. Je vais me débarrasser de vous !",
	EmoteSpark		= "de puissance surgit",
	YellPhase2		= "Je pensais mettre rapidement fin à vos existences",
	EmoteBreath		= "inspire profondément",
	YellBreath		= "Vous n'arriverez à rien tant qu'il me restera un souffle !",
	YellPhase3		= "Vos bienfaiteurs font enfin leur entrée, mais ils arrivent trop tard !"
})

