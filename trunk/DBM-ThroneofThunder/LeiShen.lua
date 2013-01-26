if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(832, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68397)
mod:SetModelID(46770)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnDecapitate					= mod:NewTargetAnnounce(135000, 4, nil, mod:IsTank() or mod:IsHealer())

local specWarnDecapitate				= mod:NewSpecialWarningRun(135000, mod:IsTank())
local specWarnDecapitateOther			= mod:NewSpecialWarningTarget(135000, mod:IsTank())

local timerDecapitateCD					= mod:NewCDTimer(50, 135000)

function mod:OnCombatStart(delay)
	timerDecapitateCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(135000) then
		warnDecapitate:Show(args.destName)
		timerDecapitateCD:Start()
		if args:IsPlayer() then
			specWarnDecapitate:Show()
		else
			specWarnDecapitateOther:Show(args.destName)
		end
	end
end