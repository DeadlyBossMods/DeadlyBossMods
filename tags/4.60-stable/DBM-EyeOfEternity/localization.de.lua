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
   WarningSpark      = "Energiefunke",
   WarningBreathSoon   = "Tiefer Atem bald",
   WarningBreath      = "Tiefer Atem"
})

L:SetTimerLocalization({
   TimerSpark      = "Nächster Energiefunke",
   TimerBreath      = "Nächster Tiefer Atem"
})

L:SetOptionLocalization({
   WarningSpark      = "Zeige Warnung für Energiefunke",
   WarningBreathSoon   = "Zeige Vorwarnung für Tiefen Atem",
   WarningBreath      = "Zeige Warnung für Tiefen Atem",
   TimerSpark         = "Zeige Timer für nächsten Energiefunken",
   TimerBreath         = "Zeige Timer für nächsten Tiefen Atem"
})

L:SetMiscLocalization({
   YellPull      = "Meine Geduld ist am Ende. Ich werde mich eurer entledigen!",
   EmoteSpark      = "Ein Energiefunke bildet sich aus einem nahegelegenen Graben!",
   YellPhase2      = "Ich hatte gehofft, eure Leben schnell zu beenden, doch ihr zeigt euch... hartnäckiger als erwartet.",
   EmoteBreath      = "%s holt tief Luft.",
   YellBreath      = "Solange ich atme, werdet ihr nicht obsiegen!",
   YellPhase3      = "Eure Wohltäter sind eingetroffen, doch sie kommen zu spät! Die hier gespeicherten Energien reichen aus, die Welt zehnmal zu zerstören. Was, denkt ihr, werden sie mit euch machen?"
})

