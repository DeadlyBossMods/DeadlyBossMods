if GetLocale() ~= "deDE" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
   name = "Malygos"
})

L:SetWarningLocalization({
   WarningSpark      = "Energiefunke da!",
   WarningVortex      = "Vortex",
   WarningBreathSoon   = "Tiefer Atem bald",
   WarningBreath      = "Tiefer Atem!",
   WarningSurge      = "Kraftsog auf >%s<",
   WarningVortexSoon   = "Vortex bald",
   WarningSurgeYou      = "Kraftsog auf dir!"
})

L:SetTimerLocalization({
   TimerSpark      = "Energiefunke",
   TimerVortex      = "Vortex",
   TimerBreath      = "Tiefer Atem",
   TimerVortexCD   = "Vortex Cooldown"
})

L:SetOptionLocalization({
   WarningSpark      = "Warnung für Energiefunke anzeigen",
   WarningVortex      = "Warnung für Vortex anzeigen",
   WarningBreathSoon   = "Vorwarnung für Tiefen Atem anzeigen",
   WarningBreath      = "Warnung für Tiefen Atem anzeigen",
   WarningSurge      = "Warnung für Kraftsog anzeigen",
   TimerSpark         = "Timer für Energiefunke anzeigen",
   TimerVortex         = "Timer für Vortex anzeigen",
   TimerBreath         = "Timer für Tiefen Atem anzeigen",
   TimerVortexCD      = "Timer für Vortex Cooldown anzeigen (ungenau)",
   WarningVortexSoon   = "Vorwarnung für Vortex anzeigen (ungenau)",
   WarningSurgeYou      = "Spezial Warnung anzeigen, wenn du von Kraftsog betroffen bist"
})

L:SetMiscLocalization({
   YellPull      = "Meine Geduld ist am Ende. Ich werde mich eurer entledigen!",
   EmoteSpark      = "Ein Energiefunke bildet sich aus einem nahegelegenen Graben!",
   YellPhase2      = "Ich hatte gehofft, eure Leben schnell zu beenden, doch ihr zeigt euch... hartnäckiger als erwartet.",
   EmoteBreath      = "%s holt tief Luft.",
   YellBreath      = "Solange ich atme, werdet ihr nicht obsiegen!",
   YellPhase3      = "Eure Wohltäter sind eingetroffen, doch sie kommen zu spät! Die hier gespeicherten Energien reichen aus, die Welt zehnmal zu zerstören. Was, denkt ihr, werden sie mit euch machen?"
})
