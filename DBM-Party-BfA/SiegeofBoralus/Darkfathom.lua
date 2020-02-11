local mod	= DBM:NewMod(2134, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(130836)
mod:SetEncounterID(2099)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 257882 276068",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local specWarnCrashingTide			= mod:NewSpecialWarningDodge(261563, "Tank", nil, nil, 1, 2)
local specWarnBreakWater			= mod:NewSpecialWarningDodge(257882, nil, nil, nil, 2, 2)
local specWarnTidalSurge			= mod:NewSpecialWarningMoveTo(276068, nil, nil, nil, 3, 2)

local timerCrashingTideCD			= mod:NewCDTimer(15.8, 261563, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBreakWaterCD				= mod:NewCDTimer(30, 257882, nil, nil, nil, 3)
local timerTidalSurgeCD				= mod:NewCDTimer(49.8, 276068, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

function mod:OnCombatStart(delay)
	timerBreakWaterCD:Start(7.1-delay)
	timerCrashingTideCD:Start(13.1-delay)
	timerTidalSurgeCD:Start(24.1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257882 then
		specWarnBreakWater:Show()
		specWarnBreakWater:Play("watchstep")
		timerBreakWaterCD:Start()
	elseif spellId == 276068 then
		specWarnTidalSurge:Show(DBM_CORE_BREAK_LOS)
		specWarnTidalSurge:Play("findshelter")
		timerTidalSurgeCD:Start()--Unknown, pulls to short
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257861 then--Crashing Tide
		specWarnCrashingTide:Show()
		specWarnCrashingTide:Play("shockwave")
		timerCrashingTideCD:Start()
	end
end
