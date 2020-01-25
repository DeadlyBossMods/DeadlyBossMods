local mod	= DBM:NewMod(2358, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150222)
mod:SetEncounterID(2292)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297834 297835",
	"SPELL_CAST_SUCCESS 297985",
	"SPELL_AURA_APPLIED 298259 297913"
--	"SPELL_AURA_REMOVED 298259"
)

--[[
(ability.id = 297834 or ability.id = 297835) and type = "begincast"
 or (ability.id = 297821 or ability.id = 297985) and type = "cast"
--]]
local warnGooped					= mod:NewTargetNoFilterAnnounce(298259, 2)
local warnSplatter					= mod:NewSpellAnnounce(297985, 2)

local specWarnToxicWave				= mod:NewSpecialWarningSpell(297834, nil, nil, nil, 2, 2)
local specWarnGooped				= mod:NewSpecialWarningYou(298259, nil, nil, nil, 1, 2)
local yellGooped					= mod:NewYell(298259)
local specWarnGoopedDispel			= mod:NewSpecialWarningDispel(298259, "RemoveDisease", nil, nil, 1, 2)
local specWarnToxicGoopDispel		= mod:NewSpecialWarningDispel(297913, false, nil, nil, 1, 2)
local specWarnCoalesce				= mod:NewSpecialWarningDodge(297835, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerToxicWaveCD				= mod:NewCDTimer(49.8, 297834, nil, nil, nil, 2)
local timerSplatterCD				= mod:NewCDTimer(25.1, 297985, nil, nil, nil, 3)
local timerCoalesceCD				= mod:NewCDTimer(49.8, 297835, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerSplatterCD:Start(8.7-delay)
	timerCoalesceCD:Start(20.6-delay)
	timerToxicWaveCD:Start(44.8-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297834 then
		specWarnToxicWave:Show()
		specWarnToxicWave:Play("specialsoon")--watchwave (if dodgable)
		timerToxicWaveCD:Start()
	elseif spellId == 297835 then
		specWarnCoalesce:Show()
		specWarnCoalesce:Play("watchstep")
		timerCoalesceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 297985 then
		warnSplatter:Show()
		timerSplatterCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 298259 then
		if args:IsPlayer() then
			specWarnGooped:Show()
			specWarnGooped:Play("targetyou")
		elseif self.Options.SpecWarn298259dispel and self:CheckDispelFilter() then
			specWarnGoopedDispel:Show(args.destName)
			specWarnGoopedDispel:Play("helpdispel")
		else
			warnGooped:CombinedShow(1, args.destName)
		end
	elseif spellId == 297913 then
		if args:IsPlayer() then
			specWarnGooped:Show()
			specWarnGooped:Play("targetyou")
		elseif self.Options.SpecWarn297913dispel and self:CheckDispelFilter() then
			specWarnToxicGoopDispel:Show(args.destName)
			specWarnToxicGoopDispel:Play("helpdispel")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 257827 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
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
