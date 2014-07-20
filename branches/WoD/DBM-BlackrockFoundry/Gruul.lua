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
	"SPELL_CAST_SUCCESS 155730 155078",
	"SPELL_AURA_APPLIED 155326",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 155326"
)

local warnInfernoSlice				= mod:NewSpellAnnounce(155080, 3)
local warnOverwhelmingBlows			= mod:NewSpellAnnounce(155078, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWorldShaking				= mod:NewSpellAnnounce(155539, 3)
local warnCrumblingRoar				= mod:NewSpellAnnounce(155730, 3, nil, false)--Might be spammy. I have a hunch it may be so temp off by default
local warnOverheadSmash				= mod:NewCastAnnounce(155301, 3, nil, false)--Like annihilate on garrosh? spammy?

local specWarnInfernoSlice			= mod:NewSpecialWarningSpell(155080, mod:IsTank())--Need more information on how he's taunted and timing of overwhelming Blows to fine tune this
local specWarnWorldShaking			= mod:NewSpecialWarningSpell(155539, nil, nil, nil, 2)
local specWarnPetrifyingSlam		= mod:NewSpecialWarningYou(155326)

local timerInfernoSliceCD			= mod:NewCDTimer(60, 155080)--Unit Power based, probably very similar approach to sha of fear breath
local timerWorldShakingCD			= mod:NewCDTimer(60, 155539)

--local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 155530)
local adaptiveLearning1 = 0--Temp code to test 
local adaptiveLearning2 = 0

function mod:OnCombatStart(delay)
	adaptiveLearning1 = 0
	adaptiveLearning2 = 0
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
		if adaptiveLearning1 ~= 0 then
			local guessedTime = GetTime() - adaptiveLearning1
			timerInfernoSliceCD:Start(guessedTime)
			print(guessedTime.."Seconds since last cast of Inferno Slice. DBM is creating a CD timer for next cast using this time. This may not be accurate if timing is variable!")
		end
		adaptiveLearning1 = GetTime()
	elseif spellId == 155539 then
		warnWorldShaking:Show()
		specWarnWorldShaking:Show()
		if adaptiveLearning2 ~= 0 then
			local guessedTime = GetTime() - adaptiveLearning2
			timerWorldShakingCD:Start(guessedTime)
			print(guessedTime.."Seconds since last cast of World Shaking. DBM is creating a CD timer for next cast using this time. This may not be accurate if timing is variable!")
		end
		adaptiveLearning2 = GetTime()
	elseif spellId == 155301 then
		warnOverheadSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155730 then
		warnCrumblingRoar:Show()
	elseif spellId == 155078 then
		warnOverwhelmingBlows:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155326 and args:IsPlayer() then
		specWarnPetrifyingSlam:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155326 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143500 then
		self:BossTargetScanner(71515, "LeapTarget", 0.05, 16)
	end
end--]]
