local mod	= DBM:NewMod(2406, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2401)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnBlackPowder				= mod:NewTargetAnnounce(257314, 4)

--local specWarnBlackPowder			= mod:NewSpecialWarningRun(257314, nil, nil, nil, 4, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

--local timerAvastyeCD				= mod:NewCDTimer(13, 257316, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--local timerSwiftwindSaberCD			= mod:NewCDTimer(15.8, 257316, nil, nil, nil, 3)

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257402 then

--	elseif spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
