local mod	= DBM:NewMod(1161, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76877)
mod:SetEncounterID(1691)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155080 155301",
	"SPELL_CAST_SUCCESS 155326 155080",
	"SPELL_AURA_APPLIED 155323 155539 155078",
	"SPELL_AURA_APPLIED_DOSE 155078",
	"SPELL_AURA_REMOVED 155323 155539",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, confirm if LFR Inferno Slice change actually also made mythic/heroic/normal or if they are still 13
--TODO, recheck rampage timer on non LFR difficulties to see if longer there too (related to inferno slice change probably)
--TODO, see if there is any way to impliment timers for smash and petrifyig slam. right now they are too variable. has to be a method to it.
local warnOverwhelmingBlows			= mod:NewStackAnnounce(155078, 3, nil, mod:IsTank() or mod:IsHealer())--No special warnings, strats for this revolve around the inferno slice strat, not this debuff, so dbm isn't going to say when tanks should taunt here
local warnCrumblingRoar				= mod:NewSpellAnnounce(155730, 3, nil, false)--Cave ins
local warnInfernoSlice				= mod:NewCountAnnounce(155080, 4)
local warnRampage					= mod:NewSpellAnnounce(155539, 2)
local warnOverheadSmash				= mod:NewCountAnnounce(155301, 3)--every 6 seconds is ok, boss doesn't do much else during this phase. TODO< why does this fire outside of world shaking? tank out of range?
local warnPetrifyingSlam			= mod:NewSpellAnnounce(155326, 4)

local specWarnInfernoSlice			= mod:NewSpecialWarningCount(155080, mod:IsTank() or mod:IsHealer())
local specWarnRampage				= mod:NewSpecialWarningSpell(155539, nil, nil, nil, 2)
local specWarnRampageEnded			= mod:NewSpecialWarningEnd(155539)
local specWarnOverheadSmash			= mod:NewSpecialWarningCount(155301, nil, nil, nil, 2)
local specWarnPetrifyingSlam		= mod:NewSpecialWarningMoveAway(155326, nil, nil, nil, 3)

local timerInfernoSliceCD			= mod:NewCDTimer(13, 155080)--Variable do to energy bugs (gruul not gain power consistently)
--local timerPetrifyingSlamCD		= mod:NewCDTimer(99, 155323)
local timerShatter					= mod:NewCastTimer(8, 155529)
local timerRampage					= mod:NewBuffActiveTimer(30, 155539)
local timerRampageCD				= mod:NewCDTimer(110, 155539)--Not sure if it's 110 in all difficulties, this is what LFR was from rampage end to new rampage

--local berserkTimer				= mod:NewBerserkTimer(360)--Said to be 6 minutes. Unconfirmed.

mod:AddRangeFrameOption(8, 155530)

mod.vb.smashCount = 0
mod.vb.sliceCount = 0

function mod:OnCombatStart(delay)
	self.vb.smashCount = 0
	self.vb.sliceCount = 0
--	timerPetrifyingSlamCD:Start(22-delay)
	timerRampageCD:Start(-delay)--112-117 variation (121.5 in LFR)
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
		warnInfernoSlice:Show(self.vb.sliceCount)
		specWarnInfernoSlice:Show(self.vb.sliceCount)
		if self:IsLFR() then
			timerInfernoSliceCD:Start(17.5)
		else
			timerInfernoSliceCD:Start()
		end
	elseif spellId == 155301 then
		self:UnregisterShortTermEvents()
		self.vb.smashCount = self.vb.smashCount + 1
		warnOverheadSmash:Show(self.vb.smashCount)
		specWarnOverheadSmash:Show(self.vb.smashCount)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then
		warnPetrifyingSlam:Show()
		timerShatter:Start()
--		timerPetrifyingSlamCD:Start()
		--Maybe show range frame for all here instead of only those who get debuff?
	elseif spellId == 155080 then--Inferno Slice Cast Finish
		self:RegisterShortTermEvents(
			"UNIT_POWER_FREQUENT boss1"
		)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155323 and args:IsPlayer() then
		specWarnPetrifyingSlam:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 155539 then
		self.vb.smashCount = 0
		self.vb.sliceCount = 0
		warnRampage:Show()
		specWarnRampage:Show()
		timerRampage:Start()
		timerInfernoSliceCD:Cancel()
	elseif spellId == 155078 then
		local amount = args.amount or 1
		if amount % 2 == 0 or amount >= 5 then
			warnOverwhelmingBlows:Show(args.destName, amount)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 155539 then
		specWarnRampageEnded:Show()
		timerRampageCD:Start()--VERIFY
--		timerPetrifyingSlamCD:Start(19)--Still HIGHLY variable, 19 to 33, wtf?
		if self:IsLFR() then
			timerInfernoSliceCD:Start(17.5)
		else
			timerInfernoSliceCD:Start()
		end
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
