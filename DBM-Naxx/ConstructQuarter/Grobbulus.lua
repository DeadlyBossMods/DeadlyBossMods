local mod = DBM:NewMod("Grobbulus", "DBM-Naxx", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15931)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnInjection			= mod:NewTargetAnnounce(28169, 2)

local specWarnInjection		= mod:NewSpecialWarning("SpecialWarningInjection")

local timerInjection		= mod:NewTargetTimer(10, 28169)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(28169) then
		warnInjection:Show(args.destName)
		timerInjection:Start(args.destName)
		if args:IsPlayer() then
			specWarnInjection:Show()
		end
		self:SetIcon(args.destName, 8, 9)
	end	
end

