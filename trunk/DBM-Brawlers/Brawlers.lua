local mod	= DBM:NewMod("Brawlers", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_CHANNEL_START",
	"UNIT_DIED"
)

local warnChomp					= mod:NewSpellAnnounce(135342, 4)
local warnLumberingCharge		= mod:NewSpellAnnounce(134527, 4)
local warnHeatedPokers			= mod:NewSpellAnnounce(133286, 4)
local warnThrowNet				= mod:NewSpellAnnounce(133308, 3)--Pretty dangerous but probably no need for special warning.
local warnGoblinDevice			= mod:NewSpellAnnounce(133227, 4)
local warnPyroblast				= mod:NewCastAnnounce(132666, 3)--Hits fairly hard, interruptable, not make or break though. So no special warning. If it hits you you won't wipe.
local warnFireWall				= mod:NewSpellAnnounce(132666, 4)
local warnVolatileFlames		= mod:NewSpellAnnounce(134740, 3)
local warnFireLine				= mod:NewCastAnnounce(133607, 4)
local warnDevastatingThrust		= mod:NewSpellAnnounce(134777, 4)--1.5 second cast, does 2 million damage. pretty brutal
local warnSummonTwister			= mod:NewSpellAnnounce(132670, 3)
local warnStormCloud			= mod:NewSpellAnnounce(135234, 3)--Can be interrupted

local specWarnYourTurn			= mod:NewSpecialWarning("specWarnYourTurn")
local specWarnChomp				= mod:NewSpecialWarningMove(135342)
local specWarnLumberingCharge	= mod:NewSpecialWarningMove(134527)
local specWarnHeatedPokers		= mod:NewSpecialWarningSpell(133286)--Can be interrupted, if you don't have one. can stun through buff or run away. How you handle varies, but you MUST handle it.
local specWarnGoblinDevice		= mod:NewSpecialWarningSpell(133227)--This is debuff cast, it makes YOU drop mines 3-4 seconds later. you can drop these where you want.
local specWarnFireWall			= mod:NewSpecialWarningSpell(132666)
local specWarnFireLine			= mod:NewSpecialWarningMove(133607)
local specWarnDevastatingThrust	= mod:NewSpecialWarningMove(134777)
local specWarnStormCloud		= mod:NewSpecialWarningInterrupt(135234)

local timerChompCD				= mod:NewCDTimer(8, 135342)
local timerLumberingChargeCD	= mod:NewCDTimer(7, 134527)--7-10 sec variation
local timerHeatedPokers			= mod:NewBuffActiveTimer(8, 133286)
local timerHeatedPokersCD		= mod:NewCDTimer(29, 133286)
local timerThrowNetCD			= mod:NewCDTimer(20, 133308)
local timerGoblinDeviceCD		= mod:NewCDTimer(22, 133227)
local timerFirewallCD			= mod:NewCDTimer(18, 132666)--18-22 sec variation
local timerVolatileFlamesCD		= mod:NewCDTimer(11, 134740)--11-20 sec variation
local timerFireLineCD			= mod:NewCDTimer(15, 133607)--15-22 sec variation
local timerDevastatingThrustCD	= mod:NewCDTimer(12, 134777)--Need more data to verify CD
local timerSummonTwisterCD		= mod:NewCDTimer(15, 132670)--15-17 sec variation

mod:AddBoolOption("SpectatorMode", true)

local matchActive = true
local playerisFighting = false

function mod:SPELL_CAST_START(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(135342) then
		warnChomp:Show()--Give reg warnings for spectators
		timerChompCD:Start()--And timers (first one is after 6 seconds)
		if playerisFighting then--Only give special warnings if you're in arena though.
			specWarnChomp:Show()
		end
	elseif args:IsSpellID(133286) then
		warnHeatedPokers:Show()
		timerHeatedPokersCD:Start()
		if playerisFighting then
			specWarnHeatedPokers:Show()
		end
	elseif args:IsSpellID(133308) then
		warnThrowNet:Show()
		timerThrowNetCD:Start()
	elseif args:IsSpellID(33975) then--Spellid is used by 5 diff mobs in game, but SetZone sould filter the other 4 mobs.
		warnPyroblast:Show()
	elseif args:IsSpellID(132666) then
		warnFireWall:Show()
		timerFirewallCD:Start()--First one is 5 seconds after combat start
		if playerisFighting then
			specWarnFireWall:Show()
		end
	elseif args:IsSpellID(133607) then
		warnFireLine:Show()
		timerFireLineCD:Start()--First one is 9-10 seconds after combat start
		if playerisFighting then
			specWarnFireLine:Show()
		end
	elseif args:IsSpellID(134777) then
		warnDevastatingThrust:Show()
		timerDevastatingThrustCD:Start()--First one is 7-8 seconds after combat start
		if playerisFighting then
			specWarnDevastatingThrust:Show()
		end
	elseif args:IsSpellID(135234) then
		warnStormCloud:Show()
		--CD seems to be 32 seconds usually but sometimes only 16? no timer for now
		if playerisFighting then
			specWarnStormCloud:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end
	if args:IsSpellID(133227) then
		warnGoblinDevice:Show()
		timerGoblinDeviceCD:Start()--6 seconds after combat start, if i do that kind of detection later
		if playerisFighting then--Only give special warnings if you're in arena though.
			specWarnGoblinDevice:Show()
		end
	elseif args:IsSpellID(132670) then
		warnSummonTwister:Show()
		timerSummonTwisterCD:Start()--22 seconds after combat start?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.SpectatorMode and not playerisFighting then return end
	if args:IsSpellID(133286) then
		timerHeatedPokers:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
--	"<17.2 15:06:00> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Now entering the arena: a Rank 1 human warrior, Omegal! Omegal is pretty new around here, so go easy!#Bizmo###Omegal##0#0##0#988##0#false#false"
	if msg:find(L.EnteringArena1) or msg:find(L.EnteringArena2) or msg:find(L.EnteringArena3) then
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 67524 then--These 2 have a 1 min 50 second berserk
		timerThrowNetCD:Cancel()
	elseif cid == 67525 then--These 2 have a 1 min 50 second berserk
		timerGoblinDeviceCD:Cancel()
	end
end

--This event won't really work well for spectators if they target the player instead of boss. This event only fires if boss is on target/focus
--It is however the ONLy event you can detect this spell using.
function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, _, _, spellId)
	if spellId == 134527 and self:AntiSpam() then
		warnLumberingCharge:Show()
		timerLumberingChargeCD:Start()
		if playerisFighting then
			specWarnLumberingCharge:Show()
		end
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
