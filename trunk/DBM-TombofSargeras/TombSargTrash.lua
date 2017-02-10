local mod	= DBM:NewMod("TombSargTrash", "DBM-TombofSargeras")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 241360",
	"SPELL_AURA_APPLIED 240735 241362"
)

local warnPolyMorphBomb				= mod:NewTargetAnnounce(240735, 3)
local warnWateryGrave				= mod:NewTargetAnnounce(241362, 3)

local specWarnPolyMorphBomb			= mod:NewSpecialWarningMoveAway(240735, nil, nil, nil, 1, 2)
local yellPolyMorphBomb				= mod:NewYell(240735)
local specWarnWateryGrave			= mod:NewSpecialWarningSwitch(241360, "-Healer", nil, nil, 1, 2)

local voicePolyMorphBomb			= mod:NewVoice(240735)--runout
local voiceWateryGrave				= mod:NewVoice(241360, "-Healer")--help?

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then
		specWarnWateryGrave:Show()
		voiceWateryGrave:Play("help")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240735 then
		if args:IsPlayer() then
			specWarnPolyMorphBomb:Show()
			voicePolyMorphBomb:Play("runout")
			yellPolyMorphBomb:Yell()
		else
			warnPolyMorphBomb:Show(args.destName)
		end
	elseif spellId == 241362 then
		warnWateryGrave:CombinedShow(0.3, args.destName)--Multiple targets assumed
	end
end
