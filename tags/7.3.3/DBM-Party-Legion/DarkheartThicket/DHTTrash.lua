local mod	= DBM:NewMod("DHTTrash", "DBM-Party-Legion", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 198379"
)

local specWarnPrimalRampage			= mod:NewSpecialWarningDodge(198379, "Melee", nil, nil, 1, 2)

local voicePrimalRampage			= mod:NewVoice(198379, "Melee")--chargemove

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198379 then
		specWarnPrimalRampage:Show()
		voicePrimalRampage:Play("chargemove")
--[[	elseif spellId == 195046 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnStorm:Show(args.sourceName)
		specWarnRejuvWaters:Play("kickcast")--]]
	end
end
