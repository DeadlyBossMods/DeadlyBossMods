if GetLocale() ~= "ptBR" then return end
local L
-----------------------
-- <<<Auchindoun>>> --
-----------------------
-----------------------
-- Protector of Auchindoun --
-----------------------
L= DBM:GetModLocalization(1185)
-----------------------
-- Soulbinder Nyami --
-----------------------
L= DBM:GetModLocalization(1186)
-----------------------
-- Azzakel, Vanguard of the Legion --
-----------------------
L= DBM:GetModLocalization(1216)
-----------------------
-- Teron'gor --
-----------------------
L= DBM:GetModLocalization(1225)
-------------
--  Auch Trash  --
-------------
L = DBM:GetModLocalization("AuchTrash")
L:SetGeneralLocalization({
 name = "Auchindoun Trash"
})
-----------------------
-- <<<Bloodmaul Slag Mines>>> --
-----------------------
-----------------------
-- Magmolatus --
-----------------------
L= DBM:GetModLocalization(893)
-----------------------
-- Slave Watcher Crushto --
-----------------------
L= DBM:GetModLocalization(888)
-----------------------
-- Roltall --
-----------------------
L= DBM:GetModLocalization(887)
-----------------------
-- Gug'rokk --
-----------------------
L= DBM:GetModLocalization(889)
-------------
--  BSM Trash  --
-------------
L = DBM:GetModLocalization("BSMTrash")
L:SetGeneralLocalization({
 name = "MEMS Trash"
})
-----------------------
-- <<<Grimrail Depot>>> --
-----------------------
-----------------------
-- Railmaster Rocketspark and Borka the Brute --
-----------------------
L= DBM:GetModLocalization(1138)
-----------------------
-- Blackrock Assault Commander --
-----------------------
L= DBM:GetModLocalization(1163)
L:SetWarningLocalization({
 warnGrenadeDown   = "%s caiu",
 warnMortarDown   = "%s caiu"
})
-----------------------
-- Thunderlord General --
-----------------------
L= DBM:GetModLocalization(1133)
-------------
--  GRD Trash  --
-------------
L = DBM:GetModLocalization("GRDTrash")
L:SetGeneralLocalization({
 name = "CdCC Trash"
})
-----------------------
-- <<<Iron Docks>>> --
-----------------------
---------------------
-- Fleshrender Nok'gar --
---------------------
L= DBM:GetModLocalization(1235)
-------------
-- Grimrail Enforcers --
-------------
L= DBM:GetModLocalization(1236)
-----------------------
-- Oshir --
-----------------------
L= DBM:GetModLocalization(1237)
-----------------------------
-- Skulloc, Son of Gruul --
-----------------------------
L= DBM:GetModLocalization(1238)
-----------------------
-- <<<Overgrown Outpost>>> --
-----------------------
-----------------------
-- Witherbark --
-----------------------
L= DBM:GetModLocalization(1214)
-----------------------
-- Ancient Protectors --
-----------------------
L= DBM:GetModLocalization(1207)
-----------------------
-- Archmage Sol --
-----------------------
L= DBM:GetModLocalization(1208)
-----------------------
-- Xeri'tac --
-----------------------
L= DBM:GetModLocalization(1209)
L:SetMiscLocalization({
 Pull = "Xeri'tac começa a despejar Aranitas Tóxicas sobre você!"
})
-----------------------
-- Yalnu --
-----------------------
L= DBM:GetModLocalization(1210)
-----------------------
-- <<<Shadowmoon Buriel Grounds>>> --
-----------------------
-----------------------
-- Sadana Bloodfury --
-----------------------
L= DBM:GetModLocalization(1139)
-----------------------
-- Nhallish, Feaster of Souls --
-----------------------
L= DBM:GetModLocalization(1168)
-----------------------
-- Bonemaw --
-----------------------
L= DBM:GetModLocalization(1140)
-----------------------
-- Ner'zhul --
-----------------------
L= DBM:GetModLocalization(1160)
-----------------------
-- <<<Skyreach>>> --
-----------------------
-----------------------
-- Ranjit, Master of the Four Winds --
-----------------------
L= DBM:GetModLocalization(965)
-----------------------
-- Araknath --
-----------------------
L= DBM:GetModLocalization(966)
-----------------------
-- Rukhran --
-----------------------
L= DBM:GetModLocalization(967)
-----------------------
-- High Sage Viryx --
-----------------------
L= DBM:GetModLocalization(968)
L:SetWarningLocalization({
 warnAdd   = DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell:format("Constructo-escudo de Beira-céu"),
 specWarnAdd  = DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch:format("Constructo-escudo de Beira-céu")
})
L:SetOptionLocalization({
 warnAdd   = "Mostra aviso para Constructo-escudo de Beira-céu",
 specWarnAdd  = "Mostra aviso especial à trocar de alvo para Constructo-escudo de Beira-céu"
})
-------------
--  Skyreach Trash  --
-------------
L = DBM:GetModLocalization("SkyreachTrash")
L:SetGeneralLocalization({
 name = "Beira-céu Trash"
})
-----------------------
-- <<<Upper Blackrock Spire>>> --
-----------------------
-----------------------
-- Orebender Gor'ashan --
-----------------------
L= DBM:GetModLocalization(1226)
-----------------------
-- Kyrak --
-----------------------
L= DBM:GetModLocalization(1227)
-----------------------
-- Commander Tharbek --
-----------------------
L= DBM:GetModLocalization(1228)
-----------------------
-- Ragewind the Untamed --
-----------------------
L= DBM:GetModLocalization(1229)
-----------------------
-- Warlord Zaela --
-----------------------
L= DBM:GetModLocalization(1234)
L:SetTimerLocalization({
 timerZaelaReturns = "Zaela voltou"
})
L:SetOptionLocalization({
 timerZaelaReturns = "mostra aviso para quando Zaela ira retornar"
})
-------------
--  UBRS Trash  --
-------------
L = DBM:GetModLocalization("UBRSTrash")
L:SetGeneralLocalization({
 name = "PRNS Trash"
})