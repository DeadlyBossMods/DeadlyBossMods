local mod	= DBM:NewMod(2140, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(120553)
mod:SetEncounterID(2100)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 270624 275014",
	"SPELL_CAST_START 270185 269266",
	"UNIT_DIED"
)

--TODO, spawn detection of tentacles so can yell at tank to switch to new Demolishing Terror
--TODO, number of gripping terrors to add an adds remaining warning
--TODO, timer for purid waters if not cast often.
local warnPutridWaters				= mod:NewTargetAnnounce(275014, 2)

local specWarnCalloftheDeep			= mod:NewSpecialWarningDodge(270185, nil, nil, nil, 2, 2)
local yellCrushingEmbrace			= mod:NewYell(270624)
local specWarnPutridWaters			= mod:NewSpecialWarningMoveAway(275014, nil, nil, nil, 1, 2)
local yellPutridWaters				= mod:NewYell(275014)
local specWarnSlam					= mod:NewSpecialWarningDodge(269266, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCalloftheDeepCD			= mod:NewAITimer(13, 270185, nil, nil, nil, 3)
--local timerPutridWatersCD			= mod:NewAITimer(13, 275014, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerSlamCD					= mod:NewAITimer(13, 269266, nil, nil, nil, 3)

mod:AddRangeFrameOption(5, 275014)

function mod:OnCombatStart(delay)
	timerCalloftheDeepCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 270624 and args:IsPlayer() then
		yellCrushingEmbrace:Yell()
	elseif spellId == 275014 then
		if args:IsPlayer() then
			specWarnPutridWaters:Show()
			specWarnPutridWaters:Play("range5")
			yellPutridWaters:Yell()
		else
			warnPutridWaters:CombinedShow(0.3, args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 270185 then
		specWarnCalloftheDeep:Show()
		specWarnCalloftheDeep:Play("watchstep")
		timerCalloftheDeepCD:Start()
	elseif spellId == 269266 then
		specWarnSlam:Show()
		specWarnSlam:Play("shockwave")
		timerSlamCD:Start(nil, args.sourceGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 137627 then--Constricting Terror
	
	elseif cid == 137437 then--Gripping Terror
	
	elseif cid == 140447 then--Demolishing Terror
		timerSlamCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
