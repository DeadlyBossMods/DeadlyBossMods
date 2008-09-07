local mod = DBM:NewMod("Heigan", "DBM-Naxx", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15936)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnTeleportNow		= mod:NewAnnounce("WarningTeleportNow", 3, 46573)

local timerTeleport			= mod:NewTimer(90, "TimerTeleport", 46573)

