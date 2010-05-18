if GetLocale() ~= "deDE" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
   WarningTenebron         = "Tenebron kommt",
   WarningShadron         = "Shadron kommt",
   WarningVesperon         = "Vesperon kommt",
   WarningFireWall         = "Feuerwand",
   WarningVesperonPortal   = "Vesperons Portal",
   WarningTenebronPortal   = "Tenebrons Portal",
   WarningShadronPortal   = "Shadrons Portal"
})

L:SetTimerLocalization({
   TimerTenebron   = "Tenebron kommt",
   TimerShadron   = "Shadron kommt",
   TimerVesperon   = "Vesperon kommt"
})

L:SetOptionLocalization({
   PlaySoundOnFireWall   = "Spiele Sound bei Feuerwand",
   AnnounceFails      = "Verkünde Spieler, die bei Feuerwand und Zone der Leere scheitern, im Raidchat (benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
   TimerTenebron      = "Zeige Timer für Tenebrons Ankunft",
   TimerShadron      = "Zeige Timer für Shadrons Ankunft",
   TimerVesperon      = "Zeige Timer für Vesperons Ankunft",
   WarningFireWall      = "Zeige Spezialwarnung für Feuerwand",
   WarningTenebron      = "Verkünde Ankunft von Tenebron",
   WarningShadron      = "Verkünde Ankunft von Shadron",
   WarningVesperon      = "Verkünde Ankunft von Vesperon",
   WarningTenebronPortal   = "Zeige Spezialwarnung für Tenebrons Portale",
   WarningShadronPortal   = "Zeige Spezialwarnung für Shadrons Portale",
   WarningVesperonPortal   = "Zeige Spezialwarnung für Vesperons Portale"
})

L:SetMiscLocalization({
   Wall         = "Die Lava um %s brodelt!",
   Portal         = "%s beginnt, ein Portal des Zwielichts zu öffnen!",
   NameTenebron   = "Tenebron",
   NameShadron      = "Shadron",
   NameVesperon   = "Vesperon",
   FireWallOn      = "Feuerwand: %s",
   VoidZoneOn      = "Zone der Leere: %s",
   VoidZones      = "Fehler bei Zone der Leere (dieser Versuch): %s",
   FireWalls      = "Fehler bei Feuerwand (dieser Versuch): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus der Kriegsjünger"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	SplitTrigger		= "Doppelter Schmerz, halb soviel Spaß."
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Flammenschlund"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion der Zwielichtzerstörer"
})

