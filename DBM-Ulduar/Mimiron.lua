local mod = DBM:NewMod("Mimiron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33432)
mod:SetZone()

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_STOP",
	"UNIT_SPELLCAST_FAILED",
	"UNIT_SPELLCAST_FAILED_QUIET",
	"UNIT_SPELLCAST_CHANNEL_STOP"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee, "announce")
mod:AddBoolOption("PlaySoundOnDarkGlare", true, "announce")

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast", isMelee)
local timerProximityMines	= mod:NewCDTimer(35, 63027)

local timerDarkGlareCast	= mod:NewCastTimer(10, 63274)
local timerNextDarkGlare	= mod:NewCDTimer(41, 63274)
local warnDarkGlare		= mod:NewSpecialWarning("DarkGlare")

local timerSpinUp		= mod:NewCastTimer(4, 63414)
local timerP1toP2		= mod:NewTimer(30, "TimeToPhase2")

local phase = 0 

function mod:OnCombatStart(delay)
	phase = 1
end

-- todo...
local spinningUp = GetSpellInfo(63414)
function mod:WTF(event, unit, spell)
	if spell == spinningUp then
		print(event, unit, spell)
		timerSpinUp:Cancel()
		timerDarkGlareCast:Cancel()
		timerNextDarkGlare:Cancel()
		warnDarkGlare:Cancel()
	end
end

function mod:UNIT_SPELLCAST_STOP(...)
	return self:WTF("UNIT_SPELLCAST_STOP", ...)
end
function mod:UNIT_SPELLCAST_FAILED(...)
	return self:WTF("UNIT_SPELLCAST_FAILED", ...)
end
function mod:UNIT_SPELLCAST_FAILED_QUIET(...)
	return self:WTF("UNIT_SPELLCAST_FAILED_QUIET", ...)
end
function mod:UNIT_SPELLCAST_CHANNEL_STOP(...)
		return self:WTF("UNIT_SPELLCAST_CHANNEL_STOP", ...)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 63631 then
		warnShockBlast:Show()

		if self.Options.PlaySoundOnShockBlast then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63027 then		-- mines
		timerProximityMines:Start()

	elseif args.spellId == 63414 then	-- Spinning UP (before Dark Glare)
		timerSpinUp:Start()
		timerDarkGlareCast:Schedule(4)
		timerNextDarkGlare:Schedule(19)	-- 4 (cast spinup) + 15 sec (cast dark glare)
		warnDarkGlare:Show()

		if self.Options.PlaySoundOnDarkGlare then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase3 then
		phase = 3
		timerDarkGlareCast:Cancel()
		timerDarkGlareCast:Cancel()
	end
end

do 
	local count = 0
	local last = 0
	function mod:SPELL_AURA_REMOVED(args)
		if phase == 1 and self:GetCIDFromGUID(args.destGUID) == 33432 then
			if args.timestamp == last then	-- all events in the same second to detect the 2nd phase early and localization-independent
				count = count + 1
				if count > 15 then
					phase = 2
					timerProximityMines:Stop()
					timerP1toP2:Start()
				end
			else
				count = 1
			end
			last = args.timestamp
		end
	end
end

function mod:OnSync(event, args)
	
end

