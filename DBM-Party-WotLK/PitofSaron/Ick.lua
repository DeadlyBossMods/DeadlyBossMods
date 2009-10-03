local mod = DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1665 $"):sub(12, -3))
mod:SetCreatureID()
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_PERIODIC_DAMAGE"
)

local specWarnToxic		= mod:NewSpecialWarning("specWarnToxic")

--mod:AddBoolOption("SetIconOnPursueTarget", true) --Needs chatlog data to finish implimentation

do 
	local lasttoxic = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(70274) and args:IsPlayer() and time() - lasttoxic > 2 then		-- Toxic Waste, MOVE!
			specWarnToxic:Show()
			lasttoxic = time()
		end
	end
end

