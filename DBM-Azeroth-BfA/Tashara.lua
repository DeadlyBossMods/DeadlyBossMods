local mod	= DBM:NewMod(2380, "DBM-Azeroth-BfA", 6, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(132253)--Still Unknown, 3 IDs exist, only 1 is correct
mod:SetEncounterID(2352)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 314474 314524",
	"SPELL_CAST_SUCCESS 314587",
	"SPELL_AURA_APPLIED 314589",
	"SPELL_AURA_REMOVED 314589"
)

--TODO, see which instance ID she's in, 2275,870
local warnFleshtoStone					= mod:NewTargetAnnounce(314589, 2)

local specWarnLandSlide					= mod:NewSpecialWarningSpell(314474, "Tank", nil, nil, 1, 2)
local specWarnGroundShatter				= mod:NewSpecialWarningDodge(314524, nil, nil, nil, 2, 2)
local specWarnFleshtoStone				= mod:NewSpecialWarningMoveAway(314524, nil, nil, nil, 1, 2)

local timerLandslideCD					= mod:NewAITimer(46.2, 314474, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerGroundShatterCD				= mod:NewAITimer(46.2, 314524, nil, nil, nil, 3)
local timerFleshtoStoneCD				= mod:NewAITimer(46.2, 314587, nil, nil, nil, 3)

mod:AddRangeFrameOption(10, 314524)

--[[
function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end
--]]

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 314474 then
		specWarnLandSlide:Show()
		specWarnLandSlide:Play("carefly")
		timerLandslideCD:Start()
	elseif spellId == 314524 then
		specWarnGroundShatter:Show()
		specWarnGroundShatter:Play("watchstep")
		timerGroundShatterCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314587 then
		timerFleshtoStoneCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 314589 then
		warnFleshtoStone:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFleshtoStone:Show()
			specWarnFleshtoStone:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 314589 then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
