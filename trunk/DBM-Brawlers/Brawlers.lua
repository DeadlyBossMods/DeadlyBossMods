local mod	= DBM:NewMod("Brawlers", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnHeatedPokers			= mod:NewSpellAnnounce(133286, 4)

local specWarnYourTurn			= mod:NewSpecialWarning("specWarnYourTurn")
local specWarnHeatedPokers		= mod:NewSpecialWarningSpell(133286)--Maybe run away sound? not sure, diff strats. some just stun the boss for 8 seconds if they can.

local timerHeatedPokers			= mod:NewBuffActiveTimer(8, 133286)
local timerHeatedPokersCD		= mod:NewCDTimer(29, 133286)

mod:AddBoolOption("SpectatorMode", true)

local playerisFighting = false

function mod:SPELL_CAST_START(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(133286) then
		warnHeatedPokers:Show()--Give reg warnings for spectators
		timerHeatedPokersCD:Start()--And timers
		if playerisFighting then--Only give special warnings if you're in arena though.
			specWarnHeatedPokers:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end
	if args:IsSpellID(133286) then
		timerHeatedPokers:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
--	"<17.2 15:06:00> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Now entering the arena: a Rank 1 human warrior, Omegal! Omegal is pretty new around here, so go easy!#Bizmo###Omegal##0#0##0#988##0#false#false"
	if msg:find(L.EnteringArena) then
		if target == UnitName("player") then
			specWarnYourTurn:Show()
			playerisFighting = true
		end
		self:SendSync("MatchBegin")
	elseif npc == L.Bizmo and matchActive and (msg:find(L.Victory1) or msg:find(L.Victory2) or msg:find(L.Victory3) or msg:find(L.Victory4) or msg:find(L.Victory5) or msg:find(L.Lost1) or msg:find(L.Lost2) or msg:find(L.Lost3) or msg:find(L.Lost4)) then
		self:SendSync("MatchEnd")
	end
end

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
		DBM:GetModByName("Brawlers"):Stop()--Stop all timers and warnings
	end
end
