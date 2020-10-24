local mod	= DBM:NewMod(2431, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(173104)
mod:SetEncounterID(2410)
mod:SetReCombatTime(20)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS"
)

--local specWarnSongoftheEmpress			= mod:NewSpecialWarningDodge(314304, nil, nil, nil, 2, 2)
--local specWarnForceandVerve				= mod:NewSpecialWarningMoveTo(314333, nil, nil, nil, 3, 2)
--local specWarnSummonSwarmguard			= mod:NewSpecialWarningSwitch(314307, "-Healer", nil, nil, 1, 2)

--local timerSongoftheEmpressCD				= mod:NewCDTimer(82.0, 314304, nil, nil, nil, 3)
--local timerForceandVerveCD				= mod:NewCDTimer(82.0, 314333, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 1, 5)

--[[
function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 314304 then

	elseif spellId == 314333 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314307 then

	end
end
--]]
