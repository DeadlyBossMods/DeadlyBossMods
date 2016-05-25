local mod	= DBM:NewMod("EoATrash", "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196870 195046"
)

--TODO, still missing some GTFOs for this. Possibly other important spells.
local specWarnStorm				= mod:NewSpecialWarningInterrupt(196870, "HasInterrupt", nil, nil, 1, 2)
local specWarnRejuvWaters		= mod:NewSpecialWarningInterrupt(195046, "HasInterrupt", nil, nil, 1, 2)

local voiceStorm				= mod:NewVoice(196870, "HasInterrupt")--kickcast
local voiceRejuvWaters			= mod:NewVoice(195046, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196870 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnStorm:Show(args.sourceName)
		voiceStorm:Play("kickcast")
	elseif spellId == 195046 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnStorm:Show(args.sourceName)
		specWarnRejuvWaters:Play("kickcast")
	end
end
