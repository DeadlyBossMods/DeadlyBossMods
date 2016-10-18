local mod	= DBM:NewMod("ArcwayTrash", "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 14860 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 211757 226206",
	"SPELL_AURA_APPLIED 194006 210750 211745"
)

--TODO, for time being, not registering high cpu spell damage events for GTFOs. One warning should be enough. Will re-evalulate if it is a problem
local specWarnArgusPortal			= mod:NewSpecialWarningInterrupt(211757, "HasInterrupt", nil, nil, 1, 2)
local specWarnArcaneReconstitution	= mod:NewSpecialWarningInterrupt(226206, "HasInterrupt", nil, nil, 1, 2)

local specWarnOozePuddle			= mod:NewSpecialWarningMove(194006, nil, nil, nil, 1, 2)
local specWarnColapsingRift			= mod:NewSpecialWarningMove(210750, nil, nil, nil, 1, 2)
local specWarnFelStrike				= mod:NewSpecialWarningMove(211745, nil, nil, nil, 1, 2)

local voiceArgusPortal				= mod:NewVoice(211757, "HasInterrupt")--kickcast
local voiceArcaneReconstitution		= mod:NewVoice(226206, "HasInterrupt")--kickcast
local voiceOozePuddle				= mod:NewVoice(194006)--runaway
local voiceColapsingRift			= mod:NewVoice(210750)--runaway
local voiceFelStrike				= mod:NewVoice(211745)--runaway

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 211757 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnArgusPortal:Show(args.sourceName)
		voiceArgusPortal:Play("kickcast")
	elseif spellId == 226206 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnArcaneReconstitution:Show(args.sourceName)
		voiceArcaneReconstitution:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194006 and args:IsPlayer() then
		specWarnOozePuddle:Show()
		voiceOozePuddle:Play("runaway")
	elseif spellId == 210750 and args:IsPlayer() then
		specWarnColapsingRift:Show()
		voiceColapsingRift:Play("runaway")
	elseif spellId == 211745 and args:IsPlayer() then
		specWarnFelStrike:Show()
		voiceFelStrike:Play("runaway")
	end
end
