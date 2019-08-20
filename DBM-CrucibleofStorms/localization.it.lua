if GetLocale() ~= "itIT" then return end
local L

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "Zaxasj",
	Fathuul = "Fa'thuul"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "Imposta comportamento Risonanza per l'incursione (Se capoincursione, sovrascrive incursione)",
	SetOne				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "Pietra del Vuoto (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Tridente/Oceano (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempesta (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "Tridente/Oceano",
	Storm = "Richiamo della Tempesta",
	Void = "Pietra del Vuoto",
	Lunacy = "Pazzia",
	DBMConfigMsg	= "Configurazione Risonanza Instabile impostata a %s come da configurazione capoincursione."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"Scartini Crogiolo"
})
