local mod	= DBM:NewMod(2134, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(130836)
mod:SetEncounterID(2099)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 261563 257882 276068"
)

--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnCrashingTide			= mod:NewSpecialWarningSpell(261563, "Tank", nil, nil, 1, 2)
local specWarnBreakWater			= mod:NewSpecialWarningDodge(257882, nil, nil, nil, 2, 2)
local specWarnTidalSurge			= mod:NewSpecialWarningMoveTo(276068, nil, nil, nil, 3, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCrashingTideCD			= mod:NewAITimer(13, 261563, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBreakWaterCD				= mod:NewAITimer(13, 257882, nil, nil, nil, 3)
local timerTidalSurgeCD				= mod:NewAITimer(13, 276068, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerCrashingTideCD:Start(1-delay)
	timerBreakWaterCD:Start(1-delay)
	timerTidalSurgeCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 261563 then
		specWarnCrashingTide:Show()
		specWarnCrashingTide:Play("shockwave")
		timerCrashingTideCD:Start()
	elseif spellId == 257882 then
		specWarnBreakWater:Show()
		specWarnBreakWater:Play("watchstep")
		timerBreakWaterCD:Start()
	elseif spellId == 276068 then
		specWarnTidalSurge:Show(DBM_CORE_BREAK_LOS)
		specWarnTidalSurge:Play("findshelter")
		timerTidalSurgeCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
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
