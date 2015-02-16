local mod	= DBM:NewMod("d287", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23872)
mod:SetModelID(21824)
mod:SetReCombatTime(10)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 47310",
	"SPELL_AURA_APPLIED 47376 47340 47442 51413",
	"SPELL_AURA_REMOVED 47376 47340 47442 51413"
)

local warnDisarm			= mod:NewCastAnnounce(47310, 2, nil, nil, "Melee")
local warnBarrel			= mod:NewTargetAnnounce(51413, 4)

local specWarnBrew			= mod:NewSpecialWarning("specWarnBrew")
local specWarnBrewStun		= mod:NewSpecialWarning("specWarnBrewStun")

local timerBarrel			= mod:NewTargetTimer(8, 51413)
local timerBrew				= mod:NewTargetTimer(10, 47376, nil, false)
local timerBrewStun			= mod:NewTargetTimer(6, 47340, nil, false)
local timerDisarm			= mod:NewCastTimer(4, 47310)

mod:AddBoolOption("YellOnBarrel", "Tank", "announce")

function mod:SPELL_CAST_START(args)
	if args.spellId == 47310 then
		warnDisarm:Show()
		timerDisarm:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 47376 then											-- Brew
		timerBrew:Start(args.destName)
		if args:IsPlayer() then
			specWarnBrew:Show()
		end
	elseif spellId == 47340 then										-- Brew Stun
		timerBrewStun:Start(args.destName)
		if args:IsPlayer() then
			specWarnBrewStun:Show()
		end
	elseif args:IsSpellID(47442, 51413) then								-- Barreled!
		warnBarrel:Show(args.destName)
		timerBarrel:Start(args.destName)
		if self.Options.YellOnBarrel and args:IsPlayer() then
			SendChatMessage(L.YellBarrel, "SAY")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 47376 then											-- Brew
		timerBrew:Cancel(args.destName)
	elseif args.spellId == 47340 then										-- Brew Stun
		timerBrewStun:Cancel(args.destName)
	elseif args:IsSpellID(47442, 51413) then								-- Barreled!
		timerBarrel:Cancel(args.destName)
	end
end
