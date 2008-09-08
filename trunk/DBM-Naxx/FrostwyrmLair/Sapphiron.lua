local mod = DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15989)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(

)

--local warnMarkSoon	= mod:NewAnnounce("WarningMarkSoon", 1, 28835)
--local warnMarkNow	= mod:NewAnnounce("WarningMarkNow", 2, 28835)

local timerAirPhase		= mod:NewTimer(45, "TimerAir", "")
local timerAirLadning	= mod:NewTimer(12, "TimerLadning", "")

function mod:OnCombatStart(delay)
	timerAirPhase:Start(45 - delay)
end

