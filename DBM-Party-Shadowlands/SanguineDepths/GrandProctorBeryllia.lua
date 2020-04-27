local mod	= DBM:NewMod(2421, "DBM-Party-Shadowlands", 8, 1189)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162102)
mod:SetEncounterID(2362)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 325254 325360 326039"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more info needed, like how many people can get protection and how much, and how to show it, infoframe?
--TODO, fine tune range frame to not show when endless torment isn't being cast
local warnRiteofSupremacy			= mod:NewCastAnnounce(325360, 4)

local specWarnIronSpikes			= mod:NewSpecialWarningDefensive(325254, nil, nil, nil, 1, 2)
local specWarnEndlessTorment		= mod:NewSpecialWarningMoveAway(326039, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerIronSpikesCD				= mod:NewAITimer(13, 325254, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRiteofSupremacyCD		= mod:NewAITimer(10, 325360, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerRiteofSupremacy			= mod:NewCastTimer(10, 325360, nil, false, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerEndlessTormentCD			= mod:NewAITimer(10, 326039, nil, nil, nil, 2)

mod:AddRangeFrameOption(6, 325885)

function mod:OnCombatStart(delay)
	timerIronSpikesCD:Start(1-delay)
	timerRiteofSupremacyCD:Start(1-delay)
	timerEndlessTormentCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325254 then
		specWarnIronSpikes:Show()
		specWarnIronSpikes:Play("defensive")
		timerIronSpikesCD:Start()
	elseif spellId == 325360 then
		warnRiteofSupremacy:Show()
		timerRiteofSupremacy:Start()
		timerRiteofSupremacyCD:Start()
	elseif spellId == 326039 then
		specWarnEndlessTorment:Show()
		specWarnEndlessTorment:Play("range5")
		timerEndlessTormentCD:Start()
	end
end

--[[
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
