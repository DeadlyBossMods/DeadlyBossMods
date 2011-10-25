if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(332, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56427)
mod:SetModelID(39399)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnTwilightOnslaught			= mod:NewCastAnnounce(107588, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())

--local specWarmTwilightOnslaught	= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank(), 3)

--local timerTwilightOnslaughtCD	= mod:NewCDTimer(60, 107588)--Cd unknown, placeholder
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, mod:IsTank() or mod:IsHealer())

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107588) then--Assumed since it's only cast ID spellid in ptr.wowhead
		warnTwilightOnslaught:Show()
--		specWarmTwilightOnslaught:Show()
--		timerTwilightOnslaughtCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(108043) then
		warnSunder:Show(args.destName, args.amount or 1)
		timerSunder:Start(args.destName)
		if (args.amount or 0) >= 3 and args:IsPlayer() then
			specWarnSunder:Show(args.amount)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED