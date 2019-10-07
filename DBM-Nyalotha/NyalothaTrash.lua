local mod	= DBM:NewMod("NyalothaTrash", "DBM-Nyalotha", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true
--mod:SetUsedIcons(1, 2, 3, 4, 5)

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

--local warnArcaneBomb						= mod:NewTargetNoFilterAnnounce(304026, 3)

--local specWarnHeal							= mod:NewSpecialWarningInterrupt(303205, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGaleBuffet					= mod:NewSpecialWarningSpell(296701, nil, nil, nil, 2, 2)
--local specWarnArcaneBomb					= mod:NewSpecialWarningMoveAway(304026, nil, nil, nil, 1, 2)
--local yellArcaneBomb						= mod:NewYell(304026)

--mod:AddSetIconOption("SetIconDread", 303619, true, false, {1, 2, 3, 4, 5})

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 304261 and self:CheckInterruptFilter(args.sourceGUID, false, true) then

	elseif spellId == 303619 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 304026 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 304026 then

	end
end
--]]
