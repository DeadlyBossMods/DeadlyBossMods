local mod	= DBM:NewMod(2515, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(193534)
mod:SetEncounterID(2651)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 387191 389951 385980",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 387199",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 387191"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO, figure out how to add https://www.wowhead.com/spell=387216/shock-water personal alert?
--TODO, target scan tornados? or move announce to success for target?
local warnEmpoweredStorm				= mod:NewSpellAnnounce(387191, 3)
local warnEmpoweredStormOver			= mod:NewEndAnnounce(387191, 1)
local warnThunderVortex					= mod:NewSpellAnnounce(385980, 2)
--local warnDarkDeterrence				= mod:NewStackAnnounce(361390, 2, nil, "Tank|Healer")

local specWarnStrunraanTempest			= mod:NewSpecialWarningYou(387199, nil, nil, nil, 1, 2)
local specWarnArcExpulsion				= mod:NewSpecialWarningDodge(389951, nil, nil, nil, 2, 2)

local timerEmpoweredStormCD				= mod:NewAITimer(74.7, 387191, nil, nil, nil, 6)
local timerArcExpulsionCD				= mod:NewAITimer(31.3, 389951, nil, nil, nil, 3)--More data needed
local timerThunderVortexCD				= mod:NewCDTimer(6.8, 385980, nil, nil, nil, 3)
--local timerDeterrentStrikeCD			= mod:NewAITimer(9.7, 361387, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddRangeFrameOption(10, 387265)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 387191 then
		warnEmpoweredStorm:Show()
		timerEmpoweredStormCD:Start()
	elseif spellId == 389951 then
		specWarnArcExpulsion:Show()
		specWarnArcExpulsion:Play("breathsoon")
		timerArcExpulsionCD:Start()
	elseif spellId == 385980 then
		warnThunderVortex:Show()
		timerThunderVortexCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 361341 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 387199 and args:IsPlayer() then
		specWarnStrunraanTempest:Show()
		specWarnStrunraanTempest:Play("targetyou")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 387191 then
		warnEmpoweredStormOver:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 361335 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
