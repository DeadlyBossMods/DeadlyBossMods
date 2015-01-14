local mod	= DBM:NewMod("GarrisonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)
mod.noStatistics = true

local specWarnRylak				= mod:NewSpecialWarning("specWarnRylak")
local specWarnWorker			= mod:NewSpecialWarning("specWarnWorker")

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.rylakSpawn or msg:find(L.rylakSpawn) then
		specWarnRylak:Show()
	elseif msg == L.terrifiedWorker or msg:find(L.terrifiedWorker) then
		specWarnWorker:Show()
	end
end
