if not WorldMap_EventOverlayDataProviderMixin then return end--Random 8.3 api check
local mod	= DBM:NewMod(2381, "DBM-Azeroth-BfA", 6, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(160970)
mod:SetEncounterID(2353)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS"
)

--TODO, see which instance ID she's in, 2275,870
--local warnPetrify						= mod:NewSpellAnnounce(282615, 2, nil, nil, nil, nil, nil, 2)

--local specWarnStormWing				= mod:NewSpecialWarningSpell(260908, nil, nil, nil, 2, 2)

--local timerStormWingCD				= mod:NewCDTimer(46.2, 260908, nil, nil, nil, 2)
--local timerHurricaneCrashCD			= mod:NewCDTimer(46.2, 261088, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--[[
function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260908 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 261467 then

	end
end
--]]
