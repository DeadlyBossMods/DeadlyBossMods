local mod	= DBM:NewMod(1161, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76877)
mod:SetEncounterID(1691)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155080 155539 155301",
	"SPELL_CAST_SUCCESS 155730 155078 155326",
	"SPELL_AURA_APPLIED 155323",--155078
	"SPELL_AURA_APPLIED_DOSE",--155078
	"SPELL_AURA_REMOVED 155323 155539",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnOverwhelmingBlows			= mod:NewSpellAnnounce(155078, 3, nil, mod:IsTank() or mod:IsHealer())--Doesn't show cast event in combat log and I still don't get how it works.
--local warnCrumblingRoar				= mod:NewSpellAnnounce(155730, 3, nil, false)--Might be spammy. I have a hunch it may be so temp off by default
local warnInfernoSlice				= mod:NewSpellAnnounce(155080, 3)
local warnWorldShaking				= mod:NewSpellAnnounce(155539, 3)
local warnOverheadSmash				= mod:NewCountAnnounce(155301, 3)--every 6 seconds is ok, boss doesn't do much else during this phase. TODO< why does this fire outside of world shaking? tank out of range?
local warnPetrifyingSlam			= mod:NewSpellAnnounce(155326, 3)
local warnGroundPunch				= mod:NewSpellAnnounce(155294, 3, nil, false)

local specWarnInfernoSlice			= mod:NewSpecialWarningSpell(155080, mod:IsTank())--Need more information on how he's taunted and timing of overwhelming Blows to fine tune this
local specWarnWorldShaking			= mod:NewSpecialWarningSpell(155539, nil, nil, nil, 2)
local specWarnOverheadSmash			= mod:NewSpecialWarningSpell(155301, nil, nil, nil, 2)
local specWarnPetrifyingSlam		= mod:NewSpecialWarningYou(155326)

--local timerInfernoSliceCD			= mod:NewCDTimer(15, 155080)--Highly Variable, not useful right now.
local timerPetrifyingSlamCD			= mod:NewCDTimer(99, 155323)
local timerShatter					= mod:NewCastTimer(8, 155529)
local timerWorldShaking				= mod:NewBuffActiveTimer(27, 155539)
local timerWorldShakingCD			= mod:NewCDTimer(82, 155539)

--local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 155530)

mod.vb.smashCount = 0

function mod:OnCombatStart(delay)
	self.vb.smashCount = 0
	timerPetrifyingSlamCD:Start(35-delay)--this actually is consistent
	timerWorldShakingCD:Start(-delay)--82-90 variation
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155080 then
		warnInfernoSlice:Show()
		specWarnInfernoSlice:Show()
--		timerInfernoSliceCD:Start()
	elseif spellId == 155539 then
		self.vb.smashCount = 0
		warnWorldShaking:Show()
		specWarnWorldShaking:Show()
		timerWorldShaking:Start()
	elseif spellId == 155301 then
		self.vb.smashCount = self.vb.smashCount + 1
		warnOverheadSmash:Show(self.vb.smashCount)
		specWarnOverheadSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155730 then
		warnCrumblingRoar:Show()
--[[	elseif spellId == 155078 then
		warnOverwhelmingBlows:Show()--]]
	elseif spellId == 155326 then
		warnPetrifyingSlam:Show()
		timerShatter:Start()
		timerPetrifyingSlamCD:Start()
		--Maybe show range frame for all here instead of only those who get debuff?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155323 and args:IsPlayer() then
		specWarnPetrifyingSlam:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 155539 then
		timerWorldShakingCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 155294 then
		warnGroundPunch:Show()
	end
end
