if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Faucemagma"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Sistema de defensa de Omnitron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Fase 2 pronto",
	WarnBreak	= "%s en >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Mostrar un preaviso para la fase 2",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown")
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
