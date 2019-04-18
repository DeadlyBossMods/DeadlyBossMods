local mod	= DBM:NewMod(2360, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(127484)
mod:SetEncounterID(2312)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS"
)

--local warnSmokePowder				= mod:NewSpellAnnounce(257793, 2)

--local specWarnHowlingFear			= mod:NewSpecialWarningInterrupt(257791, "HasInterrupt", nil, nil, 1, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--local timerHowlingFearCD			= mod:NewAITimer(13.4, 257791, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--local timerFlashingDaggerCD			= mod:NewAITimer(31.6, 257785, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--mod:AddRangeFrameOption(5, 194966)
--[[
function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 257827 then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257791 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
