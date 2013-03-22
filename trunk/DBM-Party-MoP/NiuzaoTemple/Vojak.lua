local mod	= DBM:NewMod(738, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61634)
mod:SetModelID(42169)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
--	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnCausticTar			= mod:NewSpellAnnounce("ej6278", 2)--Announce a tar is ready to be used. (may be spammy and turned off by default if it is)
local warnBombard				= mod:NewSpellAnnounce(120200, 3)
local warnDashingStrike			= mod:NewSpellAnnounce(120789, 3)
local warnThousandBlades		= mod:NewSpellAnnounce(120759, 4)

local specWarnThousandBlades	= mod:NewSpecialWarningRun(120759, mod:IsMelee())

--local timerWaveCD				= mod:NewTimer(12, "TimerWave", 69076)--Not wave timers in traditional sense. They are non stop, this is for when he activates certain mob types.
local timerBombard				= mod:NewBuffActiveTimer(15, 120200)
local timerBombardCD			= mod:NewCDTimer(42, 120200)
local timerDashingStrikeCD		= mod:NewCDTimer(13.5, 120789)--14-16 second variation
local timerThousandBladesCD		= mod:NewNextTimer(15, 120759)
local timerThousandBlades		= mod:NewBuffActiveTimer(4, 120759)

local soundThousandBlades		= mod:NewSound(120759, nil, mod:IsMelee())

--local Swarmers 		= EJ_GetSectionInfo(6280)
--local Demolishers 	= EJ_GetSectionInfo(6282)
--local Warriors	 	= EJ_GetSectionInfo(6283)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 120759 then
		warnThousandBlades:Show()
		specWarnThousandBlades:Show()
		timerThousandBlades:Start()
		soundThousandBlades:Play()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 120789 then
		warnDashingStrike:Show()
		timerDashingStrikeCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 120402 then-- NPC only buff, player's buff is 123032
		warnCausticTar:Show()
	elseif args.spellId == 120759 then
		timerThousandBladesCD:Start()
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.WaveStart or msg:find(L.WaveStart) then -- all timer and mob not confirmed, maybe useless.
		timerWaveCD:Start(8, Swarmers) 
		timerWaveCD:Start(65, Demolishers)
		timerWaveCD:Start(102, Swarmers..", "..Warriors)
		timerWaveCD:Start(160, Demolishers..", "..Warriors)
	end
end--]]

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:120559") then -- Bombard seems to be not related with wave status.
		warnBombard:Show()
		timerBombard:Start()
		timerBombardCD:Start()
	end
end
