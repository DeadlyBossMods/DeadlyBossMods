local mod	= DBM:NewMod(2171, "DBM-Party-BfA", 3, 1041)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134993)
mod:SetEncounterID(2142)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267618 267626 271555",
	"SPELL_CAST_START 267639 267702 267763",
	"SPELL_CAST_SUCCESS 267618",
	"SPELL_PERIODIC_DAMAGE 267874",
	"SPELL_PERIODIC_MISSED 267874"
)

--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnBurnCorruption		= mod:NewSpecialWarningRun(267639, "Melee", nil, nil, 4, 2)
local specWarnDrainFluids			= mod:NewSpecialWarningYou(267618, "HasImmunity", nil, nil, 1, 2)
local specWarnDessication			= mod:NewSpecialWarningTarget(267626, "Healer", nil, nil, 1, 2)
local specWarnEntomb				= mod:NewSpecialWarningYou(271555, nil, nil, nil, 1, 2)
local yellEntomb					= mod:NewYell(271555)
local specWarnEntombOther			= mod:NewSpecialWarningSwitch(271555, nil, nil, nil, 1, 2)
local specWarnWretchedDischarge		= mod:NewSpecialWarningInterrupt(267763, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(267874, nil, nil, nil, 1, 2)

local timerBurnCorruptionCD			= mod:NewAITimer(13, 267639, nil, "Melee", nil, 2, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local timerDrainFluidsCD			= mod:NewAITimer(13, 267618, nil, nil, nil, 3)
local timerEntombCD					= mod:NewAITimer(13, 267702, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerBurnCorruptionCD:Start(1-delay)
	timerDrainFluidsCD:Start(1-delay)
	timerEntombCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267618 then
		if args:IsPlayer() then
			specWarnDrainFluids:Show()
			specWarnDrainFluids:Play("targetyou")
		end
	elseif spellId == 267626 then
		specWarnDessication:Show(args.destName)
		specWarnDessication:Play("healfull")
	elseif spellId == 271555 then
		if args:IsPlayer() then
			specWarnEntomb:Show()
			specWarnEntomb:Play("targetyou")
			yellEntomb:Yell()
		else
			specWarnEntombOther:Show()
			specWarnEntombOther:Play("targetchange")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267639 then
		specWarnBurnCorruption:Show()
		specWarnBurnCorruption:Play("justrun")
		timerBurnCorruptionCD:Start()
	elseif spellId == 267702 then
		timerEntombCD:Start()
	elseif spellId == 267763 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWretchedDischarge:Show(args.sourceName)
		specWarnWretchedDischarge:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267618 then
		timerDrainFluidsCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 267874 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
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
