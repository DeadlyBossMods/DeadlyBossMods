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
--TODO, more timer data verification
local warnRiteofSupremacy			= mod:NewCastAnnounce(325360, 4)

local specWarnIronSpikes			= mod:NewSpecialWarningDefensive(325254, "Tank|Healer", nil, 2, 1, 2)
local specWarnEndlessTorment		= mod:NewSpecialWarningMoveAway(326039, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerIronSpikesCD				= mod:NewCDTimer(31.6, 325254, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Change to next if the custom rule for 2nd cast works out good
local timerRiteofSupremacyCD		= mod:NewNextCountTimer(34.5, 325360, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerRiteofSupremacy			= mod:NewCastTimer(10, 325360, nil, nil, nil, 5, nil, DBM_CORE_L.DEADLY_ICON)
local timerEndlessTormentCD			= mod:NewNextTimer(38.8, 326039, nil, nil, nil, 2)

mod:AddRangeFrameOption(6, 325885)

mod.vb.spikesCast = 0
mod.vb.tormentCast = 0
mod.vb.riteCast = 0
local tormentTimers = {24.2, 11.3, 32.7, 39.7, 11.3, 31.1}
local spikesTimers = {3.5, 44.1, 32.7, 50.6}
local riteTimers = {11, 38.9, 40, 42.5}

function mod:OnCombatStart(delay)
	self.vb.spikesCast = 0
	self.vb.tormentCast = 0
	self.vb.riteCast = 0
	timerIronSpikesCD:Start(3.5-delay)
	timerRiteofSupremacyCD:Start(11-delay, 1)
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
		local timer = spikesTimers[self.vb.spikesCast+1] or 32.7
		timerIronSpikesCD:Start(timer)
	elseif spellId == 325360 then
		self.vb.riteCast = self.vb.riteCast + 1
		warnRiteofSupremacy:Show()
		timerRiteofSupremacy:Start()
		local timer = riteTimers[self.vb.riteCast+1] or 38.9
		timerRiteofSupremacyCD:Start(timer, self.vb.riteCast + 1)
	elseif spellId == 326039 then
		self.vb.tormentCast = self.vb.tormentCast + 1
		specWarnEndlessTorment:Show()
		specWarnEndlessTorment:Play("range5")
		local timer = tormentTimers[self.vb.tormentCast+1] or 11.3
		timerEndlessTormentCD:Start(timer)
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
