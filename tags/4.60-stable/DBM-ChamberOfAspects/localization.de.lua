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
	WarningSplitSoon	= "Aufspaltung bald"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Zeige Vorwarnun für Aufspaltung",
	RangeFrame			= "Zeige Abstandsfenster (12 m)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
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

L:SetWarningLocalization({
	SpecialWarningTranq		= "Wutanfall - Einlullen/Beruhigen"
})

L:SetOptionLocalization({
	SpecialWarningTranq		= "Zeige Spezialwarnung für $spell:78722",
	RangeFrame				= "Zeige Abstandsfenster (10 m)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

L:SetMiscLocalization{
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Neue Adds"
})

L:SetTimerLocalization({
	TimerAdds	= "Neue Adds"
})

L:SetOptionLocalization({
	WarnAdds		= "Verkünde neue Adds",
	TimerAdds		= "Zeige Timer für neue Adds"
})

L:SetMiscLocalization({
	SummonMinions	= "Äschert sie ein, Lakaien!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion der Zwielichtzerstörer"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "Phase 2 bald",
	WarnPhase3Soon		= "Phase 3 bald"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Zeige Vorwarnung für Phase 2 (bei ~79%)",	
	WarnPhase3Soon			= "Zeige Vorwarnung für Phase 3 (bei ~54%)",
	SoundOnConsumption		= "Spiele Sound bei Einäschern",--We use localized text for these functions
	SetIconOnConsumption	= "Setze Zeichen auf Ziele von Einäschern"--So we can use single functions for both versions of spell."--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	MeteorCast				= "Die Himmel brennen!",
	Phase2					= "Ihr werdet im Reich des Zwielichts nur Leid finden! Tretet ein, wenn ihr es wagt!",
	Phase3					= "Ich bin das Licht und die Dunkelheit!",--partial, message find should find it though.
	twilightcutter			= "Die kreisenden Sphären pulsieren vor dunkler Energie!",
	YellCombustion			= "Combustion on me!",--needs translation
	YellConsumption			= "Consumption on me!",--needs translation
	Kill					= "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"--needs translation
})
