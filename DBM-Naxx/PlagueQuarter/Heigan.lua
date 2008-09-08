local mod = DBM:NewMod("Heigan", "DBM-Naxx", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15936)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents()

local warnTeleportSoon		= mod:NewAnnounce("WarningTeleportSoon", 2, 46573)
local warnTeleportNow		= mod:NewAnnounce("WarningTeleportNow", 3, 46573)

local timerTeleport			= mod:NewTimer(90, "TimerTeleport", 46573)

function mod:OnCombatStart(delay)
	mod:BackInRoom(delay)
end

function mod:DancePhase()
	timerTeleport:Show(50)
	warnTeleportSoon:Schedule(40, 10)
	warnTeleportNow:Schedule(50)
	self:ScheduleMethod(50, "BackInRoom")
end

function mod:BackInRoom(delay)
	delay = delay or 0
	timerTeleport:Show(90 - delay)
	warnTeleportSoon:Schedule(75 - delay, 15)
	warnTeleportNow:Schedule(90 - delay)
	self:ScheduleMethod(90 - delay, "DancePhase")
end
