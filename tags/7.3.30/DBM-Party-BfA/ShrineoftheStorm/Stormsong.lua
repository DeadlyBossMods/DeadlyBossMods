local mod	= DBM:NewMod(2155, "DBM-Party-BfA", 4, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134060)
mod:SetEncounterID(2132)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 268896 269131",
	"SPELL_CAST_START 268347 269097",
	"SPELL_CAST_SUCCESS 268896 269131"
)

--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnVoidBolt				= mod:NewSpecialWarningInterruptCount(268347, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindRend				= mod:NewSpecialWarningDispel(268896, "Healer", nil, nil, 1, 2)
local specWarnWakentheVoid			= mod:NewSpecialWarningDodge(269097, nil, nil, nil, 2, 2)
local specWarnAncientMindbender		= mod:NewSpecialWarningSwitch(269131, nil, nil, nil, 1, 2)
local yellAncientMindbender			= mod:NewYell(269131)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerVoidBoltCD				= mod:NewCDTimer(8.4, 268347, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerMindRendCD				= mod:NewAITimer(8.4, 268896, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)
local timerWakentheVoidCD			= mod:NewCDTimer(52.3, 269097, nil, nil, nil, 3)--IFFY, could be health based
local timerAncientMindbenderCD		= mod:NewCDTimer(42.5, 269131, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)

--mod:AddRangeFrameOption(5, 194966)

mod.vb.interruptCount = 0

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	timerMindRendCD:Start(1-delay)
	timerWakentheVoidCD:Start(13.1-delay)
	timerAncientMindbenderCD:Start(19.6-delay)--SUCCESS
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 268896 then
		specWarnMindRend:Show(args.destName)
		specWarnMindRend:Play("helpdispel")
	elseif spellId == 269131 then
		specWarnAncientMindbender:Show()
		specWarnAncientMindbender:Play("findmc")
		if args:IsPlayer() then
			yellAncientMindbender:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 269097 then
		specWarnWakentheVoid:Show()
		specWarnWakentheVoid:Play("watchorb")
		timerWakentheVoidCD:Start()
	elseif spellId == 268347 then
		timerVoidBoltCD:Start()
		if self.vb.interruptCount == 2 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnVoidBolt:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			specWarnVoidBolt:Play("kick1r")
		elseif kickCount == 2 then
			specWarnVoidBolt:Play("kick2r")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 268896 then
		timerMindRendCD:Start()
	elseif spellId == 269131 then
		timerAncientMindbenderCD:Start()
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
