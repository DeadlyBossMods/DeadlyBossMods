local mod	= DBM:NewMod("UndermineTrash", "DBM-Party-BfA", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 268709 263275",
	"SPELL_AURA_APPLIED 268702",
	"SPELL_CAST_SUCCESS 280604"
)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnCover					= mod:NewSpecialWarningMove(263275, "Tank", nil, nil, 1, 2)
local specWarnEarthShield			= mod:NewSpecialWarningInterrupt(268709, "HasInterrupt", nil, nil, 1, 2)
local specWarnIcedSpritzer			= mod:NewSpecialWarningInterrupt(280604, "HasInterrupt", nil, nil, 1, 2)
local specWarnFuriousQuake			= mod:NewSpecialWarningInterrupt(268702, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268709 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEarthShield:Show(args.sourceName)
		specWarnEarthShield:Play("kickcast")
	elseif spellId == 263275 then
		specWarnCover:Show()
		specWarnCover:Play("moveboss")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268702 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFuriousQuake:Show(args.sourceName)
		specWarnFuriousQuake:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 280604 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnIcedSpritzer:Show(args.sourceName)
		specWarnIcedSpritzer:Play("kickcast")
	end
end
