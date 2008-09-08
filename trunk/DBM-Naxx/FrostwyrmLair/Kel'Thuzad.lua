local mod = DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15990)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("yell", L.Yell)

mod:RegisterEvents(

)

--local warnMarkSoon	= mod:NewAnnounce("WarningMarkSoon", 1, 28835)
--local warnMarkNow	= mod:NewAnnounce("WarningMarkNow", 2, 28835)

local timerPhase2		= mod:NewTimer(320, "TimerPhase2")


function mod:OnCombatStart(delay)
	timerPhase2:Start()
end

