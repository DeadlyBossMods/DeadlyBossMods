local mod	= DBM:NewMod("TazaveshTrash", "DBM-Party-Shadowlands", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = false--in this zone, some of the hard modes are just making you do the boss with trash

mod:RegisterEvents(
	"SPELL_CAST_START 356548 352390 354297 356537"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
)

--local warnClingingDarkness					= mod:NewTargetNoFilterAnnounce(323347, 3, nil, "Healer|RemoveMagic")
local warnRadiantPulse						= mod:NewSpellAnnounce(356548, 2)--Zo'honn

--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
local specWarnRiftBlasts					= mod:NewSpecialWarningDodge(327401, nil, nil, nil, 2, 2)--Zo'honn
local specWarnHyperlightBolt				= mod:NewSpecialWarningInterrupt(354297, "Tank", nil, nil, 1, 2)--Zo'honn casts this on tank
local specWarnEmpoweredGlyphofRestraint		= mod:NewSpecialWarningInterrupt(356537, "HasInterrupt", nil, nil, 1, 2)--Zo'honn casts this on everyone
--local specWarnSharedAgony					= mod:NewSpecialWarningMoveAway(327401, nil, nil, nil, 1, 11)
--local yellSharedAgony						= mod:NewYell(327401)
--local specWarnDarkShroud					= mod:NewSpecialWarningDispel(335141, "MagicDispeller", nil, nil, 1, 2)
--local specWarnGoresplatterDispel			= mod:NewSpecialWarningDispel(338353, "RemoveDisease", nil, nil, 1, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 356548 then
		warnRadiantPulse:Show()
	elseif spellId == 352390 and self:AntiSpam(3, 2) then
		specWarnRiftBlasts:Show()
		specWarnRiftBlasts:Play("watchstep")
	elseif spellId == 354297 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHyperlightBolt:Show(args.sourceName)
		specWarnHyperlightBolt:Play("kickcast")
	elseif spellId == 356537 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEmpoweredGlyphofRestraint:Show(args.sourceName)
		specWarnEmpoweredGlyphofRestraint:Play("kickcast")
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 327401 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--]]
