local mod	= DBM:NewMod("CorenDirebrew", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23872)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBarrel			= mod:NewTargetAnnounce(51413, 4)
local timerBarrel			= mod:NewTargetTimer(8, 51413)

local specWarnDisarm		= mod:NewSpecialWarningRun(47310, mod:IsMelee())
local specWarnBrew			= mod:NewSpecialWarning("specWarnBrew")
local specWarnBrewStun		= mod:NewSpecialWarning("specWarnBrewStun")

local timerBrew				= mod:NewTargetTimer(10, 47376)
local timerBrewStun			= mod:NewTargetTimer(6, 47340)

mod:AddBoolOption("YellOnBarrel", mod:IsTank(), "announce")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(47310) then
		specWarnDisarm:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(47376) then											-- Brew
		timerBrew:Start(args.destName)
		if args:IsPlayer() then
			specWarnBrew:Show()
		end
	elseif args:IsSpellID(47340) then										-- Brew Stun
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


