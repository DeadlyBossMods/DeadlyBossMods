local mod	= DBM:NewMod(1749, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(107023)
mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 175791",
	"SPELL_AURA_APPLIED 175827"
)

local specWarnColossalSlam		= mod:NewSpecialWarningDodge(175791, nil, nil, nil, 2, 2)
local specWarnCallofEarth		= mod:NewSpecialWarningSpell(175827)

local timerColossalSlamCD		= mod:NewCDTimer(16, 175791, nil, nil, nil, 3)
local timerCallofEarthCD		= mod:NewCDTimer(90, 175827, nil, nil, nil, 1)

local voiceColossalSlam			= mod:NewVoice(175791)

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175791 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 175827 then

	end
end
--]]