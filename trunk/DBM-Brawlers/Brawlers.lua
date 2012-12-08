local mod	= DBM:NewMod("Brawlers", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone()

mod:RegisterEvents(
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnYourTurn			= mod:NewSpecialWarning("specWarnYourTurn")

mod:AddBoolOption("SpectatorMode", true)

local matchActive = false
local playerisFighting = false
local currentRank = 0--Used to stop bars for the right sub mod based on dynamic rank detection from pulls

function mod:PlayerFighting()--So external mods can check value of a local variable
	if playerisFighting then return true end
	if not playerisFighting then return false end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
--	"<17.2 15:06:00> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Now entering the arena: a Rank 1 human warrior, Omegal! Omegal is pretty new around here, so go easy!#Bizmo###Omegal##0#0##0#988##0#false#false"
	if msg:find(L.Rank) then
		currentRank = L.Rank--This is wrong, need some fancy code to pull number from message (ie "Rank 1") so we can set it as current rank
		if target == UnitName("player") then
			specWarnYourTurn:Show()
			playerisFighting = true
		end
		self:SendSync("MatchBegin")
	elseif matchActive and (msg:find(L.Victory1) or msg:find(L.Victory2) or msg:find(L.Victory3) or msg:find(L.Victory4) or msg:find(L.Victory5) or msg:find(L.Victory6) or msg:find(L.Lost1) or msg:find(L.Lost2) or msg:find(L.Lost3) or msg:find(L.Lost4) or msg:find(L.Lost5) or msg:find(L.Lost6) or msg:find(L.Lost7) or msg:find(L.Lost8)) then
		self:SendSync("MatchEnd")
	end
end

--TODO: Maybe add a PLAYE_REGEN_DISABLED event that checks current target for deciding what special bars to start on engage.
function mod:PLAYER_REGEN_ENABLED()
	if playerisFighting then--We check playerisFighting to filter bar brawls, this should only be true if we were ported into ring.
		playerisFighting = false
		self:SendSync("MatchEnd")
	end
end

--Most group up for this so they can buff eachother for matches. Syncing should greatly improve reliability, especially for match end since the person fighting definitely should detect that (probalby missing yells still)
function mod:OnSync(msg)
	if msg == "MatchBegin" then
		matchActive = true
	elseif msg == "MatchEnd" then
		matchActive = false
		DBM:GetModByName(currentRank):Stop()--Stop all timers and warnings
	end
end
