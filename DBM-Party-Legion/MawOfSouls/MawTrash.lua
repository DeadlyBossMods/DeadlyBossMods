local mod	= DBM:NewMod("MawTrash", "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetEncounterID(1823)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 198405 195031"
)

local specWarnScream			= mod:NewSpecialWarningInterrupt(198405, "HasInterrupt", nil, nil, 1, 2)
local specWarnDefiantStrike		= mod:NewSpecialWarningDodge(195031, nil, nil, nil, 2, 2)

local voiceScream				= mod:NewVoice(198405, "HasInterrupt")--kickcast
local voiceDefiantStrike		= mod:NewVoice(195036)--chargemove (eh, kind of a charge?)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198405 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnScream:Show(args.sourceName)
		voiceScream:Play("kickcast")
	elseif spellId == 195031 and self:AntiSpam(3, 1) then
		specWarnDefiantStrike:Show()
		voiceDefiantStrike:Play("chargemove")
	end
end
