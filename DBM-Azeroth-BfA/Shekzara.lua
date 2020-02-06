local mod	= DBM:NewMod(2378, "DBM-Azeroth-BfA", 6, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(154638)
mod:SetEncounterID(2351)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 314304 314333",
	"SPELL_CAST_SUCCESS 314307"
)

--TODO, see which instance ID she's in, 2275,870
local specWarnSongoftheEmpress			= mod:NewSpecialWarningDodge(314304, nil, nil, nil, 2, 2)
local specWarnForceandVerve				= mod:NewSpecialWarningMoveTo(314333, nil, nil, nil, 3, 2)
local specWarnSummonSwarmguard			= mod:NewSpecialWarningSwitch(314307, "-Healer", nil, nil, 1, 2)

local timerSongoftheEmpressCD			= mod:NewCDTimer(82.0, 314304, nil, nil, nil, 3)
local timerForceandVerveCD				= mod:NewCDTimer(82.0, 314333, nil, nil, 2, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
local timerSummonSwarmguardCD			= mod:NewCDTimer(30.5, 314307, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON)

local BarrierName = DBM:GetSpellInfo(314323)

--[[
function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerSongoftheEmpressCD:Start(1-delay)
		--timerForceandVerveCD:Start(1-delay)
		--timerSummonSwarmguardCD:Start(1-delay)
	end
end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 314304 then
		specWarnSongoftheEmpress:Show()
		specWarnSongoftheEmpress:Play("watchwave")
		timerSongoftheEmpressCD:Start()
	elseif spellId == 314333 then
		specWarnForceandVerve:Show(BarrierName)
		specWarnForceandVerve:Play("findshelter")
		timerForceandVerveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314307 then
		specWarnSummonSwarmguard:Show()
		specWarnSummonSwarmguard:Play("killmob")
		timerSummonSwarmguardCD:Start()
	end
end
