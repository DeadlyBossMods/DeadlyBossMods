local mod	= DBM:NewMod(1161, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76877)
mod:SetEncounterID(1691)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155080 155301 155326",
	"SPELL_CAST_SUCCESS 155326 155080",
	"SPELL_AURA_APPLIED 155323 155539 155078",
	"SPELL_AURA_APPLIED_DOSE 155078",
	"SPELL_AURA_REMOVED 155323 155539",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, confirm if LFR Inferno Slice change actually also made mythic/heroic/normal or if they are still 13
--TODO, recheck rampage timer on non LFR difficulties to see if longer there too (related to inferno slice change probably)
--TODO, see if there is any way to impliment timers for smash and petrifyig slam. right now they are too variable. has to be a method to it.
local warnOverwhelmingBlows			= mod:NewStackAnnounce(155078, 3, nil, "Tank|Healer")--No special warnings, strats for this revolve around the inferno slice strat, not this debuff, so dbm isn't going to say when tanks should taunt here
local warnCrumblingRoar				= mod:NewSpellAnnounce(155730, 3, nil, false)--Cave ins
local warnInfernoSlice				= mod:NewCountAnnounce(155080, 4)
local warnPetrifyingSlam			= mod:NewTargetAnnounce(155326, 4)--non mythic only. in mythic, applied to all, so target list only spam

local specWarnInfernoSlice			= mod:NewSpecialWarningCount(155080, "Tank|Healer", nil, nil, nil, nil, true)
local specWarnRampage				= mod:NewSpecialWarningSpell(155539, nil, nil, nil, 2)
local specWarnRampageEnded			= mod:NewSpecialWarningEnd(155539)
local specWarnOverheadSmash			= mod:NewSpecialWarningCount(155301, nil, nil, nil, 2, nil, true)
local specWarnPetrifyingSlam		= mod:NewSpecialWarningMoveAway(155326, nil, nil, nil, 3, nil, true)

local timerInfernoSliceCD			= mod:NewCDCountTimer(17, 155080)--Variable do to energy bugs (gruul not gain power consistently)
local timerPetrifyingSlamCD			= mod:NewCDCountTimer(60, 155323)--60-70 variation
local timerOverheadSmashCD			= mod:NewCDCountTimer(30, 155301)--30-40 variation
local timerShatter					= mod:NewCastTimer(8, 155529)
local timerRampage					= mod:NewBuffActiveTimer(30, 155539)
local timerRampageCD				= mod:NewCDTimer(121.5, 155539)--Not sure if it's 110 in all difficulties, this is what LFR was from rampage end to new rampage

local countdownInfernoSlice			= mod:NewCountdown(17, 155080, "Tank")

local voiceInfernoSlice				= mod:NewVoice(155080) --gathershare. maybe change to "InfernoSlice".
--local voiceCrumblingRoar			= mod:NewVoice(155730)
local voiceOverheadSmash			= mod:NewVoice(155301) --shockwave
local voiceShatter					= mod:NewVoice(155326)--Spread/Scatter

--local berserkTimer				= mod:NewBerserkTimer(360)--Said to be 6 minutes. Unconfirmed.

mod:AddRangeFrameOption(8, 155530)

mod.vb.smashCount = 0
mod.vb.sliceCount = 0
mod.vb.petrifyCount = 0
mod.vb.rampage = false
local debuffFilter
do
	local petrifyDebuff = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, petrifyDebuff) then
			return true
		end
	end
end

local function clearRampage(self)
	self.vb.rampage = false
end

local function clearRangeFrame(self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.smashCount = 0
	self.vb.sliceCount = 0
	self.vb.petrifyCount = 0
	self.vb.rampage = false
	timerInfernoSliceCD:Start(14-delay, 1)
	countdownInfernoSlice:Start(14-delay)
	timerPetrifyingSlamCD:Start(21.5-delay, 1)
	timerOverheadSmashCD:Start(-delay, 1)
	timerRampageCD:Start(114-delay)--112-117 variation (121.5 in LFR)
--[[	self:RegisterShortTermEvents(
		"UNIT_POWER_FREQUENT boss1"
	)--]]
end

function mod:OnCombatEnd()
--	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155080 then--Inferno Slice Cast Start
		self.vb.sliceCount = self.vb.sliceCount + 1
		if self.Options.SpecWarn155080count then--if special warning is enabled, do not show regular warning.
			specWarnInfernoSlice:Show(self.vb.sliceCount)
		else
			warnInfernoSlice:Show(self.vb.sliceCount)
		end
--		if self:IsLFR() then
			timerInfernoSliceCD:Start(17, self.vb.sliceCount+1)--Maybe 17 in all now? 17 normal and LFR. maybe heroic and mythic still 13?
			countdownInfernoSlice:Start()
--		else
--			timerInfernoSliceCD:Start()
--		end
		voiceInfernoSlice:Play("gathershare")
	elseif spellId == 155301 then
--		self:UnregisterShortTermEvents()
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnOverheadSmash:Show(self.vb.smashCount)
		voiceOverheadSmash:Play("shockwave")
		if not self.vb.rampage and self.vb.smashCount < 3 then
			timerOverheadSmashCD:Start(nil, self.vb.smashCount+1)--First usually 31-21, second 33-39
		end
	elseif spellId == 155326 and self.Options.RangeFrame and not self:IsMythic() then--On mythic everyone gets debuff so no reason to ever show this radar first
		DBM.RangeCheck:Show(8, debuffFilter)--Show filtered frame at first for all, then update to unfiltered for those affected.
		self:Schedule(10, clearRangeFrame, self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then
		self.vb.petrifyCount = self.vb.petrifyCount + 1
		timerShatter:Start()
		if self.vb.petrifyCount == 1 then
			timerPetrifyingSlamCD:Start(nil, self.vb.petrifyCount+1)
		end
--	elseif spellId == 155080 then--Inferno Slice Cast Finish
--		self:RegisterShortTermEvents(
--			"UNIT_POWER_FREQUENT boss1"
--		)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155323 then
		if not self:IsMythic() then--Applied to 8 or less targets in non mythic, in mythic, applied to EVERYONE so no need target warning.
			warnPetrifyingSlam:CombinedShow(0.5, args.destName)
		end
		if args:IsPlayer() then
			specWarnPetrifyingSlam:Show()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
			voiceShatter:Play("scatter")
		end
	elseif spellId == 155539 then
		self.vb.rampage = true
		self.vb.smashCount = 0
		specWarnRampage:Show()
		timerRampage:Start()
		timerInfernoSliceCD:Cancel()
		countdownInfernoSlice:Cancel()
	elseif spellId == 155078 then
		local amount = args.amount or 1
		if amount % 2 == 0 or amount >= 5 then
			warnOverwhelmingBlows:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 155539 then
		specWarnRampageEnded:Show()
		timerRampageCD:Start()--VERIFY ALL MODES
		self.vb.petrifyCount = 0
		self.vb.smashCount = 0
		self.vb.sliceCount = 0
		--Delay Rampage clear. Removed event can fire before last rampage smash cast finishes
		--so we don't want that smash falsely detected as non rampage smash
		self:Schedule(3, clearRampage, self)
		timerPetrifyingSlamCD:Start(26, 1)--VERIFY
--		timerOverheadSmashCD:Start(47, 1)--VERIFY
--		if self:IsLFR() then
			timerInfernoSliceCD:Start(17.5, 1)
			countdownInfernoSlice:Start(17.5)
--		else
--			timerInfernoSliceCD:Start()
--		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then--Cave In
		warnCrumblingRoar:Show()
	end
end

--[[
function mod:UNIT_POWER_FREQUENT(uId)
	local bossPower = UnitPower("boss1") --Get Boss Power
	bossPower = bossPower / 10 --Divide it by 10 (cause he gains 10 power per second and we need to know how many seconds to subtrack from CD)
	timerInfernoSliceCD:Update(10-bossPower+3, 13)--Maybe awkward way of doing it since timer will slow down when gruul does, but as long as cast comes when timer finishes, that's best result we can get with shitty blizzard code.
end--]]
