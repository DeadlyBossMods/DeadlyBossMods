local mod	= DBM:NewMod("d517", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 878)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
--	"SCENARIO_CRITERIA_UPDATE"
)

--[[First event
"<24.7 19:33:15> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#The storm is starting! Get ready.#Brewmaster Blanche###Omegal##0#0##0#995#nil#0#false#false", -- [40]
"<29.8 19:33:20> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 10
"<39.5 19:33:30> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 20
"<47.0 19:33:37> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 30
"<53.9 19:33:44> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 40
"<68.4 19:33:59> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 50
"<78.5 19:34:09> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 60
"<83.6 19:34:14> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 70
"<92.8 19:34:23> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 80
"<98.2 19:34:29> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 90
"<107.4 19:34:38> [UPDATE_WORLD_STATES] |0#1#false#Brew Progress: 100
"<107.5 19:34:38> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#You did it! Let's get this brew to the Monastery...#Brewmaster Blanche###Brewkeg##0#0##0#1005#nil#0#false#false", -- [698]
--]]

--[[Possible Timer update stuff we can use to auto adjust remaining time to these values every 10 energy
Start to finish, 82.8
10 to finish,  77.7
20 to finish,  68
30 to finish,  60.5
40 to finish,  53.6
50 to finish,  39.1
60 to finish,  29
70 to finish,  23.9
80 to finish,  14.7
90 to finish,  9.3
--]]

--Event Warnings
---Maybe add warning for saurok waves? or if a barrel catches fire? Not get transcriptor of fire since we didn't let any saurok reach barrels
--Borokhula the Destroyer
local warnSwampSmash			= mod:NewSpellAnnounce(115013, 3)--TODO, see if target scanning works and change to target warning and target special warning instead
local warnEarthShattering		= mod:NewSpellAnnounce(122142, 3)

--Event
---NOTHING HERE!
--Borokhula the Destroyer
local specWarnSwampSmash		= mod:NewSpecialWarningSpell(115013, nil, nil, nil, 2)

--Event
--local timerEvent				= mod:NewTimer(82.8, "timerEvent", 106648)
--Borokhula the Destroyer
local timerSwampSmashCD			= mod:NewCDTimer(18, 115013)--Limited sample size, may be shorter
local timerEarthShatteringCD	= mod:NewNextTimer(25, 122142)--Limited sample size, may be shorter

mod:RemoveOption("HealthFrame")

local CRITERIA_DEFEND_THE_BREW = 22197

function mod:SPELL_CAST_START(args)
	if args.spellId == 115013 then
		warnSwampSmash:Show()
		specWarnSwampSmash:Show()
		timerSwampSmashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 122142 then
		warnEarthShattering:Show()
		timerEarthShatteringCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.BrewStart or msg:find(L.BrewStart) then
		self:SendSync("BrewStarted")
	elseif msg == L.BorokhulaPull or msg:find(L.BorokhulaPull) then
		self:SendSync("BorokhulaPulled")
	elseif msg == L.BorokhulaAdds or msg:find(L.BorokhulaAdds) then
		self:SendSync("BorokhulaAdds")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 58739 then--Borokhula the Destroyer
		timerSwampSmashCD:Cancel()
		timerEarthShatteringCD:Cancel()
	end
end

--[[
function mod:SCENARIO_CRITERIA_UPDATE(criteriaID)
	if criteriaID == CRITERIA_DEFEND_THE_BREW and self:IsCriteriaCompleted(criteriaID) then
		timerEvent:Cancel()
	end
end--]]

function mod:OnSync(msg)
	if msg == "BrewStarted" then
--		timerEvent:Start()
	elseif msg == "BorokhulaPulled" then
		timerSwampSmashCD:Start()
		timerEarthShatteringCD:Start()
	elseif msg == "BorokhulaAdds" then
--[[--Insufficent data to determine consistent timing, or if it's even time based at all (maybe he just calls more when old ones all die?)
"<378.3 19:39:09> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#Last call, you fork-tongued dip-slithers!
"<396.4 19:39:27> RAID_BOSS_EMOTE#%s calls out for reinforcements!#Borokhula the Destroyer#0#true", -- [3]
"<409.6 19:39:40> RAID_BOSS_EMOTE#%s calls out for reinforcements!#Borokhula the Destroyer#0#true", -- [4]
--]]
	end
end
