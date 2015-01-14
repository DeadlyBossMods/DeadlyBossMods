local mod	= DBM:NewMod("GarrisonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)
mod.noStatistics = true

local specWarnRylak				= mod:NewSpecialWarning("specWarnRylak")
local specWarnWorker			= mod:NewSpecialWarning("specWarnWorker")

--local timerCombatStart			= mod:NewCombatTimer(44)--rollplay for first pull

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.rylakSpawn or msg:find(L.rylakSpawn) then
		specWarnRylak:Show()
	elseif msg == L.terrifiedWorker or msg:find(L.terrifiedWorker) then
		specWarnWorker:Show()
	end
end

--"<11.02 22:30:06> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#To arms! To your posts! Our fight today is with ogres.#Sergeant Crowler###Esoth##0#0##0#4137#nil#0#false#false#false", -- [3]
--"<55.10 22:30:50> [SCENARIO_CRITERIA_UPDATE] criteriaID#25172#Info#Gorian Assault#1#6#0#false#false#false#625#228000#StepInfo#Invasion!#Follow the Sergeant#1#false#false#false#CriteriaInfo1#Follow the Sergeant#92#true#1#1#0#39813#1#25172#0#0#false", -- [40]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.preCombat or msg:find(L.preCombat) then
		--timerCombatStart:Start()
	end
end
