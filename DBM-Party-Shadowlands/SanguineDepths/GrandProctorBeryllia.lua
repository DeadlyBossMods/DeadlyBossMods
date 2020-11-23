local mod	= DBM:NewMod(2421, "DBM-Party-Shadowlands", 8, 1189)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162102)
mod:SetEncounterID(2362)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 325254 325360 326039"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 325254 or ability.id = 325360 or ability.id = 326039) and type = "begincast"
--]]
--TODO, more info needed, like how many people can get protection and how much, and how to show it, infoframe?
--TODO, fine tune range frame to not show when endless torment isn't being cast
local warnRiteofSupremacy			= mod:NewCastAnnounce(325360, 4)

local specWarnIronSpikes			= mod:NewSpecialWarningDefensive(325254, nil, nil, nil, 1, 2)
local specWarnEndlessTorment		= mod:NewSpecialWarningMoveAway(326039, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerIronSpikesCD				= mod:NewCDTimer(31.6, 325254, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Change to next if the custom rule for 2nd cast works out good
local timerRiteofSupremacyCD		= mod:NewNextTimer(38.6, 325360, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerRiteofSupremacy			= mod:NewCastTimer(10, 325360, nil, nil, nil, 5, nil, DBM_CORE_L.DEADLY_ICON)
local timerEndlessTormentCD			= mod:NewNextTimer(38.8, 326039, nil, nil, nil, 2)

mod:AddRangeFrameOption(6, 325885)

mod.vb.spikesCast = 0

function mod:OnCombatStart(delay)
	self.vb.spikesCast = 0
	timerIronSpikesCD:Start(3.5-delay)
	timerRiteofSupremacyCD:Start(11-delay)
	timerEndlessTormentCD:Start(24.2-delay)
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
		self.vb.spikesCast = self.vb.spikesCast + 1
		specWarnIronSpikes:Show()
		specWarnIronSpikes:Play("defensive")
		timerIronSpikesCD:Start(self.vb.spikesCast == 1 and 31.6 or 37.9)
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
