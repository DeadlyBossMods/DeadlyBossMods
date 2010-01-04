local mod	= DBM:NewMod("CorenDirebrew", "DBM-Party-WotLK", 17)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23872)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

local warnBarrel			= mod:NewTargetAnnounce(51413)
local timerBarrel			= mod:NewTargetTimer(8, 51413)
local specWarnDisarm		= mod:NewSpecialWarningRun(47310, isMelee)
local specWarnBrew			= mod:NewSpecialWarning("specWarnBrew")
local timerBrew				= mod:NewTargetTimer(10, 47376)
local specWarnBrewStun		= mod:NewSpecialWarning("specWarnBrewStun")
local timerBrewStun			= mod:NewTargetTimer(6, 47340)

mod:AddBoolOption("YellOnBarrel", true, "announce")
local soundDisarm = mod:NewSound(47310)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(47310) then
		specWarnDisarm:Show()
		soundDisarm:Play()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(47376) then											-- Brew
		if args:IsPlayer() then
			specWarnBrew:Show()
		end
		timerBrew:Start(args.destName)
	elseif args:IsSpellID(47340) then										-- Brew Stun
		if args:IsPlayer() then
			specWarnBrewStun:Show()
		end
		timerBrewStun:Start(args.destName)
	elseif args:IsSpellID(47442, 51413) then								-- Barreled!
		warnBarrel:Show(args.destName)
		timerBarrel:Start(args.destName)
		if self.Options.YellOnBarrel and args:IsPlayer() then
			SendChatMessage(L.YellBarrel, "YELL")
		end
	end
end


