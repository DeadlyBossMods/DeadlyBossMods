local mod	= DBM:NewMod("EmeraldNightmareTrash", "DBM-Uldir")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

--[[
mod:RegisterEvents(
--	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--local warnUnstableDecay				= mod:NewTargetAnnounce(221028, 3)

--local specWarnUnstableDecay			= mod:NewSpecialWarningMoveAway(221028, nil, nil, nil, 1, 2)
--local yellUnstableDecay				= mod:NewYell(221028)
--local specWarnWildFire				= mod:NewSpecialWarningInterrupt(253562, "HasInterrupt", nil, nil, 1, 2)

--mod:AddRangeFrameOption(10, 221028)

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221028 then

	elseif spellId == 255041 and self:CheckInterruptFilter(args.sourceGUID) then
--		specWarnTerrifyingScreech:Show()
--		specWarnTerrifyingScreech:Play("kickcast")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221028 then
	
	end
end
--]]
