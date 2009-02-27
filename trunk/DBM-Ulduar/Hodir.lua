local mod = DBM:NewMod("Hodir", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
)

--mod:NewAnnounce("WarningSpark", 1, 59381)
--mod:NewTimer(30, "TimerSpark", 59381)
--mod:NewSpecialWarning("WarningSurgeYou")
--mod:NewEnrageTimer(615)

function mod:OnCombatStart(delay)
end

